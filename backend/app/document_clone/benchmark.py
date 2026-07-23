"""Brique Q1 — the Benchmark Engine.

The measurement discipline that turns the clone engine into something hard to
equal. It walks the whole :file:`Corpus/`, runs the measurable chain on every
document, and produces a consolidated report: the **4 KPIs** per software, the
certifications, and the **regressions** against the previous run.

    Import → Analyzer → (extraction) → Report → Renderer → Comparateur → Certification

Extraction (Brique 4) is not built yet, so today the engine runs on the parts
that exist and are honest to measure:

* **every** PDF is classified by the Analyzer (native/hybrid/image + ★);
* a **Gold Standard** (``<radical>.artizen.json`` + ``<radical>.data.json``) is
  rendered and compared to its original → *Fidelity* + *Certification*, and its
  declared sections give *Coverage*;
* a ``<radical>.meta.json`` sidecar (written later by Template Studio) carries
  the human-side KPIs — *validation time*, *corrections* — the argument that
  ARTIZEN takes a correction from 5 minutes to 20 seconds.

Nothing here is speculative infrastructure: it is the instrument that makes
Brique 4's progress *pilotable*, version after version. The competitive moat is
the corpus + these measurements, not the format.
"""

import json
import statistics
from dataclasses import asdict, dataclass, field
from pathlib import Path

from app.document_analysis.pdf_classifier import classify_pdf
from app.document_clone.artizen_format import ArtizenTemplate
from app.document_clone.comparator import compare_pdfs
from app.document_clone.extract_report import build_extraction_report
from app.document_clone.renderer import render_artizen

_EXPECTED_SUFFIX = ".expected.pdf"
_OUTPUT_DIRNAME = "benchmark"  # skipped during discovery, holds the reports


@dataclass
class DocKpis:
    """The 4 KPIs for one document (``None`` = not measurable yet)."""

    fidelity: float | None = None
    coverage: float | None = None
    confidence: float | None = None
    validation_seconds: float | None = None
    corrections: int | None = None
    certification: str | None = None


@dataclass
class DocResult:
    source: str
    document: str
    kind: str
    stars: int
    kpis: DocKpis
    notes: list[str] = field(default_factory=list)


@dataclass
class SourceSummary:
    source: str
    documents: int
    avg_fidelity: float | None
    avg_coverage: float | None
    avg_confidence: float | None
    avg_validation_seconds: float | None
    certifications: dict[str, int]
    #: kpi -> delta vs the previous run for this source (+ = improved).
    regression: dict[str, float]


@dataclass
class BenchmarkReport:
    label: str
    total_documents: int
    sources: list[SourceSummary]
    documents: list[DocResult]
    message: str = ""


def _iter_documents(corpus_dir: Path):
    """Yield ``(source, pdf_path)`` for every original PDF in the corpus —
    skipping the ``.expected.pdf`` renders and the output directory."""
    for source_dir in sorted(p for p in corpus_dir.iterdir() if p.is_dir()):
        if source_dir.name == _OUTPUT_DIRNAME:
            continue
        for pdf in sorted(source_dir.glob("*.pdf")):
            if pdf.name.endswith(_EXPECTED_SUFFIX):
                continue
            yield source_dir.name, pdf


def _load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def _evaluate(source: str, pdf_path: Path) -> DocResult:
    content = pdf_path.read_bytes()
    quality = classify_pdf(content)
    kpis = DocKpis()
    notes: list[str] = []

    radical = pdf_path.name[: -len(".pdf")]
    tpl_path = pdf_path.with_name(radical + ".artizen.json")
    data_path = pdf_path.with_name(radical + ".data.json")
    meta_path = pdf_path.with_name(radical + ".meta.json")

    if tpl_path.exists():
        template = ArtizenTemplate.model_validate_json(tpl_path.read_text(encoding="utf-8"))
        cols = template.graphic.table.columns if template.graphic.table else []
        report = build_extraction_report(
            document=pdf_path.name,
            document_type=template.document_type,
            quality=quality,
            sections=template.business.sections,
            columns=[c.label for c in cols],
        )
        kpis.coverage = report.coverage

        if data_path.exists():
            data = _load_json(data_path)
            try:
                rendered = render_artizen(
                    template, fields=data.get("fields", {}), rows=data.get("rows", [])
                )
                fidelity = compare_pdfs(content, rendered)
                kpis.fidelity = fidelity.overall
                kpis.certification = fidelity.certification
            except Exception as exc:  # a broken template must not kill the run
                notes.append(f"rendu/comparaison échoués : {exc}")
        else:
            notes.append("fidélité ignorée : pas de .data.json")
    else:
        notes.append("pas de Gold Standard (.artizen.json)")

    if meta_path.exists():
        meta = _load_json(meta_path)
        kpis.validation_seconds = meta.get("validation_seconds")
        kpis.corrections = meta.get("corrections")
        kpis.confidence = meta.get("confidence", kpis.confidence)

    return DocResult(
        source=source,
        document=pdf_path.name,
        kind=quality.kind.value,
        stars=quality.stars,
        kpis=kpis,
        notes=notes,
    )


def _mean(values: list[float]) -> float | None:
    vals = [v for v in values if v is not None]
    return round(statistics.fmean(vals), 2) if vals else None


