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
from datetime import datetime, timezone

from sqlalchemy.ext.asyncio import AsyncSession

from app.catalog.repository import CatalogItemRepository
from app.clients.repository import ClientRepository
from app.core.exceptions import NotFoundError
from app.quotes.calculator import LineTotals, QuoteCalculator
from app.quotes.exceptions import (
    InactiveCatalogItemError,
    InvalidQuoteTransitionError,
    QuoteNotEditableError,
)
from app.quotes.models import QUOTE_TRANSITIONS, Quote, QuoteLine, QuoteStatus
from app.quotes.repository import (
    QuoteCounterRepository,
    QuoteLineRepository,
    QuoteRepository,
)
from app.quotes.schemas import QuoteCreate, QuoteLineRead, QuoteRead

#: "DEV-2026-0001". Prefix + year + zero-padded sequence, the sequence
#: restarting each year. Chosen because it is what French artisans
#: actually use, it carries its own date, and it extends to invoices as
#: "FAC-2026-0001" without inventing a second scheme.
QUOTE_NUMBER_PREFIX = "DEV"
_SEQUENCE_WIDTH = 4


def format_quote_number(year: int, sequence: int) -> str:
    """Pure, so the format can be tested without a database or a clock.

    Padding is a minimum, not a ceiling: the 10000th quote of a year
    becomes DEV-2026-10000 rather than silently colliding with a truncated
    number. Unlikely for one artisan, but the failure mode of the
    alternative is a duplicate document number — not something to leave to
    chance.
    """
    return f"{QUOTE_NUMBER_PREFIX}-{year}-{sequence:0{_SEQUENCE_WIDTH}d}"


class QuoteService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._quotes = QuoteRepository(session)
        self._lines = QuoteLineRepository(session)
        self._counters = QuoteCounterRepository(session)
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

        # Numbered at creation, not at send: the number is how the artisan
        # refers to the quote from the moment it exists — including while
        # still a draft, on the phone, before anything is sent. A deleted
        # draft therefore leaves a gap, which is fine for quotes. Invoices
        # inheriting this scheme will not have that latitude (art. 242
        # nonies A CGI) and will need to number at issue instead.
        year = datetime.now(timezone.utc).year
        sequence = await self._counters.next_number(data.company_id, year)

        quote = await self._quotes.create(
            Quote(
                company_id=data.company_id,
                client_id=data.client_id,
                quote_number=format_quote_number(year, sequence),
                status=QuoteStatus.DRAFT,
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

    async def change_status(self, quote_id: uuid.UUID, new_status: QuoteStatus) -> QuoteRead:
        """Move a quote along its commercial life, or refuse to.

        Transitions come from ``QUOTE_TRANSITIONS`` rather than from a
        chain of ifs, so the rule is one readable table instead of logic
        scattered across a method. What it forbids matters more than what
        it allows: nothing goes back to DRAFT. Once a PDF has left for the
        customer, the document they hold is a fact — a quote that could
        return to DRAFT could be edited and then silently disagree with
        the paper on their desk.

        The row is locked, not merely read: this is a read-decide-write,
        and the transition table alone cannot make it safe. Two concurrent
        requests would both read 'sent', both find their own move legal,
        and both write — so "accepté" could answer 200 and still lose to a
        simultaneous "refusé". Found by trying to break it, not by reading
        it. With the lock, the second request reads the first one's result
        and refuses properly.
        """
        quote = await self._quotes.get_for_update(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")

        if new_status == quote.status:
            # Idempotent: re-sending "sent" for a sent quote is not an
            # error, it is a client retrying.
            return await self._build_read(quote)

        allowed = QUOTE_TRANSITIONS.get(quote.status, frozenset())
        if new_status not in allowed:
            raise InvalidQuoteTransitionError(
                f"A quote cannot go from '{quote.status.value}' to "
                f"'{new_status.value}'."
                + (
                    f" Allowed from here: {', '.join(sorted(s.value for s in allowed))}."
                    if allowed
                    else " This status is final."
                )
            )

        quote.status = new_status
        await self._session.flush()
        await self._session.refresh(quote)
        return await self._build_read(quote)

    async def delete(self, quote_id: uuid.UUID) -> None:
        """Deletes a quote — only while it is still a DRAFT.

        Deleting is how a mistyped quote gets undone: there is no update
        path, deliberately. An update would have to recompute every total
        through ``QuoteCalculator``, which has no recalculation entry point
        for an existing quote, and nothing in the design would force a
        future caller to do so. Recreating goes back through ``create``,
        where totals are computed the only way they are ever computed.

        Past DRAFT it refuses: a sent quote is a document the customer
        holds, and an accepted one is a commercial commitment. Neither is
        the artisan's to erase — the trace has to survive, which is also
        what the invoices to come will require of their own numbering.

        Quote.lines cascade at the database level (QuoteLine.quote_id is
        ondelete="CASCADE"), so no line is orphaned.

        Locked for the same reason as ``change_status``: reading the status
        and then deleting is a read-decide-write. Without the lock, a delete
        racing a send could read 'draft', pass the check, and erase a quote
        that has just been sent to a customer.
        """
        quote = await self._quotes.get_for_update(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        if quote.status != QuoteStatus.DRAFT:
            raise QuoteNotEditableError(
                f"Quote {quote.quote_number} is '{quote.status.value}' and can no "
                "longer be deleted. Only a draft can."
            )
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
            quote_number=quote.quote_number,
            status=quote.status,
            total_ht=quote.total_ht,
            total_vat=quote.total_vat,
            total_ttc=quote.total_ttc,
            lines=[QuoteLineRead.model_validate(line) for line in lines],
            created_at=quote.created_at,
            updated_at=quote.updated_at,
        )
