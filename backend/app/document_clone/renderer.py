"""The deterministic ``.artizen`` renderer — Brique 3.

Takes an :class:`ArtizenTemplate` + the document's resolved data and draws the
PDF **by absolute position**: every fixed label, shape, image and bound field is
placed at the exact coordinates the model carries. **No AI, no layout guessing,
no arithmetic** — a pure function of (template, data). This is what makes the
whole pipeline trustworthy: once a ``.artizen`` is correct, every future
document is reproduced identically, forever.

Deliberately generic and decoupled: it takes ``fields`` (a ``{path: value}``
map for the variable zones) and ``rows`` (the table rows) — it never hears of a
"quote". Mapping a Quote/Facture to those dicts belongs to the business layer,
exactly like ``quotes/document_mapper.py`` feeds the neutral PDF engine.
"""

import base64
import io
import logging

from reportlab.lib.colors import Color, HexColor
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    GraphicPage,
    HAlign,
    Rect,
    TableSpec,
    TextStyle,
)
from app.document_clone.font_resolver import resolve as resolve_font

logger = logging.getLogger(__name__)

_registered: set[str] = set()


def _hex(value: str | None, fallback: str = "#000000") -> Color:
    try:
        return HexColor(value)  # type: ignore[arg-type]
    except (ValueError, AttributeError, TypeError):
        return HexColor(fallback)


def _register_fonts(template: ArtizenTemplate) -> dict[str, str]:
    """Registers the model's embedded fonts with reportlab; returns
    family → reportlab-name. A font that can't be registered (e.g. an exotic
    variable font) simply falls back to a base font — a wrong glyph metric must
    never cost the whole document."""
    mapping: dict[str, str] = {}
    for font in template.graphic.fonts:
        if not font.asset_ref or font.asset_ref not in template.assets:
            continue
        name = f"artizen__{font.asset_ref}"
        if name not in _registered:
            try:
                data = base64.b64decode(template.assets[font.asset_ref])
                pdfmetrics.registerFont(TTFont(name, io.BytesIO(data)))
                _registered.add(name)
            except Exception:
                logger.warning("artizen_renderer.font_failed ref=%s", font.asset_ref)
                continue
        mapping[font.family] = name
    return mapping


def _font_name(style: TextStyle, mapping: dict[str, str]) -> str:
    # Strategy A: the original embedded font, when the renderer registered it.
    if style.font in mapping:
        return mapping[style.font]
    # Strategy C: a metric-compatible substitute (Liberation…), the intelligent
    # fallback. The ``.artizen`` keeps ``style.font`` untouched, so the true font
    # can be restored later — resolution happens here, at draw time.
    return resolve_font(style)


def render_artizen(
    template: ArtizenTemplate,
    fields: dict[str, str],
    rows: list[dict[str, str]],
) -> bytes:
    g = template.graphic
    fonts = _register_fonts(template)

    # A flat (legacy, single-page) template is one implicit page; a multipage
    # one drives the loop from ``g.pages``. Either way each page is drawn by the
    # same ``_draw_page`` — page breaks are preserved, never recomposed.
    pages = g.pages or [
        GraphicPage(
            page=g.page,
            fixed_texts=g.fixed_texts,
            shapes=g.shapes,
            images=g.images,
            table=g.table,
        )
    ]

    buffer = io.BytesIO()
    c = canvas.Canvas(buffer, pagesize=(pages[0].page.width, pages[0].page.height))
    for index, page in enumerate(pages):
        c.setPageSize((page.page.width, page.page.height))
        # Bound fields (the variable zones) live on the first page only; on a
        # reproduction they are empty anyway.
        _draw_page(c, template, page, fonts, fields if index == 0 else {}, rows)
        c.showPage()
    c.save()
    return buffer.getvalue()


