"""Pydantic v2 schemas for the AI Companion — the conversational contract.

Every response is explainable by construction: it carries *why*, *which engine*,
*which knowledge* and *what confidence*, and whether a human validation is
required. The Companion proposes; the artisan decides. No shape carries a price
the Companion computed — amounts only ever come back from the Quote Engine.
"""

import uuid
from typing import Literal

from pydantic import BaseModel, Field

# --- requests ---------------------------------------------------------------

class ChatRequest(BaseModel):
    # Ignored server-side — company_id always comes from the JWT.
    company_id: uuid.UUID | None = None
    message: str = Field(min_length=1, max_length=4000)
    # Continue an existing session; omit to start a new one.
    session_id: str | None = None
    # Structured slots the UI resolves (a picked client_id, a chosen date…). The
    # Companion never invents these — it fills action parameters only from here
    # or from prior turns, and asks when something required is still missing.
    params: dict = Field(default_factory=dict)


class ContinueRequest(BaseModel):
    session_id: str = Field(min_length=1)
    message: str = Field(min_length=1, max_length=4000)
    params: dict = Field(default_factory=dict)


class ConfirmRequest(BaseModel):
    session_id: str = Field(min_length=1)


class CancelRequest(BaseModel):
    session_id: str = Field(min_length=1)


# --- explainability ---------------------------------------------------------

class SourceRef(BaseModel):
    kind: str  # knowledge | mission | planning | decision | conversation
    ref: str = ""
    title: str = ""


class Explanation(BaseModel):
    why: str = ""
    engine: str = "companion"  # the owning engine that produced the substance
    knowledge_used: list[str] = Field(default_factory=list)  # knowledge slugs
    confidence: float = Field(ge=0, le=1, default=0.0)
    needs_confirmation: bool = False


class ProposedAction(BaseModel):
    """A business action the Companion would trigger — only via an owning
    engine's public service, and only after explicit human validation."""

    tool: str  # plan_intervention | schedule | send_notification | create_quote
    engine: str  # orchestration | planning | notification | quotes
    description: str
    params: dict = Field(default_factory=dict)
    missing: list[str] = Field(default_factory=list)  # required params still needed

    @property
    def ready(self) -> bool:
        return not self.missing


# --- responses --------------------------------------------------------------

class ChatResponse(BaseModel):
    session_id: str
    intent: str
    message: str
    explanation: Explanation
    sources: list[SourceRef] = Field(default_factory=list)
    proposed_action: ProposedAction | None = None
    needs_confirmation: bool = False
    questions: list[str] = Field(default_factory=list)  # clarification questions
    executed: bool = False  # true once a confirmed action has run
    result: dict | None = None  # the owning engine's result after execution


class ConversationTurn(BaseModel):
    role: Literal["user", "assistant"]
    text: str
    intent: str = ""


class SessionRead(BaseModel):
    session_id: str
    company_id: uuid.UUID
    turns: list[ConversationTurn] = Field(default_factory=list)
    pending_action: ProposedAction | None = None
    summary: str = ""
