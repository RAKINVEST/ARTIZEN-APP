"""Public runtime configuration for the client (unauthenticated).

Exposes the handful of backend-owned values the UI needs — starting with the
support address — so there is a SINGLE source of truth (``app.core.config``),
never a copy baked into the Flutter build. Public because the legal pages, which
carry the contact address, are reachable while signed out.
"""

from fastapi import APIRouter
from pydantic import BaseModel

from app.core.config import settings

router = APIRouter()


class PublicConfig(BaseModel):
    support_email: str


@router.get("/config", response_model=PublicConfig, tags=["config"])
async def public_config() -> PublicConfig:
    return PublicConfig(support_email=settings.SUPPORT_EMAIL)
