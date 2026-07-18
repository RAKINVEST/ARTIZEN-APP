"""Catalog business logic: categories and items. Routes never touch the
repositories directly — everything goes through this service.

Category and item management are grouped in a single service (rather
than two), mirroring ``BrandingService`` in step 2: both concern "the
catalog" as one cohesive resource, and splitting them would only add
indirection without a real separation of concerns.
"""

import uuid

from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.catalog.models import CatalogCategory, CatalogItem
from app.catalog.repository import CatalogCategoryRepository, CatalogItemRepository
from app.catalog.schemas import (
    CatalogCategoryCreate,
    CatalogCategoryUpdate,
    CatalogItemCreate,
    CatalogItemUpdate,
)
from app.core.authorization import ensure_same_company
from app.core.exceptions import ConflictError, NotFoundError


class CatalogService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._categories = CatalogCategoryRepository(session)
        self._items = CatalogItemRepository(session)

    # --- Categories ---

    async def create_category(self, data: CatalogCategoryCreate) -> CatalogCategory:
        return await self._categories.create(CatalogCategory(**data.model_dump()))

    async def get_category(self, category_id: uuid.UUID) -> CatalogCategory:
        category = await self._categories.get(category_id)
        if category is None:
            raise NotFoundError(f"Catalog category {category_id} not found.")
        return category

    async def list_categories(
        self, *, company_id: uuid.UUID | None = None, offset: int = 0, limit: int = 100
    ) -> list[CatalogCategory]:
        if company_id is not None:
            return await self._categories.list_by_company(company_id, offset=offset, limit=limit)
        return await self._categories.list(offset=offset, limit=limit)

    async def update_category(
        self, category_id: uuid.UUID, data: CatalogCategoryUpdate
    ) -> CatalogCategory:
        category = await self.get_category(category_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(category, field, value)
        await self._session.flush()
        await self._session.refresh(category)
        return category

    async def delete_category(self, category_id: uuid.UUID) -> None:
        category = await self.get_category(category_id)
        try:
            await self._categories.delete(category)
        except IntegrityError as exc:
            await self._session.rollback()
            raise ConflictError(
                f"Catalog category {category_id} still has items and cannot be deleted."
            ) from exc

    # --- Items ---

    async def _ensure_category_belongs_to(
        self, category_id: uuid.UUID, company_id: uuid.UUID
    ) -> None:
        """The category is the one field on an item that points at another
        row, and it arrives straight from the client. The foreign key only
        proves the row exists — not that it is *this* company's.

        Without this, an item could be attached to another company's
        category, which then pins that company: CatalogItem.category_id is
        RESTRICT, so the victim could never delete their own category
        again (a permanent 409 they cannot explain or fix). Exploiting it
        needs a category UUID no route ever discloses, which is why this
        is a hole rather than a breach — but the contract says company_id
        never comes from the client, and until now that only held for the
        row itself, not for what it referenced.
        """
        category = await self._categories.get(category_id)
        if category is None:
            raise NotFoundError(f"Catalog category {category_id} not found.")
        ensure_same_company(category.company_id, category_id, company_id)

    async def create_item(self, data: CatalogItemCreate) -> CatalogItem:
        if data.company_id is not None:
            await self._ensure_category_belongs_to(data.category_id, data.company_id)
        return await self._items.create(CatalogItem(**data.model_dump()))

    async def get_item(self, item_id: uuid.UUID) -> CatalogItem:
        item = await self._items.get(item_id)
        if item is None:
            raise NotFoundError(f"Catalog item {item_id} not found.")
        return item

    async def list_items(
        self,
        *,
        company_id: uuid.UUID | None = None,
        active_only: bool = False,
        query: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[CatalogItem]:
        if company_id is not None:
            return await self._items.list_by_company(
                company_id, active_only=active_only, search=query, offset=offset, limit=limit
            )
        return await self._items.list(offset=offset, limit=limit)

    async def update_item(self, item_id: uuid.UUID, data: CatalogItemUpdate) -> CatalogItem:
        item = await self.get_item(item_id)
        # Same check as create_item, and needed for the same reason: the
        # router has already confirmed the *item* is this company's, but
        # category_id can still be repointed at anyone's category.
        # item.company_id is the trustworthy side here — the router derived
        # it from the JWT before letting the update through.
        if data.category_id is not None and data.category_id != item.category_id:
            await self._ensure_category_belongs_to(data.category_id, item.company_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(item, field, value)
        await self._session.flush()
        await self._session.refresh(item)
        return item

    async def deactivate_item(self, item_id: uuid.UUID) -> CatalogItem:
        """Soft-delete: sets ``active=False`` rather than removing the row,
        since a past quote may already reference this item."""
        item = await self.get_item(item_id)
        item.active = False
        await self._session.flush()
        await self._session.refresh(item)
        return item
