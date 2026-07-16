"""Clients business logic. Routes never touch the repository directly."""

import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.clients.models import Client
from app.clients.repository import ClientRepository
from app.clients.schemas import ClientCreate, ClientUpdate
from app.core.exceptions import NotFoundError


class ClientService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._clients = ClientRepository(session)

    async def create(self, data: ClientCreate) -> Client:
        return await self._clients.create(Client(**data.model_dump()))

    async def get(self, client_id: uuid.UUID) -> Client:
        client = await self._clients.get(client_id)
        if client is None:
            raise NotFoundError(f"Client {client_id} not found.")
        return client

    async def list(
        self,
        *,
        company_id: uuid.UUID | None = None,
        query: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Client]:
        if company_id is not None:
            return await self._clients.search(company_id, query=query, offset=offset, limit=limit)
        return await self._clients.list(offset=offset, limit=limit)

    async def update(self, client_id: uuid.UUID, data: ClientUpdate) -> Client:
        client = await self.get(client_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(client, field, value)
        await self._session.flush()
        await self._session.refresh(client)
        return client

    async def delete(self, client_id: uuid.UUID) -> None:
        client = await self.get(client_id)
        await self._clients.delete(client)
