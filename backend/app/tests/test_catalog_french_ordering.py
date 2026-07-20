"""The catalog must be alphabetical *as a French artisan reads it*.

The database is created with the C collation, which orders by byte value and
files every accented initial after Z. Left alone, an électricien opens his
catalog and finds "Éclairage" and "Électricité" at the very bottom, under
"Ventilation" — which reads as a broken app, not as a sorting convention.
These tests pin the ICU collation applied in ``catalog/repository.py``.
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
        "/api/catalog/categories", json={"company_id": company_id, "name": "Divers"}
    )
    return response.json()["id"]


async def test_accented_categories_sort_with_their_unaccented_letter(
    client: AsyncClient, company_id: str
) -> None:
    """"Évacuation" belongs between "Chauffe-eau" and "Sanitaires", not last."""
    created = ("Tuyauterie", "Évacuation", "Chauffe-eau", "Sanitaires", "Éclairage")
    for name in created:
        await client.post(
            "/api/catalog/categories", json={"company_id": company_id, "name": name}
        )

    response = await client.get("/api/catalog/categories")
    names = [category["name"] for category in response.json() if category["name"] in created]

    assert names == ["Chauffe-eau", "Éclairage", "Évacuation", "Sanitaires", "Tuyauterie"]


async def test_accented_items_sort_with_their_unaccented_letter(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    """Same rule inside a folder: an item is found where the eye looks."""
    created = ("Vanne d'arrêt", "Économiseur d'eau", "Bonde de douche", "Évier inox")
    for designation in created:
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

    response = await client.get("/api/catalog/items")
    designations = [
        item["designation"] for item in response.json() if item["designation"] in created
    ]

    assert designations == [
        "Bonde de douche",
        "Économiseur d'eau",
        "Évier inox",
        "Vanne d'arrêt",
    ]
