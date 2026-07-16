"""Pydantic schemas for the template-import module.

``TemplateImportPreviewRead`` deliberately carries both the freshly
detected fields (``detection``) and the company's *current* values
(``current_company``/``current_brand``) side by side: the user must be
able to compare "what Artizen found in the PDF" against "what's
currently configured" before deciding what to keep — the "Validation"
step of the pipeline is meaningless without that comparison.

``TemplateImportValidateRequest`` carries the *final* values the user
confirmed (already resolved client-side from detected vs. edited vs.
kept-as-is) — not a diff/patch instruction set. Every field is optional
and only the ones actually provided are applied, exactly like
``CompanyUpdate``/``BrandProfileUpdate`` (which this schema's fields
mirror).
"""

from pydantic import BaseModel

from app.branding.schemas import BrandProfileRead, CompanyRead
from app.document_analysis.schemas import DocumentAnalysisRead
from app.document_detection.schemas import DocumentDetectionResultRead


class TemplateImportPreviewRead(BaseModel):
    analysis: DocumentAnalysisRead
    detection: DocumentDetectionResultRead
    current_company: CompanyRead
    current_brand: BrandProfileRead


class TemplateImportValidateRequest(BaseModel):
    name: str | None = None
    legal_name: str | None = None
    siret: str | None = None
    vat_number: str | None = None
    address_line: str | None = None
    postal_code: str | None = None
    city: str | None = None
    phone: str | None = None
    email: str | None = None
    website: str | None = None
    primary_color: str | None = None
    secondary_color: str | None = None
