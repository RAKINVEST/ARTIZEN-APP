"""HTTP-level tests for the Mission Engine (require the DB — run in Docker).

A freshly registered tenant, real JWT, exercised through the public /api
contract: create/open a mission, associate a site and workflow, attach a note,
track progress and timeline, tenant scope.
"""

from httpx import AsyncClient


async def _client_id(ac: AsyncClient) -> str:
    r = await ac.post("/api/clients", json={"last_name": "Durand"})
    assert r.status_code == 201, r.text
    return r.json()["id"]


async def _create_mission(ac: AsyncClient) -> dict:
    customer_id = await _client_id(ac)
    r = await ac.post(
        "/api/missions", json={"customer_id": customer_id, "title": "Remplacement chauffe-eau"}
    )
    assert r.status_code == 201, r.text
    return r.json()


async def test_create_mission(client: AsyncClient) -> None:
    mission = await _create_mission(client)
    assert mission["status"] == "nouvelle"
    assert mission["progress"] == 0
    assert mission["is_terminal"] is False
    assert len(mission["timeline"]) == 1  # created


async def test_create_requires_known_customer(client: AsyncClient) -> None:
    import uuid

    r = await client.post(
        "/api/missions", json={"customer_id": str(uuid.uuid4()), "title": "x"}
    )
    assert r.status_code == 404


async def test_lifecycle_and_progress(client: AsyncClient) -> None:
    mission = await _create_mission(client)
    mid = mission["id"]
    for target, progress in (("ouverte", 25), ("en_cours", 60), ("cloturee", 100)):
        r = await client.post(f"/api/missions/{mid}/status", json={"status": target})
        assert r.status_code == 200, r.text
        body = r.json()
        assert body["status"] == target
        assert body["progress"] == progress
    assert body["is_terminal"] is True
    assert len(body["timeline"]) == 4  # created + 3 transitions


async def test_invalid_transition_returns_409(client: AsyncClient) -> None:
    mission = await _create_mission(client)
    r = await client.post(
        f"/api/missions/{mission['id']}/status", json={"status": "cloturee"}
    )
    assert r.status_code == 409  # can't skip from 'nouvelle'


async def test_associate_workflow_and_attach_note(client: AsyncClient) -> None:
    mission = await _create_mission(client)
    mid = mission["id"]
    wf = await client.post(
        "/api/workflow/instances", json={"definition_slug": "intervention", "context": {}}
    )
    assert wf.status_code == 201, wf.text
    r = await client.post(
        f"/api/missions/{mid}/workflow",
        json={"workflow_instance_id": wf.json()["id"]},
    )
    assert r.status_code == 200, r.text
    assert r.json()["workflow_instance_id"] == wf.json()["id"]

    r = await client.post(
        f"/api/missions/{mid}/attachments", json={"kind": "note", "text": "Client absent"}
    )
    assert r.status_code == 200, r.text
    assert any(a["kind"] == "note" for a in r.json()["attachments"])


async def test_mission_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    mission = await _create_mission(client)
    r = await second_client.get(f"/api/missions/{mission['id']}")
    assert r.status_code == 404  # cross-tenant -> not found


async def test_no_hard_delete_route(client: AsyncClient) -> None:
    mission = await _create_mission(client)
    r = await client.delete(f"/api/missions/{mission['id']}")
    assert r.status_code == 405  # Loi 5: no hard delete
