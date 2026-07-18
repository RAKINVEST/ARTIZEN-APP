"""Phase 0 — Productivité Artisan: server-side search, pagination bounds, and
list filters. Each reduces clicks, typing or scrolling for the artisan.
"""

from httpx import AsyncClient


async def _make_category(client: AsyncClient) -> str:
    return (await client.post("/api/catalog/categories", json={"name": "Chauffage"})).json()["id"]


async def _make_item(client: AsyncClient, category_id: str, designation: str, code: str | None = None) -> str:
    payload = {
        "category_id": category_id, "designation": designation, "item_type": "service",
        "unit": "u", "unit_price_ht": "100.00", "vat_rate": "20.00",
    }
    if code is not None:
        payload["code"] = code
    return (await client.post("/api/catalog/items", json=payload)).json()["id"]


# --- Catalog server-side search (audit C5) ----------------------------------


async def test_catalog_search_matches_designation_server_side(client: AsyncClient) -> None:
    cat = await _make_category(client)
    await _make_item(client, cat, "Chaudière gaz à condensation")
    await _make_item(client, cat, "Radiateur fonte")
    await _make_item(client, cat, "Robinet thermostatique")

    found = (await client.get("/api/catalog/items", params={"q": "chaudière"})).json()
    assert len(found) == 1
    assert found[0]["designation"] == "Chaudière gaz à condensation"


async def test_catalog_search_matches_code(client: AsyncClient) -> None:
    cat = await _make_category(client)
    await _make_item(client, cat, "Article A", code="REF-ABC")
    await _make_item(client, cat, "Article B", code="REF-XYZ")

    found = (await client.get("/api/catalog/items", params={"q": "xyz"})).json()
    assert len(found) == 1 and found[0]["code"] == "REF-XYZ"


async def test_catalog_item_beyond_the_first_page_is_findable(client: AsyncClient) -> None:
    """The productivity win: an item past the default page used to be invisible
    (client-side filter over the first 100 only). Now search reaches it."""
    cat = await _make_category(client)
    for i in range(120):
        await _make_item(client, cat, f"Prestation numéro {i:03d}")
    needle = "Prestation numéro 115"

    found = (await client.get("/api/catalog/items", params={"q": needle})).json()
    assert len(found) == 1 and found[0]["designation"] == needle


# --- Pagination bounds (audit M13 / Y1) -------------------------------------


async def test_pagination_rejects_out_of_range_instead_of_500(client: AsyncClient) -> None:
    # Was: limit=-5 / offset=-1 -> raw 500; limit=1e9 -> loads the whole table.
    assert (await client.get("/api/clients", params={"limit": -5})).status_code == 422
    assert (await client.get("/api/clients", params={"offset": -1})).status_code == 422
    assert (await client.get("/api/clients", params={"limit": 100_000_000})).status_code == 422
    assert (await client.get("/api/catalog/items", params={"limit": 0})).status_code == 422


# --- Quotes list filters (audit M8) -----------------------------------------


async def test_quotes_filter_by_status(client: AsyncClient) -> None:
    cat = await _make_category(client)
    item = await _make_item(client, cat, "Prestation")
    cli = (await client.post("/api/clients", json={"last_name": "Martin"})).json()["id"]

    async def new_quote() -> str:
        return (
            await client.post(
                "/api/quotes",
                json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "1.00"}]},
            )
        ).json()["id"]

    draft = await new_quote()
    to_send = await new_quote()
    await client.put(f"/api/quotes/{to_send}/status", json={"status": "sent"})

    sent = (await client.get("/api/quotes", params={"status": "sent"})).json()
    sent_ids = {q["id"] for q in sent}
    assert to_send in sent_ids and draft not in sent_ids
    assert all(q["status"] == "sent" for q in sent)

    drafts = (await client.get("/api/quotes", params={"status": "draft"})).json()
    assert draft in {q["id"] for q in drafts}
