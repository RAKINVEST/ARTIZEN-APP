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
from app.quotes.calculator import LineTotals, QuoteCalculator
from app.quotes.exceptions import InactiveCatalogItemError
from app.quotes.models import Quote, QuoteLine
from app.quotes.repository import QuoteLineRepository, QuoteRepository
from app.quotes.schemas import QuoteCreate, QuoteLineRead, QuoteRead


class QuoteService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._quotes = QuoteRepository(session)
        self._lines = QuoteLineRepository(session)
        self._catalog_items = CatalogItemRepository(session)
        self._clients = ClientRepository(session)
        self._calculator = QuoteCalculator()

    async def create(self, data: QuoteCreate) -> QuoteRead:
        client = await self._clients.get(data.client_id)
        if client is None or client.company_id != data.company_id:
            raise NotFoundError(f"Client {data.client_id} not found.")

        line_models: list[QuoteLine] = []
        line_totals: list[LineTotals] = []
        for line_data in data.lines:
            item = await self._catalog_items.get(line_data.catalog_item_id)
            if item is None or item.company_id != data.company_id:
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

        quote_totals = self._calculator.calculate_quote(line_totals)

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

    async def get(self, quote_id: uuid.UUID) -> QuoteRead:
        quote = await self._quotes.get(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        return await self._build_read(quote)

    async def delete(self, quote_id: uuid.UUID) -> None:
        """Deleting is the only way to undo a quote, and until now there
        wasn't one: no PUT, no PATCH, no DELETE, so a mistyped quantity was
        permanent and the artisan's only recourse was a second quote next
        to the wrong one.

        Deliberately delete-and-recreate rather than an update path. An
        update would have to recompute every total through
        ``QuoteCalculator`` — which has no recalculation entry point for an
        existing quote — and nothing in the current design would force a
        future caller to do so. Recreating goes back through ``create``,
        where the totals are computed the only way they are ever computed.
        Editing in place waits for the quote lifecycle (status: only a
        draft is editable) — see docs/AUDIT-V1.md.

        Quote.lines cascade at the database level (QuoteLine.quote_id is
        ondelete="CASCADE"), so no line is orphaned.
        """
        quote = await self._quotes.get(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        await self._quotes.delete(quote)

    async def list(
        self, *, company_id: uuid.UUID | None = None, offset: int = 0, limit: int = 100
    ) -> list[QuoteRead]:
        if company_id is not None:
            quotes = await self._quotes.list_by_company(company_id, offset=offset, limit=limit)
        else:
            quotes = await self._quotes.list(offset=offset, limit=limit)
        # One grouped query for every quote's lines, not one per quote.
        lines_by_quote = await self._lines.list_by_quote_ids([quote.id for quote in quotes])
        return [self._to_read(quote, lines_by_quote.get(quote.id, [])) for quote in quotes]

    async def _build_read(self, quote: Quote) -> QuoteRead:
        lines = await self._lines.list_by_quote(quote.id)
        return self._to_read(quote, lines)

    @staticmethod
    # "list[QuoteLine]" is quoted on purpose. This class defines a method
    # named `list`, which shadows the builtin inside the class body from its
    # own definition onwards — so an unquoted `list[QuoteLine]` here
    # subscripts that method and raises TypeError at import time. (`list`'s
    # own `-> list[QuoteRead]` works only because its annotation is
    # evaluated before the name is bound.) Quoting defers the lookup to
    # typing, which resolves it against the module namespace.
    def _to_read(quote: Quote, lines: "list[QuoteLine]") -> QuoteRead:
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
