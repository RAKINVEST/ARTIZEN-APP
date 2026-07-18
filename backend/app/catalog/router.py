"""Catalog HTTP endpoints — categories and items. Every route only
declares the request shape and delegates to ``CatalogService``.

Every route now requires ``CurrentUserDep`` (Étape 10): creates always
use ``current_user.company_id`` (overriding whatever the client sent,
if anything — the payload's own ``company_id`` is never trusted), lists
are always scoped to it, and by-id routes verify the fetched resource
actually belongs to the caller's company before returning or mutating
it, raising the same ``NotFoundError`` a made-up id would (a 404, not a
403 — this API never confirms that another company's resource exists).
"""

import uuid

from fastapi import APIRouter, Query, status

from app.catalog.deps import CatalogServiceDep
from app.catalog.schemas import (
    CatalogCategoryCreate,
    CatalogCategoryRead,
    CatalogCategoryUpdate,
    CatalogItemCreate,
    CatalogItemRead,
    CatalogItemUpdate,
)
from app.core.authorization import ensure_same_company
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/catalog", tags=["catalog"])


@router.post("/categories", response_model=CatalogCategoryRead, status_code=status.HTTP_201_CREATED)
async def create_category(
    service: CatalogServiceDep, current_user: CurrentUserDep, payload: CatalogCategoryCreate
) -> CatalogCategoryRead:
    payload = payload.model_copy(update={"company_id": current_user.company_id})
    category = await service.create_category(payload)
    return CatalogCategoryRead.model_validate(category)


@router.get("/categories", response_model=list[CatalogCategoryRead])
async def list_categories(
    service: CatalogServiceDep,
    current_user: CurrentUserDep,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[CatalogCategoryRead]:
    categories = await service.list_categories(
        company_id=current_user.company_id, offset=offset, limit=limit
    )
    return [CatalogCategoryRead.model_validate(category) for category in categories]


@router.get("/categories/{category_id}", response_model=CatalogCategoryRead)
async def get_category(
    service: CatalogServiceDep, current_user: CurrentUserDep, category_id: uuid.UUID
) -> CatalogCategoryRead:
    category = await service.get_category(category_id)
    ensure_same_company(category.company_id, category_id, current_user.company_id)
    return CatalogCategoryRead.model_validate(category)


@router.put("/categories/{category_id}", response_model=CatalogCategoryRead)
async def update_category(
    service: CatalogServiceDep,
    current_user: CurrentUserDep,
    category_id: uuid.UUID,
    payload: CatalogCategoryUpdate,
) -> CatalogCategoryRead:
    existing = await service.get_category(category_id)
    ensure_same_company(existing.company_id, category_id, current_user.company_id)
    category = await service.update_category(category_id, payload)
    return CatalogCategoryRead.model_validate(category)


@router.delete("/categories/{category_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_category(
    service: CatalogServiceDep, current_user: CurrentUserDep, category_id: uuid.UUID
) -> None:
    existing = await service.get_category(category_id)
    ensure_same_company(existing.company_id, category_id, current_user.company_id)
    await service.delete_category(category_id)


@router.post("/items", response_model=CatalogItemRead, status_code=status.HTTP_201_CREATED)
async def create_item(
    service: CatalogServiceDep, current_user: CurrentUserDep, payload: CatalogItemCreate
) -> CatalogItemRead:
    payload = payload.model_copy(update={"company_id": current_user.company_id})
    item = await service.create_item(payload)
    return CatalogItemRead.model_validate(item)


@router.get("/items", response_model=list[CatalogItemRead])
async def list_items(
    service: CatalogServiceDep,
    current_user: CurrentUserDep,
    q: str | None = None,
    active_only: bool = False,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[CatalogItemRead]:
    """``q`` searches items by designation or code (ILIKE) — server-side, so a
    catalogue of any size is searchable, not just the first page."""
    items = await service.list_items(
        company_id=current_user.company_id,
        active_only=active_only,
        query=q,
        offset=offset,
        limit=limit,
    )
    return [CatalogItemRead.model_validate(item) for item in items]


@router.get("/items/{item_id}", response_model=CatalogItemRead)
async def get_item(
    service: CatalogServiceDep, current_user: CurrentUserDep, item_id: uuid.UUID
) -> CatalogItemRead:
    item = await service.get_item(item_id)
    ensure_same_company(item.company_id, item_id, current_user.company_id)
    return CatalogItemRead.model_validate(item)


@router.put("/items/{item_id}", response_model=CatalogItemRead)
async def update_item(
    service: CatalogServiceDep,
    current_user: CurrentUserDep,
    item_id: uuid.UUID,
    payload: CatalogItemUpdate,
) -> CatalogItemRead:
    existing = await service.get_item(item_id)
    ensure_same_company(existing.company_id, item_id, current_user.company_id)
    item = await service.update_item(item_id, payload)
    return CatalogItemRead.model_validate(item)


@router.delete("/items/{item_id}", response_model=CatalogItemRead)
async def deactivate_item(
    service: CatalogServiceDep, current_user: CurrentUserDep, item_id: uuid.UUID
) -> CatalogItemRead:
    """Soft-delete: deactivates the item (``active=False``) rather than
    removing it, so past quotes referencing it remain intact."""
    existing = await service.get_item(item_id)
    ensure_same_company(existing.company_id, item_id, current_user.company_id)
    item = await service.deactivate_item(item_id)
    return CatalogItemRead.model_validate(item)
