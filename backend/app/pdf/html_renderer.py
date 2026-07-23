"""Renders a ``Document`` to PDF via an HTML/CSS template — the "Bleu Premium"
model, reproduced faithfully.

Why HTML/CSS (WeasyPrint) and not reportlab: the premium quote model is a
web-designed document (rounded panels, multi-column bands, backgrounds). reportlab
draws primitives by hand and never matches it pixel-for-pixel; an HTML template is
the same medium the model was designed in, so it can be an exact copy. WeasyPrint
turns that HTML into PDF with no browser — it needs Pango (see the Dockerfile).

Like the reportlab engine, **this computes nothing**: every amount is printed
exactly as the ``Document`` carries it. The only logic here is layout.
"""

import base64
import logging
import re
from html import escape as _esc

from weasyprint import HTML

from app.pdf.renderer import _fr_date, _money, _quantity, _rate, _split_details
from app.pdf.schemas import Document

logger = logging.getLogger(__name__)

# Bleu Premium palette (defaults; a company's imported colours override).
_NAVY = "#140E55"
_NAVY_DEEP = "#060930"
_GOLD = "#F4C95D"
_TEXT = "#1E293B"
_MUTED = "#63688E"
_RULE = "#E6E6F0"
_ZEBRA = "#F7F5FC"
_CARD_BORDER = "#E2E8F0"

_HEX = re.compile(r"^#[0-9a-fA-F]{6}$")


def _clean_hex(value: str | None, fallback: str) -> str:
    if not value:
        return fallback
    v = value.strip()
    return v if _HEX.match(v) else fallback


def _luminance(hex_color: str) -> float:
    r = int(hex_color[1:3], 16) / 255
    g = int(hex_color[3:5], 16) / 255
    b = int(hex_color[5:7], 16) / 255
    return 0.299 * r + 0.587 * g + 0.114 * b


def _logo_data_uri(data: bytes | None) -> str | None:
    if not data:
        return None
    try:
        return "data:image/png;base64," + base64.b64encode(data).decode("ascii")
    except Exception:
        logger.warning("html_pdf.logo_encode_failed", exc_info=True)
        return None


