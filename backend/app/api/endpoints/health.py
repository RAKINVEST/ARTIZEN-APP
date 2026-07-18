"""Liveness/readiness probe used by Docker healthchecks and monitoring."""

import logging
from typing import Literal

from fastapi import APIRouter
from sqlalchemy import text

from app.api.deps import SessionDep
from app.core.config import settings
from app.redis_client import redis_healthy
from app.schemas.common import HealthResponse
from app.tasks.queue import queue_depth

logger = logging.getLogger(__name__)

router = APIRouter()


@router.get("/health", response_model=HealthResponse, tags=["health"])
async def health_check(session: SessionDep) -> HealthResponse:
    database_status: Literal["ok", "unavailable"]
    try:
        await session.execute(text("SELECT 1"))
        database_status = "ok"
    except Exception:
        logger.exception("Database health check failed")
        database_status = "unavailable"

    # Redis is monitored but non-fatal: it only powers async features, so its
    # absence must never turn a healthy app "degraded" (or fail the Docker
    # healthcheck). The overall status stays driven by the database alone.
    redis_ok = await redis_healthy()
    depth = await queue_depth() if redis_ok else None

    return HealthResponse(
        status="ok" if database_status == "ok" else "degraded",
        version=settings.VERSION,
        environment=settings.ENVIRONMENT,
        database=database_status,
        redis="ok" if redis_ok else "unavailable",
        queue_depth=depth,
    )
