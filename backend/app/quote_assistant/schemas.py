"""Pydantic schemas for the quote-assistant module.

Two distinct shapes live here, deliberately kept separate:

- ``QuoteSuggestionRequest``/``QuoteSuggestionRead`` are the public API
  contract (``POST /quote-assistant/suggest``).
- ``RawSuggestionItem``/``RawSuggestionResponse`` describe the strict
  JSON Claude itself must reply with — parsed by ``CatalogMatcherClaude``
  before ``MatchValidator`` ever sees it. ``catalog_item_id`` stays a
  plain ``uuid.UUID`` here (schema-level validation only); whether that
  UUID actually refers to an existing, active, same-company catalog item
  is a business-rule question answered later by ``MatchValidator``, not
  by this schema.

Neither shape carries a price: this module only ever proposes *which*
existing catalog items (and what quantity) match a free-text
description. Amounts still come exclusively from ``QuoteCalculator``,
once the user submits the accepted suggestion through the existing
``POST /quotes``.
"""

import uuid
from decimal import Decimal

from pydantic import BaseModel, Field


class QuoteSuggestionRequest(BaseModel):
    # Ignored server-side — company_id always comes from the authenticated
    # user (see quote_assistant/router.py). Optional here so callers don't
    # need to send a value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    description: str = Field(min_length=1)


class QuoteSuggestionItemRead(BaseModel):
    catalog_item_id: uuid.UUID
    designation: str
    quantity: Decimal
    reason: str


class QuoteSuggestionRead(BaseModel):
    items: list[QuoteSuggestionItemRead]
    confidence: float
    comment: str


class RawSuggestionItem(BaseModel):
    catalog_item_id: uuid.UUID
    quantity: Decimal = Field(gt=0)
    reason: str = ""


class RawSuggestionResponse(BaseModel):
    items: list[RawSuggestionItem] = Field(default_factory=list)
    confidence: float = Field(ge=0, le=1)
    comment: str = ""
