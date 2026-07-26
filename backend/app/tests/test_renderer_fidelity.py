"""Renderer fidelity behaviours the experiments established — locked so they
never silently regress:

* **E-012** — a left-aligned run is scaled horizontally to the *original* advance
  width, so a substitute font lays out like the source;
* **E-013** — an image fills its extracted rect exactly (no aspect preservation),
  because that rect is the image's actual drawn extent in the source.
"""

import base64
import io

import fitz
from PIL import Image as PILImage

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    GraphicLayer,
    ImageBlock,
    FixedText,
    PageGeometry,
    Rect,
    TextStyle,
)
from app.document_clone.renderer import render_artizen


def _span_widths(pdf: bytes, text: str) -> list[float]:
    doc = fitz.open(stream=pdf, filetype="pdf")
    try:
        widths = []
        for block in doc[0].get_text("dict")["blocks"]:
            for line in block.get("lines", []):
                for span in line["spans"]:
                    if span["text"].strip() == text:
                        widths.append(span["bbox"][2] - span["bbox"][0])
        return widths
    finally:
        doc.close()


def test_horizontal_scaling_makes_a_run_occupy_the_original_width() -> None:
    # The same text at two different target widths must render at those widths —
    # proof it is scaled to the extracted advance width, not drawn at its natural
    # width (which would be identical for both).
    narrow, wide = 75.0, 120.0
    template = ArtizenTemplate(
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            fixed_texts=[
                FixedText(
                    text="Menuiserie Dupont",
                    rect=Rect(x=40, y=100, w=narrow, h=12),
                    style=TextStyle(font="Arial", size=10),
                ),
                FixedText(
                    text="Menuiserie Dupont",
                    rect=Rect(x=40, y=200, w=wide, h=12),
                    style=TextStyle(font="Arial", size=10),
                ),
            ],
        )
    )
    widths = sorted(_span_widths(render_artizen(template, {}, []), "Menuiserie Dupont"))

    assert len(widths) == 2
    assert abs(widths[0] - narrow) / narrow < 0.05, widths
    assert abs(widths[1] - wide) / wide < 0.05, widths


def test_image_fills_the_extracted_rect_even_with_a_different_aspect() -> None:
    # A square image placed in a wide rect must FILL it (the rect is the source's
    # drawn extent), never be shrunk to keep its own aspect ratio.
    square = PILImage.new("RGB", (50, 50), (200, 30, 30))
    buffer = io.BytesIO()
    square.save(buffer, format="PNG")
    ref = "img0"
    template = ArtizenTemplate(
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            images=[ImageBlock(role="logo", rect=Rect(x=40, y=60, w=180, h=50), asset_ref=ref)],
        ),
        assets={ref: base64.b64encode(buffer.getvalue()).decode("ascii")},
    )
    doc = fitz.open(stream=render_artizen(template, {}, []), filetype="pdf")
    try:
        infos = doc[0].get_image_info()
    finally:
        doc.close()

    assert len(infos) == 1
    x0, y0, x1, y1 = infos[0]["bbox"]
    assert abs((x1 - x0) - 180) < 2.0, (x1 - x0)  # filled the width, not 50 (aspect)
    assert abs((y1 - y0) - 50) < 2.0, (y1 - y0)
