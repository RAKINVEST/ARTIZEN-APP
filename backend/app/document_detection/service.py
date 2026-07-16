"""Document-detection business logic.

Fetches the underlying ``DocumentAnalysis`` via ``document_analysis``'s
own repository — the only module ``document_detection`` depends on, as
allowed by the spec ("il peut utiliser le pipeline document_analysis")
— runs the nine detectors once through ``DetectionAggregator``, and
caches the result. Routes never touch the repositories, storage or
aggregator directly.
"""

import logging
import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.authorization import ensure_same_company
from app.core.exceptions import NotFoundError
from app.document_analysis.models import DocumentStatus
from app.document_analysis.repository import DocumentAnalysisRepository
from app.document_detection.aggregator import DetectionAggregator
from app.document_detection.exceptions import DocumentNotProcessedError
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

    async def get_or_run(
        self, analysis_id: uuid.UUID, *, company_id: uuid.UUID
    ) -> DocumentDetectionResult:
        analysis = await self._analyses.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        ensure_same_company(analysis.company_id, analysis_id, company_id)

        existing = await self._detections.get_by_analysis_id(analysis_id)
        if existing is not None:
            return existing

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

        detection = DocumentDetectionResult(document_analysis_id=analysis.id, **fields)
        return await self._detections.create(detection)
