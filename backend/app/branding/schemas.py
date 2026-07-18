"""Pydantic schemas for the branding module: read models returned by the
API, plus upload-result shapes.
"""

import uuid
from datetime import datetime
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field

from app.branding.models import TemplateType

#: The only two VAT regimes the product supports today. "franchise" is the
#: micro-entrepreneur / franchise-en-base case (art. 293 B du CGI): quotes carry
#: no VAT and the PDF prints the mention instead.
VatRegime = Literal["normal", "franchise"]


class StoredFileInfo(BaseModel):
    """Metadata about a single uploaded file, as returned to the client."""

    filename: str
    content_type: str
    size_bytes: int
    path: str


class CompanyRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    name: str | None
    legal_name: str | None
    siret: str | None
    vat_number: str | None
    address_line: str | None
    postal_code: str | None
    city: str | None
    country: str | None
    phone: str | None
    email: str | None
    website: str | None
    # Regulatory identity (Phase 1)
    legal_form: str | None
    share_capital: str | None
    rcs_rm: str | None
    ape_code: str | None
    insurance_name: str | None
    insurance_contract: str | None
    insurance_coverage: str | None
    rge_number: str | None
    payment_terms: str | None
    vat_regime: VatRegime
    quote_validity_days: int


class BrandProfileRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    logo_path: str | None
    primary_color: str | None
    secondary_color: str | None
    font_family: str | None
    tagline: str | None
    signature_path: str | None
    stamp_path: str | None


class DocumentTemplateRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    type: TemplateType
    name: str
    version: int
    is_active: bool
    created_at: datetime
    source_file_path: str


class TemplateUploadResult(BaseModel):
    """Response body for the template upload endpoints: the persisted
    template row plus the metadata of the file that was just stored."""

    template: DocumentTemplateRead
    file: StoredFileInfo


class BrandingProfileRead(BaseModel):
    """Aggregate view returned by ``GET /branding/profile``."""

    company: CompanyRead
    brand: BrandProfileRead
    templates: list[DocumentTemplateRead]


class CompanyUpdate(BaseModel):
    """Partial update for ``Company``. Every field is optional and only
    the ones actually present in the request are applied (``exclude_unset``
    in the service), so this can be called both from a manual "edit my
    company" form and from ``template_import`` applying values a user
    reviewed in a PDF-import preview — neither ever wipes a field the
    caller didn't mean to touch."""

    name: str | None = None
    legal_name: str | None = None
    siret: str | None = None
    vat_number: str | None = None
    address_line: str | None = None
    postal_code: str | None = None
    city: str | None = None
    country: str | None = None
    phone: str | None = None
    email: str | None = None
    website: str | None = None
    # Regulatory identity (Phase 1)
    legal_form: str | None = None
    share_capital: str | None = None
    rcs_rm: str | None = None
    ape_code: str | None = None
    insurance_name: str | None = None
    insurance_contract: str | None = None
    insurance_coverage: str | None = None
    rge_number: str | None = None
    payment_terms: str | None = None
    vat_regime: VatRegime | None = None
    quote_validity_days: int | None = Field(default=None, ge=1, le=365)


class BrandProfileUpdate(BaseModel):
    """Partial update for ``BrandProfile``'s plain fields. ``logo_path``/
    ``signature_path``/``stamp_path`` are deliberately absent: those are
    only ever set by the dedicated upload endpoints, never by a bare
    field update, since they must correspond to a file actually stored."""

    primary_color: str | None = None
    secondary_color: str | None = None
    font_family: str | None = None
    tagline: str | None = None
