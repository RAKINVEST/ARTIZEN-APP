"""ORM models for the branding module: ``Company``, ``BrandProfile`` and
``DocumentTemplate``.

Together they describe an artisan's business identity — what Artizen
needs to generate quotes and invoices that look like the artisan's own
documents, not a generic template.

Relationships are expressed as plain foreign keys, queried explicitly
through ``repository.py``, rather than as SQLAlchemy ``relationship()``
attributes: async lazy-loading of unloaded relationships raises at
runtime unless eagerly joined, and nothing here needs ORM-level
traversal yet.
"""

import enum
import uuid

from sqlalchemy import Enum as SAEnum
from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class TemplateType(str, enum.Enum):
    QUOTE = "quote"
    INVOICE = "invoice"


class Company(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "companies"

    name: Mapped[str | None] = mapped_column(default=None)
    legal_name: Mapped[str | None] = mapped_column(default=None)
    siret: Mapped[str | None] = mapped_column(default=None)
    vat_number: Mapped[str | None] = mapped_column(default=None)
    address_line: Mapped[str | None] = mapped_column(default=None)
    postal_code: Mapped[str | None] = mapped_column(default=None)
    city: Mapped[str | None] = mapped_column(default=None)
    country: Mapped[str | None] = mapped_column(default="France")
    phone: Mapped[str | None] = mapped_column(default=None)
    email: Mapped[str | None] = mapped_column(default=None)
    website: Mapped[str | None] = mapped_column(default=None)


class BrandProfile(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "brand_profiles"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), unique=True
    )
    logo_path: Mapped[str | None] = mapped_column(default=None)
    primary_color: Mapped[str | None] = mapped_column(default=None)
    secondary_color: Mapped[str | None] = mapped_column(default=None)
    font_family: Mapped[str | None] = mapped_column(default=None)
    tagline: Mapped[str | None] = mapped_column(default=None)
    signature_path: Mapped[str | None] = mapped_column(default=None)
    stamp_path: Mapped[str | None] = mapped_column(default=None)


class DocumentTemplate(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "document_templates"

    company_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("companies.id", ondelete="CASCADE"))
    type: Mapped[TemplateType] = mapped_column(
        SAEnum(
            TemplateType,
            name="document_template_type",
            # Without this, SQLAlchemy stores the Python member *name*
            # ("QUOTE") rather than its value ("quote"), which would be
            # confusing for anything reading the column directly.
            values_callable=lambda enum_cls: [member.value for member in enum_cls],
        )
    )
    name: Mapped[str]
    version: Mapped[int] = mapped_column(default=1)
    source_file_path: Mapped[str]
    is_active: Mapped[bool] = mapped_column(default=True)
