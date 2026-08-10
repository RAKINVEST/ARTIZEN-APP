"""V1.1 #2 — free lines and per-line custom prices (décision 5).

A quote line may now be a **free line** (no ``catalog_item_id``, everything
typed) or a **catalog line** with an optional ``unit_price_ht`` override. The
calculator stays the only place a total is computed; these tests pin the new
input shapes, the validation that guards them, and the DB behaviours (nullable
``catalog_item_id`` + ``ON DELETE SET NULL``).
"""

import uuid
from decimal import Decimal

import pytest
from httpx import AsyncClient
from pydantic import ValidationError
from sqlalchemy import delete, select

from app.catalog.models import CatalogItem
from app.database.session import AsyncSessionLocal
from app.quotes.models import QuoteLine
from app.quotes.schemas import QuoteLineCreate


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture(autouse=True)
async def _normal_regime(client: AsyncClient) -> None:
    """Free-line VAT assertions need the réel regime — the shared company row
    might have been left in franchise by another test. The franchise test sets
    its own regime explicitly."""
    await client.put("/api/branding/company", json={"vat_regime": "normal"})


@pytest.fixture
async def client_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Client Libre"}
    )
    return response.json()["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Divers"}
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
            "designation": "Article catalogue",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": unit_price_ht,
            "vat_rate": vat_rate,
        },
    )
    return response.json()["id"]


_FREE_LINE = {
    "quantity": "2",
    "designation": "Péage A6 (aller-retour)",
    "unit": "trajet",
    "unit_price_ht": "12.50",
    "vat_rate": "20.00",
}


# --- Schema validation (pure, no DB) --------------------------------------


def test_catalog_line_needs_only_id_and_quantity() -> None:
    QuoteLineCreate(catalog_item_id=uuid.uuid4(), quantity=Decimal("1"))


def test_catalog_line_accepts_a_price_override() -> None:
    line = QuoteLineCreate(
        catalog_item_id=uuid.uuid4(), quantity=Decimal("1"), unit_price_ht=Decimal("15.00")
    )
    assert line.unit_price_ht == Decimal("15.00")


def test_free_line_complete_is_valid() -> None:
    QuoteLineCreate(
        quantity=Decimal("2"),
        designation="Péage",
        unit="trajet",
        unit_price_ht=Decimal("12.50"),
        vat_rate=Decimal("20.00"),
    )


@pytest.mark.parametrize("missing", ["designation", "unit", "unit_price_ht", "vat_rate"])
def test_free_line_requires_every_field(missing: str) -> None:
    payload = {
        "quantity": Decimal("1"),
        "designation": "Péage",
        "unit": "trajet",
        "unit_price_ht": Decimal("12.50"),
        "vat_rate": Decimal("20.00"),
    }
    del payload[missing]
    with pytest.raises(ValidationError):
        QuoteLineCreate(**payload)


# --- Create / calculate ----------------------------------------------------


async def test_create_quote_with_a_free_line(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    response = await client.post(
        "/api/quotes",
        json={"company_id": company_id, "client_id": client_id, "lines": [_FREE_LINE]},
    )

    assert response.status_code == 201
    body = response.json()
    # 2 × 12.50 = 25.00 HT ; VAT 20% = 5.00
    assert body["total_ht"] == "25.00"
    assert body["total_vat"] == "5.00"
    assert body["total_ttc"] == "30.00"
    line = body["lines"][0]
    assert line["catalog_item_id"] is None
    assert line["designation"] == "Péage A6 (aller-retour)"
    assert line["unit"] == "trajet"
    assert line["unit_price_ht"] == "12.50"


async def test_calculate_preview_with_a_free_line(
    client: AsyncClient, company_id: str
) -> None:
    response = await client.post(
        "/api/quotes/calculate",
        json={"company_id": company_id, "lines": [_FREE_LINE]},
    )
    assert response.status_code == 200
    body = response.json()
    assert body["total_ht"] == "25.00"
    assert body["lines"][0]["catalog_item_id"] is None
    assert body["lines"][0]["total_ttc"] == "30.00"


async def test_mixed_catalog_and_free_lines(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [
                {"catalog_item_id": item, "quantity": "1"},
                _FREE_LINE,
            ],
        },
    )
    assert response.status_code == 201
    body = response.json()
    # 100.00 (catalog) + 25.00 (free) = 125.00 HT
    assert body["total_ht"] == "125.00"
    assert len(body["lines"]) == 2


