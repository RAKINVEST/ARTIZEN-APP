"""Tests for the Benchmark Engine (Brique Q1).

The instrument that pilots Brique 4 must itself be trustworthy: it discovers the
corpus, runs the measurable chain on a Gold Standard, aggregates per software,
detects regressions, and stays honest (and non-crashing) on an empty corpus.
Built on a temp corpus so it needs no real PDFs.
"""

import json

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BusinessLayer,
    FieldBinding,
    FixedText,
    GraphicLayer,
    HAlign,
    PageGeometry,
    Rect,
    SectionPresence,
    Shape,
    TableColumn,
    TableSpec,
    TextStyle,
)
from app.document_clone.benchmark import (
    append_history,
    run_benchmark,
    to_json,
    to_markdown,
    verify_replay,
)
from app.document_clone.renderer import render_artizen


def _template() -> ArtizenTemplate:
    return ArtizenTemplate(
        graphic=GraphicLayer(
            page=PageGeometry(width=595, height=842),
            shapes=[Shape(kind="rect", rect=Rect(x=30, y=20, w=535, h=55), fill="#140E55")],
            fixed_texts=[
                FixedText(text="DEVIS", rect=Rect(x=430, y=30, w=120, h=28),
                          style=TextStyle(size=22, color="#F4C95D", bold=True))
            ],
            table=TableSpec(
                rect=Rect(x=30, y=130, w=535, h=200),
                header_fill="#140E55",
                columns=[
                    TableColumn(key="designation", label="Libellé", x=40, width=300, align=HAlign.LEFT),
                    TableColumn(key="total_ht", label="Total HT", x=480, width=70, align=HAlign.RIGHT),
                ],
            ),
        ),
        business=BusinessLayer(
            fields=[FieldBinding(field="company.name", rect=Rect(x=45, y=36, w=250, h=18),
                                 style=TextStyle(size=14, color="#140E55", bold=True))],
            sections=SectionPresence(logo=True, company=True, client=True, table=True, totals=True),
        ),
    )


def _gold_standard(source_dir, radical: str) -> None:
    """Write a self-consistent Gold Standard: the 'original' PDF *is* the render
    of the template+data, so a faithful re-render scores ~100 (plumbing check)."""
    template = _template()
    data = {"fields": {"company.name": "ARTIZEN PLOMBERIE"},
            "rows": [{"designation": "1 - Chauffe-eau", "total_ht": "617,50"}]}
    pdf = render_artizen(template, data["fields"], data["rows"])
    (source_dir / f"{radical}.pdf").write_bytes(pdf)
    (source_dir / f"{radical}.artizen.json").write_text(template.model_dump_json(), encoding="utf-8")
    (source_dir / f"{radical}.data.json").write_text(json.dumps(data), encoding="utf-8")


def test_empty_corpus_is_honest_not_a_crash(tmp_path) -> None:
    (tmp_path / "Batappli").mkdir()

    report = run_benchmark(tmp_path, label="v0.1")

    assert report.total_documents == 0
    assert "vide" in report.message.lower()
    assert "vide" in to_markdown(report).lower()


def test_gold_standard_produces_the_kpis_and_certifies(tmp_path) -> None:
    batappli = tmp_path / "Batappli"
    batappli.mkdir()
    _gold_standard(batappli, "batappli-001")

    report = run_benchmark(tmp_path, label="v0.4")

    assert report.total_documents == 1
    doc = report.documents[0]
    assert doc.source == "Batappli"
    assert doc.kpis.fidelity is not None and doc.kpis.fidelity >= 99.0
    assert doc.kpis.certification == "Platine"
    assert doc.kpis.coverage is not None
    # aggregated per source + rendered to Markdown.
    md = to_markdown(report)
    assert "Batappli" in md and "Fidélité" in md
    # serialisable for the machine-readable trend record.
    json.loads(to_json(report))


def test_missing_data_json_skips_fidelity_but_keeps_coverage(tmp_path) -> None:
    ebp = tmp_path / "EBP"
    ebp.mkdir()
    template = _template()
    pdf = render_artizen(template, {"company.name": "X"}, [])
    (ebp / "ebp-001.pdf").write_bytes(pdf)
    (ebp / "ebp-001.artizen.json").write_text(template.model_dump_json(), encoding="utf-8")
    # no .data.json

    report = run_benchmark(tmp_path)
    doc = report.documents[0]

    assert doc.kpis.fidelity is None
    assert doc.kpis.coverage is not None
    assert any("data.json" in n for n in doc.notes)


def test_auto_pass_counts_zero_correction_documents(tmp_path) -> None:
    batappli = tmp_path / "Batappli"
    batappli.mkdir()
    _gold_standard(batappli, "batappli-001")
    _gold_standard(batappli, "batappli-002")
    # One needed no correction, the other needed three (from Template Studio).
    (batappli / "batappli-001.meta.json").write_text(
        json.dumps({"corrections": 0, "validation_seconds": 12}), encoding="utf-8")
    (batappli / "batappli-002.meta.json").write_text(
        json.dumps({"corrections": 3, "validation_seconds": 95}), encoding="utf-8")

    report = run_benchmark(tmp_path, label="v0.5")
    summary = next(s for s in report.sources if s.source == "Batappli")

    # 1 of 2 measured documents passed with zero correction → 50 %.
    assert summary.auto_pass == 50.0
    assert summary.avg_validation_seconds is not None
    assert "Auto-pass" in to_markdown(report)


def test_benchmark_is_reproducible_replay(tmp_path) -> None:
    batappli = tmp_path / "Batappli"
    batappli.mkdir()
    _gold_standard(batappli, "batappli-001")

    first = run_benchmark(tmp_path, label="v0.7")
    second = run_benchmark(tmp_path, label="v0.7")

    # Same corpus + same engine → identical fingerprint and identical output.
    assert first.fingerprint == second.fingerprint
    assert first.fingerprint  # non-empty
    assert to_json(first) == to_json(second)

    # Replay against the recorded run confirms exact reproduction…
    history = append_history(None, first)
    ok, _ = verify_replay(history, second)
    assert ok is True

    # …and a tampered fingerprint is caught as drift.
    history["runs"][-1]["fingerprint"] = "deadbeefdead"
    drifted, message = verify_replay(history, second)
    assert drifted is False
    assert "divergence" in message.lower()


def test_run_number_increments_with_history(tmp_path) -> None:
    batappli = tmp_path / "Batappli"
    batappli.mkdir()
    _gold_standard(batappli, "batappli-001")

    r1 = run_benchmark(tmp_path, label="v0.1")
    history = append_history(None, r1)
    r2 = run_benchmark(tmp_path, label="v0.2", history=history)

    assert r1.run == 1
    assert r2.run == 2


def test_regression_is_detected_against_history(tmp_path) -> None:
    batappli = tmp_path / "Batappli"
    batappli.mkdir()
    _gold_standard(batappli, "batappli-001")

    # A previous run where Batappli scored a perfect 100 fidelity.
    history = {"runs": [{"label": "v0.3", "sources": {"Batappli": {
        "fidelity": 100.0, "coverage": 100.0, "confidence": None}}}]}

    report = run_benchmark(tmp_path, label="v0.4", history=history)
    summary = next(s for s in report.sources if s.source == "Batappli")

    # Current fidelity is ~99.x < 100 → a negative delta is surfaced.
    assert "fidelity" in summary.regression
    assert summary.regression["fidelity"] <= 0

    # And the run appends to the history for next time.
    updated = append_history(history, report)
    assert len(updated["runs"]) == 2
    assert updated["runs"][-1]["label"] == "v0.4"
