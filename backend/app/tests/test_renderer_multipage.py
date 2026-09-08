"""P2.3 — multi-page rendering + orchestration.

Assembles a synthetic 3-page ``.artizen`` (fields on pages 0 and 2, a table on
pages 0 and 1), replays the original data per page, renders it, then RE-EXTRACTS
the produced PDF to prove that every field and every table row lands on its own
source page — no cross-page bleed, correct page count, order preserved.
"""

from app.document_clone.adapter import artizen_to_blocks
from app.document_clone.ai_contract import (
    BlockRole,
    ColumnMapping,
    FieldRole,
    SemanticStructure,
    assemble_business_layer,
)
from app.document_clone.artizen_format import (
    ArtizenTemplate,
    FixedText,
    GraphicLayer,
    GraphicPage,
    HAlign,
    PageGeometry,
    Rect,
    TextStyle,
)
from app.document_clone.assembler import (
    _bound_block_ids,
    assemble_artizen,
    extract_original_rows,
    table_geometry,
)
from app.document_clone.extraction.pdf_extractor import extract
from app.document_clone.renderer import render_artizen

_BODY = TextStyle(size=10)
_RIGHT = TextStyle(size=10, align=HAlign.RIGHT)
_HDR = TextStyle(size=9, bold=True)
# page 0 table body sits at y~300; page 1 body at y~70 (top of its page)
_REGIONS = {0: Rect(x=30, y=292, w=530, h=40), 1: Rect(x=30, y=62, w=530, h=40)}


def _template() -> ArtizenTemplate:
    geo = PageGeometry(width=595, height=842)
    page0 = GraphicPage(page=geo, fixed_texts=[
        FixedText(text="ACME BTP", rect=Rect(x=30, y=20, w=100, h=18), style=TextStyle(size=14, bold=True)),  # 0
        FixedText(text="Désignation", rect=Rect(x=150, y=270, w=80, h=12), style=_HDR),   # 1
        FixedText(text="Montant HT", rect=Rect(x=470, y=270, w=60, h=12), style=_HDR),    # 2
        FixedText(text="Ligne 1", rect=Rect(x=70, y=300, w=150, h=11), style=_BODY),      # 3
        FixedText(text="100,00", rect=Rect(x=500, y=300, w=50, h=11), style=_RIGHT),      # 4
        FixedText(text="Ligne 2", rect=Rect(x=70, y=314, w=150, h=11), style=_BODY),      # 5
        FixedText(text="200,00", rect=Rect(x=505, y=314, w=45, h=11), style=_RIGHT),      # 6
    ])
    page1 = GraphicPage(page=geo, fixed_texts=[
        FixedText(text="Désignation", rect=Rect(x=150, y=40, w=80, h=12), style=_HDR),    # 7 (repeated header)
        FixedText(text="Montant HT", rect=Rect(x=470, y=40, w=60, h=12), style=_HDR),     # 8
        FixedText(text="Ligne 3", rect=Rect(x=70, y=70, w=150, h=11), style=_BODY),       # 9
        FixedText(text="300,00", rect=Rect(x=500, y=70, w=50, h=11), style=_RIGHT),       # 10
        FixedText(text="Ligne 4", rect=Rect(x=70, y=84, w=150, h=11), style=_BODY),       # 11
        FixedText(text="400,00", rect=Rect(x=505, y=84, w=45, h=11), style=_RIGHT),       # 12
    ])
    page2 = GraphicPage(page=geo, fixed_texts=[
        FixedText(text="Total TTC", rect=Rect(x=400, y=700, w=60, h=12), style=_HDR),     # 13
        FixedText(text="1 000,00", rect=Rect(x=500, y=700, w=60, h=12), style=_RIGHT),    # 14
    ])
    return ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page0, page1, page2]))


def _semantics() -> SemanticStructure:
    return SemanticStructure(
        roles=[
            BlockRole(block_id=0, role=FieldRole.COMPANY_NAME, confidence=0.9),   # page 0
            BlockRole(block_id=14, role=FieldRole.TOTAL_TTC, confidence=0.9),     # page 2
        ],
        columns=[
            ColumnMapping(block_id=1, key="designation", label="Désignation"),
            ColumnMapping(block_id=2, key="total_ht", label="Montant HT"),
        ],
    )


