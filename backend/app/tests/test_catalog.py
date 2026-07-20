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


# --- Category hierarchy + trade packs ---


async def test_created_category_exposes_hierarchy_fields(
    client: AsyncClient, company_id: str
) -> None:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Racine"}
    )
    body = response.json()
    assert body["parent_id"] is None
    assert body["sort_order"] == 0


async def test_create_subcategory_nested_under_parent(
    client: AsyncClient, company_id: str, category_id: str
) -> None:
    response = await client.post(
        "/api/catalog/categories",
        json={"company_id": company_id, "name": "Tubes", "parent_id": category_id, "sort_order": 2},
    )
    assert response.status_code == 201
    body = response.json()
    assert body["parent_id"] == category_id
    assert body["sort_order"] == 2


async def test_list_trades(client: AsyncClient) -> None:
    response = await client.get("/api/catalog/trades")
    assert response.status_code == 200
    trades = response.json()
    slugs = {t["slug"] for t in trades}
    assert {"plombier", "chauffagiste", "climaticien"} <= slugs
    plombier = next(t for t in trades if t["slug"] == "plombier")
    assert plombier["name"] == "Plombier"
    assert plombier["item_count"] > 0
    assert plombier["category_count"] > 0


async def test_install_trade_builds_hierarchy(client: AsyncClient, company_id: str) -> None:
    response = await client.post("/api/catalog/trades/plombier/install")
    assert response.status_code == 201
    result = response.json()
    assert result["categories_created"] > 0
    assert result["items_created"] > 0

    categories = (await client.get("/api/catalog/categories")).json()
    roots = [c for c in categories if c["parent_id"] is None]
    children = [c for c in categories if c["parent_id"] is not None]
    # The métier is the top-level folder; its categories nest beneath it.
    assert any(c["name"] == "Plombier" for c in roots)
    root = next(c for c in roots if c["name"] == "Plombier")
    assert any(c["name"] == "Tubes" and c["parent_id"] == root["id"] for c in children)

    items = (await client.get("/api/catalog/items")).json()
    per = next(i for i in items if i["designation"] == "Tube PER")
    # Prices are left at 0 for the artisan to fill in.
    assert per["unit_price_ht"] == "0.00"


async def test_install_unknown_trade_returns_404(client: AsyncClient) -> None:
    response = await client.post("/api/catalog/trades/inconnu/install")
    assert response.status_code == 404


async def test_installed_catalog_is_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    await client.post("/api/catalog/trades/plombier/install")
    # A different company never sees another's installed catalog.
    assert (await second_client.get("/api/catalog/categories")).json() == []
    assert (await second_client.get("/api/catalog/items")).json() == []
