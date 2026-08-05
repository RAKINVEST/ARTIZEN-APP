"""HTTP-level tests for the sites module (capability #8 chantiers).

Mirrors the existing module tests: each test runs against a freshly
registered tenant (the ``client`` fixture) with a real JWT, exercising the
public /api contract rather than the service in isolation.

Invariants proven here:
- a site must reference a real client of the caller's own company (404 otherwise);
- lists and by-id access are strictly tenant-scoped (cross-tenant -> 404);
- business data is never hard-deleted: a site is archived, and there is no
  DELETE route (405).
"""

import uuid

from httpx import AsyncClient


async def _create_client(ac: AsyncClient, last_name: str = "Durand") -> str:
    response = await ac.post("/api/clients", json={"last_name": last_name})
    assert response.status_code == 201, response.text
    return response.json()["id"]


async def _create_site(ac: AsyncClient, customer_id: str, name: str = "Chantier A") -> dict:
    response = await ac.post(
        "/api/sites",
        json={"customer_id": customer_id, "name": name, "address": "1 rue de la Paix"},
    )
    assert response.status_code == 201, response.text
    return response.json()


async def test_create_site_under_client(client: AsyncClient) -> None:
    customer_id = await _create_client(client)
    site = await _create_site(client, customer_id)

    assert site["customer_id"] == customer_id
    assert site["name"] == "Chantier A"
    assert site["address"] == "1 rue de la Paix"
    assert site["status"] == "active"
    assert uuid.UUID(site["id"])  # a real UUID was assigned
    assert site["company_id"]  # stamped from the JWT, not the request body


async def test_create_site_ignores_client_supplied_company_id(client: AsyncClient) -> None:
    customer_id = await _create_client(client)
    foreign_company = str(uuid.uuid4())
    response = await client.post(
        "/api/sites",
        json={"customer_id": customer_id, "name": "X", "company_id": foreign_company},
    )
    assert response.status_code == 201, response.text
    assert response.json()["company_id"] != foreign_company


async def test_create_site_requires_known_customer(client: AsyncClient) -> None:
    response = await client.post(
        "/api/sites", json={"customer_id": str(uuid.uuid4()), "name": "Ghost"}
    )
    assert response.status_code == 404


async def test_create_site_rejects_other_tenant_customer(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    # A client that exists, but belongs to another company, must be invisible.
    foreign_customer = await _create_client(second_client, last_name="Autre")
    response = await client.post(
        "/api/sites", json={"customer_id": foreign_customer, "name": "Intrus"}
    )
    assert response.status_code == 404


async def test_list_sites_scoped_to_company(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    customer_id = await _create_client(client)
    await _create_site(client, customer_id, name="Mine")

    other_customer = await _create_client(second_client, last_name="Autre")
    await _create_site(second_client, other_customer, name="Theirs")

    mine = await client.get("/api/sites")
    assert mine.status_code == 200
    names = {s["name"] for s in mine.json()}
    assert "Mine" in names
    assert "Theirs" not in names


async def test_list_filter_by_customer(client: AsyncClient) -> None:
    customer_a = await _create_client(client, last_name="A")
    customer_b = await _create_client(client, last_name="B")
    await _create_site(client, customer_a, name="For A")
    await _create_site(client, customer_b, name="For B")

    response = await client.get("/api/sites", params={"customer_id": customer_a})
    assert response.status_code == 200
    names = {s["name"] for s in response.json()}
    assert names == {"For A"}


async def test_get_site_cross_tenant_returns_404(
    client: AsyncClient, second_client: AsyncClient
) -> None:
    customer_id = await _create_client(client)
    site = await _create_site(client, customer_id)

    response = await second_client.get(f"/api/sites/{site['id']}")
    assert response.status_code == 404


async def test_update_site(client: AsyncClient) -> None:
    customer_id = await _create_client(client)
    site = await _create_site(client, customer_id)

    response = await client.put(
        f"/api/sites/{site['id']}", json={"name": "Renommé", "address": "2 rue Neuve"}
    )
    assert response.status_code == 200, response.text
    body = response.json()
    assert body["name"] == "Renommé"
    assert body["address"] == "2 rue Neuve"
    assert body["customer_id"] == customer_id  # unchanged


async def test_archive_hides_from_default_list_but_keeps_data(client: AsyncClient) -> None:
    customer_id = await _create_client(client)
    site = await _create_site(client, customer_id, name="À archiver")

    archived = await client.post(f"/api/sites/{site['id']}/archive")
    assert archived.status_code == 200, archived.text
    assert archived.json()["status"] == "archived"

    default_list = await client.get("/api/sites")
    assert "À archiver" not in {s["name"] for s in default_list.json()}

    with_archived = await client.get("/api/sites", params={"include_archived": "true"})
    assert "À archiver" in {s["name"] for s in with_archived.json()}

    # The record still exists and is still reachable by id (data not destroyed).
    still_there = await client.get(f"/api/sites/{site['id']}")
    assert still_there.status_code == 200
    assert still_there.json()["status"] == "archived"


async def test_no_hard_delete_route(client: AsyncClient) -> None:
    customer_id = await _create_client(client)
    site = await _create_site(client, customer_id)
    # Loi 5: business data is never destroyed — there is no DELETE endpoint.
    response = await client.delete(f"/api/sites/{site['id']}")
    assert response.status_code == 405
