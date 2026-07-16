"""Liveness/readiness probe used by Docker healthchecks and monitoring."""

import logging
from typing import Literal

from fastapi import APIRouter
from sqlalchemy import text

from app.api.deps import SessionDep
from app.core.config import settings
from app.schemas.common import HealthResponse

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

    return HealthResponse(
        status="ok" if database_status == "ok" else "degraded",
        version=settings.VERSION,
        environment=settings.ENVIRONMENT,
        database=database_status,
    )
