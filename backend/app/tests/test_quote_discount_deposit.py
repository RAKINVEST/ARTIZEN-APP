"""HTTP tests for quote discount + deposit (V1.1 #3, décision 5).

A global discount on the HT recomputes VAT per rate; a deposit splits the net
TTC into an amount to pay now and a balance. Everything is computed by the
backend and persisted (photograph); the endpoints only take the parameters.
"""

import io

import pytest
from httpx import AsyncClient
from pypdf import PdfReader


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    return (await client.get("/api/branding/profile")).json()["company"]["id"]


@pytest.fixture(autouse=True)
async def _normal_regime(client: AsyncClient) -> None:
    """VAT assertions need the réel regime; the franchise test overrides it."""
    await client.put("/api/branding/company", json={"vat_regime": "normal"})


@pytest.fixture
async def client_id(client: AsyncClient) -> str:
    return (await client.post("/api/clients", json={"last_name": "Remise"})).json()["id"]


@pytest.fixture
async def category_id(client: AsyncClient) -> str:
    return (await client.post("/api/catalog/categories", json={"name": "Divers"})).json()["id"]


async def _item(client: AsyncClient, category_id: str, *, price: str, vat: str) -> str:
    return (
        await client.post(
            "/api/catalog/items",
            json={
                "category_id": category_id,
                "designation": "Article",
                "item_type": "product",
                "unit": "u",
                "unit_price_ht": price,
                "vat_rate": vat,
            },
        )
    ).json()["id"]


async def _create(client: AsyncClient, client_id: str, lines: list[dict], **adjustments) -> dict:
    return (
        await client.post(
            "/api/quotes",
            json={"client_id": client_id, "lines": lines, **adjustments},
        )
    ).json()


# --- Discount --------------------------------------------------------------


async def test_percent_discount_recomputes_totals(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        discount_type="percent", discount_value="10",
    )
    assert body["total_ht"] == "100.00"  # gross subtotal unchanged
    assert body["discount_amount"] == "10.00"
    assert body["net_total_ht"] == "90.00"
    assert body["net_total_vat"] == "18.00"
    assert body["net_total_ttc"] == "108.00"
    assert body["balance_due"] == "108.00"  # no deposit


async def test_amount_discount(client: AsyncClient, client_id: str, category_id: str) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        discount_type="amount", discount_value="25.00",
    )
    assert body["discount_amount"] == "25.00"
    assert body["net_total_ht"] == "75.00"
    assert body["net_total_vat"] == "15.00"