class HtmlPdfRenderer:
    """Turns a ``Document`` into PDF bytes via WeasyPrint. Same interface as
    ``PdfRenderer`` (``render(document) -> bytes``) so it drops in for it."""

    def render(self, document: Document) -> bytes:
        html = self._html(document)
        return HTML(string=html).write_pdf()

    # --- html ---

    def _html(self, document: Document) -> str:
        # White text sits on the navy; a too-light brand colour falls back to
        # the navy so it stays readable. Dark text sits on the gold accent; a
        # too-dark accent falls back to the gold.
        navy = _clean_hex(document.branding.primary_color, _NAVY)
        if _luminance(navy) > 0.6:
            navy = _NAVY
        gold = _clean_hex(document.branding.secondary_color, _GOLD)
        if _luminance(gold) < 0.5:
            gold = _GOLD

        contact, legal = _split_details(document.issuer.detail_lines)

        return f"""<!DOCTYPE html>
<html lang="fr"><head><meta charset="utf-8">
<style>{self._css(navy, gold)}</style></head>
<body>
{self._header(document, navy, gold, contact)}
{self._cards(document)}
{self._lines_table(document, navy, gold)}
{self._totals(document, navy, gold)}
{self._signatures(document)}
{self._legal(document)}
{self._footer(document, navy, gold, legal)}
</body></html>"""

    def _css(self, navy: str, gold: str) -> str:
        return f"""
        @page {{
            size: A4;
            margin: 11mm 11mm 30mm 11mm;
        }}
        * {{ box-sizing: border-box; }}
        body {{
            font-family: 'Liberation Sans', 'DejaVu Sans', sans-serif;
            font-size: 9pt; color: {_TEXT}; margin: 0;
        }}
        .muted {{ color: {_MUTED}; }}

        /* Header */
        .header {{ display: table; width: 100%; table-layout: fixed;
                   border-spacing: 8px 0; }}
        .header > div {{ display: table-cell; vertical-align: middle; }}
        .logo-box {{
            width: 27%; background: {navy}; border-radius: 10px;
            padding: 14px 10px; text-align: center; vertical-align: middle;
        }}
        .logo-box img {{ max-width: 78%; max-height: 60px; }}
        .logo-mark {{ color: {gold}; font-size: 30px; font-weight: 700;
                      line-height: 1; }}
        .logo-word {{ color: #fff; font-size: 17px; font-weight: 700;
                      letter-spacing: 4px; margin-top: 4px; }}
        .logo-tagline {{ color: {gold}; font-size: 6.5px; letter-spacing: 1px;
                         margin-top: 5px; line-height: 1.5; }}
        .company {{ width: 42%; padding: 0 10px; vertical-align: top; }}
        .company-name {{ color: {navy}; font-size: 15pt; font-weight: 700;
                         margin-bottom: 4px; }}
        .company .addr {{ font-weight: 700; font-size: 9.5pt; line-height: 1.4; }}
        .company .contact {{ color: {_MUTED}; font-size: 9pt; line-height: 1.55;
                             margin-top: 2px; }}
        .devis-box {{
            width: 31%; background: {navy}; border-radius: 10px;
            padding: 14px 14px; vertical-align: top;
        }}
        .devis-title {{ color: #fff; font-size: 24pt; font-weight: 700;
                        letter-spacing: 1px; }}
        .number-pill {{ display: inline-block; background: {gold}; color: #3A2E00;
                        font-weight: 700; font-size: 11pt; border-radius: 6px;
                        padding: 5px 10px; margin: 8px 0; }}
        .date-label {{ color: #C7C9E0; font-size: 7.5pt; margin-top: 6px; }}
        .date-value {{ color: #fff; font-weight: 700; font-size: 10pt; }}

        /* Address cards */
        .cards {{ display: table; width: 100%; table-layout: fixed;
                  border-spacing: 10px 0; margin-top: 14px; }}
        .card {{ display: table-cell; width: 50%; border: 1px solid {_CARD_BORDER};
                 border-radius: 10px; padding: 10px 12px; vertical-align: top; }}
        .card-label {{ color: {navy}; font-size: 7.5pt; font-weight: 700;
                       letter-spacing: 0.5px; }}
        .card-name {{ font-weight: 700; font-size: 10.5pt; margin: 4px 0 2px; }}
        .card-line {{ color: {_MUTED}; font-size: 9pt; line-height: 1.4; }}

        /* Lines table */
        table.lines {{ width: 100%; border-collapse: collapse; margin-top: 16px;
                       font-size: 8.5pt; }}
        table.lines thead th {{ background: {navy}; color: #fff; font-weight: 700;
                                padding: 7px 8px; text-align: right;
                                font-size: 8.5pt; }}
        table.lines thead th.l {{ text-align: left; }}
        table.lines thead th.c {{ text-align: center; }}
        table.lines tbody td {{ padding: 7px 8px; text-align: right;
                                border-bottom: 0.5px solid {_RULE};
                                vertical-align: top; }}
        table.lines tbody td.l {{ text-align: left; }}
        table.lines tbody td.c {{ text-align: center; }}
        table.lines tbody tr:nth-child(even) {{ background: {_ZEBRA}; }}
        .band {{ background: {gold}; font-weight: 700; }}
        .band td {{ padding: 8px; }}

        /* Totals */
        .totals {{ display: table; width: 100%; table-layout: fixed;
                   margin-top: 6px; }}
        .totals > div {{ display: table-cell; vertical-align: top; }}
        .totals .left {{ width: 52%; padding-right: 14px; }}
        .totals .right {{ width: 48%; }}
        table.vat {{ width: 100%; border-collapse: collapse; font-size: 8pt; }}
        table.vat th {{ text-align: right; color: {navy}; font-weight: 700;
                        padding: 4px 6px; border-bottom: 0.5px solid {_RULE};
                        background: {_ZEBRA}; }}
        table.vat th.l {{ text-align: left; }}
        table.vat td {{ text-align: right; padding: 4px 6px;
                        border-bottom: 0.3px solid {_RULE}; }}
        .sum-row {{ display: table; width: 100%; }}
        .sum-row > span {{ display: table-cell; padding: 4px 8px; }}
        .sum-row .lbl {{ color: {_MUTED}; }}
        .sum-row .val {{ text-align: right; font-weight: 700; }}
        .ttc-box {{ display: table; width: 100%; background: {navy};
                    border-radius: 4px; margin-top: 4px; }}
        .ttc-box > span {{ display: table-cell; padding: 9px 10px; color: #fff;
                           font-weight: 700; vertical-align: middle; }}
        .ttc-box .amount {{ text-align: right; color: {gold}; font-size: 13pt; }}
        .reste-box {{ display: table; width: 100%; background: {gold};
                      border-radius: 4px; margin-top: 6px; }}
        .reste-box > span {{ display: table-cell; padding: 9px 10px;
                             color: #3A2E00; font-weight: 700;
                             vertical-align: middle; }}
        .reste-box .amount {{ text-align: right; font-size: 12pt; }}

        /* Legal + signatures */
        .legal {{ font-size: 7pt; color: {_MUTED}; line-height: 1.5;
                  margin-top: 10px; }}
        .signatures {{ display: table; width: 100%; table-layout: fixed;
                       border-spacing: 12px 0; margin-top: 12px; }}
        .sign {{ display: table-cell; width: 50%; border: 1px solid {_CARD_BORDER};
                 border-radius: 8px; padding: 8px 10px; height: 78px;
                 vertical-align: top; }}
        .sign-title {{ color: {navy}; font-weight: 700; font-size: 9pt; }}
        .sign-hint {{ color: {_MUTED}; font-size: 8pt; margin-top: 2px; }}
        .sign img {{ max-height: 44px; max-width: 90%; margin-top: 4px; }}

        /* Footer on every page */
        .footer {{ position: fixed; bottom: -22mm; left: 0; right: 0;
                   text-align: center; border-top: 1.4px solid {gold};
                   padding-top: 5px; }}
        .footer .fname {{ color: {navy}; font-weight: 700; font-size: 8.5pt; }}
        .footer .fline {{ color: {_MUTED}; font-size: 6.6pt; line-height: 1.5; }}
        """

    def _header(
        self, document: Document, navy: str, gold: str, contact: list[str]
    ) -> str:
        logo = _logo_data_uri(document.branding.logo)
        if logo:
            logo_html = f'<img src="{logo}" alt="logo">'
        else:
            # No logo: the ARTIZEN-style wordmark (name) stands in.
            tagline = (
                f'<div class="logo-tagline">{_esc(document.branding.tagline)}</div>'
                if document.branding.tagline
                else ""
            )
            logo_html = (
                '<div class="logo-mark">&#9651;</div>'
                f'<div class="logo-word">{_esc(document.issuer.name)}</div>'
                f"{tagline}"
            )

        addr = "".join(
            f'<div class="addr">{_esc(line)}</div>'
            for line in document.issuer.address_lines
        )
        contacts = "".join(
            f'<div class="contact">{_esc(line)}</div>' for line in contact
        )

        validity = ""
        if document.valid_until is not None:
            validity = (
                '<div class="date-label">Validité du devis :</div>'
                f'<div class="date-value">{_fr_date(document.valid_until)}</div>'
            )

        return f"""<div class="header">
  <div class="logo-box">{logo_html}</div>
  <div class="company">
    <div class="company-name">{_esc(document.issuer.name)}</div>
    {addr}
    {contacts}
  </div>
  <div class="devis-box">
    <div class="devis-title">{_esc(document.title.upper())}</div>
    <div class="number-pill">N° {_esc(document.number)}</div>
    <div class="date-label">Date du devis :</div>
    <div class="date-value">{_fr_date(document.issued_on)}</div>
    {validity}
  </div>
</div>"""

    def _cards(self, document: Document) -> str:
        r = document.recipient
        client_lines = "".join(
            f'<div class="card-line">{_esc(line)}</div>'
            for line in [*r.address_lines, *r.detail_lines]
        )
        # Worksite defaults to the client's address until a distinct one is
        # captured (Phase 4) — so the two-card band still reads right.
        chantier_lines = "".join(
            f'<div class="card-line">{_esc(line)}</div>'
            for line in r.address_lines
        )
        return f"""<div class="cards">
  <div class="card">
    <div class="card-label">ADRESSE CHANTIER</div>
    <div class="card-name">{_esc(r.name)}</div>
    {chantier_lines}
  </div>
  <div class="card">
    <div class="card-label">ADRESSE CLIENT</div>
    <div class="card-name">{_esc(r.name)}</div>
    {client_lines}
  </div>
</div>"""

    def _lines_table(self, document: Document, navy: str, gold: str) -> str:
        show_vat = document.show_vat
        head = '<th class="l">Libellé</th><th>Qté</th><th class="c">U</th><th>P.U. HT</th><th>Rem.</th>'
        if show_vat:
            head += "<th>TVA</th>"
        head += "<th>Total HT</th>"

        rows = ""
        for i, line in enumerate(document.lines, start=1):
            row = (
                f'<td class="l"><b>{i}</b> - {_esc(line.designation)}</td>'
                f"<td>{_quantity(line.quantity)}</td>"
                f'<td class="c">{_esc(line.unit)}</td>'
                f"<td>{_money(line.unit_price_ht)} €</td>"
                "<td>-</td>"
            )
            if show_vat:
                row += f"<td>{_rate(line.vat_rate)}</td>"
            row += f"<td>{_money(line.total_ht)} €</td>"
            rows += f"<tr>{row}</tr>"

        cols = 7 if show_vat else 6
        band = (
            f'<tr class="band"><td class="l" colspan="{cols - 1}">TOTAL HT AVANT DÉDUCTIONS</td>'
            f"<td>{_money(document.totals.total_ht)} €</td></tr>"
        )

        return f"""<table class="lines">
  <thead><tr>{head}</tr></thead>
  <tbody>{rows}{band}</tbody>
</table>"""

    def _totals(self, document: Document, navy: str, gold: str) -> str:
        t = document.totals

        vat_table = ""
        if document.show_vat and t.vat_rows:
            vrows = "".join(
                f'<tr><td class="l">{_rate(v.rate)}</td>'
                f"<td>{_money(v.base_ht)} €</td>"
                f"<td>{_money(v.vat_amount)} €</td></tr>"
                for v in t.vat_rows
            )
            vat_table = f"""<table class="vat">
  <thead><tr><th class="l">Taux de TVA</th><th>Base HT</th><th>Montant TVA</th></tr></thead>
  <tbody>{vrows}</tbody></table>"""

        if document.show_vat:
            summary = (
                f'<div class="sum-row"><span class="lbl">Montant HT</span>'
                f'<span class="val">{_money(t.total_ht)} €</span></div>'
                f'<div class="sum-row"><span class="lbl">Montant TVA</span>'
                f'<span class="val">{_money(t.total_vat)} €</span></div>'
            )
            ttc_label = "MONTANT TTC"
        else:
            summary = ""
            ttc_label = "TOTAL"

        # "Reste à payer" equals the TTC until an acompte/déduction is captured
        # (Phase 3).
        return f"""<div class="totals">
  <div class="left">{vat_table}</div>
  <div class="right">
    {summary}
    <div class="ttc-box"><span>{ttc_label}</span><span class="amount">{_money(t.total_ttc)} €</span></div>
    <div class="reste-box"><span>RESTE À PAYER</span><span class="amount">{_money(t.total_ttc)} €</span></div>
  </div>
</div>"""

    def _signatures(self, document: Document) -> str:
        left_inner = ""
        sig = _logo_data_uri(document.branding.signature)
        stamp = _logo_data_uri(document.branding.stamp)
        for asset in (sig, stamp):
            if asset:
                left_inner += f'<img src="{asset}">'
        if not left_inner:
            left_inner = '<div class="sign-hint">Signature et cachet</div>'

        client_hint = (
            f'<div class="sign-hint">{_esc(document.signature_label)}</div>'
            if document.signature_label
            else ""
        )
        return f"""<div class="signatures">
  <div class="sign"><div class="sign-title">Pour l'entreprise</div>{left_inner}</div>
  <div class="sign"><div class="sign-title">Pour le client</div>{client_hint}</div>
</div>"""

    def _legal(self, document: Document) -> str:
        if not document.legal_mentions:
            return ""
        lines = "<br>".join(_esc(m) for m in document.legal_mentions)
        return f'<div class="legal">{lines}</div>'

    def _footer(
        self, document: Document, navy: str, gold: str, legal: list[str]
    ) -> str:
        line = "  •  ".join(_esc(item) for item in legal) if legal else ""
        legal_html = f'<div class="fline">{line}</div>' if line else ""
        return f"""<div class="footer">
  <div class="fname">{_esc(document.issuer.name)}</div>
  {legal_html}
</div>"""
