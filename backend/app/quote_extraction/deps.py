"""FastAPI dependencies for the V2 quote-extraction module.

The AI provider is resolved by the same key-driven factory the rest of the app
uses (``ai/factory.py``): a real provider when a key is configured, the mock
otherwise. The extractor then refuses the mock at call time (it must never
invent), so a missing key surfaces as a clear 503, never as fabricated data.
"""

from typing import Annotated

from fastapi import Depends

from app.ai.factory import get_ai_provider
from app.api.deps import SessionDep
from app.branding.deps import BrandingServiceDep
from app.document_analysis.repository import DocumentAnalysisRepository
from app.quote_extraction.extractor import QuoteExtractor
from app.quote_extraction.service import QuoteExtractionService


def get_quote_extraction_service(
    session: SessionDep,
    branding: BrandingServiceDep,
) -> QuoteExtractionService:
    return QuoteExtractionService(
        analyses=DocumentAnalysisRepository(session),
        extractor=QuoteExtractor(get_ai_provider()),
        branding=branding,
    )


QuoteExtractionServiceDep = Annotated[
    QuoteExtractionService, Depends(get_quote_extraction_service)
]
