"""Orchestrates the whole "free-text description -> quote suggestion"
flow: fetch the company's active catalog (plus its usage history and
name, for prompt context), ask the AI matcher, validate every proposed
item against the real catalog, score the result, and shape the API
response.

Never creates a ``Quote`` — that stays the sole responsibility of
``QuoteService`` (existing ``POST /quotes``). This service only ever
returns a *proposal* for the user to review, edit and submit through
the existing quote-creation flow; nothing here is persisted, so there
is no repository/model for "suggestions" and no migration for this
module.
"""

import logging
import uuid

from app.branding.service import BrandingService
from app.catalog.repository import CatalogItemRepository
from app.quote_assistant.catalog_matcher_claude import CatalogMatcherClaude
from app.quote_assistant.match_validator import MatchValidator
from app.quote_assistant.schemas import QuoteSuggestionItemRead, QuoteSuggestionRead
from app.quote_assistant.suggestion_scorer import SuggestionScorer
from app.quotes.repository import QuoteLineRepository

logger = logging.getLogger(__name__)

# The catalog sent to the AI must be bounded — the whole thing goes into the
# prompt. This limit is stated here rather than inherited from
# CatalogItemRepository.list_by_company's paging default, which silently
# capped the copilot at 100 items: past that, an artisan's own item was
# simply absent from the prompt, the AI matched nothing, and the feature
# looked merely bad instead of broken. Reaching the cap is logged, never
# silent.
_MAX_CATALOG_ITEMS = 1000


class QuoteAssistantService:
    def __init__(
        self,
        catalog_items: CatalogItemRepository,
        quote_lines: QuoteLineRepository,
        matcher: CatalogMatcherClaude,
        validator: MatchValidator,
        scorer: SuggestionScorer,
        branding: BrandingService,
    ) -> None:
        self._catalog_items = catalog_items
        self._quote_lines = quote_lines
        self._matcher = matcher
        self._validator = validator
        self._scorer = scorer
        self._branding = branding

    async def suggest(self, *, company_id: uuid.UUID, description: str) -> QuoteSuggestionRead:
        logger.info(
            "quote_assistant.start company_id=%s description_length=%d",
            company_id,
            len(description),
        )

        active_items = await self._catalog_items.list_by_company(
            company_id, active_only=True, limit=_MAX_CATALOG_ITEMS
        )
        if len(active_items) == _MAX_CATALOG_ITEMS:
            logger.warning(
                "quote_assistant.catalog_truncated company_id=%s limit=%d "
                "(items beyond the limit are invisible to the copilot)",
                company_id,
                _MAX_CATALOG_ITEMS,
            )
        usage_counts = await self._quote_lines.get_usage_counts_by_company(company_id)
        company_name = await self._branding.get_company_name(company_id)

        raw = await self._matcher.match(
            description,
            catalog_items=active_items,
            company_name=company_name,
            usage_counts=usage_counts,
        )
        logger.info(
            "quote_assistant.raw_response company_id=%s proposed=%d raw_confidence=%.2f",
            company_id,
            len(raw.items),
            raw.confidence,
        )

        validation = await self._validator.validate(raw.items, company_id=company_id)
        for rejected in validation.rejected_items:
            logger.info(
                "quote_assistant.rejected company_id=%s catalog_item_id=%s reason=%s",
                company_id,
                rejected.catalog_item_id,
                rejected.reason,
            )

        confidence = self._scorer.score(
            raw_confidence=raw.confidence,
            total_count=validation.total_count,
            valid_count=validation.valid_count,
            duplicate_count=validation.duplicate_count,
        )

        logger.info(
            "quote_assistant.completed company_id=%s proposed=%d valid=%d duplicates=%d confidence=%.2f",
            company_id,
            validation.total_count,
            validation.valid_count,
            validation.duplicate_count,
            confidence,
        )

        return QuoteSuggestionRead(
            items=[
                QuoteSuggestionItemRead(
                    catalog_item_id=validated.item.id,
                    designation=validated.item.designation,
                    quantity=validated.quantity,
                    reason=validated.reason,
                )
                for validated in validation.valid_items
            ],
            confidence=confidence,
            comment=raw.comment,
        )
