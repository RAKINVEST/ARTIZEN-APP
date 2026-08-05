"""Data-access layer for the orchestration module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.orchestration.models import OrchestrationInstance
from app.repositories.base import BaseRepository


class OrchestrationInstanceRepository(BaseRepository[OrchestrationInstance]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(OrchestrationInstance, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[OrchestrationInstance]:
        result = await self.session.execute(
            select(OrchestrationInstance)
            .where(OrchestrationInstance.company_id == company_id)
            .order_by(OrchestrationInstance.created_at.desc())
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())
