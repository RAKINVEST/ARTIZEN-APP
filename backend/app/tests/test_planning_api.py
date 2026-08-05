"""HTTP-level tests for the Planning Engine (require the DB — run in Docker).

A freshly registered tenant, real JWT: create a schedule, detect conflicts,
move, auto-assign, cancel, and stay tenant-scoped. Weekdays are derived so the
slot always lands within working hours.
"""

from datetime import datetime, timedelta, timezone

from httpx import AsyncClient

_REF = datetime(2026, 6, 15, 0, 0, tzinfo=timezone.utc)
_MONDAY = (_REF - timedelta(days=_REF.weekday())).replace(hour=9, minute=0)


def _iso(hour: int) -> str:
    return _MONDAY.replace(hour=hour).isoformat()


async def _create(ac: AsyncClient, hour: int = 9, artisan: str = "alice") -> dict:
    r = await ac.post(
        "/api/planning",
        json={"start_at": _iso(hour), "duration_minutes": 120, "artisan": artisan},
    )
    assert r.status_code == 201, r.text
    return r.json()


async def test_create_and_read(client: AsyncClient) -> None:
    entry = await _create(client)
    assert entry["status"] == "planifiee"
    assert entry["artisan"] == "alice"
    assert entry["end_at"]  # computed
    assert len(entry["history"]) == 1  # PlanningCreated


async def test_availability_and_conflict(client: AsyncClient) -> None:
    await _create(client, hour=9, artisan="alice")
    # Overlapping slot for the same artisan -> not available, explained.
    r = await client.get(
        "/api/planning/availability",
        params={"start_at": _iso(10), "duration_minutes": 120, "artisan": "alice"},
    )
    assert r.status_code == 200, r.text
    body = r.json()
    assert body["available"] is False
    assert body["conflicts"][0]["type"] == "artisan_indisponible"
    # Creating it is refused (409).
    r = await client.post(
        "/api/planning",
        json={"start_at": _iso(10), "duration_minutes": 120, "artisan": "alice"},
    )
    assert r.status_code == 409


async def test_move_and_cancel(client: AsyncClient) -> None:
    entry = await _create(client, hour=9)
    r = await client.post(
        f"/api/planning/{entry['id']}/move", json={"start_at": _iso(14)}
    )
    assert r.status_code == 200, r.text
    assert r.json()["status"] == "deplacee"

    r = await client.post(f"/api/planning/{entry['id']}/cancel")
    assert r.status_code == 200, r.text
    assert r.json()["status"] == "annulee"


async def test_auto_assign_picks_free_artisan(client: AsyncClient) -> None:
    await _create(client, hour=9, artisan="alice")  # alice busy 9–11
    entry = await _create(client, hour=9, artisan="")  # unassigned at 9 — wait, conflicts?

    # The unassigned entry overlaps alice's but has no artisan/vehicle, so it is
    # allowed; auto-assign must skip alice (busy) and pick bob.
    r = await client.post(
        f"/api/planning/{entry['id']}/assign",
        json={"auto": True, "candidates": ["alice", "bob"]},
    )
    assert r.status_code == 200, r.text
    assert r.json()["artisan"] == "bob"


async def test_no_hard_delete(client: AsyncClient) -> None:
    entry = await _create(client)
    r = await client.delete(f"/api/planning/{entry['id']}")
    assert r.status_code == 405  # Loi 5


async def test_scoped_to_company(client: AsyncClient, second_client: AsyncClient) -> None:
    entry = await _create(client)
    r = await second_client.get(f"/api/planning/{entry['id']}")
    assert r.status_code == 404
