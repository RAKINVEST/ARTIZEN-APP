"""P2.4 — deterministic reflow / pagination for a NEW document.

A synthetic template whose table region fits 7 rows/page is reflowed with varying
row counts; the split is checked to be exact (order, no loss, no duplication) and a
rendered-then-re-extracted PDF proves page count, header repetition per page and
absence of cross-page bleed. The mono-page replay path (pneu/sje) is untouched by
this additive engine and is covered by its own suites.
"""

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BusinessLayer,
    FieldBinding,
    FixedText,
    GraphicLayer,
    GraphicPage,
    HAlign,
    PageGeometry,
    Rect,
    TableColumn,
    TableSpec,
    TextStyle,
)
from app.document_clone.extraction.pdf_extractor import extract
from app.document_clone.reflow import chunk_rows, page_capacity, reflow_document
from app.document_clone.renderer import render_artizen

_CAP = 7  # rows per page for the geometry below


def _base_template() -> ArtizenTemplate:
    geo = PageGeometry(width=595, height=300, margins=(34, 34, 40, 34))
    table = TableSpec(
        rect=Rect(x=40, y=100, w=515, h=140),
        page=0,
        columns=[
            TableColumn(key="designation", label="Désignation", x=40, width=400, align=HAlign.LEFT),
            TableColumn(key="total_ht", label="Montant", x=480, width=70, align=HAlign.RIGHT),
        ],
        header_style=TextStyle(size=10, bold=True),
        body_style=TextStyle(size=10),
        row_height=20.0,
    )
    page0 = GraphicPage(
        page=geo,
        fixed_texts=[FixedText(text="ACME BTP", rect=Rect(x=30, y=20, w=100, h=18),
                               style=TextStyle(size=12, bold=True))],
        table=table,
    )
    business = BusinessLayer(fields=[FieldBinding(
        field="totals.ttc", page=0, after_table=True, rect=Rect(x=480, y=262, w=70, h=14),
        style=TextStyle(size=11, bold=True, align=HAlign.RIGHT))])
    return ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page0]), business=business)


def _rows(n: int) -> list[dict[str, str]]:
    return [{"designation": f"Item {i}", "total_ht": f"{i},00"} for i in range(n)]


def test_capacity_is_computed_from_model_geometry() -> None:
    tpl = _base_template()
    assert page_capacity(tpl.graphic.pages[0].table, tpl.graphic.pages[0].page) == _CAP


def test_chunk_rows_is_deterministic_and_exact() -> None:
    rows = _rows(15)
    chunks = chunk_rows(rows, _CAP, _CAP)
    assert [len(c) for c in chunks] == [7, 7, 1]
    assert [r for c in chunks for r in c] == rows  # order + no loss/dup


def test_fewer_rows_than_capacity_one_page() -> None:
    out, rbp = reflow_document(_base_template(), _rows(2))
    assert len(out.graphic.pages) == 1
    assert len(rbp[0]) == 2


def test_exactly_capacity_one_page() -> None:
    out, rbp = reflow_document(_base_template(), _rows(_CAP))
    assert len(out.graphic.pages) == 1


def test_overflow_creates_second_page() -> None:
    out, rbp = reflow_document(_base_template(), _rows(_CAP + 1))
    assert len(out.graphic.pages) == 2
    assert len(rbp[0]) == _CAP and len(rbp[1]) == 1


def test_large_count_creates_three_pages() -> None:
    out, rbp = reflow_document(_base_template(), _rows(15))
    assert len(out.graphic.pages) == 3
    assert [len(rbp[i]) for i in range(3)] == [7, 7, 1]


def test_no_row_lost_or_duplicated_order_strictly_preserved() -> None:
    rows = _rows(20)
    out, rbp = reflow_document(_base_template(), rows)
    flat = [r for i in sorted(rbp) for r in rbp[i]]
    assert flat == rows
    assert sum(len(v) for v in rbp.values()) == 20  # nothing added/dropped


def test_header_repeated_on_every_page() -> None:
    out, _rbp = reflow_document(_base_template(), _rows(15))
    for i, page in enumerate(out.graphic.pages):
        assert page.table is not None and page.table.page == i
        assert [c.label for c in page.table.columns] == ["Désignation", "Montant"]


def test_totals_stay_on_single_page(_case="A") -> None:
    out, _rbp = reflow_document(_base_template(), _rows(2))  # fits one page
    totals = [f for f in out.business.fields if f.field == "totals.ttc"]
    assert len(out.graphic.pages) == 1
    assert totals[0].page == 0  # unchanged


def test_totals_follow_to_second_page() -> None:
    out, _rbp = reflow_document(_base_template(), _rows(_CAP + 1))  # 2 pages
    totals = [f for f in out.business.fields if f.field == "totals.ttc"]
    assert len(out.graphic.pages) == 2
    assert totals[0].page == 1  # follows the table to the last page


