"""Tests for the quote lifecycle (V2): status transitions and numbering.

Kept apart from ``test_quotes.py``, which covers creation and the money
maths. This file only asks two questions: does a quote get an identity a
human can use, and can it only move through its commercial life forwards.
"""

import asyncio
from datetime import datetime, timezone

import pytest
from httpx import AsyncClient

from app.quotes.service import format_quote_number


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def client_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post("/api/clients", json={"last_name": "Client Cycle"})
    return response.json()["id"]


@pytest.fixture
async def item_id(client: AsyncClient, company_id: str) -> str:
    category = await client.post("/api/catalog/categories", json={"name": "Cycle"})
    response = await client.post(
        "/api/catalog/items",
        json={
            "category_id": category.json()["id"],
            "designation": "Prestation",
            "item_type": "service",
            "unit": "h",
            "unit_price_ht": "100.00",
            "vat_rate": "20.00",
        },
    )
    return response.json()["id"]


async def _create_quote(client: AsyncClient, client_id: str, item_id: str) -> dict:
    response = await client.post(
        "/api/quotes",
        json={"client_id": client_id, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]},
    )
    return response.json()


async def _advance_to(client: AsyncClient, quote_id: str, status: str) -> None:
    await client.put(f"/api/quotes/{quote_id}/status", json={"status": "sent"})
    if status != "sent":
        await client.put(f"/api/quotes/{quote_id}/status", json={"status": status})


# --- Numbering ---


def test_quote_number_format_is_prefix_year_sequence() -> None:
    assert format_quote_number(2026, 1) == "DEV-2026-0001"
    assert format_quote_number(2026, 42) == "DEV-2026-0042"


def test_quote_number_padding_is_a_floor_not_a_ceiling() -> None:
    """The 10000th quote of a year must widen, not wrap around into a
    number already handed out. A duplicate document number is not
    something to leave to a format string."""
    assert format_quote_number(2026, 10000) == "DEV-2026-10000"


