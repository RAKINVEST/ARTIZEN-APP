"""Pydantic schema for the document-detection module."""

import uuid
from datetime import datetime

from pydantic import BaseModel, ConfigDict


class DocumentDetectionResultRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    document_analysis_id: uuid.UUID
    logo_detected: bool
    logo_position: str | None
    dominant_colors: list[str]
    header_detected: bool
    footer_detected: bool
    table_detected: bool
    company_name: str | None
    address: str | None
    phone: str | None
    email: str | None
    website: str | None
    siret: str | None
    vat_number: str | None
    legal_notice_detected: bool
    confidence_score: float
    detection_details: dict[str, object]
    created_at: datetime
    updated_at: datetime
