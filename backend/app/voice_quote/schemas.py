"""Runtime data structures the orchestrator passes between steps and exposes
as a snapshot (Blueprint §12.2).

None of these persist anything — they are in-memory only for this lot. A later
persistence lot maps ``ConversationSnapshot`` onto the ``ai_conversations`` /
``ai_turns`` tables; nothing here knows that. Prices are absent by
construction, exactly like ``quote_assistant`` and ``QuoteLineCreate``: the
draft carries *which* catalog item and *how much*, never an amount.
"""

import uuid
from decimal import Decimal
from typing import Literal

from pydantic import BaseModel, Field

from app.voice_quote.states import ConversationState


class ServiceRequest(BaseModel):
    """One prestation as understood from speech, before catalog matching.

    ``attributes`` holds resolved slots (e.g. ``{"unit_type": "mono-split"}``);
    the question strategy reads it to know which mandatory slots are still
    missing. Both confidences are normalized to ``[0, 1]``."""

    service_type: str  # drives the mandatory-slot set (e.g. "ac_install")
    description: str = Field(min_length=1, max_length=500)
    quantity: Decimal | None = Field(default=None, gt=0, max_digits=10)
    unit: str | None = None
    room: str | None = None
    raw_span: str = ""
    stt_confidence: float = Field(ge=0, le=1)
    nlu_confidence: float = Field(ge=0, le=1)
    attributes: dict[str, str] = Field(default_factory=dict)


class ExtractionResult(BaseModel):
    services: list[ServiceRequest] = Field(default_factory=list)
    language: str = "fr"


class MatchedService(BaseModel):
    """A ``ServiceRequest`` linked to a real catalog item by the matcher port.
    ``source_index`` points back into the services list so the composite
    confidence can pull the STT/NLU scores of the originating prestation."""

    source_index: int = Field(ge=0)
    catalog_item_id: uuid.UUID
    designation: str
    quantity: Decimal = Field(gt=0, max_digits=10)
    match_confidence: float = Field(ge=0, le=1)
    reason: str = ""


class DraftLine(BaseModel):
    """A line retained in the draft after confidence composition (Blueprint
    §5). ``needs_review`` marks the "à relire" middle band; the client turns
    ``catalog_item_id`` + ``quantity`` straight into ``QuoteLineCreate``."""

    source_index: int = Field(ge=0)
    catalog_item_id: uuid.UUID
    designation: str
    quantity: Decimal = Field(gt=0, max_digits=10)
    reason: str = ""
    confidence: float = Field(ge=0, le=1)
    needs_review: bool = False


class ClarificationQuestion(BaseModel):
    type: Literal["slot", "variant", "quantity", "room", "item_choice", "confirm"]
    prompt_text: str
    target_service_index: int = Field(ge=0)
    slot: str | None = None
    options: list[str] = Field(default_factory=list)


class UnresolvedItem(BaseModel):
    """A prestation the engine chose not to put in the draft — omitted, never
    invented. ``reason`` is what the UI shows ("aucun article correspondant")."""

    source_index: int = Field(ge=0)
    description: str
    reason: str


class ConversationSnapshot(BaseModel):
    """The full observable state of a conversation at one instant — what an API
    returns and what persistence will save. No audio, no PII beyond the
    transcript."""

    conversation_id: uuid.UUID
    company_id: uuid.UUID
    client_id: uuid.UUID | None
    language: str
    state: ConversationState
    transcript: str
    draft_lines: list[DraftLine] = Field(default_factory=list)
    pending_question: ClarificationQuestion | None = None
    unresolved: list[UnresolvedItem] = Field(default_factory=list)
    overall_confidence: float = Field(default=0.0, ge=0, le=1)
    questions_asked: int = 0
    error: str | None = None
    timings_ms: dict[str, float] = Field(default_factory=dict)
