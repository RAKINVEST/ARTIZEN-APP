"""ORM models for AI voice conversations: ``AiConversation``, ``AiTurn``,
``AiDecision``.

Design rules for these tables (V3.3 persistence lot):

- **No business logic.** No amount, no VAT, no total, no computed column, no
  trigger. They record what the engine understood and decided, nothing more.
  The ``quantity``/``confidence`` numbers are stored as ``Float`` on purpose —
  they are AI suggestions for analytics, not the financial source of truth (a
  ``Numeric`` here would imply a rounding authority these tables must not have).
- **History is independent of the catalog and clients.** ``catalog_item_id``
  and ``client_id`` are plain UUIDs with no foreign key: deactivating or
  deleting a catalog item, or a client, must never rewrite or block a past
  conversation. Only ``company_id`` is a real FK — the tenant boundary — with
  ``CASCADE`` so deleting a company (RGPD) removes its voice data, which then
  cascades to turns and decisions via ``conversation_id``.
- **Fields sized for future statistics** (engine_version, per-decision outcome,
  confidences, timings, counts, error, quote_reference) — see docs/v3/08.
"""

import uuid

from sqlalchemy import (
    Boolean,
    Float,
    ForeignKey,
    Index,
    Integer,
    String,
    Text,
    UniqueConstraint,
)
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class AiConversation(Base, TimestampMixin):
    __tablename__ = "ai_conversations"
    # created_at is indexed for time-range analytics and recent-first listing;
    # the other single-column indexes are declared inline via index=True.
    __table_args__ = (Index("ix_ai_conversations_created_at", "created_at"),)

    # The id IS the orchestrator's conversation_id (not a fresh default): the
    # engine mints it, the event stream carries it, this row adopts it.
    id: Mapped[uuid.UUID] = mapped_column(primary_key=True)

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    client_id: Mapped[uuid.UUID | None] = mapped_column(default=None)

    # Stamped from the engine on every conversation (CONVERSATION_STARTED), so
    # statistics can be compared across engine revisions.
    engine_version: Mapped[str] = mapped_column(String, index=True)
    language: Mapped[str] = mapped_column(String, default="fr")

    # Current/last state as a plain string, not a DB enum: the engine's state
    # set may evolve, and this table must not force a DDL migration each time.
    state: Mapped[str] = mapped_column(String, index=True)

    transcript: Mapped[str] = mapped_column(Text, default="")

    # --- fields for statistics (all nullable / defaulted) ---
    overall_confidence: Mapped[float | None] = mapped_column(Float, default=None)
    questions_asked: Mapped[int] = mapped_column(Integer, default=0)
    draft_line_count: Mapped[int] = mapped_column(Integer, default=0)
    unresolved_count: Mapped[int] = mapped_column(Integer, default=0)
    total_duration_ms: Mapped[float | None] = mapped_column(Float, default=None)
    # Per-step timings {"stt": 12.3, "extract": 40.1, ...} — latency analytics.
    timings: Mapped[dict] = mapped_column(JSONB, default=dict)
    error_code: Mapped[str | None] = mapped_column(String, default=None)
    error_message: Mapped[str | None] = mapped_column(String, default=None)
    # Set only if the client actually created the quote (conversion analytics).
    quote_reference: Mapped[str | None] = mapped_column(String, default=None)


class AiTurn(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "ai_turns"
    # (conversation_id, seq) is unique AND the lookup index: it backs both the
    # ordering guarantee and "give me this conversation's turns in order".
    __table_args__ = (
        UniqueConstraint("conversation_id", "seq", name="uq_ai_turns_conversation_id_seq"),
    )

    conversation_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("ai_conversations.id", ondelete="CASCADE")
    )
    seq: Mapped[int] = mapped_column(Integer)
    role: Mapped[str] = mapped_column(String)  # "user" | "assistant"
    content: Mapped[str] = mapped_column(Text)
    stt_confidence: Mapped[float | None] = mapped_column(Float, default=None)


class AiDecision(Base, TimestampMixin):
    __tablename__ = "ai_decisions"

    # id IS the decision_id minted by the engine — one unique id per AI decision.
    id: Mapped[uuid.UUID] = mapped_column(primary_key=True)

    conversation_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("ai_conversations.id", ondelete="CASCADE"), index=True
    )
    # Denormalized (no FK) so tenant-scoped decision analytics — "omit rate for
    # company X", "items company X gets suggested" — need no join. Cleanup still
    # happens through the conversation_id cascade above.
    company_id: Mapped[uuid.UUID] = mapped_column(index=True)

    source_index: Mapped[int] = mapped_column(Integer)
    # "include" | "clarify" | "omit" — the outcome, for distribution analytics.
    decision: Mapped[str] = mapped_column(String)
    # Null for an omitted prestation; indexed for item-suggestion frequency.
    catalog_item_id: Mapped[uuid.UUID | None] = mapped_column(default=None, index=True)
    designation: Mapped[str | None] = mapped_column(String, default=None)
    description: Mapped[str | None] = mapped_column(String, default=None)
    quantity: Mapped[float | None] = mapped_column(Float, default=None)
    confidence: Mapped[float | None] = mapped_column(Float, default=None)
    needs_review: Mapped[bool | None] = mapped_column(Boolean, default=None)
    reason: Mapped[str | None] = mapped_column(String, default=None)
