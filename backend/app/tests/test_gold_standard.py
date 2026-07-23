"""Tests for the Gold Standard certification protocol (Double Gold).

The reference must itself be proven. These pin the protocol: a single Gold can
never be certified; two agreeing Golds certify (and freeze expected.pdf); two
disagreeing Golds go to review; and ``certified`` cannot be declared by hand.
"""

import json

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BusinessLayer,
    FieldBinding,
    FixedText,
    GraphicLayer,
    PageGeometry,
    Rect,
    SectionPresence,
    Shape,
    TextStyle,
)
from app.document_clone.gold_standard import (
    GOLD_CERTIFIED,
    GOLD_REVIEWED,
    certify_gold_standard,
    set_gold_status,
)
from app.document_clone.ingest import ingest_pdf
from app.document_clone.renderer import render_artizen


def _template(company_y: float = 36) -> ArtizenTemplate:
    return ArtizenTemplate(
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            shapes=[Shape(kind="rect", rect=Rect(x=30, y=20, w=535, h=55), fill="#140E55")],
            fixed_texts=[FixedText(text="DEVIS", rect=Rect(x=430, y=30, w=120, h=28),
                                   style=TextStyle(size=22, color="#F4C95D", bold=True))],
        ),
        business=BusinessLayer(
            fields=[FieldBinding(field="company.name", rect=Rect(x=45, y=company_y, w=250, h=18),
                                 style=TextStyle(size=14, color="#140E55", bold=True))],
            sections=SectionPresence(company=True, totals=True),
        ),
    )


_DATA = {"fields": {"company.name": "ARTIZEN PLOMBERIE"}, "rows": []}


def _ingest_one(tmp_path) -> None:
    pdf = render_artizen(_template(), _DATA["fields"], _DATA["rows"])
    src = tmp_path / "in.pdf"
    src.write_bytes(pdf)
    ingest_pdf(tmp_path, src, software="Batappli")


def _write_gold_a(folder) -> None:
    (folder / "batappli-001.artizen.json").write_text(_template().model_dump_json(), encoding="utf-8")
    (folder / "batappli-001.data.json").write_text(json.dumps(_DATA), encoding="utf-8")


def test_a_single_gold_cannot_be_certified(tmp_path) -> None:
    _ingest_one(tmp_path)
    _write_gold_a(tmp_path / "Batappli")

    result = certify_gold_standard(tmp_path, "batappli-001")

    assert result.ok is False
    assert "second Gold" in result.messages[0]


def test_two_agreeing_golds_certify_and_freeze_expected(tmp_path) -> None:
    _ingest_one(tmp_path)
    folder = tmp_path / "Batappli"
    _write_gold_a(folder)
    # Gold B: an independent but equivalent reconstruction → renders match.
    (folder / "batappli-001.gold-b.artizen.json").write_text(_template().model_dump_json(), encoding="utf-8")
    (folder / "batappli-001.gold-b.data.json").write_text(json.dumps(_DATA), encoding="utf-8")

    result = certify_gold_standard(tmp_path, "batappli-001")

    assert result.ok is True
    assert result.state == GOLD_CERTIFIED
    assert result.agreement >= 99.0
    # The certified render is frozen as the expected reference.
    assert (folder / "batappli-001.expected.pdf").exists()


def test_two_disagreeing_golds_go_to_review(tmp_path) -> None:
    _ingest_one(tmp_path)
    folder = tmp_path / "Batappli"
    _write_gold_a(folder)
    # Gold B places the company name far away → the renders diverge.
    (folder / "batappli-001.gold-b.artizen.json").write_text(
        _template(company_y=500).model_dump_json(), encoding="utf-8")
    (folder / "batappli-001.gold-b.data.json").write_text(json.dumps(_DATA), encoding="utf-8")

    result = certify_gold_standard(tmp_path, "batappli-001")

    assert result.ok is False
    assert result.state == GOLD_REVIEWED
    assert result.agreement < 99.0
    assert not (folder / "batappli-001.expected.pdf").exists()


def test_certified_cannot_be_declared_by_hand(tmp_path) -> None:
    _ingest_one(tmp_path)

    refused = set_gold_status(tmp_path, "batappli-001", GOLD_CERTIFIED)

    assert refused.ok is False
    assert "certify_gold_standard" in refused.messages[0]
