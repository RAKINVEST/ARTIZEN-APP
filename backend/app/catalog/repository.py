"""Data-access layer for the catalog module."""

import uuid

from sqlalchemy import or_, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.catalog.models import CatalogCategory, CatalogItem
from app.repositories.base import BaseRepository

#: Alphabetical order as a French artisan reads it. The database is created
#: with the C collation, which sorts by byte value and therefore files every
#: accented initial *after* Z: "Évacuation" landed below "Tuyauterie", and an
#: electrician's "Éclairage" / "Électricité" folders would sit at the bottom
#: of his catalog looking like a bug. ICU's fr-FR puts É with E, where the
#: artisan expects it. Applied at the query, not the column, so no migration
#: and no risk of an index rebuild.
_FRENCH_COLLATION = "fr-FR-x-icu"


class CatalogCategoryRepository(BaseRepository[CatalogCategory]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(CatalogCategory, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[CatalogCategory]:
        result = await self.session.execute(
            select(CatalogCategory)
            .where(CatalogCategory.company_id == company_id)
            .order_by(CatalogCategory.name.collate(_FRENCH_COLLATION))
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())

    async def get_by_name(self, company_id: uuid.UUID, name: str) -> CatalogCategory | None:
        """Used when importing a pack: a folder the artisan already has is
        reused, never duplicated — and never renamed."""
        result = await self.session.execute(
            select(CatalogCategory).where(
                CatalogCategory.company_id == company_id, CatalogCategory.name == name
            )
        )
        return result.scalars().first()


class CatalogItemRepository(BaseRepository[CatalogItem]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(CatalogItem, session)

    async def list_by_company(
        self,
        company_id: uuid.UUID,
        *,
        active_only: bool = False,
        category_id: uuid.UUID | None = None,
        search: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[CatalogItem]:
        stmt = select(CatalogItem).where(CatalogItem.company_id == company_id)
        if active_only:
            stmt = stmt.where(CatalogItem.active.is_(True))
        if category_id is not None:
            # Scopes the list to one folder — the quote wizard picks articles
            # from the folder the artisan opened. Filtered server-side so a
            # catalogue of any size stays a single bounded, searchable page.
            stmt = stmt.where(CatalogItem.category_id == category_id)
        if search:
            # Server-side search on designation + code so a big catalog is
            # actually usable — without it the app filtered only the first 100
            # items it had loaded, making item 101+ unfindable (audit C5).
            pattern = f"%{search}%"
            stmt = stmt.where(
                or_(CatalogItem.designation.ilike(pattern), CatalogItem.code.ilike(pattern))
            )
        stmt = (
            stmt.order_by(CatalogItem.designation.collate(_FRENCH_COLLATION))
            .offset(offset)
            .limit(limit)
        )
        result = await self.session.execute(stmt)
        return list(result.scalars().all())

    async def category_stats(
        self, company_id: uuid.UUID, *, sample_size: int = 3
    ) -> dict[uuid.UUID, tuple[int, list[str]]]:
        """Per-category article count + a few example designations, in one pass.

        Fetches ``(category_id, designation)`` for the whole company ordered by
        designation (French), then folds it in Python — cheap for a catalog of
        a few hundred items, and avoids a query per folder. The samples are the
        first few alphabetically, which is what the artisan expects to see.
        """
        result = await self.session.execute(
            select(CatalogItem.category_id, CatalogItem.designation)
            .where(CatalogItem.company_id == company_id)
            .order_by(CatalogItem.designation.collate(_FRENCH_COLLATION))
        )
        stats: dict[uuid.UUID, tuple[int, list[str]]] = {}
        for category_id, designation in result.all():
            count, samples = stats.get(category_id, (0, []))
            if len(samples) < sample_size:
                samples.append(designation)
            stats[category_id] = (count + 1, samples)
        return stats

    async def designations_in_category(self, category_id: uuid.UUID) -> set[str]:
        """What the artisan already has in this folder.

        Importing a pack must never touch a line he already owns — his price,
        his wording, his choice (`docs/DECISIONS.md`, décision 1). One query
        per folder, compared by designation.
        """
        result = await self.session.execute(
            select(CatalogItem.designation).where(CatalogItem.category_id == category_id)
        )
        return set(result.scalars().all())
