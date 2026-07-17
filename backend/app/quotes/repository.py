"""Data-access layer for the quotes module."""

import uuid

from sqlalchemy import func, select
from sqlalchemy.dialects.postgresql import insert as pg_insert
from sqlalchemy.ext.asyncio import AsyncSession

from app.quotes.models import Quote, QuoteCounter, QuoteLine
from app.repositories.base import BaseRepository


class QuoteCounterRepository(BaseRepository[QuoteCounter]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(QuoteCounter, session)

    async def next_number(self, company_id: uuid.UUID, year: int) -> int:
        """Claim the next sequence number for this company and year.

        Race-free by construction, and that is the whole point of this
        method existing at all:

        1. ``INSERT ... ON CONFLICT DO NOTHING`` creates the counter row if
           this is the company's first quote of the year. Two concurrent
           first quotes both try; one inserts, the other no-ops. Neither
           errors.
        2. ``SELECT ... FOR UPDATE`` then locks that single row. A second
           transaction asking for a number blocks here until the first
           commits, so it reads the already-incremented value instead of
           the same one.

        The lock is on one company's one year, so artisans never wait on
        each other. What this replaces — ``SELECT MAX(quote_number) + 1`` —
        reads outside any lock: two simultaneous creations compute the same
        number, and one artisan gets an integrity error for having done
        nothing wrong.
        """
        await self.session.execute(
            pg_insert(QuoteCounter)
            .values(company_id=company_id, year=year, last_number=0)
            .on_conflict_do_nothing(index_elements=["company_id", "year"])
        )
        result = await self.session.execute(
            select(QuoteCounter)
            .where(QuoteCounter.company_id == company_id, QuoteCounter.year == year)
            .with_for_update()
        )
        counter = result.scalar_one()
        counter.last_number += 1
        await self.session.flush()
        return counter.last_number


class QuoteRepository(BaseRepository[Quote]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Quote, session)

    async def get_for_update(self, quote_id: uuid.UUID) -> Quote | None:
        """Load a quote with its row locked, for a read-decide-write.

        Plain ``get()`` is fine for reading. It is not fine for changing
        status: two concurrent requests both read 'sent', both find their
        transition legal, and both write — last one wins, and the artisan
        who clicked "accepté" got a 200 for a change that silently lost to
        "refusé". The transition rules cannot catch that, because at the
        moment each request checked them, both were correct.

        Locking the row makes the second request read the first one's
        result and refuse properly.
        """
        result = await self.session.execute(
            select(Quote).where(Quote.id == quote_id).with_for_update()
        )
        return result.scalar_one_or_none()

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

    async def list_by_quote_ids(
        self, quote_ids: list[uuid.UUID]
    ) -> dict[uuid.UUID, list[QuoteLine]]:
        """Lines for several quotes in one query, grouped by quote.

        Listing quotes used to call ``list_by_quote`` per quote: 100 quotes
        meant 101 round-trips, and the quotes list is the app's home
        screen. Grouped here rather than via a ``selectinload`` relationship
        so ``Quote`` keeps no ORM-level back-reference it doesn't otherwise
        need.
        """
        if not quote_ids:
            return {}
        result = await self.session.execute(
            select(QuoteLine).where(QuoteLine.quote_id.in_(quote_ids))
        )
        grouped: dict[uuid.UUID, list[QuoteLine]] = {quote_id: [] for quote_id in quote_ids}
        for line in result.scalars().all():
            grouped[line.quote_id].append(line)
        return grouped

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
