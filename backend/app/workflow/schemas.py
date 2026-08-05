"""Pydantic v2 schemas for the workflow module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, Field


class TransitionRead(BaseModel):
    event: str
    source: str
    target: str
    requires_validation: bool


class WorkflowDefinitionRead(BaseModel):
    slug: str
    name: str
    initial_state: str
    states: list[str]
    terminal_states: list[str]
    transitions: list[TransitionRead]


class StartWorkflowRequest(BaseModel):
    # Ignored server-side — company_id comes from the JWT.
    company_id: uuid.UUID | None = None
    definition_slug: str = Field(min_length=1)
    context: dict = Field(default_factory=dict)


class TransitionRequest(BaseModel):
    event: str = Field(min_length=1)


class WorkflowInstanceRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    definition_slug: str
    current_state: str
    status: str
    context: dict
    history: list[dict]
    # Computed from the definition (not columns): what the artisan can do next.
    available_events: list[str]
    is_terminal: bool
    created_at: datetime
    updated_at: datetime
