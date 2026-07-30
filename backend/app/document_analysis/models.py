"""ORM model for the document-analysis module: ``DocumentAnalysis``.

One row per uploaded document (a quote or invoice an artisan imports),
tracking it through the local analysis pipeline (see ``pipeline.py``)
from upload to a finished, structured ``blueprint``.

``document_type`` intentionally duplicates the shape of
``app.branding.models.TemplateType`` (same two values) rather than
importing it: this module must stay independent from ``branding`` at the
code level, even though it references the same company/template rows at
the data level via foreign keys. The two enums are allowed to diverge
later (e.g. this module may need a "other"/"unknown" document type that
would never make sense as a branding template slot).
"""

import enum
import uuid

from sqlalchemy import Enum as SAEnum
from sqlalchemy import ForeignKey
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class DocumentType(str, enum.Enum):
    QUOTE = "quote"
    INVOICE = "invoice"


class DocumentStatus(str, enum.Enum):
    UPLOADED = "uploaded"
    PROCESSING = "processing"
    COMPLETED = "completed"
    FAILED = "failed"


class DocumentAnalysis(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "document_analyses"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # Nullable: nothing links an analysis to a specific template yet — a
    # future matching step (structural fingerprint -> existing template)
    # will populate this. Set NULL rather than cascade-delete: losing a
    # template shouldn't destroy the analysis history that referenced it.
    document_template_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("document_templates.id", ondelete="SET NULL"), default=None
    )
    document_type: Mapped[DocumentType] = mapped_column(
        SAEnum(
            DocumentType,
            name="document_analysis_type",
            values_callable=lambda enum_cls: [member.value for member in enum_cls],
        )
    )
    filename: Mapped[str]
    file_hash: Mapped[str] = mapped_column(index=True)
    mime_type: Mapped[str]
    file_size: Mapped[int]
    # Storage key returned by StorageProvider.save() — not in the entity
    # field list from the spec, but required to re-fetch the file bytes
    # for /process; the field list is described as non-exhaustive ("notamment").
    storage_key: Mapped[str]
    # Unknown until PDFRenderer runs during /process, hence nullable.
    page_count: Mapped[int | None] = mapped_column(default=None)
    status: Mapped[DocumentStatus] = mapped_column(
        SAEnum(
            DocumentStatus,
            name="document_analysis_status",
            values_callable=lambda enum_cls: [member.value for member in enum_cls],
        ),
        default=DocumentStatus.UPLOADED,
        index=True,
    )
    processing_time_ms: Mapped[int | None] = mapped_column(default=None)
    # Actionable reason set when ``status`` is FAILED, so a failed import is
    # never silent to the artisan. A safe category message (never a stack trace
    # or internal detail — that goes to the logs). NULL while pending/on success.
    failure_reason: Mapped[str | None] = mapped_column(default=None)
    extracted_text: Mapped[str | None] = mapped_column(default=None)
    extracted_metadata: Mapped[dict[str, object] | None] = mapped_column(JSONB, default=None)
    detected_layout: Mapped[dict[str, object] | None] = mapped_column(JSONB, default=None)
    blueprint: Mapped[dict[str, object] | None] = mapped_column(JSONB, default=None)
