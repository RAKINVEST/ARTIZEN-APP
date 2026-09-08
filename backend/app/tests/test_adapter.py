"""Tests for the ArtizenTemplate → ExtractionBlocks adapter.

The adapter is the geometry→contract seam: it must preserve ids, text, position,
style and reading order exactly, and surface images after texts per page. The
``RawBlock`` has no page field — a documented P2 limit, pinned here so the day it
is lifted this test is what changes.
"""

from app.document_clone.adapter import artizen_to_blocks, iter_blocks
from app.document_clone.ai_contract import RawBlock, RawBlockKind
from app.document_clone.artizen_format import (
    ArtizenTemplate,
    FixedText,
    GraphicLayer,
    GraphicPage,
    ImageBlock,
    PageGeometry,
    Rect,
    TextStyle,
)


def _template() -> ArtizenTemplate:
    geo = PageGeometry(width=595, height=842)
    page0 = GraphicPage(
        page=geo,
        fixed_texts=[
            FixedText(text="ACME BTP", rect=Rect(x=30, y=20, w=100, h=18),
                      style=TextStyle(font="Exo 2", size=14, color="#140E55", bold=True)),
            FixedText(text="DEVIS", rect=Rect(x=400, y=20, w=80, h=16),
                      style=TextStyle(size=12)),
        ],
        images=[ImageBlock(role="logo", rect=Rect(x=30, y=40, w=60, h=40), asset_ref="logo")],
    )
    page1 = GraphicPage(
        page=geo,
        fixed_texts=[FixedText(text="Total TTC", rect=Rect(x=400, y=700, w=100, h=14),
                               style=TextStyle(size=11))],
    )
    return ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page0, page1]),
                           assets={"logo": "x"})


def test_adapter_flattens_texts_then_images_per_page_in_order() -> None:
    blocks = artizen_to_blocks(_template())
    assert blocks.page_count == 2
    assert [b.id for b in blocks.blocks] == [0, 1, 2, 3]
    assert [b.kind for b in blocks.blocks] == [
        RawBlockKind.TEXT, RawBlockKind.TEXT, RawBlockKind.IMAGE, RawBlockKind.TEXT,
    ]
    assert [b.text for b in blocks.blocks] == ["ACME BTP", "DEVIS", "", "Total TTC"]


def test_adapter_preserves_geometry_and_style() -> None:
    company = artizen_to_blocks(_template()).blocks[0]
    assert (company.rect.x, company.rect.y, company.rect.w, company.rect.h) == (30, 20, 100, 18)
    assert company.font == "Exo 2"
    assert company.size == 14
    assert company.bold is True
    assert company.color == "#140E55"


def test_adapter_image_block_carries_rect_but_no_text() -> None:
    image = artizen_to_blocks(_template()).blocks[2]
    assert image.kind is RawBlockKind.IMAGE
    assert image.text == ""
    assert (image.rect.w, image.rect.h) == (60, 40)


def test_adapter_id_convention_matches_iter_blocks() -> None:
    template = _template()
    assert [bid for bid, _pi, _kind, _el in iter_blocks(template)] == [
        b.id for b in artizen_to_blocks(template).blocks
    ]


def test_adapter_treats_flat_template_as_one_implicit_page() -> None:
    geo = PageGeometry(width=595, height=842)
    flat = ArtizenTemplate(graphic=GraphicLayer(
        page=geo, fixed_texts=[FixedText(text="X", rect=Rect(x=1, y=1, w=10, h=10))]))
    blocks = artizen_to_blocks(flat)
    assert blocks.page_count == 1
    assert [b.text for b in blocks.blocks] == ["X"]


def test_rawblock_has_no_page_field_documented_p2_limit() -> None:
    # Multi-page blocks are one flat list: RawBlock carries no page. Faithful
    # multi-page field/table placement needs this contract to evolve (P2 debt).
    assert "page" not in RawBlock.model_fields
