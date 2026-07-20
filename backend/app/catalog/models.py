"""ORM models for the catalog module: ``CatalogCategory`` and
``CatalogItem``.

This is the single source of truth for what an artisan sells (services
and products) and at what price. Artizen never invents prices: a quote
line can only ever point at a ``CatalogItem`` that already exists here
(see ``quotes/``) — this module has no notion of quotes or AI, it just
owns the catalog data.
"""

import enum
import uuid
from decimal import Decimal

from sqlalchemy import Enum as SAEnum
from sqlalchemy import ForeignKey, Numeric
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class ItemType(str, enum.Enum):
    SERVICE = "service"
    PRODUCT = "product"


class CatalogCategory(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "catalog_categories"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    name: Mapped[str]
    description: Mapped[str | None] = mapped_column(default=None)
    # Self-referencing tree: a category can be nested under another one, so
    # the catalog can model Métier → Catégorie → Sous-catégorie → Article to
    # any depth. Top-level nodes (a "métier" or a family) have parent_id NULL.
    # ondelete=CASCADE: removing a branch removes its sub-categories with it.
    parent_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("catalog_categories.id", ondelete="CASCADE"), default=None, index=True
    )
    # Preserves the intended display order within a parent (seed packs rely on
    # it so "Tubes" comes before "Chauffe-eau" as authored, not alphabetically).
    sort_order: Mapped[int] = mapped_column(default=0)


class CatalogItem(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "catalog_items"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # No ondelete=SET NULL: a category with items attached shouldn't be
    # deletable by accident (the DB's default NO ACTION/RESTRICT behavior
    # blocks it — see CatalogService.delete_category for the clean error).
    category_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("catalog_categories.id"), index=True
    )
    # Optional: an internal reference/SKU. Not every artisan uses one.
    code: Mapped[str | None] = mapped_column(default=None)
    designation: Mapped[str]
    description: Mapped[str | None] = mapped_column(default=None)
    item_type: Mapped[ItemType] = mapped_column(
        SAEnum(
            ItemType,
            name="catalog_item_type",
            values_callable=lambda enum_cls: [member.value for member in enum_cls],
        )
    )
    unit: Mapped[str]
    unit_price_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    vat_rate: Mapped[Decimal] = mapped_column(Numeric(5, 2))
    estimated_duration_minutes: Mapped[int | None] = mapped_column(default=None)
    # Soft-delete flag: items are never hard-deleted once created, since a
    # past quote may already reference one (see CatalogService.deactivate
    # and the FK from QuoteLine, which uses ondelete=RESTRICT).
    active: Mapped[bool] = mapped_column(default=True, index=True)
