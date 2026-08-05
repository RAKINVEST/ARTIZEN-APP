"""HTTP-level tests for the Decision Engine (require the app/DB — run in Docker).

Since the Knowledge integration the proposal is sourced from the Knowledge
Engine. These assert the public contract shape and the read-side guarantees;
they are robust to the corpus being absent from the backend container
(a documented limitation) — they check structure, not specific cards.
"""

from httpx import AsyncClient


async def test_interpret_returns_verb_and_target(client: AsyncClient) -> None:
    r = await client.post("/api/decision/interpret", json={"intent": "Je remplace un mitigeur"})
    assert r.status_code == 200, r.text
    body = r.json()
    assert body["verb"] == "remplacer"
    assert body["target"] == "mitigeur"


async def test_propose_returns_proposal_shape(client: AsyncClient) -> None:
    r = await client.post("/api/decision/propose", json={"intent": "Je remplace un mitigeur"})
    assert r.status_code == 200, r.text
    body = r.json()
    # Knowledge-sourced proposal: elements + explanation + confidence, no price.
    assert "elements" in body["proposal"]
    assert "items" in body["explanation"]
    assert "confidence" in body
    assert "total" not in r.text.lower()
    # Explanation covers every proposed element.
    assert len(body["explanation"]["items"]) == len(body["proposal"]["elements"])


async def test_propose_asks_when_intent_unclear(client: AsyncClient) -> None:
    r = await client.post("/api/decision/propose", json={"intent": "bonjour"})
    assert r.status_code == 200, r.text
    body = r.json()
    assert body["needs_confirmation"] is True
    assert body["questions"]  # it asks, never invents
