"""Data-access layer for the catalog module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.catalog.models import CatalogCategory, CatalogItem
from app.repositories.base import BaseRepository


class CatalogCategoryRepository(BaseRepository[CatalogCategory]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(CatalogCategory, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[CatalogCategory]:
        result = await self.session.execute(
            select(CatalogCategory)
            .where(CatalogCategory.company_id == company_id)
            .order_by(CatalogCategory.name)
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())


class CatalogItemRepository(BaseRepository[CatalogItem]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(CatalogItem, session)

    async def list_by_company(
        self,
        company_id: uuid.UUID,
        *,
        active_only: bool = False,
        offset: int = 0,
        limit: int = 100,
    ) -> list[CatalogItem]:
        query = select(CatalogItem).where(CatalogItem.company_id == company_id)
        if active_only:
            query = query.where(CatalogItem.active.is_(True))
        query = query.order_by(CatalogItem.designation).offset(offset).limit(limit)
        result = await self.session.execute(query)
        return list(result.scalars().all())
