"""Schemas shared across modules (not tied to a single domain entity)."""

from typing import Literal

from pydantic import BaseModel


class HealthResponse(BaseModel):
    status: Literal["ok", "degraded"]
    version: str
    environment: str
    database: Literal["ok", "unavailable"]
    # V3 foundations monitoring. Redis is optional infrastructure, so its
    # absence is reported but does NOT flip the overall status to degraded —
    # the app is fully usable (async features excepted) without it.
    redis: Literal["ok", "unavailable"] = "unavailable"
    queue_depth: int | None = None
