"""Renders a ``Document`` to PDF bytes — the ARTIZEN "Bleu Premium" model.

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
from datetime import date
from decimal import Decimal
from io import BytesIO
from xml.sax.saxutils import escape as _xml_escape

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_LEFT, TA_RIGHT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.lib.utils import ImageReader
from reportlab.platypus import (
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

# The ARTIZEN "Bleu Premium" palette, used when the artisan never set a brand
# colour. Not an error: a document must always be produceable, even for an
# account that configured nothing — and its default look is the premium house
# style (bleu nuit dominant, or en accent). A company's own imported colours
# still override these.
_DEFAULT_PRIMARY = colors.HexColor("#140E55")  # bleu nuit
_DEFAULT_ACCENT = colors.HexColor("#F4C95D")   # or clair — the accent
_DEFAULT_TEXT = colors.HexColor("#1E293B")     # texte principal
_MUTED = colors.HexColor("#63688E")            # texte secondaire
_RULE = colors.HexColor("#ECECF4")             # hairline / borders
_CARD_BG = colors.HexColor("#F7F5FC")          # soft panel fill
_ON_ACCENT = colors.HexColor("#3A2E00")        # dark text on the gold pill

_LOGO_MAX_WIDTH = 34 * mm
_LOGO_MAX_HEIGHT = 18 * mm
_PAGE_MARGIN = 16 * mm
_CONTENT_WIDTH = A4[0] - 2 * _PAGE_MARGIN


def _esc(value: str) -> str:
    """Escape free text before it becomes reportlab paragraph markup — a
    designation like "Pose & raccord" or "Tarif < 10 m²" must print literally,
    not break the XML the Paragraph parser expects."""
    return _xml_escape(value or "")


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


def _fr_date(value: date) -> str:
    return value.strftime("%d/%m/%Y")


def _split_details(details: list[str]) -> tuple[list[str], list[str]]:
    """Splits the issuer's detail lines into contact (phone / email, shown in
    the header) and registration (SIRET, RCS, APE, VAT, legal form — shown in
    the footer). Heuristic on the caller's own formatting, kept forgiving: an
    unrecognised line simply lands in the footer."""
    contact: list[str] = []
    legal: list[str] = []
    for line in details:
        if line.startswith("Tél") or "@" in line:
            contact.append(line)
        else:
            legal.append(line)
    return contact, legal


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
        # The second brand colour is the accent (the "DEVIS" number pill, the
        # TTC box). A company that set only a primary keeps the ARTIZEN gold as
        # its accent so the document still reads premium, not flat.
        secondary = _parse_color(document.branding.secondary_color, _DEFAULT_ACCENT)

        _, footer_legal = _split_details(document.issuer.detail_lines)

        doc = SimpleDocTemplate(
            buffer,
            pagesize=A4,
            leftMargin=_PAGE_MARGIN,
            rightMargin=_PAGE_MARGIN,
            topMargin=_PAGE_MARGIN,
            bottomMargin=20 * mm,
            title=f"{document.title} {document.number}",
            author=document.issuer.name,
        )

        story: list[object] = []
        story.append(self._header(document, primary, secondary))
        story.append(Spacer(1, 6 * mm))
        story.append(self._client_card(document, primary))
        story.append(Spacer(1, 6 * mm))
        story.append(self._lines_table(document, primary))
        story.append(Spacer(1, 5 * mm))
        story.append(self._totals_block(document, primary, secondary))
        story += self._signature_block(document, primary)
        if document.legal_mentions:
            story.append(Spacer(1, 8 * mm))
            story += self._legal(document)

        def _footer(canvas: object, _doc: object) -> None:
            """Issuer identity + registration + page number at the foot of every
            page, so a multi-page quote stays attributable and navigable even if
            pages get separated."""
            canvas.saveState()  # type: ignore[attr-defined]
            footer_y = 13 * mm
            canvas.setStrokeColor(secondary)  # type: ignore[attr-defined]
            canvas.setLineWidth(1)  # type: ignore[attr-defined]
            canvas.line(  # type: ignore[attr-defined]
                _PAGE_MARGIN, footer_y + 6 * mm, A4[0] - _PAGE_MARGIN, footer_y + 6 * mm
            )
            canvas.setFillColor(primary)  # type: ignore[attr-defined]
            canvas.setFont("Helvetica-Bold", 8)  # type: ignore[attr-defined]
            canvas.drawCentredString(  # type: ignore[attr-defined]
                A4[0] / 2, footer_y + 2 * mm, document.issuer.name
            )
            if footer_legal:
                canvas.setFillColor(_MUTED)  # type: ignore[attr-defined]
                canvas.setFont("Helvetica", 6.5)  # type: ignore[attr-defined]
                canvas.drawCentredString(  # type: ignore[attr-defined]
                    A4[0] / 2, footer_y - 1.5 * mm, "   •   ".join(footer_legal)
                )
            canvas.setFillColor(_MUTED)  # type: ignore[attr-defined]
            canvas.setFont("Helvetica", 7)  # type: ignore[attr-defined]
            canvas.drawRightString(  # type: ignore[attr-defined]
                A4[0] - _PAGE_MARGIN, footer_y - 6 * mm, f"Page {canvas.getPageNumber()}"  # type: ignore[attr-defined]
            )
            canvas.restoreState()  # type: ignore[attr-defined]

        doc.build(story, onFirstPage=_footer, onLaterPages=_footer)
        return buffer.getvalue()

    # --- sections ---

    def _header(
        self, document: Document, primary: colors.Color, accent: colors.Color
    ) -> Table:
        """Three columns: a navy logo panel, the company identity on white, and
        a navy "DEVIS" panel carrying the number (gold pill) and dates."""
        styles = _styles(primary)

        # Left — logo (or the name, in white) on navy.
        logo = self._scaled_image(document.branding.logo, _LOGO_MAX_WIDTH, _LOGO_MAX_HEIGHT)
        left: list[object] = []
        if logo is not None:
            left.append(logo)
        else:
            left.append(Paragraph(_esc(document.issuer.name), styles["logo_name"]))
        if document.branding.tagline:
            left.append(Spacer(1, 2 * mm))
            left.append(Paragraph(_esc(document.branding.tagline), styles["logo_tagline"]))

        # Middle — company identity on white (contact only; registration goes
        # to the footer).
        contact, _ = _split_details(document.issuer.detail_lines)
        middle: list[object] = [Paragraph(_esc(document.issuer.name), styles["company_name"])]
        for line in document.issuer.address_lines:
            middle.append(Paragraph(_esc(line), styles["header_line"]))
        for line in contact:
            middle.append(Paragraph(_esc(line), styles["header_line"]))

        # Right — the DEVIS panel on navy.
        number_pill = Table(
            [[Paragraph(f"N° {_esc(document.number)}", styles["number_pill"])]],
            colWidths=[46 * mm],
        )
        number_pill.setStyle(
            TableStyle(
                [
                    ("BACKGROUND", (0, 0), (-1, -1), accent),
                    ("TOPPADDING", (0, 0), (-1, -1), 4),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
                    ("LEFTPADDING", (0, 0), (-1, -1), 8),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 8),
                ]
            )
        )
        # Size the title to its length so a long one ("BON DE COMMANDE") stays
        # on one line in the panel instead of wrapping; "DEVIS" stays large.
        title_size = 22 if len(document.title) <= 9 else 14
        title_style = ParagraphStyle(
            "devis_title_dyn",
            parent=styles["devis_title"],
            fontSize=title_size,
            leading=title_size + 2,
        )
        right: list[object] = [
            Paragraph(document.title.upper(), title_style),
            Spacer(1, 3 * mm),
            number_pill,
            Spacer(1, 3 * mm),
            Paragraph("Date du devis", styles["date_label"]),
            Paragraph(_fr_date(document.issued_on), styles["date_value"]),
        ]
        if document.valid_until is not None:
            right += [
                Spacer(1, 1.5 * mm),
                Paragraph("Validité du devis", styles["date_label"]),
                Paragraph(_fr_date(document.valid_until), styles["date_value"]),
            ]

        table = Table(
            [[left, middle, right]],
            colWidths=[46 * mm, 70 * mm, _CONTENT_WIDTH - 116 * mm],
        )
        table.setStyle(
            TableStyle(
                [
                    ("BACKGROUND", (0, 0), (0, 0), primary),
                    ("BACKGROUND", (2, 0), (2, 0), primary),
                    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                    ("VALIGN", (1, 0), (1, 0), "TOP"),
                    ("LEFTPADDING", (0, 0), (-1, -1), 10),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 10),
                    ("TOPPADDING", (0, 0), (-1, -1), 12),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 12),
                    ("LEFTPADDING", (1, 0), (1, 0), 12),
                ]
            )
        )
        return table

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

    def _client_card(self, document: Document, primary: colors.Color) -> Table:
        """A single bordered card for the recipient — "ADRESSE CLIENT"."""
        styles = _styles(primary)
        recipient = document.recipient
        body: list[object] = [
            Paragraph("ADRESSE CLIENT", styles["card_label"]),
            Spacer(1, 1.5 * mm),
            Paragraph(_esc(recipient.name), styles["card_name"]),
        ]
        for line in [*recipient.address_lines, *recipient.detail_lines]:
            body.append(Paragraph(_esc(line), styles["card_line"]))

        card = Table([[body]], colWidths=[_CONTENT_WIDTH])
        card.setStyle(
            TableStyle(
                [
                    ("BOX", (0, 0), (-1, -1), 0.8, _RULE),
                    ("BACKGROUND", (0, 0), (-1, -1), colors.white),
                    ("LEFTPADDING", (0, 0), (-1, -1), 12),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 12),
                    ("TOPPADDING", (0, 0), (-1, -1), 10),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 10),
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ]
            )
        )
        return card

    def _lines_table(self, document: Document, primary: colors.Color) -> Table:
        styles = _styles(primary)
        # A franchise-en-base document carries no VAT, so it drops the TVA
        # column entirely (rather than printing a column of "0 %"), and the
        # freed width goes to the designation.
        show_vat = document.show_vat
        if show_vat:
            header = ["Libellé", "Qté", "U", "P.U. HT", "TVA", "Total HT"]
            col_widths = [None, 13 * mm, 12 * mm, 24 * mm, 16 * mm, 26 * mm]
        else:
            header = ["Libellé", "Qté", "U", "P.U. HT", "Total HT"]
            col_widths = [None, 13 * mm, 12 * mm, 24 * mm, 26 * mm]
        fixed = sum(w for w in col_widths if w is not None)
        col_widths[0] = _CONTENT_WIDTH - fixed

        rows: list[list[object]] = [
            [Paragraph(h, styles["th"]) for h in header]
        ]
        for index, line in enumerate(document.lines, start=1):
            # Every cell is a Paragraph so long values wrap inside their column
            # instead of overflowing into the next one.
            row: list[object] = [
                Paragraph(f"<b>{index}</b>  {_esc(line.designation)}", styles["td"]),
                Paragraph(_quantity(line.quantity), styles["td_num"]),
                Paragraph(_esc(line.unit), styles["td_center"]),
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
                    ("TOPPADDING", (0, 0), (-1, -1), 6),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 6),
                    ("LEFTPADDING", (0, 0), (-1, -1), 8),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 8),
                    ("LINEBELOW", (0, 1), (-1, -1), 0.4, _RULE),
                    ("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, _CARD_BG]),
                    ("TEXTCOLOR", (0, 1), (-1, -1), _DEFAULT_TEXT),
                ]
            )
        )
        return table

    def _totals_block(
        self, document: Document, primary: colors.Color, accent: colors.Color
    ) -> Table:
        styles = _styles(primary)
        totals = document.totals

        # Left column: the per-rate VAT breakdown, only when there is more than
        # one rate (on a single-rate document it would restate the summary).
        left_flow: list[object] = []
        if document.show_vat and len(totals.vat_rows) > 1:
            breakdown_rows: list[list[object]] = [
                [
                    Paragraph("Taux", styles["mini_th"]),
                    Paragraph("Base HT", styles["mini_th_num"]),
                    Paragraph("TVA", styles["mini_th_num"]),
                ]
            ]
            for vat in totals.vat_rows:
                breakdown_rows.append(
                    [
                        Paragraph(_rate(vat.rate), styles["mini_td"]),
                        Paragraph(f"{_money(vat.base_ht)} €", styles["mini_td_num"]),
                        Paragraph(f"{_money(vat.vat_amount)} €", styles["mini_td_num"]),
                    ]
                )
            breakdown = Table(breakdown_rows, colWidths=[24 * mm, 30 * mm, 30 * mm])
            breakdown.setStyle(
                TableStyle(
                    [
                        ("BACKGROUND", (0, 0), (-1, 0), _CARD_BG),
                        ("LINEBELOW", (0, 0), (-1, 0), 0.5, _RULE),
                        ("LINEBELOW", (0, 1), (-1, -2), 0.3, _RULE),
                        ("TOPPADDING", (0, 0), (-1, -1), 4),
                        ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
                        ("LEFTPADDING", (0, 0), (-1, -1), 6),
                        ("RIGHTPADDING", (0, 0), (-1, -1), 6),
                    ]
                )
            )
            left_flow = [breakdown]

        # Right column: HT / TVA summary, then the TTC in a navy box (gold text).
        # A franchise-en-base document has no HT/TVA split — only the total.
        if not document.show_vat:
            summary_rows: list[list[str]] = []
        else:
            summary_rows = [
                ["Montant HT", f"{_money(totals.total_ht)} €"],
                ["Montant TVA", f"{_money(totals.total_vat)} €"],
            ]
        right_rows: list[list[object]] = [
            [
                Paragraph(label, styles["sum_label"]),
                Paragraph(value, styles["sum_value"]),
            ]
            for label, value in summary_rows
        ]
        ttc_label = "TOTAL" if not document.show_vat else "MONTANT TTC"
        right_rows.append(
            [
                Paragraph(ttc_label, styles["ttc_label"]),
                Paragraph(f"{_money(totals.total_ttc)} €", styles["ttc_value"]),
            ]
        )
        last = len(right_rows) - 1
        right = Table(right_rows, colWidths=[40 * mm, 40 * mm])
        right.setStyle(
            TableStyle(
                [
                    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                    ("TOPPADDING", (0, 0), (-1, last - 1), 3),
                    ("BOTTOMPADDING", (0, 0), (-1, last - 1), 3),
                    ("LEFTPADDING", (0, 0), (-1, -1), 8),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 8),
                    ("BACKGROUND", (0, last), (-1, last), primary),
                    ("TOPPADDING", (0, last), (-1, last), 8),
                    ("BOTTOMPADDING", (0, last), (-1, last), 8),
                    ("LINEABOVE", (0, 0), (-1, 0), 0.5, _RULE),
                ]
            )
        )

        wrapper = Table(
            [[left_flow or "", right]],
            colWidths=[_CONTENT_WIDTH - 80 * mm, 80 * mm],
        )
        wrapper.setStyle(TableStyle([("VALIGN", (0, 0), (-1, -1), "TOP")]))
        return wrapper

    def _signature_block(self, document: Document, primary: colors.Color) -> list[object]:
        """Two facing signature cards: the artisan's ("Pour l'entreprise", with
        their signature/stamp if configured) and the client's "Bon pour accord".
        Kept together so the pair never splits across a page."""
        styles = _styles(primary)
        signature_img = self._scaled_image(document.branding.signature, 50 * mm, 18 * mm)
        stamp_img = self._scaled_image(document.branding.stamp, 26 * mm, 26 * mm)

        left_body: list[object] = [Paragraph("Pour l'entreprise", styles["sign_title"])]
        assets: list[object] = [img for img in (signature_img, stamp_img) if img is not None]
        if assets:
            left_body.append(Spacer(1, 2 * mm))
            for img in assets:
                left_body.append(img)
                left_body.append(Spacer(1, 1.5 * mm))
        else:
            left_body.append(Paragraph("Signature et cachet", styles["sign_hint"]))

        right_body: list[object] = [Paragraph("Pour le client", styles["sign_title"])]
        if document.signature_label:
            right_body.append(Paragraph(_esc(document.signature_label), styles["sign_hint"]))

        half = (_CONTENT_WIDTH - 6 * mm) / 2
        pair = Table(
            [[left_body, "", right_body]],
            colWidths=[half, 6 * mm, half],
            rowHeights=[28 * mm],
        )
        pair.setStyle(
            TableStyle(
                [
                    ("BOX", (0, 0), (0, 0), 0.8, _RULE),
                    ("BOX", (2, 0), (2, 0), 0.8, _RULE),
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("LEFTPADDING", (0, 0), (-1, -1), 10),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 10),
                    ("TOPPADDING", (0, 0), (-1, -1), 8),
                ]
            )
        )
        return [Spacer(1, 8 * mm), KeepTogether([pair])]

    def _legal(self, document: Document) -> list[object]:
        styles = _styles(_DEFAULT_PRIMARY)
        return [
            KeepTogether(
                [Paragraph(_esc(mention), styles["legal"]) for mention in document.legal_mentions]
            )
        ]


def _styles(primary: colors.Color) -> dict[str, ParagraphStyle]:
    base = getSampleStyleSheet()["BodyText"]
    white = colors.white
    return {
        # Header — navy panels
        "logo_name": ParagraphStyle(
            "logo_name", parent=base, fontName="Helvetica-Bold", fontSize=13,
            leading=16, textColor=white, alignment=TA_CENTER,
        ),
        "logo_tagline": ParagraphStyle(
            "logo_tagline", parent=base, fontSize=6.5, leading=9,
            textColor=_DEFAULT_ACCENT, alignment=TA_CENTER,
        ),
        "devis_title": ParagraphStyle(
            "devis_title", parent=base, fontName="Helvetica-Bold", fontSize=22,
            leading=24, textColor=white,
        ),
        "number_pill": ParagraphStyle(
            "number_pill", parent=base, fontName="Helvetica-Bold", fontSize=11,
            leading=13, textColor=_ON_ACCENT,
        ),
        "date_label": ParagraphStyle(
            "date_label", parent=base, fontSize=7, leading=9,
            textColor=colors.HexColor("#C7C9E0"),
        ),
        "date_value": ParagraphStyle(
            "date_value", parent=base, fontName="Helvetica-Bold", fontSize=9.5,
            leading=12, textColor=white,
        ),
        # Header — company identity (white)
        "company_name": ParagraphStyle(
            "company_name", parent=base, fontName="Helvetica-Bold", fontSize=13,
            leading=16, textColor=primary, spaceAfter=2,
        ),
        "header_line": ParagraphStyle(
            "header_line", parent=base, fontSize=8.5, leading=12, textColor=_MUTED,
        ),
        # Client card
        "card_label": ParagraphStyle(
            "card_label", parent=base, fontName="Helvetica-Bold", fontSize=7.5,
            leading=10, textColor=primary,
        ),
        "card_name": ParagraphStyle(
            "card_name", parent=base, fontName="Helvetica-Bold", fontSize=10.5,
            leading=13, textColor=_DEFAULT_TEXT,
        ),
        "card_line": ParagraphStyle(
            "card_line", parent=base, fontSize=9, leading=12, textColor=_MUTED,
        ),
        # Lines table
        "th": ParagraphStyle(
            "th", parent=base, fontName="Helvetica-Bold", fontSize=8.5,
            leading=11, textColor=colors.white,
        ),
        "td": ParagraphStyle("td", parent=base, fontSize=8.5, leading=11),
        "td_num": ParagraphStyle(
            "td_num", parent=base, fontSize=8.5, leading=11, alignment=TA_RIGHT
        ),
        "td_center": ParagraphStyle(
            "td_center", parent=base, fontSize=8.5, leading=11, alignment=TA_CENTER
        ),
        # VAT breakdown (mini table)
        "mini_th": ParagraphStyle(
            "mini_th", parent=base, fontName="Helvetica-Bold", fontSize=7.5,
            leading=10, textColor=primary,
        ),
        "mini_th_num": ParagraphStyle(
            "mini_th_num", parent=base, fontName="Helvetica-Bold", fontSize=7.5,
            leading=10, textColor=primary, alignment=TA_RIGHT,
        ),
        "mini_td": ParagraphStyle(
            "mini_td", parent=base, fontSize=7.5, leading=10, textColor=_MUTED
        ),
        "mini_td_num": ParagraphStyle(
            "mini_td_num", parent=base, fontSize=7.5, leading=10,
            textColor=_DEFAULT_TEXT, alignment=TA_RIGHT,
        ),
        # Totals summary
        "sum_label": ParagraphStyle(
            "sum_label", parent=base, fontSize=9, leading=12, textColor=_MUTED,
            alignment=TA_LEFT,
        ),
        "sum_value": ParagraphStyle(
            "sum_value", parent=base, fontName="Helvetica-Bold", fontSize=9.5,
            leading=12, textColor=_DEFAULT_TEXT, alignment=TA_RIGHT,
        ),
        "ttc_label": ParagraphStyle(
            "ttc_label", parent=base, fontName="Helvetica-Bold", fontSize=10,
            leading=13, textColor=colors.white,
        ),
        "ttc_value": ParagraphStyle(
            "ttc_value", parent=base, fontName="Helvetica-Bold", fontSize=13,
            leading=16, textColor=_DEFAULT_ACCENT, alignment=TA_RIGHT,
        ),
        # Signature cards
        "sign_title": ParagraphStyle(
            "sign_title", parent=base, fontName="Helvetica-Bold", fontSize=9,
            leading=12, textColor=primary,
        ),
        "sign_hint": ParagraphStyle(
            "sign_hint", parent=base, fontSize=8, leading=11, textColor=_MUTED,
        ),
        # Legal
        "legal": ParagraphStyle(
            "legal", parent=base, fontSize=7, textColor=_MUTED, leading=9.5
        ),
    }
