"""Renders a ``Document`` to PDF bytes.

Why reportlab: it is pure Python and needs no system libraries. The
alternative worth considering, WeasyPrint, renders HTML/CSS — nicer to
style — but pulls cairo and pango in via apt, which the ``python:3.13-slim``
image does not have. A PDF engine that makes the Docker image heavier and
the build slower is a poor trade for prettier CSS. Pillow, which reportlab
uses for images, is already a dependency.

This module knows nothing about quotes, invoices or any business model. It
takes a ``Document`` and gives back bytes. That constraint is what lets the
same engine serve devis, factures, avoirs and bons de commande without a
branch per type.

**It computes nothing.** Every amount is printed exactly as handed over —
see ``schemas.py``. The only arithmetic below is layout geometry.
"""

import logging
from decimal import Decimal
from io import BytesIO

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_RIGHT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.lib.utils import ImageReader
from reportlab.platypus import (
    HRFlowable,
    Image,
    KeepTogether,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)

from app.pdf.schemas import Document

logger = logging.getLogger(__name__)

# The ARTIZEN palette, used when the artisan never set a brand colour. Not an
# error: a document must always be produceable, even for an account that has
# configured nothing — and its default look should be the premium house style
# (bleu nuit dominant, or en accent). A company's own imported colours still
# override these.
_DEFAULT_PRIMARY = colors.HexColor("#10233F")  # bleu nuit premium
_DEFAULT_ACCENT = colors.HexColor("#D4AF37")   # or premium — the accent
_DEFAULT_TEXT = colors.HexColor("#1E293B")     # texte principal ARTIZEN
_MUTED = colors.HexColor("#64748B")            # texte secondaire ARTIZEN
_RULE = colors.HexColor("#E2E8F0")

_LOGO_MAX_WIDTH = 45 * mm
_LOGO_MAX_HEIGHT = 22 * mm
_PAGE_MARGIN = 18 * mm


def _parse_color(value: str | None, fallback: colors.Color) -> colors.Color:
    """A malformed brand colour must not cost the artisan their document.

    The colour comes from ``BrandProfile``, which may have been filled by
    `document_detection`'s heuristics — i.e. by guessing at an old PDF.
    A wrong guess should degrade to the default, never raise: nobody loses
    a quote because a hex string had five digits.
    """
    if not value:
        return fallback
    try:
        return colors.HexColor(value)
    except (ValueError, AttributeError):
        logger.warning("pdf.invalid_brand_color value=%r — falling back", value)
        return fallback


def _money(amount: Decimal) -> str:
    """French convention: space as thousands separator, comma as decimal.

    Formats the exact Decimal received. It never rounds — the value arrives
    already quantized by ``QuoteCalculator``, and re-rounding here would be
    a second opinion on an amount the artisan has already approved.
    """
    whole, _, frac = f"{amount:.2f}".partition(".")
    negative = whole.startswith("-")
    digits = whole.lstrip("-")
    grouped = ""
    while len(digits) > 3:
        grouped = f" {digits[-3:]}{grouped}"
        digits = digits[:-3]
    grouped = f"{digits}{grouped}"
    return f"{'-' if negative else ''}{grouped},{frac}"


def _quantity(value: Decimal) -> str:
    """Trims the trailing zeros a Numeric(10,2) column always carries: an
    artisan wrote "2", not "2,00". Keeps them when they mean something."""
    text = f"{value:.2f}".rstrip("0").rstrip(".")
    return text.replace(".", ",") or "0"


def _rate(value: Decimal) -> str:
    return f"{_quantity(value)} %"


