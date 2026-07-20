"""Quotes business logic: validates the client and every catalog item,
snapshots prices, runs ``QuoteCalculator`` for every amount, and
persists the result. Routes never touch repositories, the catalog, the
client list or the calculator directly.

Depends on ``catalog/`` and ``clients/`` (one-directional — neither of
those depends back on ``quotes/``), the same allowed-dependency pattern
``document_detection`` used on ``document_analysis`` in step 4: a quote
cannot exist without referencing real catalog items and a real client,
so this module is naturally "downstream" of both.
"""

import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.catalog.repository import CatalogItemRepository
from app.clients.repository import ClientRepository
from app.core.exceptions import NotFoundError
from app.quotes.calculator import LineTotals, QuoteCalculator, QuoteTotals
from app.quotes.exceptions import InactiveCatalogItemError
from app.quotes.models import Quote, QuoteLine
from app.quotes.repository import QuoteLineRepository, QuoteRepository
from app.quotes.schemas import (
    QuoteCreate,
    QuoteLineCreate,
    QuoteLineRead,
    QuoteRead,
    QuoteUpdate,
)


class QuoteService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._quotes = QuoteRepository(session)
        self._lines = QuoteLineRepository(session)
        self._catalog_items = CatalogItemRepository(session)
        self._clients = ClientRepository(session)
        self._calculator = QuoteCalculator()

    async def _build_lines(
        self, company_id: uuid.UUID, lines_data: list[QuoteLineCreate]
    ) -> tuple[list[QuoteLine], QuoteTotals]:
        """Validates every referenced catalog item, snapshots its price and
        computes each line's amounts. Shared by ``create`` and ``update`` so
        both paths apply exactly the same rules — an edited quote is priced
        by the same code as a new one."""
        line_models: list[QuoteLine] = []
        line_totals: list[LineTotals] = []
        for line_data in lines_data:
            item = await self._catalog_items.get(line_data.catalog_item_id)
            if item is None or item.company_id != company_id:
                raise NotFoundError(f"Catalog item {line_data.catalog_item_id} not found.")
            if not item.active:
                raise InactiveCatalogItemError(
                    f"Catalog item {item.id} is inactive and cannot be used in a quote."
                )

            totals = self._calculator.calculate_line(
                quantity=line_data.quantity,
                unit_price_ht=item.unit_price_ht,
                vat_rate=item.vat_rate,
            )
            line_totals.append(totals)
            line_models.append(
                QuoteLine(
                    catalog_item_id=item.id,
                    designation=item.designation,
                    unit=item.unit,
                    quantity=line_data.quantity,
                    unit_price_ht=item.unit_price_ht,
                    vat_rate=item.vat_rate,
                    total_ht=totals.total_ht,
                    total_vat=totals.total_vat,
                    total_ttc=totals.total_ttc,
                )
            )
        return line_models, self._calculator.calculate_quote(line_totals)

    async def _require_client(self, client_id: uuid.UUID, company_id: uuid.UUID) -> None:
        client = await self._clients.get(client_id)
        if client is None or client.company_id != company_id:
            raise NotFoundError(f"Client {client_id} not found.")

    async def create(self, data: QuoteCreate) -> QuoteRead:
        await self._require_client(data.client_id, data.company_id)
        line_models, quote_totals = await self._build_lines(data.company_id, data.lines)

        quote = await self._quotes.create(
            Quote(
                company_id=data.company_id,
                client_id=data.client_id,
                total_ht=quote_totals.total_ht,
                total_vat=quote_totals.total_vat,
                total_ttc=quote_totals.total_ttc,
            )
        )
        for line in line_models:
            line.quote_id = quote.id
            await self._lines.create(line)

        return await self._build_read(quote)

    async def update(
        self, quote_id: uuid.UUID, data: QuoteUpdate, *, company_id: uuid.UUID
    ) -> QuoteRead:
        """Replaces a quote's lines and recomputes every total. A quote stays
        editable indefinitely — the artisan reopens it and adjusts it as the
        job evolves."""
        quote = await self._quotes.get(quote_id)
        if quote is None or quote.company_id != company_id:
            raise NotFoundError(f"Quote {quote_id} not found.")

        if data.client_id is not None:
            await self._require_client(data.client_id, company_id)
            quote.client_id = data.client_id

        line_models, quote_totals = await self._build_lines(company_id, data.lines)

        # Old lines go before the new ones are written, so the quote never
        # holds both sets at once.
        for stale_line in await self._lines.list_by_quote(quote.id):
            await self._session.delete(stale_line)
        await self._session.flush()

        for line in line_models:
            line.quote_id = quote.id
            await self._lines.create(line)

        quote.total_ht = quote_totals.total_ht
        quote.total_vat = quote_totals.total_vat
        quote.total_ttc = quote_totals.total_ttc
        await self._session.flush()
        await self._session.refresh(quote)

        return await self._build_read(quote)

    async def get(self, quote_id: uuid.UUID) -> QuoteRead:
        quote = await self._quotes.get(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        return await self._build_read(quote)

    async def list(
        self,
        *,
        company_id: uuid.UUID | None = None,
        client_id: uuid.UUID | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[QuoteRead]:
        if company_id is not None:
            quotes = await self._quotes.list_by_company(
                company_id, client_id=client_id, offset=offset, limit=limit
            )
        else:
            quotes = await self._quotes.list(offset=offset, limit=limit)
        return [await self._build_read(quote) for quote in quotes]

    async def _build_read(self, quote: Quote) -> QuoteRead:
        lines = await self._lines.list_by_quote(quote.id)
        return QuoteRead(
            id=quote.id,
            company_id=quote.company_id,
            client_id=quote.client_id,
            total_ht=quote.total_ht,
            total_vat=quote.total_vat,
            total_ttc=quote.total_ttc,
            lines=[QuoteLineRead.model_validate(line) for line in lines],
            created_at=quote.created_at,
            updated_at=quote.updated_at,
        )
