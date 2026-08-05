"""Canonical extraction contract — the full shape of a quote read from a PDF.

ARTIZEN V2 import engine. This is the JSON a real (multimodal) AI provider must
produce from an imported ``devis`` PDF, and the single source the renderer and
the editable draft are built from. It is deliberately a *superset*: every field
a French quote can carry has a place here.

Two rules make it safe:

- **Everything is optional.** Extraction may not find a field on a given
  document; when it doesn't, the value stays ``None`` / empty. Nothing is ever
  invented to fill a gap — the imported PDF is the only source of truth, so a
  field that is not on the PDF is not on the ``ExtractedQuote``.
- **No amount is computed here.** Amounts are transcribed exactly as printed on
  the source document. The reproduction must match the PDF the customer already
  holds, byte for byte where the PDF states a number. Re-computation only
  happens later, in ``QuoteCalculator``, once the artisan *edits* the imported
  draft — never during extraction.

The mapping ``ExtractedQuote -> app.pdf.Document`` (render target) lives in
``mapper.py`` and refuses to fabricate the document's required fields.
"""

from __future__ import annotations

from decimal import Decimal

from pydantic import BaseModel, ConfigDict, Field


class ExtractedAddress(BaseModel):
    """A postal address as a pre-formatted block of lines, exactly as printed.

    Kept as free-form lines (not street/postcode/city) for the same reason the
    renderer's ``DocumentParty`` is: the engine lays text out, it does not model
    how an address is composed. Empty when no address was found.
    """

    model_config = ConfigDict(extra="ignore")

    lines: list[str] = Field(default_factory=list)


class ExtractedParty(BaseModel):
    """An issuer or a client — same shape for both. Every field optional."""

    model_config = ConfigDict(extra="ignore")

    name: str | None = None
    legal_name: str | None = None
    siret: str | None = None
    vat_number: str | None = None
    ape_code: str | None = None
    rcs: str | None = None
    address: ExtractedAddress = Field(default_factory=ExtractedAddress)
    phone: str | None = None
    email: str | None = None
    website: str | None = None


class ExtractedLine(BaseModel):
    """One row of the quote's table.

    A ``section_header`` row (a chapter title such as "Plomberie") carries only
    ``designation``; its numeric fields stay ``None``. Amounts are transcribed,
    never derived: ``total_ht`` is what the PDF prints on that line, even if it
    does not equal ``quantity * unit_price_ht`` (rounding, manual overrides).
    """

    model_config = ConfigDict(extra="ignore")

    position: int | None = None
    reference: str | None = None
    designation: str | None = None
    description: str | None = None
    unit: str | None = None
    quantity: Decimal | None = None
    unit_price_ht: Decimal | None = None
    vat_rate: Decimal | None = None
    discount_percent: Decimal | None = None
    total_ht: Decimal | None = None
    section_header: bool = False


class ExtractedVatRow(BaseModel):
    """One line of the per-rate VAT summary, transcribed as printed."""

    model_config = ConfigDict(extra="ignore")

    rate: Decimal | None = None
    base_ht: Decimal | None = None
    vat_amount: Decimal | None = None


class ExtractedTotals(BaseModel):
    """The document's monetary summary, exactly as printed on the PDF."""

    model_config = ConfigDict(extra="ignore")

    total_ht: Decimal | None = None
    total_vat: Decimal | None = None
    total_ttc: Decimal | None = None
    global_discount_amount: Decimal | None = None
    global_discount_percent: Decimal | None = None
    deposit_amount: Decimal | None = None
    deposit_percent: Decimal | None = None
    net_to_pay: Decimal | None = None
    vat_rows: list[ExtractedVatRow] = Field(default_factory=list)


class ExtractedPayment(BaseModel):
    """Payment terms and bank details, when the quote states them."""

    model_config = ConfigDict(extra="ignore")

    terms: str | None = None
    iban: str | None = None
    bic: str | None = None
    bank_name: str | None = None


class ExtractedDates(BaseModel):
    """Dates as ISO ``YYYY-MM-DD`` strings, transcribed as read.

    Strings (not ``date``) so an unparseable or partial date on the source does
    not fail the whole extraction; ``mapper.py`` parses strictly when building
    the render ``Document`` and reports a bad date rather than guessing one.
    """

    model_config = ConfigDict(extra="ignore")

    issued_on: str | None = None
    valid_until: str | None = None
    validity_days: int | None = None


class ExtractedLayout(BaseModel):
    """Best-effort visual/structure hints. Non-authoritative, never required."""

    model_config = ConfigDict(extra="ignore")

    logo_detected: bool = False
    dominant_colors: list[str] = Field(default_factory=list)  # "#rrggbb"
    has_header: bool = False
    has_footer: bool = False
    has_signature_area: bool = False
    column_labels: list[str] = Field(default_factory=list)


class ExtractedQuote(BaseModel):
    """The complete quote read from a PDF — the V2 import contract.

    Produced by ``QuoteExtractor`` from a real AI provider, validated here, then
    (a) rendered faithfully via ``mapper.extracted_quote_to_document`` and
    (b) turned into an editable draft the artisan can modify. Absent fields are
    ``None``/empty — the engine never invents one.
    """

    model_config = ConfigDict(extra="ignore")

    document_title: str | None = None
    number: str | None = None
    dates: ExtractedDates = Field(default_factory=ExtractedDates)
    issuer: ExtractedParty = Field(default_factory=ExtractedParty)
    client: ExtractedParty = Field(default_factory=ExtractedParty)
    billing_address: ExtractedAddress = Field(default_factory=ExtractedAddress)
    site_address: ExtractedAddress = Field(default_factory=ExtractedAddress)
    lines: list[ExtractedLine] = Field(default_factory=list)
    totals: ExtractedTotals = Field(default_factory=ExtractedTotals)
    payment: ExtractedPayment = Field(default_factory=ExtractedPayment)
    conditions: str | None = None
    legal_mentions: list[str] = Field(default_factory=list)
    notes: list[str] = Field(default_factory=list)
    layout: ExtractedLayout = Field(default_factory=ExtractedLayout)
    #: The provider's own confidence in this extraction, ``[0, 1]``. Drives the
    #: UI's "à vérifier" hints; it never gates persistence (the artisan does).
    extraction_confidence: float = Field(default=0.0, ge=0, le=1)