async def test_custom_price_overrides_the_catalog_price(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item, "quantity": "1", "unit_price_ht": "150.00"}],
        },
    )
    assert response.status_code == 201
    body = response.json()
    line = body["lines"][0]
    # The override wins over the catalog's 100.00; désignation still snapshotted.
    assert line["unit_price_ht"] == "150.00"
    assert line["designation"] == "Article catalogue"
    assert line["catalog_item_id"] == item
    assert body["total_ht"] == "150.00"


async def test_catalog_line_without_override_uses_the_catalog_price(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item = await _create_item(
        client, company_id, category_id, unit_price_ht="80.00", vat_rate="20.00"
    )
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item, "quantity": "1"}],
        },
    )
    assert response.status_code == 201
    assert response.json()["lines"][0]["unit_price_ht"] == "80.00"


# --- Duplication / PDF -----------------------------------------------------


async def test_duplicate_preserves_a_free_line(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    created = await client.post(
        "/api/quotes",
        json={"company_id": company_id, "client_id": client_id, "lines": [_FREE_LINE]},
    )
    quote_id = created.json()["id"]

    duplicated = await client.post(f"/api/quotes/{quote_id}/duplicate")
    assert duplicated.status_code == 201
    body = duplicated.json()
    line = body["lines"][0]
    assert line["catalog_item_id"] is None
    assert line["designation"] == "Péage A6 (aller-retour)"
    assert line["unit_price_ht"] == "12.50"
    assert body["total_ht"] == "25.00"


async def test_pdf_renders_with_a_free_line(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    created = await client.post(
        "/api/quotes",
        json={"company_id": company_id, "client_id": client_id, "lines": [_FREE_LINE]},
    )
    quote_id = created.json()["id"]

    pdf = await client.get(f"/api/quotes/{quote_id}/pdf")
    assert pdf.status_code == 200
    assert pdf.headers["content-type"] == "application/pdf"
    assert pdf.content[:5] == b"%PDF-"


async def test_franchise_regime_zeroes_a_free_line_vat(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    await client.put("/api/branding/company", json={"vat_regime": "franchise"})
    try:
        response = await client.post(
            "/api/quotes",
            json={"company_id": company_id, "client_id": client_id, "lines": [_FREE_LINE]},
        )
        assert response.status_code == 201
        body = response.json()
        # The regime forces the rate to 0 even though the free line declared 20%.
        assert body["total_vat"] == "0.00"
        assert body["lines"][0]["vat_rate"] == "0.00"
    finally:
        await client.put("/api/branding/company", json={"vat_regime": "normal"})


# --- Validation (HTTP 422) -------------------------------------------------


async def test_incomplete_free_line_is_422(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            # No catalog_item_id and missing unit_price_ht/vat_rate → free line
            # with holes.
            "lines": [{"quantity": "1", "designation": "Péage", "unit": "trajet"}],
        },
    )
    assert response.status_code == 422


async def test_free_line_zero_price_is_422(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{**_FREE_LINE, "unit_price_ht": "0"}],
        },
    )
    assert response.status_code == 422


async def test_free_line_bad_quantity_is_422(
    client: AsyncClient, company_id: str, client_id: str
) -> None:
    response = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{**_FREE_LINE, "quantity": "0"}],
        },
    )
    assert response.status_code == 422


# --- FK ON DELETE SET NULL (direct DB — no hard-delete endpoint exists) -----


async def test_deleting_a_catalog_item_nulls_the_line_but_keeps_it(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    item = await _create_item(
        client, company_id, category_id, unit_price_ht="40.00", vat_rate="20.00"
    )
    created = await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": client_id,
            "lines": [{"catalog_item_id": item, "quantity": "1"}],
        },
    )
    quote_id = created.json()["id"]

    # Hard-delete the catalog item directly (there is no API for it): the FK is
    # ON DELETE SET NULL, so the line must survive with its snapshot intact and
    # catalog_item_id nulled — the artisan can prune their catalogue freely.
    async with AsyncSessionLocal() as session:
        await session.execute(delete(CatalogItem).where(CatalogItem.id == uuid.UUID(item)))
        await session.commit()

    async with AsyncSessionLocal() as session:
        rows = (
            await session.execute(
                select(QuoteLine).where(QuoteLine.quote_id == uuid.UUID(quote_id))
            )
        ).scalars().all()
    assert len(rows) == 1
    assert rows[0].catalog_item_id is None
    assert rows[0].unit_price_ht == Decimal("40.00")
    assert rows[0].designation == "Article catalogue"