def _summarise(documents: list[DocResult], history: dict | None) -> list[SourceSummary]:
    previous = _last_run_by_source(history)
    by_source: dict[str, list[DocResult]] = {}
    for doc in documents:
        by_source.setdefault(doc.source, []).append(doc)

    summaries: list[SourceSummary] = []
    for source in sorted(by_source):
        docs = by_source[source]
        certs: dict[str, int] = {}
        for d in docs:
            if d.kpis.certification:
                certs[d.kpis.certification] = certs.get(d.kpis.certification, 0) + 1
        avg = {
            "fidelity": _mean([d.kpis.fidelity for d in docs]),
            "coverage": _mean([d.kpis.coverage for d in docs]),
            "confidence": _mean([d.kpis.confidence for d in docs]),
        }
        regression: dict[str, float] = {}
        prev = previous.get(source, {})
        for kpi, value in avg.items():
            if value is not None and prev.get(kpi) is not None:
                regression[kpi] = round(value - prev[kpi], 2)

        summaries.append(
            SourceSummary(
                source=source,
                documents=len(docs),
                avg_fidelity=avg["fidelity"],
                avg_coverage=avg["coverage"],
                avg_confidence=avg["confidence"],
                avg_validation_seconds=_mean([d.kpis.validation_seconds for d in docs]),
                certifications=certs,
                regression=regression,
            )
        )
    return summaries


def _last_run_by_source(history: dict | None) -> dict[str, dict]:
    if not history or not history.get("runs"):
        return {}
    return history["runs"][-1].get("sources", {})


def run_benchmark(
    corpus_dir: Path, *, label: str = "dev", history: dict | None = None
) -> BenchmarkReport:
    """Run the full measurable chain over the corpus and build the report."""
    documents = [_evaluate(source, pdf) for source, pdf in _iter_documents(corpus_dir)]
    sources = _summarise(documents, history)
    message = (
        ""
        if documents
        else "Corpus vide — déposez le Starter Corpus de 5 devis "
        "(Batappli, EBP, Word, Excel, personnalisé) pour démarrer les mesures."
    )
    return BenchmarkReport(
        label=label,
        total_documents=len(documents),
        sources=sources,
        documents=documents,
        message=message,
    )


# --------------------------------------------------------------------- rendering
def _fmt(value: float | None, suffix: str = " %") -> str:
    return f"{value:.1f}{suffix}" if value is not None else "—"


def _fmt_delta(regression: dict[str, float], kpi: str) -> str:
    d = regression.get(kpi)
    if d is None:
        return ""
    arrow = "▲" if d > 0 else ("▼" if d < 0 else "=")
    return f" {arrow}{abs(d):.1f}"


def to_markdown(report: BenchmarkReport) -> str:
    lines = [
        f"# Benchmark ARTIZEN — {report.label}",
        "",
        f"**{report.total_documents} document(s)** dans le corpus.",
    ]
    if report.message:
        lines += ["", f"> {report.message}"]
        return "\n".join(lines)

    lines += [
        "",
        "## Par logiciel",
        "",
        "| Logiciel | Docs | Fidélité | Couverture | Confiance | Validation | Certifications |",
        "|---|---|---|---|---|---|---|",
    ]
    for s in report.sources:
        certs = ", ".join(f"{n}×{k}" for k, n in s.certifications.items()) or "—"
        lines.append(
            f"| {s.source} | {s.documents} "
            f"| {_fmt(s.avg_fidelity)}{_fmt_delta(s.regression, 'fidelity')} "
            f"| {_fmt(s.avg_coverage)}{_fmt_delta(s.regression, 'coverage')} "
            f"| {_fmt(s.avg_confidence)}{_fmt_delta(s.regression, 'confidence')} "
            f"| {_fmt(s.avg_validation_seconds, ' s')} | {certs} |"
        )

    regressed = [
        (s.source, kpi, d)
        for s in report.sources
        for kpi, d in s.regression.items()
        if d < 0
    ]
    if regressed:
        lines += ["", "## ⚠ Régressions", ""]
        for source, kpi, d in regressed:
            lines.append(f"- **{source}** — {kpi} : {d:.1f} pts")

    lines += ["", "## Détail par document", ""]
    for d in report.documents:
        k = d.kpis
        note = f"  _{'; '.join(d.notes)}_" if d.notes else ""
        lines.append(
            f"- `{d.source}/{d.document}` — {d.kind} {'★' * d.stars} · "
            f"fidélité {_fmt(k.fidelity)} · couverture {_fmt(k.coverage)} · "
            f"{k.certification or '—'}{note}"
        )
    return "\n".join(lines)


def to_json(report: BenchmarkReport) -> str:
    return json.dumps(asdict(report), ensure_ascii=False, indent=2)


def append_history(history: dict | None, report: BenchmarkReport) -> dict:
    """Append this run's per-source KPIs to the history — the trend record that
    shows v0.4 → v0.5 → v0.6 per software, and powers regression detection."""
    history = history or {"runs": []}
    history["runs"].append(
        {
            "label": report.label,
            "sources": {
                s.source: {
                    "fidelity": s.avg_fidelity,
                    "coverage": s.avg_coverage,
                    "confidence": s.avg_confidence,
                }
                for s in report.sources
            },
        }
    )
    return history
