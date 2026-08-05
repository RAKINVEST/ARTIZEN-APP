"""Pydantic schemas for the sites module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, ConfigDict, Field


class SiteCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # sites/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    # The client this jobsite belongs to. Validated server-side against the
    # caller's own clients: an unknown or other-tenant id is rejected as 404.
    customer_id: uuid.UUID
    name: str = Field(min_length=1)
    address: str | None = None


class SiteUpdate(BaseModel):
    # customer_id is intentionally absent: a site belongs to one client for
    # its whole life (Site invariant). Re-parenting is not an edit.
    name: str | None = Field(default=None, min_length=1)
    address: str | None = None


class SiteRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    customer_id: uuid.UUID
    name: str
    address: str | None
    status: str
    created_at: datetime
    updated_at: datetime
