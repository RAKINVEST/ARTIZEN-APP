"""Document-detection business logic.

Fetches the underlying ``DocumentAnalysis`` via ``document_analysis``'s
own repository — the only module ``document_detection`` depends on, as
allowed by the spec ("il peut utiliser le pipeline document_analysis")
— runs the nine detectors once through ``DetectionAggregator``, and
caches the result. Routes never touch the repositories, storage or
aggregator directly.
"""

import asyncio
import logging
import uuid

from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.authorization import ensure_same_company
from app.core.exceptions import NotFoundError
from app.document_analysis.models import DocumentStatus
from app.document_analysis.repository import DocumentAnalysisRepository
from app.document_detection.aggregator import DetectionAggregator
from app.document_detection.exceptions import DocumentNotProcessedError
from app.document_detection.logo_detector import extract_first_image_png
from app.document_detection.models import DocumentDetectionResult
from app.document_detection.repository import DocumentDetectionResultRepository
from app.storage import StorageProvider

logger = logging.getLogger(__name__)


class DocumentDetectionService:
    def __init__(
        self, session: AsyncSession, storage: StorageProvider, aggregator: DetectionAggregator
    ) -> None:
        self._session = session
        self._storage = storage
        self._aggregator = aggregator
        self._analyses = DocumentAnalysisRepository(session)
        self._detections = DocumentDetectionResultRepository(session)

    async def extract_logo(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> bytes | None:
        """The logo image bytes of the analysed PDF, or ``None`` if there is
        no readable one. ``detect`` only scores whether a logo exists;
        ``template_import`` needs the pixels to persist it as the company
        logo, so this materialises the same first-page candidate. Loads and
        decodes off the event loop — pypdf/Pillow are CPU-bound, exactly like
        the detectors."""
        analysis = await self._analyses.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        ensure_same_company(analysis.company_id, analysis_id, company_id)
        content = await self._storage.load(analysis.storage_key)
        return await asyncio.to_thread(extract_first_image_png, content)

    async def get_or_run(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> DocumentDetectionResult:
        analysis = await self._analyses.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        ensure_same_company(analysis.company_id, analysis_id, company_id)

        existing = await self._detections.get_by_analysis_id(analysis_id)
        if existing is not None and existing.created_at >= analysis.updated_at:
            return existing
        if existing is not None:
            # The analysis was re-processed after this detection ran
            # (POST /process has no state guard, so it is replayable), which
            # left the cached result describing text that no longer exists.
            # Compared here rather than invalidated from document_analysis:
            # that module must not import this one — the dependency only
            # runs this way round.
            logger.info(
                "document_detection.stale_cache analysis_id=%s detected_at=%s reprocessed_at=%s",
                analysis_id,
                existing.created_at,
                analysis.updated_at,
            )

        if analysis.status != DocumentStatus.COMPLETED:
            raise DocumentNotProcessedError(
                f"Document analysis {analysis_id} must be processed "
                "(POST /document-analysis/{id}/process) before detection can run."
            )

        logger.info("document_detection.start analysis_id=%s", analysis_id)
        content = await self._storage.load(analysis.storage_key)
        fields = await self._aggregator.aggregate(
            text=analysis.extracted_text or "", content=content
        )
        logger.info(
            "document_detection.completed analysis_id=%s confidence_score=%.2f",
            analysis_id,
            fields["confidence_score"],
        )

        if existing is not None:
            # Refreshed in place: document_analysis_id is unique, so a
            # second row for the same analysis is not an option.
            for field, value in fields.items():
                setattr(existing, field, value)
            await self._session.flush()
            await self._session.refresh(existing)
            return existing

        detection = DocumentDetectionResult(document_analysis_id=analysis.id, **fields)
        try:
            return await self._detections.create(detection)
        except IntegrityError:
            # Two concurrent GETs both found no cached result and both ran
            # the detectors; the unique constraint lets exactly one insert
            # win. The loser re-reads the winner's row instead of failing
            # the request — the client asked for the detection, not for
            # which request computed it. Easy to trigger: the Flutter
            # screen fires preview and detection together.
            await self._session.rollback()
            winner = await self._detections.get_by_analysis_id(analysis_id)
            if winner is None:
                raise
            logger.info("document_detection.concurrent_insert analysis_id=%s", analysis_id)
            return winner
