"""HTTP-level tests for the AI Companion (require the app/DB — run in Docker).

A real tenant + JWT: hold a multi-turn conversation, resume a pending action,
confirm it into a real orchestration, refuse to create a quote (hand it off
instead), and stay tenant-scoped. The mock AI provider keeps everything offline
and deterministic.
"""

from httpx import AsyncClient


async def _customer(ac: AsyncClient) -> str:
    r = await ac.post("/api/clients", json={"last_name": "Bernard"})
    assert r.status_code == 201, r.text
    return r.json()["id"]


async def test_chat_knowledge_needs_no_confirmation(client: AsyncClient) -> None:
    r = await client.post("/api/ai/chat", json={"message": "Comment purger un radiateur ?"})
    assert r.status_code == 200, r.text
    body = r.json()
    assert body["intent"] == "search_knowledge"
    assert body["needs_confirmation"] is False
    assert body["session_id"]
    assert "engine" in body["explanation"]  # explainable


async def test_write_intent_asks_then_resumes_then_confirms(client: AsyncClient) -> None:
    customer_id = await _customer(client)
    # 1) Ask to plan — the client is missing, so the Companion asks (no action).
    first = await client.post("/api/ai/chat", json={"message": "planifie une intervention"})
    assert first.status_code == 200, first.text
    sid = first.json()["session_id"]
    assert first.json()["proposed_action"]["missing"] == ["customer_id"]
    assert first.json()["needs_confirmation"] is False

    # 2) Provide the client via params — the action resumes and is ready.
    second = await client.post(
        "/api/ai/continue",
        json={"session_id": sid, "message": "pour ce client",
              "params": {"customer_id": customer_id, "title": "Dépannage"}},
    )
    assert second.status_code == 200, second.text
    assert second.json()["needs_confirmation"] is True
    assert second.json()["proposed_action"]["missing"] == []

    # 3) Confirm — the Companion runs a real orchestration via its public service.
    confirmed = await client.post("/api/ai/confirm", json={"session_id": sid})
    assert confirmed.status_code == 200, confirmed.text
    body = confirmed.json()
    assert body["executed"] is True
    assert body["result"]["status"] == "reussi"
    assert "create_mission" in body["result"]["results"]


async def test_confirm_without_pending_is_rejected(client: AsyncClient) -> None:
    first = await client.post("/api/ai/chat", json={"message": "bonjour"})
    sid = first.json()["session_id"]
    r = await client.post("/api/ai/confirm", json={"session_id": sid})
    assert r.status_code == 400  # nothing to validate


async def test_cancel_clears_pending_action(client: AsyncClient) -> None:
    first = await client.post(
        "/api/ai/chat",
        json={"message": "préviens le client", "params": {"recipient": "x@y.z"}},
    )
    sid = first.json()["session_id"]
    assert first.json()["needs_confirmation"] is True
    r = await client.post("/api/ai/cancel", json={"session_id": sid})
    assert r.status_code == 200, r.text
    assert r.json()["executed"] is False
    # Nothing pending anymore.
    session = await client.get("/api/ai/session", params={"session_id": sid})
    assert session.json()["pending_action"] is None


async def test_quote_is_previewed_and_handed_off_never_created(client: AsyncClient) -> None:
    customer_id = await _customer(client)
    category = (await client.post("/api/catalog/categories", json={"name": "Chauffage"})).json()
    item = (
        await client.post(
            "/api/catalog/items",
            json={"category_id": category["id"], "designation": "Ballon 200L",
                  "item_type": "product", "unit": "unite",
                  "unit_price_ht": "100.00", "vat_rate": "20.00"},
        )
    ).json()
    chat = await client.post(
        "/api/ai/chat",
        json={"message": "prépare un devis", "params": {
            "client_id": customer_id,
            "lines": [{"catalog_item_id": item["id"], "quantity": "2"}]}},
    )
    assert chat.status_code == 200, chat.text
    sid = chat.json()["session_id"]
    assert chat.json()["result"]["preview"]["total_ttc"] == "240.00"  # read-only calc

    confirmed = await client.post("/api/ai/confirm", json={"session_id": sid})
    body = confirmed.json()
    # The AI never persisted a quote (Invariant #1) — it hands the payload back.
    assert body["executed"] is False
    assert body["result"]["handoff"] == "POST /api/quotes"


async def test_session_lifecycle_and_memory(client: AsyncClient) -> None:
    first = await client.post("/api/ai/chat", json={"message": "bonjour"})
    sid = first.json()["session_id"]
    await client.post(
        "/api/ai/continue", json={"session_id": sid, "message": "comment purger un radiateur"}
    )
    session = await client.get("/api/ai/session", params={"session_id": sid})
    assert session.status_code == 200
    assert len(session.json()["turns"]) == 4  # two turns, user+assistant each

    deleted = await client.delete("/api/ai/session", params={"session_id": sid})
    assert deleted.status_code == 204
    gone = await client.get("/api/ai/session", params={"session_id": sid})
    assert gone.status_code == 404


async def test_session_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    first = await client.post("/api/ai/chat", json={"message": "bonjour"})
    sid = first.json()["session_id"]
    r = await second_client.get("/api/ai/session", params={"session_id": sid})
    assert r.status_code == 404  # a foreign session id is simply not found