def _render_multipage():
    tpl = _template()
    blocks = artizen_to_blocks(tpl)
    by = {b.id: b for b in blocks.blocks}
    sem = _semantics()
    art = assemble_artizen(tpl, blocks, sem, table_regions=_REGIONS)

    business = assemble_business_layer(blocks, sem)
    paths = {f.field for f in business.fields}
    fields = {r.role.value: by[r.block_id].text for r in sem.roles if r.role.value in paths}
    bound = _bound_block_ids(sem, business)
    rows_by_page = {}
    for pg, region in _REGIONS.items():
        _fy, rh = table_geometry(blocks, region, bound, pg)
        rows_by_page[pg] = extract_original_rows(blocks, sem, region, bound, rh, pg)

    pdf = render_artizen(art, fields, rows_by_page)
    return art, fields, rows_by_page, pdf


def _page_strings(pdf: bytes) -> list[str]:
    regen = extract(pdf)
    return [" | ".join(ft.text for ft in p.fixed_texts) for p in regen.graphic.pages]


def test_assembly_builds_one_tablespec_per_page_with_source_page() -> None:
    art, _fields, rows_by_page, _pdf = _render_multipage()
    assert art.graphic.pages[0].table is not None and art.graphic.pages[0].table.page == 0
    assert art.graphic.pages[1].table is not None and art.graphic.pages[1].table.page == 1
    assert art.graphic.pages[2].table is None
    # fields carry their own source page (0 and 2), never merged
    fpages = {f.field: f.page for f in art.business.fields}
    assert fpages == {"company.name": 0, "totals.ttc": 2}
    # original rows recovered per page, in order, no cross-page mixing
    assert rows_by_page[0] == [{"designation": "Ligne 1", "total_ht": "100,00"},
                               {"designation": "Ligne 2", "total_ht": "200,00"}]
    assert rows_by_page[1] == [{"designation": "Ligne 3", "total_ht": "300,00"},
                               {"designation": "Ligne 4", "total_ht": "400,00"}]


def test_rendered_pdf_places_each_element_on_its_own_page() -> None:
    _art, _fields, _rows, pdf = _render_multipage()
    pages = _page_strings(pdf)
    assert len(pages) == 3  # page count preserved

    # page 0: company field + its own lines; NOT the other pages' lines/totals
    assert "ACME BTP" in pages[0]
    assert "Ligne 1" in pages[0] and "Ligne 2" in pages[0]
    assert "Ligne 3" not in pages[0] and "Ligne 4" not in pages[0]
    assert "1 000,00" not in pages[0]

    # page 1: repeated header + its own lines; NOT page-0 lines, NOT company/totals
    assert "Désignation" in pages[1] and "Montant HT" in pages[1]
    assert "Ligne 3" in pages[1] and "Ligne 4" in pages[1]
    assert "Ligne 1" not in pages[1] and "Ligne 2" not in pages[1]
    assert "ACME BTP" not in pages[1] and "1 000,00" not in pages[1]

    # page 2: totals field only; no table lines, no company
    assert "1 000,00" in pages[2]
    assert "ACME BTP" not in pages[2]
    assert "Ligne" not in pages[2]


def test_rows_keep_their_order_within_a_page() -> None:
    _art, _fields, _rows, pdf = _render_multipage()
    regen = extract(pdf)
    p0 = {ft.text: ft.rect.y for ft in regen.graphic.pages[0].fixed_texts}
    p1 = {ft.text: ft.rect.y for ft in regen.graphic.pages[1].fixed_texts}
    assert p0["Ligne 1"] < p0["Ligne 2"]   # row order preserved on page 0
    assert p1["Ligne 3"] < p1["Ligne 4"]   # and on page 1


def test_single_page_api_unchanged() -> None:
    # the mono-page shortcut (table_region/table_page) still works and keeps every
    # field on page 0 — the P2.3 changes are additive.
    tpl = _template()
    blocks = artizen_to_blocks(tpl)
    sem = SemanticStructure(
        roles=[BlockRole(block_id=0, role=FieldRole.COMPANY_NAME, confidence=0.9)],
        columns=_semantics().columns,
    )
    art = assemble_artizen(tpl, blocks, sem, table_region=_REGIONS[0])  # single-page shortcut
    assert art.graphic.pages[0].table is not None and art.graphic.pages[0].table.page == 0
    assert art.graphic.pages[1].table is None
    assert [f.page for f in art.business.fields] == [0]
