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

    # --- Regulatory identity (Phase 1 — commercialisation) ---
    # French building-trade quotes must carry these; all nullable so an
    # existing account keeps working and a new one fills them in over time
    # from the "Mon entreprise" screen (see docs/PHASE1-CONFORMITE.md).
    legal_form: Mapped[str | None] = mapped_column(default=None)  # forme juridique (SARL, EI…)
    share_capital: Mapped[str | None] = mapped_column(default=None)  # capital social
    rcs_rm: Mapped[str | None] = mapped_column(default=None)  # RCS ou n° Répertoire des Métiers
    ape_code: Mapped[str | None] = mapped_column(default=None)  # code APE/NAF
    # Décennale / RC pro — obligatoire bâtiment (loi du 17 mars 2014).
    insurance_name: Mapped[str | None] = mapped_column(default=None)  # assureur
    insurance_contract: Mapped[str | None] = mapped_column(default=None)  # n° de contrat
    insurance_coverage: Mapped[str | None] = mapped_column(default=None)  # couverture géographique
    rge_number: Mapped[str | None] = mapped_column(default=None)  # mention/numéro RGE si applicable
    payment_terms: Mapped[str | None] = mapped_column(default=None)  # conditions et délais de paiement

    # "normal" (assujetti TVA) | "franchise" (franchise en base, art. 293 B du CGI).
    # NOT NULL with a server default so every existing row gets a regime on
    # migration; drives whether quotes carry VAT at all (see QuoteService.create).
    vat_regime: Mapped[str] = mapped_column(default="normal", server_default="normal")
    # Durée de validité d'un devis, en jours (configurable, défaut 30).
    quote_validity_days: Mapped[int] = mapped_column(default=30, server_default="30")


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
