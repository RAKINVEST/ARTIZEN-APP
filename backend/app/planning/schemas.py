"""Pydantic v2 schemas for the planning module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, Field


class PlanningCreate(BaseModel):
    # Ignored server-side — company_id comes from the JWT.
    company_id: uuid.UUID | None = None
    mission_id: uuid.UUID | None = None
    start_at: datetime
    duration_minutes: int = Field(gt=0, le=24 * 60)
    artisan: str = ""
    team: str = ""
    vehicle: str = ""


class PlanningPatch(BaseModel):
    duration_minutes: int | None = Field(default=None, gt=0, le=24 * 60)
    artisan: str | None = None
    team: str | None = None
    vehicle: str | None = None


class PlanningMoveRequest(BaseModel):
    start_at: datetime
    duration_minutes: int | None = Field(default=None, gt=0, le=24 * 60)


class PlanningAssignRequest(BaseModel):
    artisan: str = ""
    team: str = ""
    vehicle: str = ""
    # Auto-assign: pick the first free candidate (deterministic).
    auto: bool = False
    candidates: list[str] = Field(default_factory=list)


class PlanningConflictRead(BaseModel):
    type: str
    detail: str
    entry_id: str = ""


class AvailabilityRead(BaseModel):
    available: bool
    conflicts: list[PlanningConflictRead] = Field(default_factory=list)


class PlanningRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    mission_id: uuid.UUID | None
    start_at: datetime
    end_at: datetime  # computed
    duration_minutes: int
    artisan: str
    team: str
    vehicle: str
    status: str
    is_terminal: bool  # computed
    history: list[dict]
    created_at: datetime
    updated_at: datetime
