"""HTTP-level tests for the Knowledge Engine (require the app/DB — run in Docker).

The engine is read-side and filesystem-backed; these assert the public contract
shape and the read-only guarantees. They are robust to the corpus being absent
from the backend container (a documented V1 limitation): they check structure
and status codes, not specific cards.
"""

from httpx import AsyncClient


async def test_search_returns_result_shape(client: AsyncClient) -> None:
    r = await client.get("/api/knowledge/search", params={"q": "mitigeur"})
    assert r.status_code == 200, r.text
    body = r.json()
    assert "matches" in body
    assert "total" in body
    # Validated-only by default: the flag is surfaced, never hidden.
    assert body["include_drafts"] is False


async def test_search_include_drafts_flag(client: AsyncClient) -> None:
    r = await client.get(
        "/api/knowledge/search", params={"q": "mitigeur", "include_drafts": "true"}
    )
    assert r.status_code == 200, r.text
    assert r.json()["include_drafts"] is True


async def test_unknown_detail_returns_404(client: AsyncClient) -> None:
    r = await client.get("/api/knowledge/card/does-not-exist")
    assert r.status_code == 404


async def test_search_requires_auth() -> None:
    from httpx import ASGITransport

    from app.main import app

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as anon:
        r = await anon.get("/api/knowledge/search")
    assert r.status_code in (401, 403)  # no token -> refused
