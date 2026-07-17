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
    # Bounded: the description is forwarded verbatim to the AI provider, so
    # an unbounded field bills a multi-megabyte prompt to the company's API
    # budget and may blow the context window.
    description: str = Field(min_length=1, max_length=5000)


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
    # The quantity is the one number the AI genuinely infers rather than
    # selects, so it gets an upper bound: a proposal of 1e9 units of
    # anything is a malfunction, not a suggestion.
    #
    # Deliberately no decimal_places here, unlike QuoteLineCreate. Parsing
    # is all-or-nothing (see CatalogMatcherClaude._parse), so every
    # constraint added at this layer is a new way for one odd number to
    # discard an otherwise good suggestion. A quantity too fine to persist
    # is caught later, on the quote the artisan actually submits.
    quantity: Decimal = Field(gt=0, max_digits=10)
    reason: str = ""


class RawSuggestionResponse(BaseModel):
    # Capped: every proposed item costs one catalog lookup in
    # MatchValidator, so an unbounded list turns a derailed AI answer (or a
    # prompt injection) into an amplification vector.
    items: list[RawSuggestionItem] = Field(default_factory=list, max_length=50)
    confidence: float = Field(ge=0, le=1)
    comment: str = ""
