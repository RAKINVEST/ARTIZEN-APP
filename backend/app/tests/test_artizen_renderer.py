"""Tests for the deterministic .artizen renderer (Brique 3).

The renderer must place every element at the *exact* coordinates the model
carries. So the tests render a hand-authored model, then read the produced PDF
back with PyMuPDF and assert the texts, their positions and the fills are where
they should be — a first, concrete taste of the fidelity comparator to come.
"""

import fitz  # PyMuPDF

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BusinessLayer,
    FieldBinding,
    FixedText,
    GraphicLayer,
    HAlign,
    PageGeometry,
    Rect,
    Shape,
    TableColumn,
    TableSpec,
    TextStyle,
)
from app.document_clone.renderer import render_artizen


def _template() -> ArtizenTemplate:
    return ArtizenTemplate(
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            shapes=[
                Shape(kind="rect", rect=Rect(x=30, y=20, w=535, h=55), fill="#140E55", radius=8),
            ],
            fixed_texts=[
                FixedText(
                    text="DEVIS",
                    rect=Rect(x=430, y=30, w=120, h=28),
                    style=TextStyle(size=22, color="#F4C95D", bold=True, align=HAlign.LEFT),
                )
            ],
            table=TableSpec(
                rect=Rect(x=30, y=130, w=535, h=200),
                header_fill="#140E55",
                header_style=TextStyle(size=9, color="#FFFFFF"),
                columns=[
                    TableColumn(key="designation", label="Libellé", x=40, width=300, align=HAlign.LEFT),
                    TableColumn(key="total_ht", label="Total HT", x=480, width=70, align=HAlign.RIGHT),
                ],
            ),
        ),
        business=BusinessLayer(
            fields=[
                FieldBinding(
                    field="company.name",
                    rect=Rect(x=45, y=36, w=250, h=18),
                    style=TextStyle(size=14, color="#140E55", bold=True),
                )
            ],
        ),
    )


def _render() -> fitz.Document:
    pdf = render_artizen(
        _template(),
        fields={"company.name": "ARTIZEN PLOMBERIE"},
        rows=[
            {"designation": "1 - Chauffe-eau ATLANTIC 150L", "total_ht": "617,50"},
            {"designation": "2 - Forfait main d'oeuvre", "total_ht": "200,00"},
        ],
    )
    assert pdf.startswith(b"%PDF-")
    return fitz.open(stream=pdf, filetype="pdf")


def _spans(page: fitz.Page):
    return [
        s
        for b in page.get_text("dict")["blocks"]
        if b.get("lines")
        for line in b["lines"]
        for s in line["spans"]
    ]


def test_renders_all_the_text_it_was_given() -> None:
    page = _render()[0]
    text = page.get_text("text")

    for expected in ("DEVIS", "ARTIZEN PLOMBERIE", "Libellé", "Total HT", "Chauffe-eau", "617,50"):
        assert expected in text


def test_places_text_at_the_models_coordinates() -> None:
    """Positioning is the whole point — a bound field must land where the model
    says (within a couple of points), whatever the font metrics."""
    page = _render()[0]
    company = next(s for s in _spans(page) if "ARTIZEN PLOMBERIE" in s["text"])

    x0, y0 = company["bbox"][0], company["bbox"][1]
    assert abs(x0 - 45) < 4   # model rect.x = 45
    assert abs(y0 - 36) < 6   # model rect.y = 36


def test_right_aligned_column_hugs_its_right_edge() -> None:
    page = _render()[0]
    amount = next(s for s in _spans(page) if s["text"].strip() == "617,50")

    # Column x=480 width=70 → right edge 550; a right-aligned value ends there.
    assert abs(amount["bbox"][2] - 550) < 4


def test_draws_the_navy_fills() -> None:
    page = _render()[0]
    fills = [d["fill"] for d in page.get_drawings() if d.get("fill")]

    def is_navy(c) -> bool:
        r, g, b = c
        return r < 0.15 and g < 0.15 and 0.28 < b < 0.38

    # The header band and the table header row are both navy.
    assert sum(1 for c in fills if is_navy(c)) >= 2
