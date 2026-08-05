"""Pydantic v2 schemas for the decision module.

The Decision Engine is read-side (docs/blueprint/engines/decision/): it turns an
intention into an explained *proposal* and **never persists anything, never
creates a Quote, never computes an amount** (ADR-023). Since the integration
with the Knowledge Engine, a proposal is a set of **knowledge elements**
(cards, kits, diagnostics, procedures…) drawn from the Knowledge Engine — the
single source of truth. No shape here carries a price.
"""

import uuid

from pydantic import BaseModel, Field


class DecisionRequest(BaseModel):
    # Ignored server-side — company_id always comes from the authenticated user.
    company_id: uuid.UUID | None = None
    intent: str = Field(min_length=1, max_length=2000)


class Intent(BaseModel):
    """The understood intention (read-side, transient — never persisted)."""

    verb: str  # normalized intervention verb (frozen taxonomy `intervention:`)
    target: str
    raw: str


class ProposalElement(BaseModel):
    """One piece of knowledge proposed for the intent, straight from the
    Knowledge Engine — with its confidence, sources and relations."""

    slug: str
    type: str  # card | kit | diagnostic | checklist | procedure | phrase
    title: str
    reason: str  # why proposed (the Knowledge match explanation)
    score: float = Field(ge=0, le=1)
    confidence: str = ""  # A/B/C/D (from the knowledge item)
    sources: list[str] = Field(default_factory=list)
    relations: list[str] = Field(default_factory=list)


class Proposal(BaseModel):
    elements: list[ProposalElement] = Field(default_factory=list)
    comment: str = ""


class ExplanationItem(BaseModel):
    """Why one element is proposed — traceable to the Knowledge Engine (Loi 6)."""

    subject: str
    why: str
    basis: str
    confidence: str = ""


class Explanation(BaseModel):
    items: list[ExplanationItem] = Field(default_factory=list)


class DecisionResponse(BaseModel):
    intent: Intent
    proposal: Proposal
    explanation: Explanation
    confidence: float = Field(ge=0, le=1)
    needs_confirmation: bool = False
    questions: list[str] = Field(default_factory=list)
