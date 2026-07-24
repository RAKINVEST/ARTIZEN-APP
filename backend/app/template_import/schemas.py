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

from enum import Enum

from pydantic import BaseModel

from app.branding.schemas import BrandProfileRead, CompanyRead
from app.document_analysis.schemas import DocumentAnalysisRead
from app.document_detection.schemas import DocumentDetectionResultRead


class IdentityVerdict(str, Enum):
    """Does the imported devis's identity look like the account's own?
    (Décision 8). Never a fraud verdict — a check that keeps the promise:
    *we reproduce **your** identity.*"""

    RECOGNIZED = "recognized"    # SIRET (or name) matches — "Nous avons reconnu votre entreprise"
    MISMATCH = "mismatch"        # a *different* SIRET — likely another company; warn + confirm
    UNVERIFIED = "unverified"    # no legible identity to compare — soft confirmation


class IdentityCoherence(BaseModel):
    """The signal the import screen turns into an artisan-language message. The
    backend judges; the client speaks (BRAND.md, deux langues)."""

    verdict: IdentityVerdict
    #: True/False when both SIRETs were comparable, else None.
    siret_matches: bool | None = None
    extracted_siret: str | None = None
    extracted_name: str | None = None


class TemplateImportPreviewRead(BaseModel):
    analysis: DocumentAnalysisRead
    detection: DocumentDetectionResultRead
    current_company: CompanyRead
    current_brand: BrandProfileRead
    coherence: IdentityCoherence


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