def test_totals_follow_to_third_page() -> None:
    out, _rbp = reflow_document(_base_template(), _rows(15))  # 3 pages
    totals = [f for f in out.business.fields if f.field == "totals.ttc"]
    assert len(out.graphic.pages) == 3
    assert totals[0].page == 2


def test_totals_rect_and_style_preserved_only_page_changes() -> None:
    base = _base_template()
    original = next(f for f in base.business.fields if f.field == "totals.ttc")
    out, _rbp = reflow_document(base, _rows(15))
    moved = next(f for f in out.business.fields if f.field == "totals.ttc")
    assert moved.page == 2
    assert moved.rect == original.rect          # rect unchanged
    assert moved.style == original.style        # style unchanged


def test_totals_without_after_table_flag_are_never_moved() -> None:
    # case D-adjacent: a field NOT flagged after_table is left exactly where it is.
    base = _base_template()
    base.business.fields[0].after_table = False
    out, _rbp = reflow_document(base, _rows(15))
    assert next(f for f in out.business.fields if f.field == "totals.ttc").page == 0


def test_totals_go_to_fresh_page_when_last_row_would_reach_them() -> None:
    # totals placed high (y=180 -> capacity above them = 3); 7 rows fill one page and
    # would reach the totals band, so the totals move to a fresh trailing page.
    base = _base_template()
    base.business.fields[0] = base.business.fields[0].model_copy(
        update={"rect": Rect(x=480, y=180, w=70, h=14)})
    out, _rbp = reflow_document(base, _rows(_CAP))  # 7 rows -> single table page, but overlaps totals band
    totals = next(f for f in out.business.fields if f.field == "totals.ttc")
    assert len(out.graphic.pages) == 2          # table page + fresh totals page
    assert totals.page == 1
    assert out.graphic.pages[1].table is None   # the trailing page carries no table


def test_rendered_pdf_paginates_and_repeats_header_without_bleed() -> None:
    out, rbp = reflow_document(_base_template(), _rows(_CAP + 1))  # 8 rows -> 2 pages
    pdf = render_artizen(out, {"totals.ttc": "999,00"}, rbp)
    pages = [" | ".join(ft.text for ft in p.fixed_texts) for p in extract(pdf).graphic.pages]

    assert len(pages) == 2
    assert "Désignation" in pages[0] and "Désignation" in pages[1]   # header repeated
    assert "Item 0" in pages[0] and "Item 6" in pages[0]
    assert "Item 7" not in pages[0]                                  # no overflow onto page 0
    assert "Item 7" in pages[1] and "Item 0" not in pages[1]         # continuation, no bleed


def test_reflow_repeats_captured_header_texts_on_continuation_pages() -> None:
    # A replay-style table: TableSpec labels are empty, the header lives in
    # header_texts (captured at assembly). Reflow must repeat it verbatim.
    geo = PageGeometry(width=595, height=300, margins=(34, 34, 40, 34))
    header = [
        FixedText(text="Désignation", rect=Rect(x=70, y=80, w=100, h=12), style=TextStyle(size=9, bold=True)),
        FixedText(text="Montant", rect=Rect(x=480, y=80, w=70, h=12), style=TextStyle(size=9, bold=True)),
    ]
    table = TableSpec(
        rect=Rect(x=40, y=100, w=515, h=140), page=0,
        columns=[TableColumn(key="designation", label="", x=70, width=400, align=HAlign.LEFT),
                 TableColumn(key="total_ht", label="", x=480, width=70, align=HAlign.RIGHT)],
        header_texts=header, row_height=20.0,
    )
    page0 = GraphicPage(page=geo, fixed_texts=[h.model_copy() for h in header], table=table)
    tpl = ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page0]))

    out, rbp = reflow_document(tpl, _rows(_CAP + 1))  # 2 pages
    assert len(out.graphic.pages) == 2
    assert {ft.text for ft in out.graphic.pages[1].fixed_texts} == {"Désignation", "Montant"}

    pages = [" | ".join(ft.text for ft in p.fixed_texts)
             for p in extract(render_artizen(out, {}, rbp)).graphic.pages]
    assert "Désignation" in pages[0] and "Désignation" in pages[1]  # header repeated
    assert "Item 0" in pages[0] and "Item 7" in pages[1] and "Item 7" not in pages[0]


def test_no_table_is_safe_noop() -> None:
    geo = PageGeometry(width=595, height=842)
    tpl = ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[GraphicPage(page=geo)]))
    out, rbp = reflow_document(tpl, _rows(3))
    assert len(out.graphic.pages) == 1
    assert rbp == {0: _rows(3)}
