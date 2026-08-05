"""Data-access layer for the planning module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.planning.models import PLANNING_ANNULEE, PlanningEntry
from app.repositories.base import BaseRepository


class PlanningEntryRepository(BaseRepository[PlanningEntry]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(PlanningEntry, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 200
    ) -> list[PlanningEntry]:
        result = await self.session.execute(
            select(PlanningEntry)
            .where(PlanningEntry.company_id == company_id)
            .order_by(PlanningEntry.start_at)
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())

    async def list_active_for_company(
        self, company_id: uuid.UUID, *, exclude_id: uuid.UUID | None = None
    ) -> list[PlanningEntry]:
        """Non-cancelled entries — the set conflict detection runs against."""
        stmt = select(PlanningEntry).where(
            PlanningEntry.company_id == company_id,
            PlanningEntry.status != PLANNING_ANNULEE,
        )
        if exclude_id is not None:
            stmt = stmt.where(PlanningEntry.id != exclude_id)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
