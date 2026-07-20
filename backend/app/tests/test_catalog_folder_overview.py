"""Tests for the folder overview: ``GET /catalog/categories/overview``.

The guided assistant's "Dossier" step shows each folder with its article count
and a few example designations, so the artisan recognises the right folder
without opening it. These pin the count, the sample cap (3), and the French
ordering of the samples.
"""

import pytest
from httpx import AsyncClient


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Sanitaires"}
    )
    return response.json()["id"]


async def _add_item(client: AsyncClient, company_id: str, category_id: str, designation: str) -> None:
    await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": designation,
            "item_type": "product",
            "unit": "unité",
            "unit_price_ht": "10.00",
            "vat_rate": "10.00",
        },
    )


async def test_overview_gives_count_and_up_to_three_samples(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    for designation in ["WC suspendu", "Lavabo", "Receveur", "Baignoire", "Évier"]:
        await _add_item(client, company_id, category_id, designation)

    response = await client.get("/api/catalog/categories/overview")

    assert response.status_code == 200
    folder = next(f for f in response.json() if f["id"] == category_id)
    assert folder["name"] == "Sanitaires"
    assert folder["item_count"] == 5
    # Capped at 3, alphabetical as a French artisan reads it (Évier sorts with E).
    assert folder["sample_designations"] == ["Baignoire", "Évier", "Lavabo"]


async def test_empty_folder_appears_with_zero(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    response = await client.get("/api/catalog/categories/overview")

    folder = next(f for f in response.json() if f["id"] == category_id)
    assert folder["item_count"] == 0
    assert folder["sample_designations"] == []


async def test_overview_is_not_parsed_as_a_category_id(
    client: AsyncClient, company_id: str
) -> None:
    """The route order must let "overview" win over /categories/{id}."""
    response = await client.get("/api/catalog/categories/overview")
    assert response.status_code == 200
    assert isinstance(response.json(), list)
