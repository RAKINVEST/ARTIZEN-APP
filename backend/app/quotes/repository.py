"""Data-access layer for the quotes module."""

import uuid

from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.quotes.models import Quote, QuoteLine
from app.repositories.base import BaseRepository


class QuoteRepository(BaseRepository[Quote]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Quote, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[Quote]:
        result = await self.session.execute(
            select(Quote)
            .where(Quote.company_id == company_id)
            .order_by(Quote.created_at.desc())
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())


class QuoteLineRepository(BaseRepository[QuoteLine]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(QuoteLine, session)

    async def list_by_quote(self, quote_id: uuid.UUID) -> list[QuoteLine]:
        result = await self.session.execute(
            select(QuoteLine).where(QuoteLine.quote_id == quote_id)
        )
        return list(result.scalars().all())

    async def get_usage_counts_by_company(self, company_id: uuid.UUID) -> dict[uuid.UUID, int]:
        """How many past quote lines reference each catalog item, for this
        company. Feeds `quote_assistant.PromptBuilder`'s "frequently used"
        hint — a purely informational signal for the AI to break ties on
        an ambiguous description, never a substitute for its own judgment
        and never used to alter a suggestion after the fact."""
        result = await self.session.execute(
            select(QuoteLine.catalog_item_id, func.count(QuoteLine.id))
            .join(Quote, Quote.id == QuoteLine.quote_id)
            .where(Quote.company_id == company_id)
            .group_by(QuoteLine.catalog_item_id)
        )
        return dict(result.all())
