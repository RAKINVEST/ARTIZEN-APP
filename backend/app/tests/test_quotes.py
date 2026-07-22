"""Tests for the quotes module: quote creation, HT/VAT/TTC calculation,
rounding, the inactive-catalog-item guard, and the schema bounds that keep
a persisted line consistent with what the calculator computed.
"""

import uuid
from decimal import Decimal

import pytest
from httpx import AsyncClient
from pydantic import ValidationError

from app.catalog.models import ItemType
from app.catalog.schemas import CatalogItemCreate
from app.quotes.calculator import QuoteCalculator, VatBucket
from app.quotes.schemas import QuoteLineCreate


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


async def test_delete_quote_removes_it_and_its_lines(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    """Deleting is the only way to undo a mistyped quote — there is no
    update path. It must actually be gone afterwards."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    created = await client.post(
        "/api/quotes",
        json={"client_id": client_id, "lines": [{"catalog_item_id": item_id, "quantity": "2"}]},
    )
    quote_id = created.json()["id"]

    delete_response = await client.delete(f"/api/quotes/{quote_id}")

    assert delete_response.status_code == 204
    assert (await client.get(f"/api/quotes/{quote_id}")).status_code == 404


async def test_delete_quote_leaves_the_catalog_item_alone(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    """The lines cascade, but the catalog item they referenced must not:
    QuoteLine.catalog_item_id is RESTRICT precisely so a quote can never
    take an item down with it."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    created = await client.post(
        "/api/quotes",
        json={"client_id": client_id, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )

    await client.delete(f"/api/quotes/{created.json()['id']}")

    assert (await client.get(f"/api/catalog/items/{item_id}")).status_code == 200


async def test_delete_quote_of_another_company_is_a_404(
    client: AsyncClient,
    second_client: AsyncClient,
    company_id: str,
    client_id: str,
    category_id: str,
) -> None:
    """404 rather than 403: confirming the quote exists would already leak
    it. And the quote must survive the attempt."""
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    created = await client.post(
        "/api/quotes",
        json={"client_id": client_id, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )
    quote_id = created.json()["id"]

    response = await second_client.delete(f"/api/quotes/{quote_id}")

    assert response.status_code == 404
    assert (await client.get(f"/api/quotes/{quote_id}")).status_code == 200


async def test_delete_unknown_quote_is_a_404(client: AsyncClient) -> None:
    response = await client.delete(f"/api/quotes/{uuid.uuid4()}")

    assert response.status_code == 404


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


def test_calculator_handles_quote_without_lines() -> None:
    # sum()'s Decimal("0.00") start value is what keeps this from being a
    # TypeError on an int 0 — worth pinning, since it's invisible at the
    # call site.
    totals = QuoteCalculator().calculate_quote([])

    assert totals.total_ht == Decimal("0.00")
    assert totals.total_vat == Decimal("0.00")
    assert totals.total_ttc == Decimal("0.00")


@pytest.mark.parametrize("quantity", ["0.333", "1.005", "0.004"])
def test_quote_line_rejects_quantity_finer_than_the_column(quantity: str) -> None:
    """QuoteLine.quantity is Numeric(10, 2). The calculator used to compute
    total_ht from the full-precision value while PostgreSQL rounded the
    quantity it stored, so the persisted line no longer multiplied out:
    "0.333 × 300.00" was saved as "0.33 × 300.00 = 99.90" — a line the
    artisan cannot justify to a customer. Worse, "0.004" passed gt=0 and
    then stored as 0.00: a quantity of nothing, billed 0.40 €.

    A quantity the column can't hold must be refused, never rounded behind
    the artisan's back."""
    with pytest.raises(ValidationError):
        QuoteLineCreate(catalog_item_id=uuid.uuid4(), quantity=Decimal(quantity))


@pytest.mark.parametrize("quantity", ["1", "2.5", "0.01", "99999999.99"])
def test_quote_line_accepts_quantity_the_column_can_hold(quantity: str) -> None:
    line = QuoteLineCreate(catalog_item_id=uuid.uuid4(), quantity=Decimal(quantity))

    assert line.quantity == Decimal(quantity)


def test_quote_line_rejects_quantity_beyond_column_range() -> None:
    # Numeric(10, 2) tops out at 99_999_999.99; without max_digits this
    # reached PostgreSQL and failed as a raw "numeric field overflow" 500
    # instead of a 422.
    with pytest.raises(ValidationError):
        QuoteLineCreate(catalog_item_id=uuid.uuid4(), quantity=Decimal("100000000"))


@pytest.mark.parametrize("vat_rate", ["101", "500", "-1"])
def test_catalog_item_rejects_impossible_vat_rate(vat_rate: str) -> None:
    # An unbounded rate put a 500 %-VAT quote in front of a real customer.
    with pytest.raises(ValidationError):
        CatalogItemCreate(
            category_id=uuid.uuid4(),
            designation="Test",
            item_type=ItemType.SERVICE,
            unit="h",
            unit_price_ht=Decimal("100.00"),
            vat_rate=Decimal(vat_rate),
        )


@pytest.mark.parametrize("vat_rate", ["0", "2.1", "5.5", "10", "20", "100"])
def test_catalog_item_accepts_legal_vat_rates(vat_rate: str) -> None:
    item = CatalogItemCreate(
        category_id=uuid.uuid4(),
        designation="Test",
        item_type=ItemType.SERVICE,
        unit="h",
        unit_price_ht=Decimal("100.00"),
        vat_rate=Decimal(vat_rate),
    )

    assert item.vat_rate == Decimal(vat_rate)


# --- V2: VAT breakdown (the per-rate summary a French document must show) ---


def test_vat_breakdown_groups_a_single_rate() -> None:
    breakdown = QuoteCalculator().calculate_vat_breakdown(
        [(Decimal("20.00"), Decimal("100.00"), Decimal("20.00"))]
    )

    assert breakdown == [
        VatBucket(rate=Decimal("20.00"), base_ht=Decimal("100.00"), vat_amount=Decimal("20.00"))
    ]


def test_vat_breakdown_merges_lines_at_the_same_rate() -> None:
    """Two lines at 20% must collapse into one bucket — the summary shows
    one row per rate, not one per line. This is the merge branch, which no
    test reached before."""
    breakdown = QuoteCalculator().calculate_vat_breakdown(
        [
            (Decimal("20.00"), Decimal("100.00"), Decimal("20.00")),
            (Decimal("20.00"), Decimal("50.00"), Decimal("10.00")),
        ]
    )

    assert breakdown == [
        VatBucket(rate=Decimal("20.00"), base_ht=Decimal("150.00"), vat_amount=Decimal("30.00"))
    ]


def test_vat_breakdown_keeps_distinct_rates_separate_and_sorted() -> None:
    """Mixed rates stay in their own buckets, sorted ascending so the
    document reads the same regardless of line entry order."""
    breakdown = QuoteCalculator().calculate_vat_breakdown(
        [
            (Decimal("20.00"), Decimal("450.00"), Decimal("90.00")),
            (Decimal("10.00"), Decimal("150.00"), Decimal("15.00")),
            (Decimal("5.50"), Decimal("40.00"), Decimal("2.20")),
            (Decimal("20.00"), Decimal("50.00"), Decimal("10.00")),  # merges into 20%
        ]
    )

    assert breakdown == [
        VatBucket(rate=Decimal("5.50"), base_ht=Decimal("40.00"), vat_amount=Decimal("2.20")),
        VatBucket(rate=Decimal("10.00"), base_ht=Decimal("150.00"), vat_amount=Decimal("15.00")),
        VatBucket(rate=Decimal("20.00"), base_ht=Decimal("500.00"), vat_amount=Decimal("100.00")),
    ]
    # The buckets sum back to the quote totals — the breakdown is a
    # partition of the VAT, not a separate computation of it.
    assert sum(b.base_ht for b in breakdown) == Decimal("690.00")
    assert sum(b.vat_amount for b in breakdown) == Decimal("117.20")


def test_vat_breakdown_of_no_lines_is_empty() -> None:
    assert QuoteCalculator().calculate_vat_breakdown([]) == []


async def test_send_quote_emails_the_pdf_and_marks_it_sent(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    from app.email.providers.mock import MockEmailProvider

    recipient = "envoi-devis@artizen-qa.io"
    cid = (
        await client.post(
            "/api/clients",
            json={
                "company_id": company_id,
                "last_name": "Destinataire",
                "email": recipient,
            },
        )
    ).json()["id"]
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="100.00", vat_rate="20.00"
    )
    created = await client.post(
        "/api/quotes",
        json={"client_id": cid, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )
    quote_id = created.json()["id"]
    number = created.json()["quote_number"]

    # Validate (draft → pending) so it becomes sendable.
    await client.put(f"/api/quotes/{quote_id}/status", json={"status": "pending"})

    response = await client.post(f"/api/quotes/{quote_id}/send")

    assert response.status_code == 200
    assert response.json()["status"] == "sent"
    message = MockEmailProvider.last_for(recipient)
    assert message is not None
    assert number in message["subject"]
    assert message["attachments"] == [f"{number}.pdf"]


async def test_send_quote_without_client_email_is_422(
    client: AsyncClient, company_id: str, client_id: str, category_id: str
) -> None:
    # The shared client fixture carries no email — there is nowhere to send it.
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    quote_id = (
        await client.post(
            "/api/quotes",
            json={
                "client_id": client_id,
                "lines": [{"catalog_item_id": item_id, "quantity": "1"}],
            },
        )
    ).json()["id"]
    await client.put(f"/api/quotes/{quote_id}/status", json={"status": "pending"})

    response = await client.post(f"/api/quotes/{quote_id}/send")

    assert response.status_code == 422


async def test_send_quote_requires_validation_first(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    # A brand-new quote is a draft; it must be validated (→ pending) before it
    # can be sent, so sending a draft is refused.
    recipient = "envoi-brouillon@artizen-qa.io"
    cid = (
        await client.post(
            "/api/clients",
            json={"company_id": company_id, "last_name": "X", "email": recipient},
        )
    ).json()["id"]
    item_id = await _create_item(
        client, company_id, category_id, unit_price_ht="10.00", vat_rate="20.00"
    )
    quote_id = (
        await client.post(
            "/api/quotes",
            json={"client_id": cid, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
        )
    ).json()["id"]

    response = await client.post(f"/api/quotes/{quote_id}/send")

    assert response.status_code == 409  # draft → sent is not allowed
