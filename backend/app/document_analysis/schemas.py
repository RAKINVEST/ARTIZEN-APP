"""Pydantic schema for the document-analysis module.

A single read model is enough: upload, get, list and process all return
the same ``DocumentAnalysis`` resource shape — there is no separate
"upload response" concept like in ``branding``, since the entity itself
already is the thing being returned everywhere.
"""

import uuid
from datetime import datetime

from pydantic import BaseModel, ConfigDict

from app.document_analysis.models import DocumentStatus, DocumentType


class DocumentAnalysisRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    company_id: uuid.UUID
    document_template_id: uuid.UUID | None
    document_type: DocumentType
    filename: str
    file_hash: str
    mime_type: str
    file_size: int
    page_count: int | None
    status: DocumentStatus
    processing_time_ms: int | None
    extracted_text: str | None
    extracted_metadata: dict[str, object] | None
    detected_layout: dict[str, object] | None
    blueprint: dict[str, object] | None
    created_at: datetime
    updated_at: datetime
