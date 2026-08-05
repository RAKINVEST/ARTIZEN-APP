"""Map an ``ExtractedQuote`` (read from a PDF) to a render ``Document``.

Faithful, never inventive. Where the render ``Document`` (``app.pdf.schemas``)
requires a field the extraction did not capture, this raises
``IncompleteExtractionError`` naming the gap — it never substitutes a value.
That is the V2 contract: the imported PDF is the only source of truth, so a
number, a date or a line total that is not on the PDF is not on the reproduction.

Known limitation, deliberately explicit (see ADR): the frozen ``Document`` model
has no row type for *section headers* or per-line discounts. Section-header rows
are therefore preserved on the ``ExtractedQuote`` (which drives the editable
draft) but omitted from the rendered preview until the renderer gains a header
row. We omit rather than print a fake "0,00 €" line.
"""

from __future__ import annotations

from datetime import date, datetime
from decimal import Decimal

from app.pdf.schemas import (
    Document,
    DocumentBranding,
    DocumentLine,
    DocumentParty,
    DocumentTotals,
    DocumentVatRow,
)
from app.quote_extraction.exceptions import IncompleteExtractionError
from app.quote_extraction.schemas import ExtractedParty, ExtractedQuote

_QUOTE_TITLE = "DEVIS"


def _parse_date(value: str | None) -> date | None:
    """Parse an ISO ``YYYY-MM-DD`` date, tolerating the French ``DD/MM/YYYY``.

    Returns ``None`` when absent or unparseable — the caller decides whether the
    field was required. Parsing a printed date is transcription, not invention;
    guessing a *missing* date would be invention, and we never do it."""
    if not value:
        return None
    text = value.strip()
    try:
        return date.fromisoformat(text)
    except ValueError:
        pass
    for fmt in ("%d/%m/%Y", "%d-%m-%Y", "%d.%m.%Y"):
        try:
            return datetime.strptime(text, fmt).date()
        except ValueError:
            continue
    return None


def _party(party: ExtractedParty) -> DocumentParty:
    """An issuer/recipient block, built only from captured values."""
    name = party.name or party.legal_name or ""
    details = [
        detail
        for detail in (
            f"SIRET {party.siret}" if party.siret else None,
            f"TVA {party.vat_number}" if party.vat_number else None,
            party.phone,
            party.email,
            party.website,
        )
        if detail
    ]
    return DocumentParty(
        name=name,
        address_lines=list(party.address.lines),
        detail_lines=details,
    )


def extracted_quote_to_document(
    extracted: ExtractedQuote,
    *,
    branding: DocumentBranding | None = None,
) -> Document:
    """Build a renderable ``Document`` from an extraction, or raise
    ``IncompleteExtractionError`` listing every field that could not be read."""
    missing: list[str] = []

    number = (extracted.number or "").strip()
    if not number:
        missing.append("numéro du devis")

    issued_on = _parse_date(extracted.dates.issued_on)
    if issued_on is None:
        missing.append("date d'émission")

    totals = extracted.totals
    if totals.total_ht is None:
        missing.append("total HT")
    if totals.total_ttc is None:
        missing.append("total TTC")

    # VAT is shown unless the document is franchise-en-base (no VAT charged).
    show_vat = totals.total_vat is not None and totals.total_vat != Decimal("0")

    document_lines: list[DocumentLine] = []
    for index, line in enumerate(extracted.lines, start=1):
        if line.section_header:
            # Preserved on the ExtractedQuote for the editable draft; the frozen
            # render model has no header row yet, so it is omitted here (never a
            # fabricated 0,00 € row). See the module docstring / ADR.
            continue
        line_missing: list[str] = []
        if line.quantity is None:
            line_missing.append("quantité")
        if line.unit_price_ht is None:
            line_missing.append("prix unitaire")
        if line.total_ht is None:
            line_missing.append("total")
        if line_missing:
            label = line.designation or f"#{index}"
            missing.append(f"ligne « {label} » : {', '.join(line_missing)}")
            continue
        document_lines.append(
            DocumentLine(
                designation=line.designation or "",
                unit=line.unit or "",
                quantity=line.quantity,  # type: ignore[arg-type]
                unit_price_ht=line.unit_price_ht,  # type: ignore[arg-type]
                vat_rate=line.vat_rate
                if line.vat_rate is not None
                else Decimal("0"),
                total_ht=line.total_ht,  # type: ignore[arg-type]
            )
        )

    if not document_lines and not any(l.section_header for l in extracted.lines):
        missing.append("au moins une ligne d'article")

    if missing:
        raise IncompleteExtractionError(missing)

    total_vat = totals.total_vat if totals.total_vat is not None else Decimal("0.00")
    vat_rows = [
        DocumentVatRow(
            rate=row.rate if row.rate is not None else Decimal("0"),
            base_ht=row.base_ht if row.base_ht is not None else Decimal("0"),
            vat_amount=row.vat_amount if row.vat_amount is not None else Decimal("0"),
        )
        for row in totals.vat_rows
    ]

    return Document(
        title=extracted.document_title or _QUOTE_TITLE,
        number=number,
        issued_on=issued_on,  # type: ignore[arg-type]  # guarded above
        valid_until=_parse_date(extracted.dates.valid_until),
        issuer=_party(extracted.issuer),
        recipient=_party(extracted.client),
        lines=document_lines,
        totals=DocumentTotals(
            total_ht=totals.total_ht,  # type: ignore[arg-type]  # guarded above
            total_vat=total_vat,
            total_ttc=totals.total_ttc,  # type: ignore[arg-type]  # guarded above
            vat_rows=vat_rows,
        ),
        legal_mentions=list(extracted.legal_mentions),
        branding=branding or DocumentBranding(),
        show_vat=show_vat,
        signature_label="Bon pour accord" if extracted.layout.has_signature_area else None,
    )