class PdfRenderer:
    """Turns a ``Document`` into PDF bytes.

    Synchronous and stateless. reportlab is CPU-bound, so callers must run
    it off the event loop (``asyncio.to_thread``) — the same reason the
    document pipeline wraps pypdf. Keeping this class free of async lets it
    be unit-tested without a loop.
    """

    def render(self, document: Document) -> bytes:
        buffer = BytesIO()
        primary = _parse_color(document.branding.primary_color, _DEFAULT_PRIMARY)
        # The second brand colour accents the rule under the header and the
        # party labels. A company that set only a primary keeps its own colour
        # as the accent (coherent with their brand); an account that configured
        # nothing falls back to the ARTIZEN gold, giving the default document
        # the house premium look rather than a flat one-colour page.
        accent_fallback = primary if document.branding.primary_color else _DEFAULT_ACCENT
        secondary = _parse_color(document.branding.secondary_color, accent_fallback)

        doc = SimpleDocTemplate(
            buffer,
            pagesize=A4,
            leftMargin=_PAGE_MARGIN,
            rightMargin=_PAGE_MARGIN,
            topMargin=_PAGE_MARGIN,
            bottomMargin=_PAGE_MARGIN,
            title=f"{document.title} {document.number}",
            author=document.issuer.name,
        )

        story: list[object] = []
        story += self._header(document, primary)
        story.append(Spacer(1, 4 * mm))
        story.append(HRFlowable(width="100%", thickness=1.2, color=secondary, spaceBefore=0, spaceAfter=0))
        story.append(Spacer(1, 6 * mm))
        story += self._parties(document, secondary)
        story.append(Spacer(1, 8 * mm))
        story.append(self._lines_table(document, primary))
        story.append(Spacer(1, 6 * mm))
        story.append(self._totals_block(document, primary))
        story += self._signature_block(document)
        if document.legal_mentions:
            story.append(Spacer(1, 10 * mm))
            story += self._legal(document)

        def _footer(canvas: object, _doc: object) -> None:
            """Issuer identity + page number at the foot of every page — so a
            multi-page quote stays attributable and navigable even if pages get
            separated."""
            canvas.saveState()  # type: ignore[attr-defined]
            canvas.setFont("Helvetica", 7)  # type: ignore[attr-defined]
            canvas.setFillColor(_MUTED)  # type: ignore[attr-defined]
            canvas.setStrokeColor(_RULE)  # type: ignore[attr-defined]
            footer_y = 12 * mm
            canvas.line(  # type: ignore[attr-defined]
                _PAGE_MARGIN, footer_y + 3 * mm, A4[0] - _PAGE_MARGIN, footer_y + 3 * mm
            )
            canvas.drawString(_PAGE_MARGIN, footer_y, document.issuer.name)  # type: ignore[attr-defined]
            canvas.drawRightString(  # type: ignore[attr-defined]
                A4[0] - _PAGE_MARGIN, footer_y, f"Page {canvas.getPageNumber()}"  # type: ignore[attr-defined]
            )
            canvas.restoreState()  # type: ignore[attr-defined]

        doc.build(story, onFirstPage=_footer, onLaterPages=_footer)
        return buffer.getvalue()

    # --- sections ---

    def _header(self, document: Document, primary: colors.Color) -> list[object]:
        styles = _styles()
        left: list[object] = []

        logo = self._logo_flowable(document)
        if logo is not None:
            left.append(logo)
        else:
            # No logo is normal — a brand new account has none. The name
            # takes its place rather than leaving a hole.
            left.append(Paragraph(document.issuer.name, styles["issuer_name"]))
        if document.branding.tagline:
            left.append(Paragraph(document.branding.tagline, styles["tagline"]))

        right = [
            Paragraph(document.title.upper(), _title_style(primary)),
            Paragraph(document.number, styles["number"]),
            Paragraph(
                f"Le {document.issued_on.strftime('%d/%m/%Y')}", styles["issued_on"]
            ),
        ]

        table = Table([[left, right]], colWidths=[95 * mm, 79 * mm])
        table.setStyle(
            TableStyle(
                [
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("LEFTPADDING", (0, 0), (-1, -1), 0),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                ]
            )
        )
        return [table]

    def _logo_flowable(self, document: Document) -> Image | None:
        return self._scaled_image(document.branding.logo, _LOGO_MAX_WIDTH, _LOGO_MAX_HEIGHT)

    def _scaled_image(self, data: bytes | None, max_width: float, max_height: float) -> Image | None:
        """Fit image ``data`` inside a box, preserving aspect ratio. A broken or
        missing image degrades to ``None`` (no image), never an exception — the
        bytes come from an upload and losing the whole document over one would
        be absurd (same reasoning as ``_parse_color``)."""
        if not data:
            return None
        try:
            reader = ImageReader(BytesIO(data))
            width, height = reader.getSize()
            if not width or not height:
                return None
            scale = min(max_width / width, max_height / height, 1.0)
            return Image(BytesIO(data), width=width * scale, height=height * scale)
        except Exception:
            logger.warning("pdf.unreadable_image — rendering without it", exc_info=True)
            return None

    def _parties(self, document: Document, secondary: colors.Color) -> list[object]:
        styles = _styles()
        # The ÉMETTEUR / CLIENT labels carry the secondary brand accent rather
        # than the default grey, so the artisan's identity shows even in the
        # small type.
        label_style = ParagraphStyle(
            "party_label_accent", parent=styles["party_label"], textColor=secondary
        )

        def block(party: object, label: str) -> list[object]:
            assert not isinstance(party, str)
            out: list[object] = [Paragraph(label, label_style)]
            out.append(Paragraph(party.name, styles["party_name"]))  # type: ignore[attr-defined]
            for line in [*party.address_lines, *party.detail_lines]:  # type: ignore[attr-defined]
                out.append(Paragraph(line, styles["party_line"]))
            return out

        table = Table(
            [[block(document.issuer, "ÉMETTEUR"), block(document.recipient, "CLIENT")]],
            colWidths=[87 * mm, 87 * mm],
        )
        table.setStyle(
            TableStyle(
                [
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("LEFTPADDING", (0, 0), (0, 0), 0),
                    ("RIGHTPADDING", (-1, 0), (-1, 0), 0),
                ]
            )
        )
        return [table]

    def _lines_table(self, document: Document, primary: colors.Color) -> Table:
        styles = _styles()
        # A franchise-en-base document carries no VAT, so it drops the TVA
        # column entirely (rather than printing a column of "0 %"), and the
        # freed width goes to the designation.
        show_vat = document.show_vat
        if show_vat:
            header = ["Désignation", "Qté", "Unité", "P.U. HT", "TVA", "Total HT"]
            col_widths = [74 * mm, 14 * mm, 18 * mm, 24 * mm, 18 * mm, 26 * mm]
        else:
            header = ["Désignation", "Qté", "Unité", "P.U. HT", "Total HT"]
            col_widths = [92 * mm, 14 * mm, 18 * mm, 24 * mm, 26 * mm]
        rows: list[list[object]] = [
            [Paragraph(f"<b>{h}</b>", styles["th"]) for h in header]
        ]
        for line in document.lines:
            # Every cell is a Paragraph so long values wrap inside their column
            # instead of overflowing into the next one — a long unit ("forfait
            # mensuel") or a large amount ("1 234 567,89 €") must never spill.
            row: list[object] = [
                Paragraph(line.designation, styles["td"]),
                Paragraph(_quantity(line.quantity), styles["td_num"]),
                Paragraph(line.unit, styles["td_center"]),
                Paragraph(f"{_money(line.unit_price_ht)} €", styles["td_num"]),
            ]
            if show_vat:
                row.append(Paragraph(_rate(line.vat_rate), styles["td_num"]))
            row.append(Paragraph(f"{_money(line.total_ht)} €", styles["td_num"]))
            rows.append(row)

        table = Table(rows, colWidths=col_widths, repeatRows=1)
        table.setStyle(
            TableStyle(
                [
                    ("BACKGROUND", (0, 0), (-1, 0), primary),
                    ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
                    ("ALIGN", (1, 0), (-1, -1), "RIGHT"),
                    ("ALIGN", (2, 0), (2, -1), "CENTER"),
                    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                    ("FONTSIZE", (0, 0), (-1, -1), 8.5),
                    ("TOPPADDING", (0, 0), (-1, -1), 5),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
                    ("LINEBELOW", (0, 1), (-1, -1), 0.4, _RULE),
                    ("TEXTCOLOR", (0, 1), (-1, -1), _DEFAULT_TEXT),
                ]
            )
        )
        return table

    def _totals_block(self, document: Document, primary: colors.Color) -> Table:
        totals = document.totals
        rows: list[list[object]] = []

        # No VAT (franchise-en-base): a single "Total" line, no VAT total, no
        # per-rate breakdown — the 293 B mention in the legal block says why.
        if not document.show_vat:
            summary_rows = [["Total", f"{_money(totals.total_ttc)} €"]]
        else:
            summary_rows = [
                ["Total HT", f"{_money(totals.total_ht)} €"],
                ["Total TVA", f"{_money(totals.total_vat)} €"],
                ["Total TTC", f"{_money(totals.total_ttc)} €"],
            ]
            # The per-rate summary only earns its space when there is more than
            # one rate: on a single-rate document it would restate the line
            # below it.
            if len(totals.vat_rows) > 1:
                for row in totals.vat_rows:
                    rows.append(
                        [
                            f"Base HT à {_rate(row.rate)}",
                            f"{_money(row.base_ht)} €",
                            f"TVA {_rate(row.rate)}",
                            f"{_money(row.vat_amount)} €",
                        ]
                    )

        last = len(summary_rows) - 1
        summary = Table(summary_rows, colWidths=[38 * mm, 32 * mm])
        summary.setStyle(
            TableStyle(
                [
                    ("ALIGN", (1, 0), (1, -1), "RIGHT"),
                    ("FONTSIZE", (0, 0), (-1, -1), 9),
                    ("LINEABOVE", (0, last), (-1, last), 0.8, primary),
                    ("FONTNAME", (0, last), (-1, last), "Helvetica-Bold"),
                    ("TEXTCOLOR", (0, last), (-1, last), primary),
                    ("TOPPADDING", (0, 0), (-1, -1), 3),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 3),
                ]
            )
        )

        if not rows:
            wrapper = Table([["", summary]], colWidths=[104 * mm, 70 * mm])
        else:
            breakdown = Table(rows, colWidths=[26 * mm, 24 * mm, 24 * mm, 26 * mm])
            breakdown.setStyle(
                TableStyle(
                    [
                        ("ALIGN", (1, 0), (1, -1), "RIGHT"),
                        ("ALIGN", (3, 0), (3, -1), "RIGHT"),
                        ("FONTSIZE", (0, 0), (-1, -1), 7.5),
                        ("TEXTCOLOR", (0, 0), (-1, -1), _MUTED),
                    ]
                )
            )
            wrapper = Table([[breakdown, summary]], colWidths=[104 * mm, 70 * mm])
        wrapper.setStyle(TableStyle([("VALIGN", (0, 0), (-1, -1), "TOP")]))
        return wrapper

    def _signature_block(self, document: Document) -> list[object]:
        """Two facing signature areas: the artisan's own signature/stamp on the
        left (the issuer pre-signs), the client's "Bon pour accord" box on the
        right (a quote that claims acceptance-on-signature must give somewhere
        to sign).

        Stays clean in every combination: with neither artisan asset the left
        column is simply empty; with no ``signature_label`` there is no client
        box. If nothing at all is to be drawn, the whole section is dropped.
        Kept together so it never splits across a page.
        """
        styles = _styles()
        signature_img = self._scaled_image(document.branding.signature, 55 * mm, 20 * mm)
        stamp_img = self._scaled_image(document.branding.stamp, 30 * mm, 30 * mm)

        left: list[object] = []
        if signature_img is not None or stamp_img is not None:
            left.append(Paragraph("Signature de l'entreprise :", styles["signature"]))
            left.append(Spacer(1, 3 * mm))
            for image in (signature_img, stamp_img):
                if image is not None:
                    left.append(image)
                    left.append(Spacer(1, 2 * mm))

        right: list[object] = []
        if document.signature_label:
            box = Table(
                [[Paragraph(document.signature_label, styles["signature"])]],
                colWidths=[80 * mm],
                rowHeights=[26 * mm],
            )
            box.setStyle(
                TableStyle(
                    [
                        ("BOX", (0, 0), (-1, -1), 0.6, _RULE),
                        ("VALIGN", (0, 0), (-1, -1), "TOP"),
                        ("LEFTPADDING", (0, 0), (-1, -1), 6),
                        ("TOPPADDING", (0, 0), (-1, -1), 6),
                    ]
                )
            )
            right = [box]

        if not left and not right:
            return []

        wrapper = Table([[left, right]], colWidths=[94 * mm, 80 * mm])
        wrapper.setStyle(
            TableStyle(
                [
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("LEFTPADDING", (0, 0), (0, 0), 0),
                ]
            )
        )
        return [Spacer(1, 8 * mm), KeepTogether([wrapper])]

    def _legal(self, document: Document) -> list[object]:
        styles = _styles()
        return [
            KeepTogether(
                [Paragraph(mention, styles["legal"]) for mention in document.legal_mentions]
            )
        ]


