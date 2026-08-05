"""Orchestrates the V2 import: an analysed PDF -> a validated ``ExtractedQuote``
and, on demand, a faithful reproduction PDF.

Owns no table: the extraction is derived from the existing ``DocumentAnalysis``
row (which already holds the OCR/analysis text). Depends only downstream —
``document_analysis`` (text), ``app.ai`` (provider, via the injected extractor),
``branding`` (the artisan's identity for the reproduction) and ``app.pdf`` (the
render target + renderer). The reproduction wears the artisan's identity but its
number, client, dates, lines and amounts come only from the imported PDF.
"""

from __future__ import annotations

import asyncio
import uuid

from app.branding.service import BrandingService
from app.core.authorization import ensure_same_company
from app.core.exceptions import NotFoundError
from app.document_analysis.models import DocumentAnalysis, DocumentType
from app.document_analysis.repository import DocumentAnalysisRepository
from app.pdf.html_renderer import HtmlPdfRenderer
from app.pdf.schemas import DocumentBranding
from app.quote_extraction.exceptions import (
    DocumentTextUnavailableError,
    NotAQuoteDocumentError,
)
from app.quote_extraction.extractor import QuoteExtractor
from app.quote_extraction.mapper import extracted_quote_to_document
from app.quote_extraction.schemas import ExtractedQuote


class QuoteExtractionService:
    def __init__(
        self,
        analyses: DocumentAnalysisRepository,
        extractor: QuoteExtractor,
        branding: BrandingService,
    ) -> None:
        self._analyses = analyses
        self._extractor = extractor
        self._branding = branding
        self._renderer = HtmlPdfRenderer()

    async def extract(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> ExtractedQuote:
        """Read the full quote from a previously analysed PDF. Never fabricates:
        raises if no real AI is configured or the text is missing, rather than
        returning invented data."""
        analysis = await self._get_quote_analysis(analysis_id, company_id=company_id)
        text = analysis.extracted_text
        if not text or not text.strip():
            raise DocumentTextUnavailableError(
                "Le document n'a pas encore été analysé : lancez d'abord son "
                "traitement avant l'extraction."
            )
        return await self._extractor.extract(text)

    async def render_reproduction_pdf(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> tuple[str, bytes]:
        """Extract, then render a PDF that reproduces the imported devis with the
        artisan's identity (logo/colours) applied. The document's content is the
        extraction — no sample, no placeholder."""
        extracted = await self.extract(analysis_id, company_id=company_id)
        branding = await self._document_branding(company_id)
        document = extracted_quote_to_document(extracted, branding=branding)
        pdf = await asyncio.to_thread(self._renderer.render, document)
        return f"{document.number}.pdf", pdf

    async def _document_branding(self, company_id: uuid.UUID) -> DocumentBranding:
        profile = await self._branding.get_profile(company_id)
        logo: bytes | None = None
        try:
            logo, _ = await self._branding.load_asset(company_id, "logo")
        except NotFoundError:
            logo = None
        return DocumentBranding(
            logo=logo,
            primary_color=profile.brand.primary_color,
            secondary_color=profile.brand.secondary_color,
            tagline=profile.brand.tagline,
        )

    async def _get_quote_analysis(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> DocumentAnalysis:
        analysis = await self._analyses.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        ensure_same_company(analysis.company_id, analysis_id, company_id)
        if analysis.document_type != DocumentType.QUOTE:
            raise NotAQuoteDocumentError(
                f"Document analysis {analysis_id} is a {analysis.document_type.value}, "
                "not a quote — only a devis can be reconstructed as an editable quote."
            )
        return analysis
