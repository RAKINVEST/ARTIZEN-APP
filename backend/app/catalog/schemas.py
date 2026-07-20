"""Pydantic schemas for the catalog module."""

import uuid
from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, ConfigDict, Field

from app.catalog.models import ItemType


class CatalogCategoryCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # catalog/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    name: str
    description: str | None = None
    # NULL = a top-level family/métier; otherwise nests under another category.
    parent_id: uuid.UUID | None = None
    sort_order: int = 0


class CatalogCategoryUpdate(BaseModel):
    name: str | None = None
    description: str | None = None
    parent_id: uuid.UUID | None = None
    sort_order: int | None = None


class CatalogCategoryRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    name: str
    description: str | None
    parent_id: uuid.UUID | None
    sort_order: int
    created_at: datetime
    updated_at: datetime


class TradeSummary(BaseModel):
    """One installable trade pack, as advertised by GET /catalog/trades."""

    slug: str
    name: str
    description: str
    category_count: int
    item_count: int


class TradeInstallResult(BaseModel):
    """What POST /catalog/trades/{slug}/install created."""

    slug: str
    categories_created: int
    items_created: int


class CatalogItemCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # catalog/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    category_id: uuid.UUID
    code: str | None = None
    designation: str
    description: str | None = None
    item_type: ItemType
    unit: str
    unit_price_ht: Decimal = Field(ge=0)
    vat_rate: Decimal = Field(ge=0)
    estimated_duration_minutes: int | None = Field(default=None, ge=0)


class CatalogItemUpdate(BaseModel):
    category_id: uuid.UUID | None = None
    code: str | None = None
    designation: str | None = None
    description: str | None = None
    item_type: ItemType | None = None
    unit: str | None = None
    unit_price_ht: Decimal | None = Field(default=None, ge=0)
    vat_rate: Decimal | None = Field(default=None, ge=0)
    estimated_duration_minutes: int | None = Field(default=None, ge=0)
    active: bool | None = None


class CatalogItemRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    category_id: uuid.UUID
    code: str | None
    designation: str
    description: str | None
    item_type: ItemType
    unit: str
    unit_price_ht: Decimal
    vat_rate: Decimal
    estimated_duration_minutes: int | None
    active: bool
    created_at: datetime
    updated_at: datetime
