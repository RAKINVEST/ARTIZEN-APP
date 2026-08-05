"""HTTP-level tests for the Workflow Engine (require the DB — run in Docker).

Mirror the other module tests: a freshly registered tenant, real JWT, exercised
through the public /api contract. Proves instantiation, transitions, the
tenant scope and the append-only history.
"""

from httpx import AsyncClient


async def _start(ac: AsyncClient, slug: str = "intervention") -> dict:
    r = await ac.post(
        "/api/workflow/instances",
        json={"definition_slug": slug, "context": {"intent": "remplacer un chauffe-eau"}},
    )
    assert r.status_code == 201, r.text
    return r.json()


async def test_list_definitions(client: AsyncClient) -> None:
    r = await client.get("/api/workflow/definitions")
    assert r.status_code == 200, r.text
    slugs = {d["slug"] for d in r.json()}
    assert "intervention" in slugs


async def test_start_instance_from_context(client: AsyncClient) -> None:
    body = await _start(client)
    assert body["definition_slug"] == "intervention"
    assert body["current_state"] == "proposee"
    assert body["status"] == "running"
    assert body["context"]["intent"] == "remplacer un chauffe-eau"
    assert "planifier" in body["available_events"]
    assert len(body["history"]) == 1  # the "start" event


async def test_unknown_definition_is_rejected(client: AsyncClient) -> None:
    r = await client.post("/api/workflow/instances", json={"definition_slug": "ghost"})
    assert r.status_code == 400


async def test_valid_transition_advances_and_records_history(client: AsyncClient) -> None:
    instance = await _start(client)
    r = await client.post(
        f"/api/workflow/instances/{instance['id']}/transition", json={"event": "planifier"}
    )
    assert r.status_code == 200, r.text
    body = r.json()
    assert body["current_state"] == "planifiee"
    assert len(body["history"]) == 2  # start + planifier


async def test_invalid_transition_returns_409(client: AsyncClient) -> None:
    instance = await _start(client)
    r = await client.post(
        f"/api/workflow/instances/{instance['id']}/transition", json={"event": "cloturer"}
    )
    assert r.status_code == 409  # not allowed from 'proposee'


async def test_full_lifecycle_completes(client: AsyncClient) -> None:
    instance = await _start(client)
    iid = instance["id"]
    for event in ("planifier", "demarrer", "controler", "cloturer"):
        r = await client.post(f"/api/workflow/instances/{iid}/transition", json={"event": event})
        assert r.status_code == 200, r.text
    final = r.json()
    assert final["current_state"] == "cloturee"
    assert final["status"] == "completed"
    assert final["is_terminal"] is True


async def test_instance_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    instance = await _start(client)
    r = await second_client.get(f"/api/workflow/instances/{instance['id']}")
    assert r.status_code == 404  # cross-tenant -> not found, never 403
