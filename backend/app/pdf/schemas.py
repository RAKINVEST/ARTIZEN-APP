"""The shape a document must take to be rendered — and nothing else.

This is transverse infrastructure: it describes *a commercial document*,
not a quote. Nothing here mentions ``Quote``, ``Invoice`` or any business
model, and nothing here imports from a business module. That is the whole
point — the same engine has to serve quotes, invoices, credit notes and
purchase orders, and it can only do that if it has never heard of any of
them.

The mapping in the other direction (a ``Quote`` -> a ``Document``) belongs
to the module that owns the quote, which is where it can be tested against
real quote data. See ``app/quotes/document_mapper.py``.

**No amount is ever computed here.** Every ``Decimal`` below arrives
already calculated by ``QuoteCalculator`` — including the VAT summary. A
renderer that did its own arithmetic would be a second place where money
is decided, which the product forbids for good reason: the totals on the
PDF the customer receives must be, byte for byte, the totals the artisan
approved on screen.
"""

from dataclasses import dataclass, field
from datetime import date
from decimal import Decimal


@dataclass(frozen=True)
class DocumentParty:
    """Who issues the document, or who receives it — same shape for both.

    ``address_lines`` is a pre-formatted block rather than structured
    fields (street / postcode / city): the engine's job is to lay text out,
    not to know how an address is composed in a given country. The caller
    formats; the renderer prints.
    """

    name: str
    address_lines: list[str] = field(default_factory=list)
    #: SIRET, VAT number, phone, email — anything the caller wants under
    #: the name. Free-form for the same reason as ``address_lines``.
    detail_lines: list[str] = field(default_factory=list)


@dataclass(frozen=True)
class DocumentLine:
    designation: str
    unit: str
    quantity: Decimal
    unit_price_ht: Decimal
    vat_rate: Decimal
    total_ht: Decimal


@dataclass(frozen=True)
class DocumentVatRow:
    """One row of the per-rate VAT summary. Comes from
    ``QuoteCalculator.calculate_vat_breakdown`` — never derived here."""

    rate: Decimal
    base_ht: Decimal
    vat_amount: Decimal


@dataclass(frozen=True)
class DocumentTotals:
    #: The gross subtotal HT — the sum of the lines, before any discount.
    total_ht: Decimal
    #: The VAT owed and the TTC, **net** of any discount. With no discount they
    #: equal the gross figures, so a document without one renders exactly as
    #: before this feature.
    total_vat: Decimal
    total_ttc: Decimal
    vat_rows: list[DocumentVatRow] = field(default_factory=list)
    #: Optional discount + deposit — generic monetary figures (a quote's remise
    #: and acompte, an invoice's later). ``net_total_ht`` is the HT after the
    #: discount; ``balance_due`` the TTC after the deposit. Left ``None`` / ``0``
    #: when the document carries neither, and the renderer then omits their rows.
    net_total_ht: Decimal | None = None
    discount_amount: Decimal = Decimal("0.00")
    deposit_amount: Decimal = Decimal("0.00")
    balance_due: Decimal | None = None

    @property
    def has_discount(self) -> bool:
        return self.discount_amount > 0

    @property
    def has_deposit(self) -> bool:
        return self.deposit_amount > 0


@dataclass(frozen=True)
class DocumentBranding:
    """The artisan's identity, as bytes and colours rather than as records.

    ``logo`` is raw image bytes, not a storage key: the engine must not know
    that a ``StorageProvider`` exists, let alone how to read from it. The
    caller loads; the renderer draws. It also keeps the renderer trivially
    testable — no storage, no filesystem, no fixtures.

    Colours are ``#rrggbb`` strings or ``None``. ``None`` is not an error:
    an artisan who never set a colour must still get a clean document, so
    the renderer falls back to a neutral default rather than refusing.
    """

    logo: bytes | None = None
    primary_color: str | None = None
    secondary_color: str | None = None
    tagline: str | None = None
    #: The artisan's own signature and (optional) stamp, as raw image bytes —
    #: same rule as ``logo``: the engine draws bytes, it never reads storage.
    #: Both ``None`` is normal and must still render cleanly.
    signature: bytes | None = None
    stamp: bytes | None = None


@dataclass(frozen=True)
class Document:
    """A complete, renderable commercial document.

    ``title`` is what the reader sees at the top ("DEVIS", "FACTURE",
    "AVOIR", "BON DE COMMANDE"). It is a plain string and not an enum on
    purpose: an enum here would mean this module has to be edited — and
    its tests re-run — every time a new kind of document appears, which is
    exactly the coupling this file exists to avoid.
    """

    title: str
    number: str
    issued_on: date
    issuer: DocumentParty
    recipient: DocumentParty
    lines: list[DocumentLine]
    totals: DocumentTotals
    #: Optional "valid until" date shown next to the issue date (a quote's
    #: validity). ``None`` for document types that have no such date.
    valid_until: date | None = None
    #: Printed small at the bottom. The caller decides what the law
    #: requires of *this* document type — the engine only lays it out.
    legal_mentions: list[str] = field(default_factory=list)
    branding: DocumentBranding = field(default_factory=DocumentBranding)
    #: Layout flag, not a tax opinion: when ``False`` the engine omits the VAT
    #: column and the VAT total. The caller (which knows the issuer's regime)
    #: decides — a franchise-en-base document shows no VAT and states the
    #: "art. 293 B" mention in ``legal_mentions`` instead of a "Total TVA 0 €".
    show_vat: bool = True
    #: When set, the engine draws a signature area with this label (a quote's
    #: "Bon pour accord"). ``None`` for documents that don't need one.
    signature_label: str | None = None
