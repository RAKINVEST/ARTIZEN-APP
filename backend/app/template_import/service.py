"""Orchestrates "importer un ancien devis PDF": reuses the existing
``document_analysis`` pipeline (text/metadata/layout) and
``document_detection`` heuristics (logo, colors, SIRET, VAT, contact,
header/footer/table zones) to build a preview, then — once the user
validates it — updates the company's identity (``Company``,
``BrandProfile``) and registers the imported PDF as the new active
quote ``DocumentTemplate`` via ``branding``.

No new table, no new extraction logic: every field this module surfaces
or persists already exists somewhere in ``document_analysis``,
``document_detection`` or ``branding`` — this module is pure
orchestration across three existing, unmodified services/repositories,
the same one-directional "downstream module" pattern ``quotes`` used on
``catalog``+``clients`` and ``document_detection`` used on
``document_analysis``.
"""

import uuid

from app.branding.models import TemplateType
from app.branding.schemas import BrandingProfileRead, BrandProfileUpdate, CompanyUpdate
from app.branding.service import BrandingService
from app.core.authorization import ensure_same_company
from app.core.exceptions import NotFoundError
from app.document_analysis.models import DocumentAnalysis, DocumentType
from app.document_analysis.repository import DocumentAnalysisRepository
from app.document_analysis.schemas import DocumentAnalysisRead
from app.document_detection.schemas import DocumentDetectionResultRead
from app.document_detection.service import DocumentDetectionService
from app.template_import.exceptions import InvalidDocumentTypeForTemplateError
from app.template_import.schemas import TemplateImportPreviewRead, TemplateImportValidateRequest

_COMPANY_FIELDS = {
    "name", "legal_name", "siret", "vat_number",
    "address_line", "postal_code", "city", "phone", "email", "website",
}
_BRAND_FIELDS = {"primary_color", "secondary_color"}


class TemplateImportService:
    def __init__(
        self,
        analyses: DocumentAnalysisRepository,
        detection: DocumentDetectionService,
        branding: BrandingService,
    ) -> None:
        self._analyses = analyses
        self._detection = detection
        self._branding = branding

    async def preview(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> TemplateImportPreviewRead:
        analysis = await self._get_quote_analysis(analysis_id, company_id=company_id)
        detection = await self._detection.get_or_run(analysis_id, company_id=company_id)
        profile = await self._branding.get_profile(company_id)

        return TemplateImportPreviewRead(
            analysis=DocumentAnalysisRead.model_validate(analysis),
            detection=DocumentDetectionResultRead.model_validate(detection),
            current_company=profile.company,
            current_brand=profile.brand,
        )

    async def validate(
        self, analysis_id: uuid.UUID, data: TemplateImportValidateRequest, *, company_id: uuid.UUID
    ) -> BrandingProfileRead:
        analysis = await self._get_quote_analysis(analysis_id, company_id=company_id)
        # Ensures detection actually completed (raises DocumentNotProcessedError
        # via the same guard GET /document-analysis/{id}/detection uses).
        detection = await self._detection.get_or_run(analysis_id, company_id=company_id)

        company_fields = data.model_dump(include=_COMPANY_FIELDS, exclude_unset=True)
        if company_fields:
            await self._branding.update_company(company_id, CompanyUpdate(**company_fields))

        brand_fields = data.model_dump(include=_BRAND_FIELDS, exclude_unset=True)
        if brand_fields:
            await self._branding.update_profile(company_id, BrandProfileUpdate(**brand_fields))

        # The identity fields above were already reviewed and confirmed in the
        # preview form, but the logo never had a form field — it was only ever
        # *detected*, not applied — which is why an imported quote still came
        # out with no logo on the generated PDF. When one was detected, pull
        # its pixels from the imported PDF and store them as the company logo
        # so the PDF engine (which reads brand.logo_path) actually shows it.
        # Best-effort: a logo we cannot re-read must not fail the import.
        if detection.logo_detected:
            logo_bytes = await self._detection.extract_logo(analysis_id, company_id=company_id)
            if logo_bytes:
                await self._branding.set_logo_from_bytes(company_id, logo_bytes)

        template = await self._branding.create_template_from_existing_file(
            company_id,
            TemplateType.QUOTE,
            filename=analysis.filename,
            storage_key=analysis.storage_key,
        )
        analysis.document_template_id = template.id

        return await self._branding.get_profile(company_id)

    async def _get_quote_analysis(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> DocumentAnalysis:
        analysis = await self._analyses.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        ensure_same_company(analysis.company_id, analysis_id, company_id)
        if analysis.document_type != DocumentType.QUOTE:
            raise InvalidDocumentTypeForTemplateError(
                f"Document analysis {analysis_id} is a {analysis.document_type.value}, "
                "not a quote — only quote imports can become the active quote template."
            )
        return analysis
