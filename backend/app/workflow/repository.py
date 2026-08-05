"""Data-access layer for the workflow module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.base import BaseRepository
from app.workflow.models import WorkflowInstance


class WorkflowInstanceRepository(BaseRepository[WorkflowInstance]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(WorkflowInstance, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[WorkflowInstance]:
        result = await self.session.execute(
            select(WorkflowInstance)
            .where(WorkflowInstance.company_id == company_id)
            .order_by(WorkflowInstance.created_at.desc())
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())
