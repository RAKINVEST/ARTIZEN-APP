"""CRUD tests for the catalog module: categories and items, plus item
deactivation (soft delete)."""

import pytest
from httpx import AsyncClient


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Plomberie"}
    )
    return response.json()["id"]


async def test_create_category(client: AsyncClient, company_id: str) -> None:
    response = await client.post(
        "/api/catalog/categories",
        json={"company_id": company_id, "name": "Chauffage", "description": "Chaudieres, PAC"},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["name"] == "Chauffage"
    assert body["description"] == "Chaudieres, PAC"


async def test_create_item(client: AsyncClient, company_id: str, category_id: str) -> None:
    response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Main-d'oeuvre plomberie",
            "item_type": "service",
            "unit": "heure",
            "unit_price_ht": "45.00",
            "vat_rate": "20.00",
        },
    )

    assert response.status_code == 201
    body = response.json()
    assert body["designation"] == "Main-d'oeuvre plomberie"
    assert body["item_type"] == "service"
    assert body["unit_price_ht"] == "45.00"
    assert body["active"] is True


async def test_get_item(client: AsyncClient, company_id: str, category_id: str) -> None:
    create_response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Deplacement",
            "item_type": "service",
            "unit": "forfait",
            "unit_price_ht": "30.00",
            "vat_rate": "20.00",
        },
    )
    item_id = create_response.json()["id"]

    response = await client.get(f"/api/catalog/items/{item_id}")

    assert response.status_code == 200
    assert response.json()["designation"] == "Deplacement"


async def test_update_item(client: AsyncClient, company_id: str, category_id: str) -> None:
    create_response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Robinet",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "20.00",
            "vat_rate": "20.00",
        },
    )
    item_id = create_response.json()["id"]

    response = await client.put(f"/api/catalog/items/{item_id}", json={"unit_price_ht": "25.00"})

    assert response.status_code == 200
    assert response.json()["unit_price_ht"] == "25.00"


async def test_list_items_by_company(client: AsyncClient, company_id: str, category_id: str) -> None:
    await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Groupe de securite",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "15.00",
            "vat_rate": "20.00",
        },
    )

    response = await client.get("/api/catalog/items", params={"company_id": company_id})

    assert response.status_code == 200
    body = response.json()
    assert len(body) >= 1
    assert all(item["company_id"] == company_id for item in body)


async def test_list_items_can_be_scoped_to_a_category(
    client: AsyncClient, company_id: str
) -> None:
    """The quote wizard lists one folder's articles: ``?category_id=`` filters
    server-side so a catalogue of any size stays a single bounded page."""
    cat_a = (
        await client.post(
            "/api/catalog/categories", json={"company_id": company_id, "name": "Sanitaires"}
        )
    ).json()["id"]
    cat_b = (
        await client.post(
            "/api/catalog/categories", json={"company_id": company_id, "name": "Chauffage"}
        )
    ).json()["id"]

    def _item(category_id: str, designation: str) -> dict:
        return {
            "company_id": company_id,
            "category_id": category_id,
            "designation": designation,
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "20.00",
            "vat_rate": "20.00",
        }

    item_a = (await client.post("/api/catalog/items", json=_item(cat_a, "WC suspendu"))).json()["id"]
    await client.post("/api/catalog/items", json=_item(cat_b, "Radiateur"))

    response = await client.get("/api/catalog/items", params={"category_id": cat_a})

    assert response.status_code == 200
    body = response.json()
    ids = [item["id"] for item in body]
    assert item_a in ids  # the folder's own article is listed
    assert all(item["category_id"] == cat_a for item in body)  # and nothing else


async def test_get_item_from_another_company_returns_not_found(
    client: AsyncClient, second_client: AsyncClient, company_id: str, category_id: str
) -> None:
    """Étape 10: by-id routes verify the resource actually belongs to
    the caller's company (`ensure_same_company`) — `second_client` is a
    real, independently-registered company and must never be able to
    read `client`'s item, even by guessing its real id."""
    create_response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Article prive",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "10.00",
            "vat_rate": "20.00",
        },
    )
    item_id = create_response.json()["id"]

    response = await second_client.get(f"/api/catalog/items/{item_id}")

    assert response.status_code == 404


async def test_list_items_never_includes_another_companys_items(
    client: AsyncClient, second_client: AsyncClient, company_id: str, category_id: str
) -> None:
    await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Article prive",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "10.00",
            "vat_rate": "20.00",
        },
    )

    response = await second_client.get("/api/catalog/items")

    assert response.status_code == 200
    assert response.json() == []


async def test_deactivate_item(client: AsyncClient, company_id: str, category_id: str) -> None:
    create_response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Radiateur",
            "item_type": "product",
            "unit": "unite",
            "unit_price_ht": "80.00",
            "vat_rate": "20.00",
        },
    )
    item_id = create_response.json()["id"]

    delete_response = await client.delete(f"/api/catalog/items/{item_id}")
    assert delete_response.status_code == 200
    assert delete_response.json()["active"] is False

    get_response = await client.get(f"/api/catalog/items/{item_id}")
    assert get_response.json()["active"] is False


async def test_create_item_rejects_another_companys_category(
    client: AsyncClient, second_client: AsyncClient, category_id: str
) -> None:
    """category_id is the one field on an item that references another row
    and comes straight from the client. The foreign key only proves the
    category exists — this proves it is the caller's.

    Left unchecked, company B could hang an item off company A's category,
    and since CatalogItem.category_id is RESTRICT, A could then never
    delete that category again: a permanent 409 on their own data, with no
    way to see why.
    """
    response = await second_client.post(
        "/api/catalog/items",
        json={
            "category_id": category_id,
            "designation": "Article greffe sur la categorie d'autrui",
            "item_type": "service",
            "unit": "h",
            "unit_price_ht": "50.00",
            "vat_rate": "20.00",
        },
    )

    assert response.status_code == 404


async def test_update_item_cannot_repoint_to_another_companys_category(
    client: AsyncClient, second_client: AsyncClient, category_id: str
) -> None:
    """Same hole on the update path: the router confirms the *item* belongs
    to the caller, which says nothing about the category it is moved to."""
    own_category = await second_client.post(
        "/api/catalog/categories", json={"name": "Categorie B"}
    )
    own_item = await second_client.post(
        "/api/catalog/items",
        json={
            "category_id": own_category.json()["id"],
            "designation": "Article de B",
            "item_type": "service",
            "unit": "h",
            "unit_price_ht": "50.00",
            "vat_rate": "20.00",
        },
    )

    response = await second_client.put(
        f"/api/catalog/items/{own_item.json()['id']}",
        json={"category_id": category_id},
    )

    assert response.status_code == 404


async def test_update_item_keeps_working_within_its_own_company(
    second_client: AsyncClient,
) -> None:
    """The guard must not block the legitimate move it looks like: an
    artisan reclassifying their own item into their own other category."""
    first = await second_client.post("/api/catalog/categories", json={"name": "Avant"})
    second = await second_client.post("/api/catalog/categories", json={"name": "Apres"})
    item = await second_client.post(
        "/api/catalog/items",
        json={
            "category_id": first.json()["id"],
            "designation": "Article a reclasser",
            "item_type": "service",
            "unit": "h",
            "unit_price_ht": "50.00",
            "vat_rate": "20.00",
        },
    )

    response = await second_client.put(
        f"/api/catalog/items/{item.json()['id']}",
        json={"category_id": second.json()["id"]},
    )

    assert response.status_code == 200
    assert response.json()["category_id"] == second.json()["id"]
