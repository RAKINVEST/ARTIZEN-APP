"""Pydantic schemas for the clients module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, ConfigDict, EmailStr


class ClientCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # clients/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    last_name: str
    first_name: str | None = None
    company_name: str | None = None
    address: str | None = None
    phone: str | None = None
    # Optional, but if given it must be a real address — it will be printed on
    # the quote PDF and used to email the quote (V1.1). Empty = omit / send null.
    email: EmailStr | None = None
    notes: str | None = None


class ClientUpdate(BaseModel):
    last_name: str | None = None
    first_name: str | None = None
    company_name: str | None = None
    address: str | None = None
    phone: str | None = None
    # Optional, but if given it must be a real address — it will be printed on
    # the quote PDF and used to email the quote (V1.1). Empty = omit / send null.
    email: EmailStr | None = None
    notes: str | None = None


class ClientRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    last_name: str
    first_name: str | None
    company_name: str | None
    address: str | None
    phone: str | None
    email: str | None
    notes: str | None
    created_at: datetime
    updated_at: datetime
