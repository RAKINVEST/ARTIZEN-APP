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

import asyncio
import logging
import uuid
from datetime import date, datetime, timezone
from decimal import Decimal

from sqlalchemy.ext.asyncio import AsyncSession

from app.branding.schemas import BrandingProfileRead
from app.branding.service import BrandingService
from app.catalog.repository import CatalogItemRepository
from app.clients.repository import ClientRepository
from app.core.exceptions import NotFoundError
from app.email.base import EmailAttachment, EmailProvider
from app.pdf.html_renderer import HtmlPdfRenderer
from app.quotes.calculator import LineTotals, QuoteCalculator, QuoteTotals
from app.quotes.document_mapper import quote_to_document, sample_document
from app.quotes.exceptions import (
    InactiveCatalogItemError,
    InvalidQuoteTransitionError,
    QuoteHasNoRecipientError,
    QuoteNotEditableError,
)
from app.quotes.models import QUOTE_TRANSITIONS, Quote, QuoteLine, QuoteStatus
from app.quotes.readiness import evaluate_readiness
from app.quotes.repository import (
    QuoteCounterRepository,
    QuoteLineRepository,
    QuoteRepository,
)
from app.quotes.schemas import (
    QuoteCalculation,
    QuoteCalculationRequest,
    QuoteCreate,
    QuoteLineCalculation,
    QuoteLineCreate,
    QuoteLineRead,
    QuoteRead,
    QuoteReadiness,
)
from app.storage import StorageProvider

