"""First real extractor (experiment E-004) — a native PDF → ``ArtizenTemplate``.

Reads **every page's** geometry with **PyMuPDF (fitz)** and transcribes it into
the graphic layer the deterministic renderer replays, one :class:`GraphicPage`
per page (page breaks preserved, never recomposed):

* every text **span** → a :class:`FixedText` at its exact bbox, verbatim
  (letter-spacing and all — the renderer copies it, so it reproduces perfectly);
* every vector **drawing** with a fill/stroke → a :class:`Shape` at its rect;
* every **image** (the logo…) → an :class:`ImageBlock` with the bytes embedded.

It is **descriptive, never interpretive** (EXTRACTION_SPEC §0): it transcribes
what is physically on the page — no business meaning, no "this is a SIRET". A
pure function of the PDF.

Known limit, tracked not hidden: **no font embedding yet** — fonts fall back at
render time, so typography is the weakest axis (U-013; the naive embedding of
subsetted fonts was tried in E-005 and regressed, so it stays open).
"""

import fitz

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    FixedText,
    GraphicLayer,
    GraphicPage,
    HAlign,
    ImageBlock,
    PageGeometry,
    Rect,
    Shape,
    TextStyle,
)

# fitz span "flags" bit field.
_FLAG_ITALIC = 1 << 1
_FLAG_BOLD = 1 << 4


def _color_from_int(color: int) -> str:
    """fitz span colour (sRGB int) → ``#rrggbb``."""
    return f"#{color & 0xFFFFFF:06x}"


def _color_from_tuple(rgb: tuple[float, ...]) -> str:
    r, g, b = (min(255, max(0, round(component * 255))) for component in rgb[:3])
    return f"#{r:02x}{g:02x}{b:02x}"


def _extract_texts(page: "fitz.Page") -> list[FixedText]:
    texts: list[FixedText] = []
    for block in page.get_text("dict")["blocks"]:
        for line in block.get("lines", []):
            for span in line.get("spans", []):
                if not span["text"].strip():
                    continue
                x0, y0, x1, y1 = span["bbox"]
                flags = span.get("flags", 0)
                texts.append(
                    FixedText(
                        text=span["text"],  # verbatim (EXTRACTION_SPEC §3)
                        rect=Rect(x=x0, y=y0, w=x1 - x0, h=y1 - y0),
                        style=TextStyle(
                            font=span["font"],
                            size=span["size"],
                            color=_color_from_int(span["color"]),
                            bold=bool(flags & _FLAG_BOLD),
                            italic=bool(flags & _FLAG_ITALIC),
                            align=HAlign.LEFT,
                        ),
                    )
                )
    return texts


def _extract_shapes(page: "fitz.Page") -> list[Shape]:
    shapes: list[Shape] = []
    for drawing in page.get_drawings():
        rect = drawing.get("rect")
        if rect is None or rect.is_empty:
            continue
        fill = drawing.get("fill")
        stroke = drawing.get("color")
        if fill is None and stroke is None:
            continue
        shapes.append(
            Shape(
                kind="rect",
                rect=Rect(x=rect.x0, y=rect.y0, w=rect.width, h=rect.height),
                fill=_color_from_tuple(fill) if fill is not None else None,
                stroke=_color_from_tuple(stroke) if stroke is not None else None,
                stroke_width=float(drawing.get("width") or 0.0),
            )
        )
    return shapes


def _extract_images(
    page: "fitz.Page", doc: "fitz.Document", assets: dict[str, str], page_index: int
) -> list[ImageBlock]:
    import base64

    images: list[ImageBlock] = []
    for index, info in enumerate(page.get_images(full=True)):
        xref = info[0]
        try:
            rects = page.get_image_rects(xref)
            if not rects:
                continue
            extracted = doc.extract_image(xref)
            ref = f"img_p{page_index}_{index}"  # unique across pages
            assets[ref] = base64.b64encode(extracted["image"]).decode("ascii")
            r = rects[0]
            images.append(
                ImageBlock(
                    role="logo" if index == 0 else "picto",
                    rect=Rect(x=r.x0, y=r.y0, w=r.width, h=r.height),
                    asset_ref=ref,
                )
            )
        except Exception:
            # A logo we cannot re-read must not fail the whole extraction.
            continue
    return images


def extract(pdf_bytes: bytes) -> ArtizenTemplate:
    """Transcribe **every** page of a native PDF into an :class:`ArtizenTemplate`.

    Each page keeps its own geometry and content, so page breaks, headers and
    footers are reproduced exactly where the original put them."""
    doc = fitz.open(stream=pdf_bytes, filetype="pdf")
    try:
        assets: dict[str, str] = {}
        pages = [
            GraphicPage(
                page=PageGeometry(width=page.rect.width, height=page.rect.height),
                fixed_texts=_extract_texts(page),
                shapes=_extract_shapes(page),
                images=_extract_images(page, doc, assets, index),
            )
            for index, page in enumerate(doc)
        ]
        graphic = GraphicLayer(page=pages[0].page, pages=pages)
        return ArtizenTemplate(graphic=graphic, estimated_fidelity=0, assets=assets)
    finally:
        doc.close()
