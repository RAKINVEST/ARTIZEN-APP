"""ORM models for the quotes module: ``Quote`` and ``QuoteLine``.

A ``QuoteLine`` always references an existing ``CatalogItem`` — there is
no free-text price in this first version, Artizen never invents amounts.
``designation``, ``unit``, ``unit_price_ht`` and ``vat_rate`` are copied
("snapshotted") from the ``CatalogItem`` at the moment the line is
created, rather than looked up live every time the quote is read: if the
artisan later changes a price in the catalog, past quotes must keep
showing the amounts they were actually issued with.
"""

import uuid
from decimal import Decimal

from sqlalchemy import ForeignKey, Numeric
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class Quote(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "quotes"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # RESTRICT: a client with existing quotes shouldn't be deletable by
    # accident (mirrors CatalogItem's protection against deleting a
    # category that still has items). ClientService.delete translates the
    # resulting IntegrityError into a 409 — the database guard is only half
    # the protection, and for a while this comment claimed a translation
    # that did not exist, so deleting such a client returned a bare 500.
    client_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("clients.id", ondelete="RESTRICT"), index=True
    )
    total_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))
    total_vat: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))
    total_ttc: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))


class QuoteLine(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "quote_lines"

    quote_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("quotes.id", ondelete="CASCADE"), index=True
    )
    # RESTRICT: a catalog item referenced by a quote line can only be
    # deactivated (CatalogService.deactivate_item), never hard-deleted.
    catalog_item_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("catalog_items.id", ondelete="RESTRICT")
    )
    designation: Mapped[str]
    unit: Mapped[str]
    quantity: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    unit_price_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    vat_rate: Mapped[Decimal] = mapped_column(Numeric(5, 2))
    total_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    total_vat: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    total_ttc: Mapped[Decimal] = mapped_column(Numeric(10, 2))
