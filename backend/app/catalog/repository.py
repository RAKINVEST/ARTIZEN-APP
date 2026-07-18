"""Data-access layer for the catalog module."""

import uuid

from sqlalchemy import or_, select
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
        search: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[CatalogItem]:
        stmt = select(CatalogItem).where(CatalogItem.company_id == company_id)
        if active_only:
            stmt = stmt.where(CatalogItem.active.is_(True))
        if search:
            # Server-side search on designation + code so a big catalog is
            # actually usable — without it the app filtered only the first 100
            # items it had loaded, making item 101+ unfindable (audit C5).
            pattern = f"%{search}%"
            stmt = stmt.where(
                or_(CatalogItem.designation.ilike(pattern), CatalogItem.code.ilike(pattern))
            )
        stmt = stmt.order_by(CatalogItem.designation).offset(offset).limit(limit)
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
