"""Pydantic v2 schemas for the notification module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, Field


class NotificationCreate(BaseModel):
    # Ignored server-side — company_id comes from the JWT.
    company_id: uuid.UUID | None = None
    channel: str = Field(min_length=1)  # email | sms | push
    recipient: str = Field(min_length=1)
    subject: str = ""
    body: str = ""
    # Optional template: renders subject/body from context.
    template_key: str = ""
    context: dict = Field(default_factory=dict)
    related_type: str = ""
    related_id: str = ""


class NotificationRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    channel: str
    recipient: str
    subject: str
    body: str
    status: str
    template_key: str
    related_type: str
    related_id: str
    history: list[dict]
    created_at: datetime
    updated_at: datetime