logger = logging.getLogger(__name__)

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
    def __init__(
        self,
        session: AsyncSession,
        branding: BrandingService,
        storage: StorageProvider,
        email: EmailProvider,
    ) -> None:
        """``branding``, ``storage`` and ``email`` are injected rather than
        built here: rendering a document needs the artisan's identity and their
        logo bytes, and sending it needs the mail provider — all somebody else's
        to own. quotes -> branding / email are one-way dependencies, the same
        shape quote_assistant -> branding already has (email is infrastructure,
        like storage)."""
        self._session = session
        self._branding = branding
        self._storage = storage
        self._email = email
        self._renderer = HtmlPdfRenderer()
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

        line_models, quote_totals = await self._price_lines(
            company_id=data.company_id, lines_data=data.lines
        )
        return await self._persist_new_quote(
            company_id=data.company_id,
            client_id=data.client_id,
            line_models=line_models,
            totals=quote_totals,
        )

    async def calculate(self, data: QuoteCalculationRequest) -> QuoteCalculation:
        """Prices a draft **without persisting anything**.

        The guided flow lets the artisan add, remove and re-quantify lines
        and must show the running HT/VAT/TTC as they do. That total is a
        monetary amount like any other, so it cannot be added up in Flutter:
        the client displays what this returns and computes nothing.

        This is not an edit path and does not weaken "a quote is never
        modified": no ``Quote`` row is touched, no number is burned from the
        counter, no status exists. It is a pure function of (company, lines).

        It shares ``_price_lines`` with :meth:`create`, which is the point —
        a preview that could disagree with the quote finally created would be
        worse than no preview at all.
        """
        line_models, totals = await self._price_lines(
            company_id=data.company_id, lines_data=data.lines
        )
        return QuoteCalculation(
            total_ht=totals.total_ht,
            total_vat=totals.total_vat,
            total_ttc=totals.total_ttc,
            lines=[QuoteLineCalculation.model_validate(line) for line in line_models],
        )

    async def _price_lines(
        self, *, company_id: uuid.UUID, lines_data: list[QuoteLineCreate]
    ) -> tuple[list[QuoteLine], QuoteTotals]:
        """Turns requested (catalog item, quantity) pairs into priced lines.

        Shared by :meth:`create` and :meth:`calculate` so the live preview and
        the persisted quote walk the exact same catalog lookups, the same
        VAT-regime override and the same calculator. Returned ``QuoteLine``
        objects are unsaved: only ``create`` gives them a ``quote_id``.
        """
        # A company under the franchise-en-base regime (art. 293 B du CGI, the
        # micro-entrepreneur case) charges NO VAT: every line is HT only. The
        # regime belongs to the company, not the catalog item, so the service
        # applies it here by overriding the rate to 0 before the calculator
        # runs — the calculator stays the one place amounts are computed, and
        # the stored line snapshot (vat_rate=0) matches the total (VAT=0).
        company = await self._branding.get_company(company_id)
        vat_exempt = company.vat_regime == "franchise"

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

            effective_vat_rate = Decimal("0.00") if vat_exempt else item.vat_rate
            totals = self._calculator.calculate_line(
                quantity=line_data.quantity,
                unit_price_ht=item.unit_price_ht,
                vat_rate=effective_vat_rate,
            )
            line_totals.append(totals)
            line_models.append(
                QuoteLine(
                    catalog_item_id=item.id,
                    designation=item.designation,
                    unit=item.unit,
                    quantity=line_data.quantity,
                    unit_price_ht=item.unit_price_ht,
                    vat_rate=effective_vat_rate,
                    total_ht=totals.total_ht,
                    total_vat=totals.total_vat,
                    total_ttc=totals.total_ttc,
                )
            )

        return line_models, self._calculator.calculate_quote(line_totals)

    async def _persist_new_quote(
        self,
        *,
        company_id: uuid.UUID,
        client_id: uuid.UUID,
        line_models: list[QuoteLine],
        totals: QuoteTotals,
    ) -> QuoteRead:
        """Numbers, persists and returns a brand-new DRAFT quote.

        Shared by ``create`` (lines built from the live catalog) and
        ``duplicate`` (lines copied from an existing quote). Both need the
        exact same "claim a number, insert the quote, insert its lines"
        sequence, and the numbering is the part that must not be
        reimplemented twice — a second copy is a second chance to get the
        FOR UPDATE lock wrong.

        Numbered here, not at send: the number is how the artisan refers to
        the quote from the moment it exists. A deleted draft leaves a gap,
        which is fine for quotes; invoices inheriting this scheme will not
        have that latitude (art. 242 nonies A CGI) and must number at issue.
        """
        year = datetime.now(timezone.utc).year
        sequence = await self._counters.next_number(company_id, year)

        quote = await self._quotes.create(
            Quote(
                company_id=company_id,
                client_id=client_id,
                quote_number=format_quote_number(year, sequence),
                status=QuoteStatus.DRAFT,
                total_ht=totals.total_ht,
                total_vat=totals.total_vat,
                total_ttc=totals.total_ttc,
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

    async def check_readiness(self, quote_id: uuid.UUID) -> QuoteReadiness:
        """Is this quote ready to be downloaded/printed/sent? Returns 🟢 or the
        precise 🔴 list (Phase 1.1, Mission 2). Reuses the same company, client
        and lines a real render would — so "ready" means "the PDF will be
        complete", not a guess."""
        quote = await self._quotes.get(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        profile = await self._branding.get_profile(quote.company_id)
        client = await self._clients.get(quote.client_id)
        lines = await self._lines.list_by_quote(quote.id)
        issues = evaluate_readiness(
            company=profile.company, brand=profile.brand, client=client, quote=quote, lines=lines
        )
        return QuoteReadiness(ready=not issues, issues=issues)

    async def duplicate(self, quote_id: uuid.UUID) -> QuoteRead:
        """Creates a fresh DRAFT that copies an existing quote's lines.

        This is the *edit* path a quote deliberately doesn't have: a quote
        can't be modified, so "correct" or "reuse" one means duplicating it
        into a new draft and changing that. Works on a quote in any status —
        the common case is duplicating a sent or refused quote to make a
        revised one.

        The lines are copied verbatim from the original's stored snapshot
        (designation, unit, quantity, unit_price_ht, vat_rate), **not**
        re-priced from the live catalog. Two reasons this is the right
        default:

        - "Duplicate" means "make a copy". An artisan expects the same
          figures, not today's — if they wanted new prices they would
          remove and re-add the line, which re-prices.
        - It cannot fail. Re-pricing would have to re-fetch each catalog
          item and would break the moment one had been deactivated or its
          price changed — precisely on the old quotes most worth
          duplicating. Copying the snapshot depends on nothing but the
          original.

        Totals are still recomputed through ``QuoteCalculator`` rather than
        copied, so the one-place-computes-money rule holds: the numbers are
        re-derived from the copied inputs, never trusted blindly from the
        source row.
        """
        original = await self._quotes.get(quote_id)
        if original is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        source_lines = await self._lines.list_by_quote(quote_id)

        line_models: list[QuoteLine] = []
        line_totals: list[LineTotals] = []
        for source in source_lines:
            totals = self._calculator.calculate_line(
                quantity=source.quantity,
                unit_price_ht=source.unit_price_ht,
                vat_rate=source.vat_rate,
            )
            line_totals.append(totals)
            line_models.append(
                QuoteLine(
                    catalog_item_id=source.catalog_item_id,
                    designation=source.designation,
                    unit=source.unit,
                    quantity=source.quantity,
                    unit_price_ht=source.unit_price_ht,
                    vat_rate=source.vat_rate,
                    total_ht=totals.total_ht,
                    total_vat=totals.total_vat,
                    total_ttc=totals.total_ttc,
                )
            )

        quote_totals = self._calculator.calculate_quote(line_totals)
        return await self._persist_new_quote(
            company_id=original.company_id,
            client_id=original.client_id,
            line_models=line_models,
            totals=quote_totals,
        )

    async def render_pdf(self, quote_id: uuid.UUID) -> tuple[str, bytes]:
        """The document the artisan actually sends. Returns (filename, bytes).

        Rendered on demand rather than stored: the PDF is a pure function
        of the quote, and a quote's lines and totals never change (there is
        no update path — see ``delete``). Storing it would add a file to
        keep in sync with a row that cannot drift from it, plus a second
        thing to back up and to clean up.

        Off the event loop: reportlab is synchronous and CPU-bound, exactly
        like pypdf — which the V1 audit found freezing every other request
        for seconds on a large document.
        """
        quote = await self._quotes.get(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")

        lines = await self._lines.list_by_quote(quote.id)
        client = await self._clients.get(quote.client_id)
        if client is None:
            # The FK is RESTRICT, so this should be unreachable. If it ever
            # happens, saying so beats rendering a document addressed to
            # nobody.
            raise NotFoundError(f"Client {quote.client_id} not found.")

        profile = await self._branding.get_profile(quote.company_id)
        vat_breakdown = self._calculator.calculate_vat_breakdown(
            [(line.vat_rate, line.total_ht, line.total_vat) for line in lines]
        )
        logo = await self._load_asset(profile.brand.logo_path)
        signature = await self._load_asset(profile.brand.signature_path)
        stamp = await self._load_asset(profile.brand.stamp_path)

        document = quote_to_document(
            quote=quote,
            lines=lines,
            client=client,
            profile=profile,
            vat_breakdown=vat_breakdown,
            logo=logo,
            signature=signature,
            stamp=stamp,
        )
        pdf = await asyncio.to_thread(self._renderer.render, document)
        return f"{quote.quote_number}.pdf", pdf

    async def render_draft_pdf(
        self,
        *,
        company_id: uuid.UUID,
        client_id: uuid.UUID,
        lines_data: list[QuoteLineCreate],
    ) -> tuple[str, bytes]:
        """The wizard's "prêt à remplir" preview: renders a not-yet-created
        quote (the selected client + the draft lines) to the exact same premium
        PDF a real quote produces — so the artisan sees their devis take shape
        as they fill it in.

        Persists nothing and burns no number: it shares ``_price_lines`` with
        ``create``/``calculate`` (same catalog lookups, same VAT regime, same
        calculator), and the number shows a "PROJET" placeholder until the quote
        is actually created. A pure function of (company, client, lines).
        """
        line_models, totals = await self._price_lines(
            company_id=company_id, lines_data=lines_data
        )
        client = await self._clients.get(client_id)
        if client is None or client.company_id != company_id:
            raise NotFoundError(f"Client {client_id} not found.")

        profile = await self._branding.get_profile(company_id)
        vat_breakdown = self._calculator.calculate_vat_breakdown(
            [(line.vat_rate, line.total_ht, line.total_vat) for line in line_models]
        )
        logo = await self._load_asset(profile.brand.logo_path)
        signature = await self._load_asset(profile.brand.signature_path)
        stamp = await self._load_asset(profile.brand.stamp_path)

        # An unsaved, transient quote: quote_to_document only reads its number
        # and totals (the date comes from `issued_on`), so it never needs a row.
        draft = Quote(
            company_id=company_id,
            client_id=client_id,
            quote_number="PROJET",
            status=QuoteStatus.DRAFT,
            total_ht=totals.total_ht,
            total_vat=totals.total_vat,
            total_ttc=totals.total_ttc,
        )
        document = quote_to_document(
            quote=draft,
            lines=line_models,
            client=client,
            profile=profile,
            vat_breakdown=vat_breakdown,
            logo=logo,
            signature=signature,
            stamp=stamp,
            issued_on=date.today(),
        )
        pdf = await asyncio.to_thread(self._renderer.render, document)
        return "apercu-devis.pdf", pdf

    async def render_sample_pdf(self, company_id: uuid.UUID) -> tuple[str, bytes]:
        """A demo quote rendered with the company's *current* branding, for
        the "aperçu du rendu" shown right after importing a template. Same
        renderer, same ``Document`` shape and same logo loading as a real
        quote — only the lines and client are canned — so the preview is
        faithful to what a real quote will look like, and an artisan can
        confirm their logo, colours and identity landed before creating one."""
        profile = await self._branding.get_profile(company_id)
        return await self.render_sample_pdf_for_profile(profile)

    async def render_sample_pdf_for_profile(
        self, profile: BrandingProfileRead, *, logo_override: bytes | None = None
    ) -> tuple[str, bytes]:
        """Render the demo quote for an *arbitrary* branding profile, which may
        hold values that are not (yet) persisted. This is what lets
        ``template_import`` show the artisan their detected identity applied to
        a real-looking quote *before* anything is saved — "montrer plutôt
        qu'expliquer", without breaking the "nothing applied without explicit
        confirmation" invariant.

        ``logo_override`` is drawn instead of the profile's stored logo when
        given (the logo freshly extracted from the imported PDF, held only in
        memory); otherwise the profile's own stored logo is loaded, so a
        company that already has one still sees it."""
        logo = logo_override if logo_override is not None else await self._load_asset(
            profile.brand.logo_path
        )
        signature = await self._load_asset(profile.brand.signature_path)
        stamp = await self._load_asset(profile.brand.stamp_path)
        document = sample_document(profile=profile, logo=logo, signature=signature, stamp=stamp)
        pdf = await asyncio.to_thread(self._renderer.render, document)
        return "apercu-modele.pdf", pdf

    async def _load_asset(self, key: str | None) -> bytes | None:
        """A missing or unreadable brand asset (logo/signature/stamp) costs the
        artisan that asset, never their document: the storage key comes from a
        row that may point at a file that has since gone, and a quote must still
        be sendable."""
        if not key:
            return None
        try:
            return await self._storage.load(key)
        except OSError:
            logger.warning("quotes.asset_unreadable key=%s — rendering without it", key)
            return None

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

    async def send_quote(self, quote_id: uuid.UUID) -> QuoteRead:
        """Email the quote's PDF to its client, then mark it sent.

        A quote is *sent* by actually leaving for the customer: this renders
        the PDF, mails it to the client, and moves the quote to SENT in one
        step. Only an "en attente" (validated) quote is sendable — a draft has
        to be validated first, which the transition table enforces. The client
        needs an email address; without one there is nowhere to send it (422).

        Locked like every status change (read-decide-write): two concurrent
        sends must not both transition and both mail. The mail goes out before
        the transition is committed, but the EmailProvider never raises on a
        delivery failure (its contract) — so a momentarily-down mail server
        can't leave the quote stuck; operators watch the logs instead.
        """
        quote = await self._quotes.get_for_update(quote_id)
        if quote is None:
            raise NotFoundError(f"Quote {quote_id} not found.")
        if quote.status == QuoteStatus.SENT:
            # Idempotent: a retry of a send that already went through.
            return await self._build_read(quote)
        allowed = QUOTE_TRANSITIONS.get(quote.status, frozenset())
        if QuoteStatus.SENT not in allowed:
            raise InvalidQuoteTransitionError(
                f"A quote in '{quote.status.value}' cannot be sent — it must be "
                "validated first (status 'pending')."
            )

        client = await self._clients.get(quote.client_id)
        recipient = ((client.email if client else None) or "").strip()
        if not recipient:
            raise QuoteHasNoRecipientError(
                f"Le client du devis {quote.quote_number} n'a pas d'adresse "
                "e-mail : ajoutez-en une pour lui envoyer le devis."
            )

        filename, pdf = await self.render_pdf(quote_id)
        await self._email.send(
            to=recipient,
            subject=f"Votre devis {quote.quote_number}",
            text_body=(
                "Bonjour,\n\n"
                f"Veuillez trouver ci-joint votre devis {quote.quote_number}.\n\n"
                "Cordialement."
            ),
            attachments=[
                EmailAttachment(
                    filename=filename, content=pdf, media_type="application/pdf"
                )
            ],
        )

        quote.status = QuoteStatus.SENT
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
        self,
        *,
        company_id: uuid.UUID | None = None,
        statuses: list[QuoteStatus] | None = None,
        client_id: uuid.UUID | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[QuoteRead]:
        if company_id is not None:
            quotes = await self._quotes.list_by_company(
                company_id, statuses=statuses, client_id=client_id, offset=offset, limit=limit
            )
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
