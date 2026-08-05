"""Pydantic v2 schemas for the mission module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, Field


class MissionCreate(BaseModel):
    # Ignored server-side — company_id comes from the JWT.
    company_id: uuid.UUID | None = None
    customer_id: uuid.UUID
    site_id: uuid.UUID | None = None
    title: str = Field(min_length=1)


class MissionStatusRequest(BaseModel):
    status: str = Field(min_length=1)


class AssociateWorkflowRequest(BaseModel):
    workflow_instance_id: uuid.UUID


class AttachmentRequest(BaseModel):
    kind: str = Field(min_length=1)  # photo | document | note
    label: str = ""
    reference: str = ""
    text: str = ""


class MissionRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    customer_id: uuid.UUID
    site_id: uuid.UUID | None
    workflow_instance_id: uuid.UUID | None
    title: str
    status: str
    progress: int  # computed (0–100)
    is_terminal: bool  # computed
    attachments: list[dict]
    timeline: list[dict]
    created_at: datetime
    updated_at: datetime
