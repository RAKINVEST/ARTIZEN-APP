"""FastAPI dependencies for the quote-assistant module."""

from typing import Annotated

from fastapi import Depends

from app.ai.deps import AIProviderDep
from app.api.deps import SessionDep
from app.branding.deps import BrandingServiceDep
from app.catalog.repository import CatalogItemRepository
from app.quote_assistant.catalog_matcher_claude import CatalogMatcherClaude
from app.quote_assistant.match_validator import MatchValidator
from app.quote_assistant.prompt_builder import PromptBuilder
from app.quote_assistant.service import QuoteAssistantService
from app.quote_assistant.suggestion_scorer import SuggestionScorer
from app.quotes.repository import QuoteLineRepository


def get_quote_assistant_service(
    session: SessionDep,
    ai_provider: AIProviderDep,
    branding: BrandingServiceDep,
) -> QuoteAssistantService:
    catalog_items = CatalogItemRepository(session)
    quote_lines = QuoteLineRepository(session)
    matcher = CatalogMatcherClaude(ai_provider=ai_provider, prompt_builder=PromptBuilder())
    validator = MatchValidator(catalog_items)
    scorer = SuggestionScorer()
    return QuoteAssistantService(
        catalog_items=catalog_items,
        quote_lines=quote_lines,
        matcher=matcher,
        validator=validator,
        scorer=scorer,
        branding=branding,
    )


QuoteAssistantServiceDep = Annotated[QuoteAssistantService, Depends(get_quote_assistant_service)]
