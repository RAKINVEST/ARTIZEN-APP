"""Tests for the stateless pricing preview: ``POST /quotes/calculate``.

The guided flow needs live HT/VAT/TTC while the artisan adds and removes
lines, and the client is not allowed to add money up itself. These tests
pin the two properties that make such an endpoint safe: it agrees with the
quote that is finally created, and it persists nothing.
"""

from decimal import Decimal

import pytest
from httpx import AsyncClient


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def client_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Client Apercu"}
    )
    return response.json()["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Climatisation"}
    )
    return response.json()["id"]


async def _create_item(
    ac: AsyncClient, company_id: str, category_id: str, *, unit_price_ht: str, vat_rate: str
) -> str:
    response = await ac.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Split mural 3,5 kW",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": unit_price_ht,
            "vat_rate": vat_rate,
        },
    )
    return response.json()["id"]


async def test_preview_matches_the_quote_actually_created(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    """The whole point of the endpoint. A preview the artisan cannot trust —
    one that could show a total the created quote then contradicts — would be
    worse than showing no total at all. Both paths share ``_price_lines``;
    this test is what keeps them from drifting apart."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="320.00", vat_rate="20.00"
    )
    lines = [{"catalog_item_id": item_id, "quantity": "3"}]

    preview = await client.post("/api/quotes/calculate", json={"lines": lines})
    created = await client.post("/api/quotes", json={"client_id": client_id, "lines": lines})

    assert preview.status_code == 200
    assert created.status_code == 201
    previewed, persisted = preview.json(), created.json()
    for field in ("total_ht", "total_vat", "total_ttc"):
        assert Decimal(previewed[field]) == Decimal(persisted[field])
    assert Decimal(previewed["lines"][0]["total_ttc"]) == Decimal(
        persisted["lines"][0]["total_ttc"]
    )


async def test_preview_persists_nothing(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """No quote row, and — just as important — no number burned from the
    counter: previewing must never leave a gap in DEV-2026-XXXX."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="99.99", vat_rate="20.00"
    )
    before = len((await client.get("/api/quotes")).json())

    response = await client.post(
        "/api/quotes/calculate",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "2"}]},
    )

    assert response.status_code == 200
    assert len((await client.get("/api/quotes")).json()) == before


async def test_preview_returns_the_catalog_snapshot_per_line(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """The client renders the line as the backend priced it — designation,
    unit and unit price included — instead of guessing any of them."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="250.00", vat_rate="10.00"
    )

    response = await client.post(
        "/api/quotes/calculate",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "2"}]},
    )

    line = response.json()["lines"][0]
    assert line["designation"] == "Split mural 3,5 kW"
    assert line["unit"] == "unite"
    assert Decimal(line["unit_price_ht"]) == Decimal("250.00")
    assert Decimal(line["total_ht"]) == Decimal("500.00")
    assert Decimal(line["total_vat"]) == Decimal("50.00")
    assert Decimal(line["total_ttc"]) == Decimal("550.00")


async def test_preview_with_no_lines_totals_zero(client: AsyncClient) -> None:
    """An artisan who has not picked anything yet is not an error: the
    wizard opens on an empty draft and must show 0,00 €, not a 422."""
    response = await client.post("/api/quotes/calculate", json={"lines": []})

    assert response.status_code == 200
    body = response.json()
    assert Decimal(body["total_ht"]) == Decimal("0.00")
    assert Decimal(body["total_ttc"]) == Decimal("0.00")
    assert body["lines"] == []


async def test_preview_refuses_another_companys_item(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    """Same tenant rule as ``create``, and the same 404 rather than 403 — a
    403 would confirm the item exists somewhere else."""
    other_company = (await second_client.get("/api/branding/profile")).json()["company"]["id"]
    other_category = (
        await second_client.post(
            "/api/catalog/categories", json={"company_id": other_company, "name": "Autre"}
        )
    ).json()["id"]
    other_item = await _create_item(
        second_client, other_company, other_category, unit_price_ht="10.00", vat_rate="20.00"
    )

    response = await client.post(
        "/api/quotes/calculate",
        json={"lines": [{"catalog_item_id": other_item, "quantity": "1"}]},
    )

    assert response.status_code == 404


# --- Per-rate VAT ventilation exposed to the Récap (V1.1) ---


async def test_calculate_exposes_vat_breakdown_single_rate(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """The Récap needs the per-rate VAT ventilation — the same figures the PDF
    prints. A single-rate quote yields one bucket carrying the whole VAT."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    body = (
        await client.post(
            "/api/quotes/calculate",
            json={"lines": [{"catalog_item_id": item_id, "quantity": "2"}]},
        )
    ).json()

    breakdown = body["vat_breakdown"]
    assert len(breakdown) == 1
    assert Decimal(breakdown[0]["rate"]) == Decimal("20.00")
    assert Decimal(breakdown[0]["base_ht"]) == Decimal("200.00")
    assert Decimal(breakdown[0]["vat_amount"]) == Decimal("40.00")
    # The ventilation always reconciles with the quote's VAT total.
    assert sum(Decimal(b["vat_amount"]) for b in breakdown) == Decimal(body["net_total_vat"])


