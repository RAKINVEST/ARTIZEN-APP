"""Data-access layer for the branding module: one repository per entity,
built on the generic ``BaseRepository``. Each adds only the queries that
go beyond plain CRUD.
"""

import uuid

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.branding.models import BrandProfile, Company, DocumentTemplate, TemplateType
from app.repositories.base import BaseRepository


class CompanyRepository(BaseRepository[Company]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Company, session)


class BrandProfileRepository(BaseRepository[BrandProfile]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(BrandProfile, session)

    async def get_by_company_id(self, company_id: uuid.UUID) -> BrandProfile | None:
        result = await self.session.execute(
            select(BrandProfile).where(BrandProfile.company_id == company_id)
        )
        return result.scalars().first()


class DocumentTemplateRepository(BaseRepository[DocumentTemplate]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(DocumentTemplate, session)

    async def get_active(
        self, company_id: uuid.UUID, template_type: TemplateType
    ) -> DocumentTemplate | None:
        result = await self.session.execute(
            select(DocumentTemplate).where(
                DocumentTemplate.company_id == company_id,
                DocumentTemplate.type == template_type,
                DocumentTemplate.is_active.is_(True),
            )
        )
        return result.scalars().first()

    async def get_latest_version(self, company_id: uuid.UUID, template_type: TemplateType) -> int:
        result = await self.session.execute(
            select(func.max(DocumentTemplate.version)).where(
                DocumentTemplate.company_id == company_id,
                DocumentTemplate.type == template_type,
            )
        )
        return result.scalar() or 0

    async def list_by_company(self, company_id: uuid.UUID) -> list[DocumentTemplate]:
        result = await self.session.execute(
            select(DocumentTemplate)
            .where(DocumentTemplate.company_id == company_id)
            .order_by(DocumentTemplate.type, DocumentTemplate.version)
        )
        return list(result.scalars().all())
