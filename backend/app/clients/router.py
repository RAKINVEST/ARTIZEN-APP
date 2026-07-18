"""Clients HTTP endpoints. Every route only declares the request shape
and delegates to ``ClientService``.

Every route now requires ``CurrentUserDep`` (Étape 10) — same pattern
as ``catalog/router.py``: creates use ``current_user.company_id``
(never the client-supplied one), lists are always scoped to it, and
by-id routes verify ownership via ``ensure_same_company`` before
returning or mutating a resource.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.clients.deps import ClientServiceDep
from app.clients.schemas import ClientCreate, ClientRead, ClientUpdate
from app.core.authorization import ensure_same_company
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/clients", tags=["clients"])


@router.post("", response_model=ClientRead, status_code=status.HTTP_201_CREATED)
async def create_client(
    service: ClientServiceDep, current_user: CurrentUserDep, payload: ClientCreate
) -> ClientRead:
    payload = payload.model_copy(update={"company_id": current_user.company_id})
    client = await service.create(payload)
    return ClientRead.model_validate(client)


@router.get("", response_model=list[ClientRead])
async def list_clients(
    service: ClientServiceDep,
    current_user: CurrentUserDep,
    q: str | None = None,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[ClientRead]:
    """``q`` searches by name, company, phone or email (simple ILIKE match)."""
    clients = await service.list(
        company_id=current_user.company_id, query=q, offset=offset, limit=limit
    )
    return [ClientRead.model_validate(client) for client in clients]


@router.get("/{client_id}", response_model=ClientRead)
async def get_client(
    service: ClientServiceDep, current_user: CurrentUserDep, client_id: uuid.UUID
) -> ClientRead:
    client = await service.get(client_id)
    ensure_same_company(client.company_id, client_id, current_user.company_id)
    return ClientRead.model_validate(client)


@router.put("/{client_id}", response_model=ClientRead)
async def update_client(
    service: ClientServiceDep,
    current_user: CurrentUserDep,
    client_id: uuid.UUID,
    payload: ClientUpdate,
) -> ClientRead:
    existing = await service.get(client_id)
    ensure_same_company(existing.company_id, client_id, current_user.company_id)
    client = await service.update(client_id, payload)
    return ClientRead.model_validate(client)


@router.delete("/{client_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_client(
    service: ClientServiceDep, current_user: CurrentUserDep, client_id: uuid.UUID
) -> None:
    existing = await service.get(client_id)
    ensure_same_company(existing.company_id, client_id, current_user.company_id)
    await service.delete(client_id)
