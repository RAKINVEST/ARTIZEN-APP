"""Document-analysis business logic: validates uploads, computes the file
hash, stores the file, runs the pipeline and persists its result. Routes
never touch the repository, storage or pipeline directly.

Status transitions live here, not in ``DocumentPipeline``: the pipeline
is a pure computation over bytes/text/dicts and has no notion of
``DocumentAnalysis`` persistence or status.
"""

import logging
import time
import uuid

from fastapi import UploadFile
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import NotFoundError
from app.document_analysis.exceptions import InvalidDocumentError
from app.document_analysis.hashing import sha256_hex
from app.document_analysis.models import DocumentAnalysis, DocumentStatus, DocumentType
from app.document_analysis.pipeline import DocumentPipeline
from app.document_analysis.repository import DocumentAnalysisRepository
from app.storage import StorageProvider
from app.utils.upload_validation import read_validated_upload

logger = logging.getLogger(__name__)

_PDF_CONTENT_TYPES = {"application/pdf"}
_PDF_MAX_SIZE_BYTES = 15 * 1024 * 1024  # 15 MB


def _describe_failure(exc: Exception) -> str:
    """A safe, artisan-actionable reason for a failed analysis — never a stack
    trace or internal detail (those go to the logs). Distinguishes "the document
    is the problem" (the artisan can fix it) from "our problem" (retry/support)."""
    if isinstance(exc, InvalidDocumentError):
        return (
            "Le document n'a pas pu être analysé : fichier illisible, protégé "
            "par mot de passe, ou trop volumineux. Vérifiez le PDF et réessayez."
        )
    return "Une erreur inattendue est survenue pendant l'analyse. Réessayez plus tard."


class DocumentAnalysisService:
    def __init__(
        self, session: AsyncSession, storage: StorageProvider, pipeline: DocumentPipeline
    ) -> None:
        self._session = session
        self._storage = storage
        self._pipeline = pipeline
        self._repo = DocumentAnalysisRepository(session)

    async def upload(
        self,
        *,
        company_id: uuid.UUID,
        document_type: DocumentType,
        upload: UploadFile,
    ) -> DocumentAnalysis:
        """A new analysis is never linked to a template on creation:
        ``document_template_id`` is set later, and only by
        ``TemplateImportService``, once it has created the template itself.
        Accepting one here meant trusting a client-supplied reference to
        another module's row — see the route's docstring."""
        content = await read_validated_upload(
            upload, allowed_content_types=_PDF_CONTENT_TYPES, max_size_bytes=_PDF_MAX_SIZE_BYTES
        )
        file_hash = sha256_hex(content)
        filename = upload.filename or "document.pdf"
        mime_type = upload.content_type or "application/pdf"

        stored = await self._storage.save(
            category="document_analysis",
            filename=filename,
            content_type=mime_type,
            content=content,
        )

        analysis = DocumentAnalysis(
            company_id=company_id,
            document_type=document_type,
            filename=filename,
            file_hash=file_hash,
            mime_type=mime_type,
            file_size=len(content),
            storage_key=stored.key,
            status=DocumentStatus.UPLOADED,
        )
        return await self._repo.create(analysis)

    async def get(self, analysis_id: uuid.UUID) -> DocumentAnalysis:
        analysis = await self._repo.get(analysis_id)
        if analysis is None:
            raise NotFoundError(f"Document analysis {analysis_id} not found.")
        return analysis

    async def list(
        self, *, company_id: uuid.UUID | None = None, offset: int = 0, limit: int = 100
    ) -> list[DocumentAnalysis]:
        if company_id is not None:
            return await self._repo.list_by_company(company_id, offset=offset, limit=limit)
        return await self._repo.list(offset=offset, limit=limit)

    async def process(self, analysis_id: uuid.UUID) -> DocumentAnalysis:
        analysis = await self.get(analysis_id)
        analysis.status = DocumentStatus.PROCESSING
        await self._session.flush()

        started_at = time.perf_counter()
        try:
            result = await self._pipeline.run(analysis)
        except Exception as exc:
            analysis.status = DocumentStatus.FAILED
            analysis.failure_reason = _describe_failure(exc)
            analysis.processing_time_ms = int((time.perf_counter() - started_at) * 1000)
            # Full detail (type + traceback) goes to the logs; only a safe,
            # actionable reason is persisted/surfaced. A silent FAILED used to
            # lose the cause entirely (the exception wasn't even bound).
            logger.warning(
                "document_analysis.process.failed analysis_id=%s", analysis_id, exc_info=True
            )
            await self._session.flush()
            await self._session.refresh(analysis)
            return analysis

        analysis.page_count = result.page_count
        analysis.extracted_text = result.extracted_text
        analysis.extracted_metadata = result.extracted_metadata
        analysis.detected_layout = result.detected_layout
        analysis.blueprint = result.blueprint
        analysis.processing_time_ms = int((time.perf_counter() - started_at) * 1000)
        analysis.status = DocumentStatus.COMPLETED
        await self._session.flush()
        # `updated_at` (onupdate=func.now()) is left expired after flush();
        # refresh() loads it now, inside the async context, so the
        # synchronous Pydantic serialization in the router never triggers
        # an implicit lazy-load (which would raise MissingGreenlet).
        await self._session.refresh(analysis)
        return analysis
