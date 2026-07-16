"""Data-access layer for the clients module."""

import uuid

from sqlalchemy import or_, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.clients.models import Client
from app.repositories.base import BaseRepository


class ClientRepository(BaseRepository[Client]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Client, session)

    async def search(
        self,
        company_id: uuid.UUID,
        *,
        query: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Client]:
        stmt = select(Client).where(Client.company_id == company_id)
        if query:
            pattern = f"%{query}%"
            stmt = stmt.where(
                or_(
                    Client.last_name.ilike(pattern),
                    Client.first_name.ilike(pattern),
                    Client.company_name.ilike(pattern),
                    Client.phone.ilike(pattern),
                    Client.email.ilike(pattern),
                )
            )
        stmt = stmt.order_by(Client.last_name).offset(offset).limit(limit)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