async def test_multi_rate_discount_reallocates_vat(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    a = await _item(client, category_id, price="100.00", vat="20.00")
    b = await _item(client, category_id, price="300.00", vat="10.00")
    body = await _create(
        client, client_id,
        [{"catalog_item_id": a, "quantity": "1"}, {"catalog_item_id": b, "quantity": "1"}],
        discount_type="percent", discount_value="10",
    )
    # subtotal 400 ; discount 40 ; net HT 360 ; VAT 18 (on 90) + 27 (on 270) = 45.
    assert body["discount_amount"] == "40.00"
    assert body["net_total_ht"] == "360.00"
    assert body["net_total_vat"] == "45.00"
    assert body["net_total_ttc"] == "405.00"


# --- Deposit ---------------------------------------------------------------


async def test_percent_deposit_splits_the_net(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        deposit_type="percent", deposit_value="30",
    )
    # net TTC 120 ; deposit 30% = 36 ; balance 84. Totals untouched.
    assert body["net_total_ttc"] == "120.00"
    assert body["deposit_amount"] == "36.00"
    assert body["balance_due"] == "84.00"


async def test_discount_and_deposit_combined(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        discount_type="percent", discount_value="10",
        deposit_type="percent", deposit_value="25",
    )
    # net TTC 108 ; deposit 25% of 108 = 27 ; balance 81.
    assert body["net_total_ttc"] == "108.00"
    assert body["deposit_amount"] == "27.00"
    assert body["balance_due"] == "81.00"


# --- Neutral / calculate ---------------------------------------------------


async def test_no_adjustment_net_equals_gross(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(client, client_id, [{"catalog_item_id": item, "quantity": "1"}])
    assert body["discount_amount"] == "0.00"
    assert body["net_total_ht"] == body["total_ht"] == "100.00"
    assert body["net_total_ttc"] == body["total_ttc"] == "120.00"
    assert body["deposit_amount"] == "0.00"
    assert body["balance_due"] == "120.00"


async def test_calculate_preview_returns_adjustments(
    client: AsyncClient, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = (
        await client.post(
            "/api/quotes/calculate",
            json={
                "lines": [{"catalog_item_id": item, "quantity": "1"}],
                "discount_type": "percent", "discount_value": "10",
                "deposit_type": "amount", "deposit_value": "50.00",
            },
        )
    ).json()
    assert body["net_total_ttc"] == "108.00"
    assert body["deposit_amount"] == "50.00"
    assert body["balance_due"] == "58.00"


# --- Bounds (422) ----------------------------------------------------------


async def test_discount_amount_over_subtotal_is_422(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    resp = await client.post(
        "/api/quotes",
        json={
            "client_id": client_id, "lines": [{"catalog_item_id": item, "quantity": "1"}],
            "discount_type": "amount", "discount_value": "500.00",
        },
    )
    assert resp.status_code == 422


async def test_deposit_amount_over_net_ttc_is_422(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    resp = await client.post(
        "/api/quotes",
        json={
            "client_id": client_id, "lines": [{"catalog_item_id": item, "quantity": "1"}],
            "deposit_type": "amount", "deposit_value": "999.00",
        },
    )
    assert resp.status_code == 422


async def test_discount_percent_over_100_is_422(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    resp = await client.post(
        "/api/quotes",
        json={
            "client_id": client_id, "lines": [{"catalog_item_id": item, "quantity": "1"}],
            "discount_type": "percent", "discount_value": "150",
        },
    )
    assert resp.status_code == 422


async def test_value_without_type_is_422(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    resp = await client.post(
        "/api/quotes",
        json={
            "client_id": client_id, "lines": [{"catalog_item_id": item, "quantity": "1"}],
            "discount_value": "10",  # no discount_type
        },
    )
    assert resp.status_code == 422


# --- Interactions with V1.1 #2 --------------------------------------------


async def test_free_line_with_discount(client: AsyncClient, client_id: str) -> None:
    body = await _create(
        client, client_id,
        [{"quantity": "2", "designation": "Péage", "unit": "trajet",
          "unit_price_ht": "50.00", "vat_rate": "20.00"}],
        discount_type="percent", discount_value="10",
    )
    # 2×50 = 100 HT ; discount 10 ; net HT 90, VAT 18, TTC 108.
    assert body["net_total_ht"] == "90.00"
    assert body["net_total_ttc"] == "108.00"


async def test_custom_price_with_discount(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    body = await _create(
        client, client_id,
        [{"catalog_item_id": item, "quantity": "1", "unit_price_ht": "200.00"}],
        discount_type="percent", discount_value="10",
    )
    # override 200 ; discount 20 ; net HT 180, TTC 216.
    assert body["total_ht"] == "200.00"
    assert body["net_total_ht"] == "180.00"
    assert body["net_total_ttc"] == "216.00"


async def test_franchise_discount_keeps_vat_zero(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    await client.put("/api/branding/company", json={"vat_regime": "franchise"})
    try:
        item = await _item(client, category_id, price="100.00", vat="20.00")
        body = await _create(
            client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
            discount_type="percent", discount_value="10",
        )
        assert body["net_total_ht"] == "90.00"
        assert body["net_total_vat"] == "0.00"
        assert body["net_total_ttc"] == "90.00"
    finally:
        await client.put("/api/branding/company", json={"vat_regime": "normal"})


# --- Duplication + PDF -----------------------------------------------------


async def test_duplicate_preserves_discount_and_deposit(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    created = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        discount_type="percent", discount_value="10",
        deposit_type="percent", deposit_value="25",
    )
    dup = (await client.post(f"/api/quotes/{created['id']}/duplicate")).json()
    assert dup["discount_type"] == "percent"
    assert dup["discount_amount"] == "10.00"
    assert dup["net_total_ttc"] == "108.00"
    assert dup["deposit_amount"] == "27.00"
    assert dup["balance_due"] == "81.00"


async def test_pdf_shows_remise_and_acompte(
    client: AsyncClient, client_id: str, category_id: str
) -> None:
    item = await _item(client, category_id, price="100.00", vat="20.00")
    created = await _create(
        client, client_id, [{"catalog_item_id": item, "quantity": "1"}],
        discount_type="percent", discount_value="10",
        deposit_type="percent", deposit_value="25",
    )
    pdf = (await client.get(f"/api/quotes/{created['id']}/pdf")).content
    text = " ".join(page.extract_text() for page in PdfReader(io.BytesIO(pdf)).pages)
    assert "Remise" in text
    assert "Acompte" in text
    assert "SOLDE" in text
