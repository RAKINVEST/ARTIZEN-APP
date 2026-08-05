"""Pydantic v2 schemas for the orchestration module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, Field


class StartOrchestrationRequest(BaseModel):
    # Ignored server-side — company_id comes from the JWT.
    company_id: uuid.UUID | None = None
    plan_kind: str = "intervention"
    # The validated-decision context (e.g. {customer_id, title, workflow…}).
    context: dict = Field(default_factory=dict)


class OrchestrationRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    correlation_id: str
    plan_kind: str
    status: str
    is_terminal: bool
    context: dict
    plan: list[dict]
    timeline: list[dict]
    results: dict
    created_at: datetime
    updated_at: datetime
