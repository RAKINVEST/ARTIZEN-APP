"""Data-access layer for the document-detection module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.document_detection.models import DocumentDetectionResult
from app.repositories.base import BaseRepository


class DocumentDetectionResultRepository(BaseRepository[DocumentDetectionResult]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(DocumentDetectionResult, session)

    async def get_by_analysis_id(
        self, document_analysis_id: uuid.UUID
    ) -> DocumentDetectionResult | None:
        result = await self.session.execute(
            select(DocumentDetectionResult).where(
                DocumentDetectionResult.document_analysis_id == document_analysis_id
            )
        )
        return result.scalars().first()
