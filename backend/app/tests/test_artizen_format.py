"""The .artizen format is the reference model an import compiles to — so it has
to survive a full JSON round-trip losslessly (that JSON *is* the stored file).
These tests also pin the three-layer shape and the generic document type."""

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BehavioralLayer,
    BusinessLayer,
    CalcMethod,
    CalcRule,
    DocumentType,
    FieldBinding,
    FixedText,
    GraphicLayer,
    HAlign,
    PageGeometry,
    Rect,
    SectionPresence,
    Shape,
    SourceKind,
    TableColumn,
    TableSpec,
    TextStyle,
)


def _sample() -> ArtizenTemplate:
    return ArtizenTemplate(
        document_type=DocumentType.DEVIS,
        source_kind=SourceKind.NATIVE,
        confidence_stars=5,
        estimated_fidelity=98,
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            palette={"navy": "#140E55", "gold": "#F4C95D"},
            fixed_texts=[
                FixedText(
                    text="DEVIS",
                    rect=Rect(x=400, y=30, w=120, h=28),
                    style=TextStyle(font="Exo 2", size=22, color="#F4C95D", bold=True),
                )
            ],
            shapes=[
                Shape(kind="rect", rect=Rect(x=30, y=17, w=535, h=55), fill="#140E55", radius=8)
            ],
            table=TableSpec(
                rect=Rect(x=30, y=130, w=535, h=400),
                header_fill="#140E55",
                columns=[
                    TableColumn(key="designation", label="Libellé", x=40, width=200, align=HAlign.LEFT),
                    TableColumn(key="total_ht", label="Total HT", x=500, width=60),
                ],
            ),
        ),
        business=BusinessLayer(
            fields=[
                FieldBinding(field="company.name", rect=Rect(x=45, y=36, w=250, h=18)),
                FieldBinding(field="totals.ttc", rect=Rect(x=500, y=700, w=80, h=18), suffix=" €"),
            ],
            sections=SectionPresence(logo=True, company=True, client=True, table=True, totals=True),
        ),
        behavioral=BehavioralLayer(
            calc_rules=[
                CalcRule(target="total_ht", method=CalcMethod.SUM_LINES_HT),
                CalcRule(target="total_vat", method=CalcMethod.VAT_PER_LINE_HALF_UP),
                CalcRule(target="total_ttc", method=CalcMethod.TTC_HT_PLUS_VAT),
            ],
            line_discount=True,
            deposits=True,
        ),
        assets={"font_exo2": "AAAA", "logo": "BBBB"},
    )


def test_artizen_round_trips_losslessly() -> None:
    original = _sample()

    restored = ArtizenTemplate.model_validate_json(original.model_dump_json())

    assert restored == original


def test_the_three_layers_are_present_and_typed() -> None:
    t = _sample()

    # graphique
    assert t.graphic.shapes[0].fill == "#140E55"
    assert t.graphic.table is not None and t.graphic.table.columns[0].key == "designation"
    # métier
    assert {f.field for f in t.business.fields} == {"company.name", "totals.ttc"}
    assert t.business.sections.totals is True
    # comportemental
    assert CalcRule(target="total_ttc", method=CalcMethod.TTC_HT_PLUS_VAT) in t.behavioral.calc_rules
    assert t.behavioral.line_discount is True
    # self-contained
    assert set(t.assets) == {"font_exo2", "logo"}


def test_the_format_is_document_type_agnostic() -> None:
    """The same structure clones a facture, an avoir, a contrat — only the
    document type (and rules) change."""
    for doc_type in (DocumentType.FACTURE, DocumentType.AVOIR, DocumentType.CONTRAT):
        t = _sample().model_copy(update={"document_type": doc_type})
        restored = ArtizenTemplate.model_validate_json(t.model_dump_json())
        assert restored.document_type == doc_type
