"""Turns a free-text description into a raw, not-yet-validated list of
catalog item suggestions, by calling the configured AI provider through
the provider-agnostic ``AIProvider`` abstraction — never a concrete SDK
directly, so switching providers later needs no change here.

Deliberately does NOT check whether a suggested ``catalog_item_id``
really exists, belongs to this company, or is active: an AI response is
never trusted blindly, but that business validation is
``MatchValidator``'s job, not this class's. This class only answers one
question: "did the AI provider reply with something matching the
strict JSON schema we asked for?" — if not, it raises
``InvalidAIResponseError``.

Conceptually related to ``catalog.interfaces.CatalogMatcher`` (the
placeholder contract sketched in Étape 5 for "some future AI-backed
matcher"), but does not implement it: that interface returns a bare
``list[CatalogItem]``, which cannot carry the quantity, reason,
confidence and comment this feature actually needs. Rather than bend an
untested placeholder to fit after the fact, this module defines its own
purpose-built shape (see ``schemas.RawSuggestionResponse``); the
placeholder interface stays available for a simpler matcher that might
be added later.
"""

import uuid

from pydantic import ValidationError

from app.ai.base import AIProvider
from app.catalog.models import CatalogItem
from app.quote_assistant.exceptions import InvalidAIResponseError
from app.quote_assistant.prompt_builder import PromptBuilder
from app.quote_assistant.schemas import RawSuggestionResponse


def _strip_code_fence(content: str) -> str:
    """Claude is instructed to reply with bare JSON, but real-world LLM
    APIs occasionally wrap the answer in a ```json ... ``` fence anyway.
    Stripping it here is cheap and avoids a spurious parse failure for
    an otherwise perfectly valid response."""
    text = content.strip()
    if not text.startswith("```"):
        return text
    first_newline = text.find("\n")
    text = text[first_newline + 1 :] if first_newline != -1 else text
    if text.endswith("```"):
        text = text[:-3]
    return text.strip()


class CatalogMatcherClaude:
    def __init__(self, ai_provider: AIProvider, prompt_builder: PromptBuilder) -> None:
        self._ai_provider = ai_provider
        self._prompt_builder = prompt_builder

    async def match(
        self,
        description: str,
        *,
        catalog_items: list[CatalogItem],
        company_name: str | None = None,
        usage_counts: dict[uuid.UUID, int] | None = None,
    ) -> RawSuggestionResponse:
        messages = self._prompt_builder.build(
            description,
            catalog_items,
            company_name=company_name,
            usage_counts=usage_counts,
        )
        response = await self._ai_provider.complete(messages)
        return self._parse(response.content)

    def _parse(self, content: str) -> RawSuggestionResponse:
        try:
            return RawSuggestionResponse.model_validate_json(_strip_code_fence(content))
        except (ValidationError, ValueError) as exc:
            raise InvalidAIResponseError(
                "The AI provider returned a response that doesn't match the "
                "expected JSON schema."
            ) from exc