async def test_created_quote_is_a_numbered_draft(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    quote = await _create_quote(client, client_id, item_id)

    assert quote["status"] == "draft"
    # Each test registers its own company, so this is always its first.
    assert quote["quote_number"] == f"DEV-{datetime.now(timezone.utc).year}-0001"


async def test_quote_numbers_increment_within_a_company(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    numbers = [(await _create_quote(client, client_id, item_id))["quote_number"] for _ in range(3)]

    year = datetime.now(timezone.utc).year
    assert numbers == [f"DEV-{year}-0001", f"DEV-{year}-0002", f"DEV-{year}-0003"]


async def test_quote_numbers_are_per_company_not_global(
    client: AsyncClient, second_client: AsyncClient, client_id: str, item_id: str
) -> None:
    """Two artisans both holding DEV-2026-0001 is correct: each numbers
    their own documents. That is why the constraint is
    (company_id, quote_number) and not quote_number alone."""
    first = await _create_quote(client, client_id, item_id)

    other_category = await second_client.post("/api/catalog/categories", json={"name": "B"})
    other_item = await second_client.post(
        "/api/catalog/items",
        json={
            "category_id": other_category.json()["id"],
            "designation": "Article B",
            "item_type": "service",
            "unit": "h",
            "unit_price_ht": "50.00",
            "vat_rate": "20.00",
        },
    )
    other_client_row = await second_client.post("/api/clients", json={"last_name": "Client B"})
    second = await _create_quote(
        second_client, other_client_row.json()["id"], other_item.json()["id"]
    )

    assert first["quote_number"] == second["quote_number"]


async def test_concurrent_creations_never_share_a_number(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    """The reason ``QuoteCounter`` exists at all.

    ``SELECT MAX(quote_number) + 1`` reads outside any lock: two
    simultaneous creations compute the same number, the unique constraint
    catches it, and one artisan gets an error for having done nothing
    wrong. The counter row is locked FOR UPDATE instead, so concurrent
    creations queue behind each other and each gets its own number.
    """
    payload = {"client_id": client_id, "lines": [{"catalog_item_id": item_id, "quantity": "1"}]}

    responses = await asyncio.gather(*(client.post("/api/quotes", json=payload) for _ in range(5)))

    assert [r.status_code for r in responses] == [201] * 5
    numbers = [r.json()["quote_number"] for r in responses]
    assert len(set(numbers)) == 5, f"duplicate numbers handed out: {numbers}"


# --- Transitions ---


async def test_draft_can_be_sent_then_accepted(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    quote = await _create_quote(client, client_id, item_id)

    sent = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": "sent"})
    accepted = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": "accepted"})

    assert sent.json()["status"] == "sent"
    assert accepted.json()["status"] == "accepted"


async def test_a_sent_quote_can_be_refused(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    quote = await _create_quote(client, client_id, item_id)
    await _advance_to(client, quote["id"], "sent")

    response = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": "refused"})

    assert response.json()["status"] == "refused"


@pytest.mark.parametrize(
    "from_status,to_status",
    [
        ("sent", "draft"),
        ("accepted", "draft"),
        ("accepted", "sent"),
        ("refused", "accepted"),
    ],
)
async def test_a_quote_never_goes_backwards(
    client: AsyncClient, client_id: str, item_id: str, from_status: str, to_status: str
) -> None:
    """Returning to draft would let the quote be edited afterwards, and
    then silently disagree with the paper the customer is holding."""
    quote = await _create_quote(client, client_id, item_id)
    await _advance_to(client, quote["id"], from_status)

    response = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": to_status})

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "invalid_quote_transition"


async def test_concurrent_conflicting_transitions_have_exactly_one_winner(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    """Regression test for a lost update found by trying to break this.

    ``change_status`` is a read-decide-write, and the transition table
    alone cannot make it safe: two concurrent requests both read 'sent',
    both found their own move legal, and both wrote. "accepté" answered
    200 and still lost to a simultaneous "refusé" — the worst kind of
    failure, because the artisan was told it worked.

    The quote row is now locked FOR UPDATE, so the second request reads the
    first one's result. Exactly one must win, and the loser must be told.
    """
    quote = await _create_quote(client, client_id, item_id)
    await _advance_to(client, quote["id"], "sent")

    accepted, refused = await asyncio.gather(
        client.put(f"/api/quotes/{quote['id']}/status", json={"status": "accepted"}),
        client.put(f"/api/quotes/{quote['id']}/status", json={"status": "refused"}),
    )

    assert sorted([accepted.status_code, refused.status_code]) == [200, 409]
    final = (await client.get(f"/api/quotes/{quote['id']}")).json()["status"]
    winner = "accepted" if accepted.status_code == 200 else "refused"
    assert final == winner


async def test_setting_the_same_status_is_idempotent(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    """A client retrying "sent" is not making an error."""
    quote = await _create_quote(client, client_id, item_id)
    await _advance_to(client, quote["id"], "sent")

    again = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": "sent"})

    assert again.status_code == 200
    assert again.json()["status"] == "sent"


async def test_status_must_be_a_known_value(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    quote = await _create_quote(client, client_id, item_id)

    response = await client.put(f"/api/quotes/{quote['id']}/status", json={"status": "paid"})

    assert response.status_code == 422


# --- Deletion is gated by status ---


async def test_a_draft_can_still_be_deleted(
    client: AsyncClient, client_id: str, item_id: str
) -> None:
    """Deleting a draft is how a mistyped quote gets undone — there is no
    update path, deliberately."""
    quote = await _create_quote(client, client_id, item_id)

    response = await client.delete(f"/api/quotes/{quote['id']}")

    assert response.status_code == 204


@pytest.mark.parametrize("status", ["sent", "accepted", "refused"])
async def test_a_quote_past_draft_cannot_be_deleted(
    client: AsyncClient, client_id: str, item_id: str, status: str
) -> None:
    """The customer holds the PDF. The trace has to survive — which is also
    what the invoices to come will require of their own numbering."""
    quote = await _create_quote(client, client_id, item_id)
    await _advance_to(client, quote["id"], status)

    response = await client.delete(f"/api/quotes/{quote['id']}")

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "quote_not_editable"
    assert (await client.get(f"/api/quotes/{quote['id']}")).status_code == 200


# --- Tenant isolation on the new route ---


async def test_changing_status_of_another_companys_quote_is_a_404(
    client: AsyncClient, second_client: AsyncClient, client_id: str, item_id: str
) -> None:
    quote = await _create_quote(client, client_id, item_id)

    response = await second_client.put(
        f"/api/quotes/{quote['id']}/status", json={"status": "sent"}
    )

    assert response.status_code == 404
    # And the attempt left it untouched.
    assert (await client.get(f"/api/quotes/{quote['id']}")).json()["status"] == "draft"