async def test_calculate_vat_breakdown_multi_rate_sorted_and_reconciles(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    at_20 = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    at_10 = await _create_item(
        client, company_id, category_id, unit_price_ht="50.00", vat_rate="10.00"
    )

    body = (
        await client.post(
            "/api/quotes/calculate",
            json={
                "lines": [
                    {"catalog_item_id": at_20, "quantity": "1"},  # HT 100, VAT 20
                    {"catalog_item_id": at_10, "quantity": "2"},  # HT 100, VAT 10
                ]
            },
        )
    ).json()

    breakdown = body["vat_breakdown"]
    # One bucket per rate, sorted ascending.
    assert [Decimal(b["rate"]) for b in breakdown] == [Decimal("10.00"), Decimal("20.00")]
    by_rate = {Decimal(b["rate"]): b for b in breakdown}
    assert Decimal(by_rate[Decimal("10.00")]["vat_amount"]) == Decimal("10.00")
    assert Decimal(by_rate[Decimal("20.00")]["vat_amount"]) == Decimal("20.00")
    # Reconciles with the quote's net totals — never a figure of its own.
    assert sum(Decimal(b["vat_amount"]) for b in breakdown) == Decimal(body["net_total_vat"])
    assert sum(Decimal(b["base_ht"]) for b in breakdown) == Decimal(body["net_total_ht"])


async def test_calculate_vat_breakdown_is_net_after_discount(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """With a remise, the ventilation is the *net* one (after discount) — it is
    what reconciles with net_total_vat, exactly like the PDF."""
    at_20 = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    at_10 = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="10.00"
    )

    body = (
        await client.post(
            "/api/quotes/calculate",
            json={
                "lines": [
                    {"catalog_item_id": at_20, "quantity": "1"},
                    {"catalog_item_id": at_10, "quantity": "1"},
                ],
                "discount_type": "percent",
                "discount_value": "10",
            },
        )
    ).json()

    breakdown = body["vat_breakdown"]
    assert len(breakdown) == 2
    assert sum(Decimal(b["vat_amount"]) for b in breakdown) == Decimal(body["net_total_vat"])
    # The discount really lowered the VAT (net < gross).
    assert Decimal(body["net_total_vat"]) < Decimal(body["total_vat"])


async def test_calculate_vat_breakdown_franchise_zero_rate(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """A 0 % (franchise) article yields a real 0 % bucket — the backend states
    the fact; the client decides whether to show it."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="0.00"
    )
    body = (
        await client.post(
            "/api/quotes/calculate",
            json={"lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
        )
    ).json()

    breakdown = body["vat_breakdown"]
    assert len(breakdown) == 1
    assert Decimal(breakdown[0]["rate"]) == Decimal("0.00")
    assert Decimal(breakdown[0]["vat_amount"]) == Decimal("0.00")
    assert Decimal(body["total_vat"]) == Decimal("0.00")


async def test_calculate_with_no_lines_has_empty_vat_breakdown(client: AsyncClient) -> None:
    body = (await client.post("/api/quotes/calculate", json={"lines": []})).json()
    assert body["vat_breakdown"] == []


async def test_preview_refuses_inactive_item(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """The preview must fail exactly where ``create`` would, so the artisan
    finds out while editing rather than on the final tap."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    await client.delete(f"/api/catalog/items/{item_id}")  # deactivates

    response = await client.post(
        "/api/quotes/calculate",
        json={"lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "inactive_catalog_item"


async def test_preview_ignores_a_company_id_sent_by_the_client(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """``company_id`` comes from the JWT, never the payload — otherwise a
    caller could price against another tenant's catalog."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )

    response = await client.post(
        "/api/quotes/calculate",
        json={
            "company_id": "00000000-0000-0000-0000-000000000000",
            "lines": [{"catalog_item_id": item_id, "quantity": "1"}],
        },
    )

    assert response.status_code == 200
    assert Decimal(response.json()["total_ht"]) == Decimal("100.00")
