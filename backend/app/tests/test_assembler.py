"""Tests for the deterministic assembler + original-data replay.

Two layers, both corpus-free (self-consistent, like the benchmark Gold Standard):
unit tests pin the field binding, the body-driven column geometry (the P1
discovery), the FixedText removal / anti double-draw; then an end-to-end synthetic
replay proves that variabilising a document and replaying its own data reproduces
it with no lost text and no regression.
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
    SectionPresence,
    TextStyle,
)
from app.document_clone.assembler import (
    _body_cells,
    _bound_block_ids,
    assemble_artizen,
    dedup_bound_roles,
    extract_original_rows,
    table_geometry,
)
from app.document_clone.comparator import compare_pdfs
from app.document_clone.renderer import render_artizen

# Ids follow the adapter convention: page-0 fixed_texts in order.
_ID_COMPANY, _ID_H_DESIG, _ID_H_MONTANT = 0, 1, 2
_ID_R0_DESIG, _ID_R0_MONTANT, _ID_R1_DESIG, _ID_R1_MONTANT = 3, 4, 5, 6
_ID_TOTAL = 7
_REGION = Rect(x=30, y=292, w=530, h=30)  # over the 4 body cells only


def _template() -> ArtizenTemplate:
    geo = PageGeometry(width=595, height=842)
    body = TextStyle(size=10)
    page = GraphicPage(
        page=geo,
        fixed_texts=[
            FixedText(text="ACME BTP", rect=Rect(x=30, y=20, w=100, h=18),
                      style=TextStyle(font="Exo 2", size=14, color="#140E55", bold=True)),
            # headers, deliberately misaligned from their body cells
            FixedText(text="Désignation", rect=Rect(x=150, y=270, w=80, h=12), style=TextStyle(size=9, bold=True)),
            FixedText(text="Montant HT", rect=Rect(x=470, y=270, w=60, h=12), style=TextStyle(size=9, bold=True)),
            # row 0
            FixedText(text="Chauffe-eau 200L", rect=Rect(x=70, y=300, w=150, h=11), style=body),
            FixedText(text="617,50", rect=Rect(x=500, y=300, w=50, h=11), style=TextStyle(size=10, align=HAlign.RIGHT)),
            # row 1
            FixedText(text="Pose et raccordement", rect=Rect(x=70, y=314, w=160, h=11), style=body),
            FixedText(text="250,00", rect=Rect(x=505, y=314, w=45, h=11), style=TextStyle(size=10, align=HAlign.RIGHT)),
            # totals
            FixedText(text="867,50", rect=Rect(x=500, y=360, w=50, h=12), style=TextStyle(size=12, bold=True, align=HAlign.RIGHT)),
        ],
    )
    return ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page]))


def _semantics() -> SemanticStructure:
    return SemanticStructure(
        roles=[
            BlockRole(block_id=_ID_COMPANY, role=FieldRole.COMPANY_NAME, confidence=1.0),
            BlockRole(block_id=_ID_TOTAL, role=FieldRole.TOTAL_TTC, confidence=1.0),
        ],
        columns=[
            ColumnMapping(block_id=_ID_H_DESIG, key="designation", label="Désignation"),
            ColumnMapping(block_id=_ID_H_MONTANT, key="total_ht", label="Montant HT"),
        ],
        sections=SectionPresence(company=True, table=True, totals=True),
        confidence=1.0,
    )


def test_fields_bind_to_block_coordinates_and_style() -> None:
    business = assemble_business_layer(artizen_to_blocks(_template()), _semantics())
    fields = {f.field: f for f in business.fields}
    assert set(fields) == {"company.name", "totals.ttc"}
    assert fields["company.name"].rect == Rect(x=30, y=20, w=100, h=18)
    assert fields["company.name"].style.bold is True
    assert fields["totals.ttc"].rect.x == 500


def test_column_geometry_comes_from_body_cells_not_headers() -> None:
    """The P1 discovery: the designation header sits at x=150 but its cells at
    x=70. The built column must follow the cells (x≈70), never the header."""
    template = _template()
    blocks = artizen_to_blocks(template)
    art = assemble_artizen(template, blocks, _semantics(), table_region=_REGION)
    columns = {c.key: c for c in art.graphic.pages[0].table.columns}
    assert set(columns) == {"designation", "total_ht"}
    assert abs(columns["designation"].x - 70) < 1.0        # body, not header@150
    assert columns["designation"].align is HAlign.LEFT
    # right-aligned amount column reaches the cells' common right edge (~550)
    assert columns["total_ht"].align is HAlign.RIGHT
    assert abs((columns["total_ht"].x + columns["total_ht"].width) - 550) < 1.0


def test_fixed_texts_removed_for_bound_fields_and_table_cells() -> None:
    template = _template()
    blocks = artizen_to_blocks(template)
    before = sum(len(p.fixed_texts) for p in template.graphic.pages)
    art = assemble_artizen(template, blocks, _semantics(), table_region=_REGION)
    after = sum(len(p.fixed_texts) for p in art.graphic.pages)
    # 2 bound fields + 4 body cells removed; only the 2 headers stay fixed.
    assert before == 8
    assert after == 2
    assert {ft.text for ft in art.graphic.pages[0].fixed_texts} == {"Désignation", "Montant HT"}


def test_extract_original_rows_recovers_the_document_data() -> None:
    template = _template()
    blocks = artizen_to_blocks(template)
    business = assemble_business_layer(blocks, _semantics())
    bound = _bound_block_ids(_semantics(), business)
    _first, rh = table_geometry(blocks, _REGION, bound)
    rows = extract_original_rows(blocks, _semantics(), _REGION, bound, rh)
    assert rows == [
        {"designation": "Chauffe-eau 200L", "total_ht": "617,50"},
        {"designation": "Pose et raccordement", "total_ht": "250,00"},
    ]


def test_synthetic_replay_reproduces_document_losslessly() -> None:
    """ORIGINAL (all fixed) → adapter → semantics → assemble → replay original data
    → render → comparator. Proves the mechanism corpus-free: no text is lost and
    structure/layout are preserved.

    Note on fidelity: the reference here is the doc rendered against *itself*, so it
    carries zero font-metric noise — the only visible difference is that table cells
    (drawn ``valign_center``) skip E-012's left-align width-scaling that a FixedText
    gets. On a tiny 8-run doc that shows in typography; on the real corpus (dozens of
    runs vs the actual PDF) it is negligible, and the strict non-regression assertion
    lives in ``test_clone_replay_corpus``. The renderer/typography path is not touched
    here by design (E-012 owns it)."""
    template = _template()
    original = render_artizen(template, {}, [])

    blocks = artizen_to_blocks(template)
    semantics = _semantics()
    business = assemble_business_layer(blocks, semantics)
    bound = _bound_block_ids(semantics, business)
    by_id = {b.id: b for b in blocks.blocks}
    field_paths = {f.field for f in business.fields}
    fields = {r.role.value: by_id[r.block_id].text for r in semantics.roles if r.role.value in field_paths}
    _first, rh = table_geometry(blocks, _REGION, bound)
    rows = extract_original_rows(blocks, semantics, _REGION, bound, rh)

    art = assemble_artizen(template, blocks, semantics, table_region=_REGION)
    generated = render_artizen(art, fields, rows)
    report = compare_pdfs(original, generated)

    assert report.matched_texts == report.reference_texts          # no text lost
    assert report.text_recall == 100.0
    assert report.categories.get("Structure", 0) >= 99.0           # structure preserved
    assert report.categories.get("Mise en page", 0) >= 97.0        # positions preserved
    assert report.overall >= 90.0                                  # faithful reproduction


# --- anti-collapse guard -----------------------------------------------------
def test_dedup_keeps_highest_confidence_bound_role() -> None:
    sem = SemanticStructure(roles=[
        BlockRole(block_id=1, role=FieldRole.CLIENT_NAME, confidence=0.9),
        BlockRole(block_id=2, role=FieldRole.CLIENT_NAME, confidence=0.4),
    ])
    kept = [r for r in dedup_bound_roles(sem).roles if r.role is FieldRole.CLIENT_NAME]
    assert len(kept) == 1
    assert kept[0].block_id == 1  # 0.9 > 0.4


def test_dedup_leaves_nonbound_multi_occurrence_roles() -> None:
    sem = SemanticStructure(roles=[
        BlockRole(block_id=1, role=FieldRole.TABLE_HEADER, confidence=0.9),
        BlockRole(block_id=2, role=FieldRole.TABLE_HEADER, confidence=0.9),
        BlockRole(block_id=3, role=FieldRole.FIXED_LABEL, confidence=0.8),
        BlockRole(block_id=4, role=FieldRole.FOOTER, confidence=0.8),
    ])
    # structural, legitimately repeated roles are never touched
    assert len(dedup_bound_roles(sem).roles) == 4


def test_dedup_tiebreak_lowest_block_id_on_equal_confidence() -> None:
    sem = SemanticStructure(roles=[
        BlockRole(block_id=5, role=FieldRole.COMPANY_NAME, confidence=0.8),
        BlockRole(block_id=2, role=FieldRole.COMPANY_NAME, confidence=0.8),
    ])
    kept = [r for r in dedup_bound_roles(sem).roles if r.role is FieldRole.COMPANY_NAME]
    assert len(kept) == 1 and kept[0].block_id == 2  # lowest id on tie


def test_dedup_absent_confidence_is_order_independent() -> None:
    # both default to confidence 0.0; the later-listed lower id must still win,
    # proving the tiebreak does not trust the response order.
    sem = SemanticStructure(roles=[
        BlockRole(block_id=9, role=FieldRole.DOC_NUMBER),
        BlockRole(block_id=3, role=FieldRole.DOC_NUMBER),
    ])
    kept = [r for r in dedup_bound_roles(sem).roles if r.role is FieldRole.DOC_NUMBER]
    assert len(kept) == 1 and kept[0].block_id == 3


def test_dedup_leaves_columns_untouched() -> None:
    sem = SemanticStructure(
        roles=[BlockRole(block_id=1, role=FieldRole.CLIENT_NAME, confidence=0.5),
               BlockRole(block_id=2, role=FieldRole.CLIENT_NAME, confidence=0.9)],
        columns=[ColumnMapping(block_id=10, key="designation", label="X")],
    )
    assert dedup_bound_roles(sem).columns == sem.columns


def test_assemble_multi_block_bound_role_keeps_others_as_fixed_text() -> None:
    geo = PageGeometry(width=595, height=842)
    page = GraphicPage(page=geo, fixed_texts=[
        FixedText(text="Rue A", rect=Rect(x=30, y=20, w=100, h=12)),
        FixedText(text="Ville B", rect=Rect(x=30, y=34, w=100, h=12)),
        FixedText(text="Tel C", rect=Rect(x=30, y=48, w=100, h=12)),
    ])
    tpl = ArtizenTemplate(graphic=GraphicLayer(page=geo, pages=[page]))
    blocks = artizen_to_blocks(tpl)
    sem = SemanticStructure(roles=[
        BlockRole(block_id=0, role=FieldRole.COMPANY_ADDRESS, confidence=0.9),
        BlockRole(block_id=1, role=FieldRole.COMPANY_ADDRESS, confidence=0.7),
        BlockRole(block_id=2, role=FieldRole.COMPANY_ADDRESS, confidence=0.6),
    ])
    art = assemble_artizen(tpl, blocks, sem)  # field path (no table)

    # only the best block (0) is bound & removed; the other two stay FixedText
    assert len(art.business.fields) == 1
    assert {ft.text for ft in art.graphic.pages[0].fixed_texts} == {"Ville B", "Tel C"}

    # and the replay reproduces every original — nothing collapses
    original = render_artizen(tpl, {}, [])
    fields = {"company.address": blocks.blocks[0].text}  # deduped → block 0
    report = compare_pdfs(original, render_artizen(art, fields, []))
    assert report.matched_texts == report.reference_texts
