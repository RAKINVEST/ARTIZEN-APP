"""Data-access layer for the document-analysis module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.document_analysis.models import DocumentAnalysis
from app.repositories.base import BaseRepository


class DocumentAnalysisRepository(BaseRepository[DocumentAnalysis]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(DocumentAnalysis, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[DocumentAnalysis]:
        result = await self.session.execute(
            select(DocumentAnalysis)
            .where(DocumentAnalysis.company_id == company_id)
            .order_by(DocumentAnalysis.created_at.desc())
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())
