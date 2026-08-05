"""Data-access layer for the mission module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.mission.models import Mission
from app.repositories.base import BaseRepository


class MissionRepository(BaseRepository[Mission]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Mission, session)

    async def list_by_company(
        self,
        company_id: uuid.UUID,
        *,
        customer_id: uuid.UUID | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Mission]:
        stmt = select(Mission).where(Mission.company_id == company_id)
        if customer_id is not None:
            stmt = stmt.where(Mission.customer_id == customer_id)
        stmt = stmt.order_by(Mission.created_at.desc()).offset(offset).limit(limit)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
