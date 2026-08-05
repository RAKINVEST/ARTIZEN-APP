"""HTTP-level tests for the Orchestration Engine (require the DB — run in Docker).

Prove the coordinator runs a validated-decision context into a real
Mission + Workflow (through their public services), records the saga, and stays
tenant-scoped.
"""

from httpx import AsyncClient


async def _customer(ac: AsyncClient) -> str:
    r = await ac.post("/api/clients", json={"last_name": "Durand"})
    assert r.status_code == 201, r.text
    return r.json()["id"]


async def test_orchestration_coordinates_mission_and_workflow(client: AsyncClient) -> None:
    customer_id = await _customer(client)
    r = await client.post(
        "/api/orchestrations",
        json={
            "plan_kind": "intervention",
            "context": {"customer_id": customer_id, "title": "Remplacement chauffe-eau"},
        },
    )
    assert r.status_code == 201, r.text
    body = r.json()
    assert body["status"] == "reussi"
    assert body["is_terminal"] is True
    assert "mission_id" in body["results"]["create_mission"]
    assert "workflow_id" in body["results"]["start_workflow"]
    assert any(e["type"] == "orchestration_completed" for e in body["timeline"])
    assert body["correlation_id"]

    # The coordinated engines really created their own data.
    missions = await client.get("/api/missions")
    assert body["results"]["create_mission"]["mission_id"] in {m["id"] for m in missions.json()}


async def test_unknown_plan_is_rejected(client: AsyncClient) -> None:
    r = await client.post("/api/orchestrations", json={"plan_kind": "ghost", "context": {}})
    assert r.status_code == 400


async def test_missing_customer_fails_cleanly(client: AsyncClient) -> None:
    r = await client.post(
        "/api/orchestrations", json={"plan_kind": "intervention", "context": {}}
    )
    assert r.status_code == 201, r.text
    # No customer_id in context -> the saga fails and records it, not a 500.
    assert r.json()["status"] in ("echec", "partiellement_reussi")


async def test_retry_reruns(client: AsyncClient) -> None:
    customer_id = await _customer(client)
    started = await client.post(
        "/api/orchestrations",
        json={"plan_kind": "intervention", "context": {"customer_id": customer_id, "title": "X"}},
    )
    oid = started.json()["id"]
    r = await client.post(f"/api/orchestrations/{oid}/retry")
    assert r.status_code == 200, r.text
    assert any(e["type"] == "retry_run" for e in r.json()["timeline"])


async def test_orchestration_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    customer_id = await _customer(client)
    started = await client.post(
        "/api/orchestrations",
        json={"plan_kind": "intervention", "context": {"customer_id": customer_id, "title": "X"}},
    )
    r = await second_client.get(f"/api/orchestrations/{started.json()['id']}")
    assert r.status_code == 404