def _title_style(primary: colors.Color) -> ParagraphStyle:
    return ParagraphStyle(
        "doc_title",
        parent=getSampleStyleSheet()["Title"],
        fontSize=20,
        leading=24,
        alignment=TA_RIGHT,
        textColor=primary,
        spaceAfter=2,
    )


def _styles() -> dict[str, ParagraphStyle]:
    base = getSampleStyleSheet()["BodyText"]
    return {
        "issuer_name": ParagraphStyle("issuer_name", parent=base, fontSize=13, leading=16),
        "tagline": ParagraphStyle("tagline", parent=base, fontSize=8, textColor=_MUTED),
        "number": ParagraphStyle("number", parent=base, fontSize=11, alignment=TA_RIGHT),
        "issued_on": ParagraphStyle(
            "issued_on", parent=base, fontSize=9, alignment=TA_RIGHT, textColor=_MUTED
        ),
        "party_label": ParagraphStyle(
            "party_label", parent=base, fontSize=7, textColor=_MUTED, spaceAfter=2
        ),
        "party_name": ParagraphStyle("party_name", parent=base, fontSize=10, leading=13),
        "party_line": ParagraphStyle("party_line", parent=base, fontSize=8.5, leading=11),
        "th": ParagraphStyle("th", parent=base, fontSize=8.5, textColor=colors.white),
        "td": ParagraphStyle("td", parent=base, fontSize=8.5, leading=11),
        "td_num": ParagraphStyle(
            "td_num", parent=base, fontSize=8.5, leading=11, alignment=TA_RIGHT
        ),
        "td_center": ParagraphStyle(
            "td_center", parent=base, fontSize=8.5, leading=11, alignment=TA_CENTER
        ),
        "legal": ParagraphStyle("legal", parent=base, fontSize=7, textColor=_MUTED, leading=9),
        "signature": ParagraphStyle(
            "signature", parent=base, fontSize=8, textColor=_DEFAULT_TEXT, leading=11
        ),
    }
