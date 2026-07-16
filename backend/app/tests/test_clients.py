"""CRUD tests for the clients module, including the simple search."""

import uuid

import pytest
from httpx import AsyncClient


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


async def test_create_client(client: AsyncClient, company_id: str) -> None:
    response = await client.post(
        "/api/clients",
        json={
            "company_id": company_id,
            "last_name": "Durand",
            "first_name": "Marie",
            "phone": "0102030405",
            "email": "marie.durand@example.com",
        },
    )

    assert response.status_code == 201
    body = response.json()
    assert body["last_name"] == "Durand"
    assert body["first_name"] == "Marie"
    assert body["company_name"] is None


async def test_get_client(client: AsyncClient, company_id: str) -> None:
    create_response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Martin"}
    )
    client_id = create_response.json()["id"]

    response = await client.get(f"/api/clients/{client_id}")

    assert response.status_code == 200
    assert response.json()["last_name"] == "Martin"


async def test_get_client_not_found(client: AsyncClient) -> None:
    response = await client.get("/api/clients/00000000-0000-0000-0000-000000000000")

    assert response.status_code == 404


async def test_update_client(client: AsyncClient, company_id: str) -> None:
    create_response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Petit"}
    )
    client_id = create_response.json()["id"]

    response = await client.put(f"/api/clients/{client_id}", json={"phone": "0611223344"})

    assert response.status_code == 200
    body = response.json()
    assert body["phone"] == "0611223344"
    assert body["last_name"] == "Petit"


async def test_delete_client(client: AsyncClient, company_id: str) -> None:
    create_response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Bernard"}
    )
    client_id = create_response.json()["id"]

    delete_response = await client.delete(f"/api/clients/{client_id}")
    assert delete_response.status_code == 204

    get_response = await client.get(f"/api/clients/{client_id}")
    assert get_response.status_code == 404


async def test_search_clients_by_name(client: AsyncClient, company_id: str) -> None:
    # A fresh random token per run: the dev DB persists between test runs
    # (see the "Limite connue" note in the README), so a fixed literal
    # would eventually collide with a client created by an earlier run.
    unique_email = f"{uuid.uuid4().hex}@example.com"
    await client.post(
        "/api/clients",
        json={"company_id": company_id, "last_name": "Rousseau", "email": unique_email},
    )
    await client.post("/api/clients", json={"company_id": company_id, "last_name": "Autre"})

    response = await client.get(
        "/api/clients", params={"company_id": company_id, "q": unique_email}
    )

    assert response.status_code == 200
    body = response.json()
    assert len(body) == 1
    assert body[0]["last_name"] == "Rousseau"
