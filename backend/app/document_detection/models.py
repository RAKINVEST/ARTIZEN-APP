"""ORM model for the document-detection module: ``DocumentDetectionResult``.

One row per ``DocumentAnalysis`` (1-1 via ``document_analysis_id``),
holding the outcome of running all nine local heuristic detectors over
that document. Computed lazily on the first call to ``GET
/document-analysis/{id}/detection`` and cached here: detectors are
deterministic over the same extracted text/PDF, so recomputing on every
request would be wasted work (see ``DocumentDetectionService.get_or_run``).

Fields:

- ``logo_detected``: whether a logo candidate was found on page 1.
- ``logo_position``: coarse corner estimate (``"top_left"``, ``"bottom_right"``,
  ...) of the detected logo, or ``None`` if not detected / not determinable.
- ``dominant_colors``: up to 3 dominant hex colors (``"#rrggbb"``) sampled
  from the first embedded image on page 1; empty if no image was found.
- ``header_detected`` / ``footer_detected``: whether the first/last lines
  of the extracted text hold enough content to look like a letterhead or
  a footer block.
- ``table_detected``: whether several lines look like aligned tabular rows.
- ``company_name``: best-guess company name (first meaningful text line).
- ``address``: best-guess postal address line (5-digit postal code + city).
- ``phone`` / ``email`` / ``website``: contact coordinates found by regex.
- ``siret``: French SIRET number (14 digits) if found, Luhn-validated when possible.
- ``vat_number``: French or generic EU intra-community VAT number if found.
- ``legal_notice_detected``: whether known French legal-notice keywords were found.
- ``confidence_score``: average of the nine individual detector confidences (0-1).
- ``detection_details``: per-detector raw output (name -> detected/confidence/data),
  kept for debugging and as a stepping stone for a future Vision-based analyzer.
"""

import uuid

from sqlalchemy import ForeignKey, String
from sqlalchemy.dialects.postgresql import ARRAY, JSONB
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class DocumentDetectionResult(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "document_detection_results"

    document_analysis_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("document_analyses.id", ondelete="CASCADE"), unique=True, index=True
    )

    logo_detected: Mapped[bool] = mapped_column(default=False)
    logo_position: Mapped[str | None] = mapped_column(default=None)
    dominant_colors: Mapped[list[str]] = mapped_column(ARRAY(String), default=list)
    header_detected: Mapped[bool] = mapped_column(default=False)
    footer_detected: Mapped[bool] = mapped_column(default=False)
    table_detected: Mapped[bool] = mapped_column(default=False)
    company_name: Mapped[str | None] = mapped_column(default=None)
    address: Mapped[str | None] = mapped_column(default=None)
    phone: Mapped[str | None] = mapped_column(default=None)
    email: Mapped[str | None] = mapped_column(default=None)
    website: Mapped[str | None] = mapped_column(default=None)
    siret: Mapped[str | None] = mapped_column(default=None)
    vat_number: Mapped[str | None] = mapped_column(default=None)
    legal_notice_detected: Mapped[bool] = mapped_column(default=False)
    confidence_score: Mapped[float] = mapped_column(default=0.0)
    detection_details: Mapped[dict[str, object]] = mapped_column(JSONB, default=dict)
