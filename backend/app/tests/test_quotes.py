"""Tests for the quotes module: quote creation, HT/VAT/TTC calculation,
rounding, and the inactive-catalog-item guard.
"""

from decimal import Decimal

import pytest
from httpx import AsyncClient

from app.quotes.calculator import QuoteCalculator


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def client_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Client Devis"}
    )
    return response.json()["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Chauffage"}
    )
    return response.json()["id"]


async def _create_item(
    client: AsyncClient, company_id: str, category_id: str, *, unit_price_ht: str, vat_rate: str
) -> str:
    response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Chauffe-eau Atlantic 200 L",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": unit_price_ht,
            "vat_rate": vat_rate,
        },
    )
    return response.json()["id"]


async def test_create_quote_calculates_ht_vat_ttc(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )

    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item_id, "quantity": "2"}],
        },
    )

    assert response.status_code == 201
    body = response.json()
    assert body["total_ht"] == "200.00"
    assert body["total_vat"] == "40.00"
    assert body["total_ttc"] == "240.00"
    assert len(body["lines"]) == 1
    line = body["lines"][0]
    assert line["total_ht"] == "200.00"
    assert line["total_vat"] == "40.00"
    assert line["total_ttc"] == "240.00"
    assert line["designation"] == "Chauffe-eau Atlantic 200 L"


async def test_create_quote_sums_multiple_lines(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_a = await _create_item(
        client, company_id, category_id, unit_price_ht="50.00", vat_rate="20.00"
    )
    item_b = await _create_item(
        client, company_id, category_id, unit_price_ht="30.00", vat_rate="10.00"
    )

    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [
                {"catalog_item_id": item_a, "quantity": "1"},
                {"catalog_item_id": item_b, "quantity": "2"},
            ],
        },
    )

    assert response.status_code == 201
    body = response.json()
    # 50.00 + 60.00 = 110.00 HT ; VAT = 10.00 + 6.00 = 16.00
    assert body["total_ht"] == "110.00"
    assert body["total_vat"] == "16.00"
    assert body["total_ttc"] == "126.00"


async def test_get_quote(client: AsyncClient, company_id: str, client_id: str, category_id: str) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    create_response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item_id, "quantity": "1"}],
        },
    )
    quote_id = create_response.json()["id"]

    response = await client.get(f"/api/quotes/{quote_id}")

    assert response.status_code == 200
    assert response.json()["id"] == quote_id


async def test_inactive_catalog_item_rejected(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    await client.delete(f"/api/catalog/items/{item_id}")  # deactivates

    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item_id, "quantity": "1"}],
        },
    )

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "inactive_catalog_item"


def test_calculator_rounding_uses_half_up() -> None:
    # 0.67 * 1.50 = 1.0050 exactly: a genuine rounding tie. ROUND_HALF_UP
    # must give 1.01; Python's default (banker's rounding) would give 1.00.
    totals = QuoteCalculator().calculate_line(
        quantity=Decimal("1.50"), unit_price_ht=Decimal("0.67"), vat_rate=Decimal("0")
    )

    assert totals.total_ht == Decimal("1.01")


def test_calculator_quote_totals_sum_lines() -> None:
    calculator = QuoteCalculator()
    line_1 = calculator.calculate_line(
        quantity=Decimal("2"), unit_price_ht=Decimal("100.00"), vat_rate=Decimal("20.00")
    )
    line_2 = calculator.calculate_line(
        quantity=Decimal("1"), unit_price_ht=Decimal("50.00"), vat_rate=Decimal("10.00")
    )

    totals = calculator.calculate_quote([line_1, line_2])

    assert totals.total_ht == Decimal("250.00")
    assert totals.total_vat == Decimal("45.00")
    assert totals.total_ttc == Decimal("295.00")


# --- Editing a quote (it stays modifiable indefinitely) ---


async def _create_quote(client: AsyncClient, company_id: str, client_id: str, item_id: str,
                        quantity: str = "2") -> dict:
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item_id, "quantity": quantity}],
        },
    )
    return response.json()


async def test_update_quote_replaces_lines_and_recomputes_totals(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    quote = await _create_quote(client, company_id, client_id, item_id, quantity="2")
    assert quote["total_ttc"] == "240.00"

    response = await client.put(
        f"/api/quotes/{quote['id']}",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "5"}]},
    )

    assert response.status_code == 200
    body = response.json()
    assert body["id"] == quote["id"]  # same quote, edited in place
    assert len(body["lines"]) == 1  # old line replaced, not duplicated
    assert body["total_ht"] == "500.00"
    assert body["total_ttc"] == "600.00"


async def test_update_quote_can_be_repeated(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    quote = await _create_quote(client, company_id, client_id, item_id)

    for quantity, expected_ht in (("1", "100.00"), ("3", "300.00"), ("7", "700.00")):
        response = await client.put(
            f"/api/quotes/{quote['id']}",
            json={"lines": [{"catalog_item_id": item_id, "quantity": quantity}]},
        )
        assert response.status_code == 200
        assert response.json()["total_ht"] == expected_ht


async def test_update_quote_can_change_the_client(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    quote = await _create_quote(client, company_id, client_id, item_id)
    other = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Autre Client"}
    )
    other_id = other.json()["id"]

    response = await client.put(
        f"/api/quotes/{quote['id']}",
        json={"client_id": other_id, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )

    assert response.status_code == 200
    assert response.json()["client_id"] == other_id


async def test_update_unknown_quote_returns_404(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    response = await client.put(
        "/api/quotes/00000000-0000-0000-0000-000000000000",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )
    assert response.status_code == 404


async def test_update_quote_is_scoped_to_company(
    client: AsyncClient,
    second_client: AsyncClient,
    company_id: str,
    client_id: str,
    category_id: str,
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    quote = await _create_quote(client, company_id, client_id, item_id)

    # Another company can neither see nor edit this quote.
    response = await second_client.put(
        f"/api/quotes/{quote['id']}",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "9"}]},
    )
    assert response.status_code == 404


async def test_list_quotes_can_be_filtered_by_client(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    await _create_quote(client, company_id, client_id, item_id)

    other = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Client Sans Devis"}
    )
    other_id = other.json()["id"]

    mine = await client.get(f"/api/quotes?client_id={client_id}")
    assert mine.status_code == 200
    assert len(mine.json()) == 1
    assert all(q["client_id"] == client_id for q in mine.json())

    empty = await client.get(f"/api/quotes?client_id={other_id}")
    assert empty.json() == []
