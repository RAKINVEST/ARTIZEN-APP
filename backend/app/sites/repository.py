"""Data-access layer for the sites module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.base import BaseRepository
from app.sites.models import SITE_STATUS_ARCHIVED, Site


class SiteRepository(BaseRepository[Site]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Site, session)

    async def list_for_company(
        self,
        company_id: uuid.UUID,
        *,
        customer_id: uuid.UUID | None = None,
        include_archived: bool = False,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Site]:
        stmt = select(Site).where(Site.company_id == company_id)
        if customer_id is not None:
            stmt = stmt.where(Site.customer_id == customer_id)
        if not include_archived:
            # Active is the working set; archived sites are only returned on
            # explicit request.
            stmt = stmt.where(Site.status != SITE_STATUS_ARCHIVED)
        stmt = stmt.order_by(Site.name).offset(offset).limit(limit)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