def _draw_page(
    c: canvas.Canvas,
    template: ArtizenTemplate,
    page: GraphicPage,
    fonts: dict[str, str],
    fields: dict[str, str],
    rows: list[dict[str, str]],
) -> None:
    height = page.page.height

    # .artizen coordinates are top-left; reportlab's are bottom-left.
    def flip(y: float, h: float = 0.0) -> float:
        return height - y - h

    def draw_text(text: str, rect: Rect, style: TextStyle, valign_center: bool = False) -> None:
        if not text:
            return
        font = _font_name(style, fonts)
        c.setFillColor(_hex(style.color, "#1E293B"))
        c.setFont(font, style.size)
        if valign_center:
            baseline = flip(rect.y + rect.h / 2 + style.size * 0.35)
        else:
            baseline = flip(rect.y + style.size * 0.82)

        # Horizontal scale so a left-aligned reproduction run occupies the
        # ORIGINAL advance width (``rect.w``). Any substitute font renders a few
        # percent off; forcing the exact width makes the layout line up like the
        # source, glyph proportions shifting imperceptibly. Done with a transform
        # (translate to the origin, scale x) — robust across reportlab versions.
        # Table cells and bound fields (centred / right-aligned) keep their
        # natural width.
        if not valign_center and style.align == HAlign.LEFT and rect.w > 0:
            natural = pdfmetrics.stringWidth(text, font, style.size)
            if natural > 0:
                ratio = rect.w / natural
                if 0.5 <= ratio <= 2.0 and abs(ratio - 1.0) > 1e-3:
                    c.saveState()
                    c.translate(rect.x, baseline)
                    c.scale(ratio, 1.0)
                    c.drawString(0, 0, text)
                    c.restoreState()
                    return

        if style.align == HAlign.RIGHT:
            c.drawRightString(rect.x + rect.w, baseline, text)
        elif style.align == HAlign.CENTER:
            c.drawCentredString(rect.x + rect.w / 2, baseline, text)
        else:
            c.drawString(rect.x, baseline, text)

    # 1) Shapes (backgrounds / frames) — drawn first so text sits on top.
    for shape in page.shapes:
        r = shape.rect
        fill = 1 if shape.fill else 0
        stroke = 1 if shape.stroke else 0
        if shape.fill:
            c.setFillColor(_hex(shape.fill))
        if shape.stroke:
            c.setStrokeColor(_hex(shape.stroke))
            c.setLineWidth(shape.stroke_width or 0.5)
        if shape.radius > 0:
            c.roundRect(r.x, flip(r.y, r.h), r.w, r.h, shape.radius, fill=fill, stroke=stroke)
        else:
            c.rect(r.x, flip(r.y, r.h), r.w, r.h, fill=fill, stroke=stroke)

    # 2) Images (logo…).
    for img in page.images:
        data_b64 = template.assets.get(img.asset_ref)
        if not data_b64:
            continue
        try:
            reader = ImageReader(io.BytesIO(base64.b64decode(data_b64)))
            r = img.rect
            c.drawImage(
                reader, r.x, flip(r.y, r.h), r.w, r.h,
                mask="auto", preserveAspectRatio=True, anchor="nw",
            )
        except Exception:
            logger.warning("artizen_renderer.image_failed ref=%s", img.asset_ref)

    # 3) Fixed labels.
    for ft in page.fixed_texts:
        draw_text(ft.text, ft.rect, ft.style)

    # 4) The table (the one variable-length region).
    if page.table is not None:
        _draw_table(c, page.table, rows, flip, draw_text)

    # 5) Bound fields (the variable zones).
    for fb in template.business.fields:
        value = fields.get(fb.field, "")
        if value != "":
            draw_text(f"{fb.prefix}{value}{fb.suffix}", fb.rect, fb.style, valign_center=False)


def _draw_table(c, table: TableSpec, rows, flip, draw_text) -> None:
    r = table.rect
    y = r.y
    rh = table.row_height

    # Header band + labels.
    if table.header_fill:
        c.setFillColor(_hex(table.header_fill))
        c.rect(r.x, flip(y, rh), r.w, rh, fill=1, stroke=0)
    for col in table.columns:
        style = table.header_style.model_copy(update={"align": col.align, "bold": True})
        draw_text(col.label, Rect(x=col.x, y=y, w=col.width, h=rh), style, valign_center=True)
    y += rh

    # Rows (repeated deterministically from the data).
    for i, row in enumerate(rows):
        if table.zebra_fill and i % 2 == 1:
            c.setFillColor(_hex(table.zebra_fill))
            c.rect(r.x, flip(y, rh), r.w, rh, fill=1, stroke=0)
        if table.grid_color:
            c.setStrokeColor(_hex(table.grid_color))
            c.setLineWidth(0.4)
            c.line(r.x, flip(y + rh), r.x + r.w, flip(y + rh))
        for col in table.columns:
            style = table.body_style.model_copy(update={"align": col.align})
            draw_text(str(row.get(col.key, "")), Rect(x=col.x, y=y, w=col.width, h=rh), style, valign_center=True)
        y += rh
