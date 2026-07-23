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

import hashlib
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
    """The KPIs for one document (``None`` = not measurable yet)."""

    fidelity: float | None = None
    coverage: float | None = None
    confidence: float | None = None
    validation_seconds: float | None = None
    corrections: int | None = None
    #: inter-annotator agreement (Gold A vs Gold B) — the reference's credibility.
    agreement: float | None = None
    certification: str | None = None


@dataclass
class DocResult:
    source: str
    document: str
    kind: str
    stars: int
    kpis: DocKpis
    #: sha256 of the original PDF bytes — pins the exact input for Replay.
    content_hash: str = ""
    notes: list[str] = field(default_factory=list)


@dataclass
class SourceSummary:
    source: str
    documents: int
    avg_fidelity: float | None
    avg_coverage: float | None
    avg_confidence: float | None
    avg_validation_seconds: float | None
    #: % of measured documents that needed **zero** correction — the R&D KPI.
    auto_pass: float | None
    #: mean inter-annotator agreement — how credible this source's references are.
    avg_agreement: float | None
    certifications: dict[str, int]
    #: kpi -> delta vs the previous run for this source (+ = improved).
    regression: dict[str, float]


@dataclass
class BenchmarkReport:
    label: str
    total_documents: int
    sources: list[SourceSummary]
    documents: list[DocResult]
    #: monotonic run number (Run #48) and the fingerprint of the results.
    run: int = 0
    #: sha256 over (input hash + KPI scores) of every document — two runs over
    #: identical inputs and code produce the SAME fingerprint. That equality is
    #: the Replay guarantee: "Run #48 → exactly the same results".
    fingerprint: str = ""
    message: str = ""


def _iter_documents(corpus_dir: Path):
    """Yield ``(source, pdf_path)`` for every original PDF in the corpus —
    skipping the ``.expected.pdf`` renders and the output directory."""
    for source_dir in sorted(p for p in corpus_dir.iterdir() if p.is_dir()):
        if source_dir.name == _OUTPUT_DIRNAME or source_dir.name.startswith("_"):
            continue
        for pdf in sorted(source_dir.glob("*.pdf")):
            if pdf.name.endswith(_EXPECTED_SUFFIX):
                continue
            yield source_dir.name, pdf


def _load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def _evaluate(source: str, pdf_path: Path) -> DocResult:
    content = pdf_path.read_bytes()
    content_hash = hashlib.sha256(content).hexdigest()[:16]
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

                # 6th KPI: if a second, independent Gold exists, measure agreement.
                b_tpl = pdf_path.with_name(radical + ".gold-b.artizen.json")
                b_data = pdf_path.with_name(radical + ".gold-b.data.json")
                if b_tpl.exists() and b_data.exists():
                    template_b = ArtizenTemplate.model_validate_json(
                        b_tpl.read_text(encoding="utf-8")
                    )
                    data_b = _load_json(b_data)
                    rendered_b = render_artizen(
                        template_b, fields=data_b.get("fields", {}), rows=data_b.get("rows", [])
                    )
                    kpis.agreement = compare_pdfs(rendered, rendered_b).overall
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
        content_hash=content_hash,
        notes=notes,
    )


def _fingerprint(documents: list[DocResult]) -> str:
    """A stable digest of (input hash + KPI scores) per document — identical
    across runs iff the inputs and the engine are identical. Gap *ordering* and
    read order are deliberately excluded: only what must be reproducible counts."""
    payload = sorted(
        (
            {
                "id": f"{d.source}/{d.document}",
                "hash": d.content_hash,
                "fidelity": d.kpis.fidelity,
                "coverage": d.kpis.coverage,
                "confidence": d.kpis.confidence,
                "agreement": d.kpis.agreement,
                "certification": d.kpis.certification,
            }
            for d in documents
        ),
        key=lambda e: e["id"],
    )
    blob = json.dumps(payload, sort_keys=True, ensure_ascii=False)
    return hashlib.sha256(blob.encode("utf-8")).hexdigest()[:12]


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

        corrected = [d.kpis.corrections for d in docs if d.kpis.corrections is not None]
        auto_pass = (
            round(100 * sum(1 for c in corrected if c == 0) / len(corrected), 1)
            if corrected
            else None
        )

        summaries.append(
            SourceSummary(
                source=source,
                documents=len(docs),
                avg_fidelity=avg["fidelity"],
                avg_coverage=avg["coverage"],
                avg_confidence=avg["confidence"],
                avg_validation_seconds=_mean([d.kpis.validation_seconds for d in docs]),
                auto_pass=auto_pass,
                avg_agreement=_mean([d.kpis.agreement for d in docs]),
                certifications=certs,
                regression=regression,
            )
        )
    return summaries


def _last_run_by_source(history: dict | None) -> dict[str, dict]:
    if not history or not history.get("runs"):
        return {}
    return history["runs"][-1].get("sources", {})


def _next_run_number(history: dict | None) -> int:
    if not history or not history.get("runs"):
        return 1
    return int(history["runs"][-1].get("run", len(history["runs"]))) + 1


def _certified_ids(corpus_dir: Path) -> set[str]:
    from app.document_clone.ingest import load_manifest  # local: avoid import cycle risk

    manifest = load_manifest(corpus_dir)
    return {d["id"] for d in manifest.get("documents", []) if d.get("gold_status") == "certified"}


def run_benchmark(
    corpus_dir: Path,
    *,
    label: str = "dev",
    history: dict | None = None,
    official_only: bool = False,
) -> BenchmarkReport:
    """Run the full measurable chain over the corpus and build the report.

    Deterministic by construction: no clock, no randomness, pure render/compare —
    so re-running over the same corpus yields the same :attr:`fingerprint`.

    ``official_only`` restricts the run to **certified** references (per the
    manifest) — the only documents allowed in an official benchmark."""
    allowed = _certified_ids(corpus_dir) if official_only else None
    documents = [
        _evaluate(source, pdf)
        for source, pdf in _iter_documents(corpus_dir)
        if allowed is None or pdf.name[: -len(".pdf")] in allowed
    ]
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
        run=_next_run_number(history),
        fingerprint=_fingerprint(documents),
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
        f"**Run #{report.run}** · empreinte `{report.fingerprint}` · "
        f"{report.total_documents} document(s).",
    ]
    if report.message:
        lines += ["", f"> {report.message}"]
        return "\n".join(lines)

    lines += [
        "",
        "## Par logiciel",
        "",
        "| Logiciel | Docs | Fidélité | Couverture | Confiance | Accord A/B | Validation | Auto-pass | Certifications |",
        "|---|---|---|---|---|---|---|---|---|",
    ]
    for s in report.sources:
        certs = ", ".join(f"{n}×{k}" for k, n in s.certifications.items()) or "—"
        lines.append(
            f"| {s.source} | {s.documents} "
            f"| {_fmt(s.avg_fidelity)}{_fmt_delta(s.regression, 'fidelity')} "
            f"| {_fmt(s.avg_coverage)}{_fmt_delta(s.regression, 'coverage')} "
            f"| {_fmt(s.avg_confidence)}{_fmt_delta(s.regression, 'confidence')} "
            f"| {_fmt(s.avg_agreement)} "
            f"| {_fmt(s.avg_validation_seconds, ' s')} | {_fmt(s.auto_pass)} | {certs} |"
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
            "run": report.run,
            "label": report.label,
            "fingerprint": report.fingerprint,
            "sources": {
                s.source: {
                    "fidelity": s.avg_fidelity,
                    "coverage": s.avg_coverage,
                    "confidence": s.avg_confidence,
                    "auto_pass": s.auto_pass,
                }
                for s in report.sources
            },
        }
    )
    return history


#: A source may not lose more than this many points of fidelity between runs.
#: Empirical, provisional — to be recalibrated once real data exists.
_MAX_FAMILY_DROP = 0.5


def regression_gate(
    history: dict | None, report: BenchmarkReport, *, max_drop: float = _MAX_FAMILY_DROP
) -> tuple[bool, list[tuple[str, float]]]:
    """Governance gate for the R&D loop: a new heuristic must not sink any family
    beyond ``max_drop`` points of fidelity versus the previous run. One that lifts
    Batappli but drops EBP is **not** automatically acceptable — this is how a
    generic engine avoids rotting into a pile of special cases. Returns
    ``(passed, [(source, delta), …])``."""
    previous = _last_run_by_source(history)
    offenders = [
        (s.source, round(s.avg_fidelity - previous[s.source]["fidelity"], 2))
        for s in report.sources
        if previous.get(s.source, {}).get("fidelity") is not None
        and s.avg_fidelity is not None
        and (s.avg_fidelity - previous[s.source]["fidelity"]) < -max_drop
    ]
    return (not offenders), offenders


#: The measurable criteria that end Phase R&D — when all are met, Brique 4 goes
#: from R&D to Production. Empirical targets, revisable as an amendment.
def _agg(sources: list[SourceSummary], attr: str) -> float | None:
    vals = [getattr(s, attr) for s in sources if getattr(s, attr) is not None]
    return round(statistics.fmean(vals), 1) if vals else None


def _stable_over_three_runs(history: dict | None) -> bool | None:
    runs = (history or {}).get("runs", [])
    if len(runs) < 3:
        return None  # not enough history to judge stability yet
    for before, after in zip(runs[-3:], runs[-3:][1:]):
        for src, cur in after.get("sources", {}).items():
            prev = before.get("sources", {}).get(src, {}).get("fidelity")
            now = cur.get("fidelity")
            if prev is not None and now is not None and now < prev - _MAX_FAMILY_DROP:
                return False
    return True


def phase_rd_status(
    report: BenchmarkReport, history: dict | None = None, manifest: dict | None = None
) -> list[dict]:
    """The Phase R&D scorecard: each exit criterion as met / failed / pending
    (pending = no data yet). This makes "when does R&D end?" measurable, not an
    opinion — the answer comes from the corpus, not the meeting room."""
    docs = (manifest or {}).get("documents", [])
    certified = sum(1 for d in docs if d.get("gold_status") == "certified")
    families = {d.get("layout_family") for d in docs if d.get("layout_family")}
    fid, cov = _agg(report.sources, "avg_fidelity"), _agg(report.sources, "avg_coverage")
    ap, val = _agg(report.sources, "auto_pass"), _agg(report.sources, "avg_validation_seconds")
    stable = _stable_over_three_runs(history)

    def crit(name: str, ok: bool | None, detail: str) -> dict:
        status = "pending" if ok is None else ("met" if ok else "failed")
        return {"criterion": name, "status": status, "detail": detail}

    return [
        crit("Starter Corpus (≥ 5 docs)", (len(docs) >= 5) if docs else None,
             f"{len(docs)} docs, {len(families)} familles"),
        crit("50 références certifiées", (certified >= 50) if docs else None, f"{certified}/50"),
        crit("Fidélité moyenne ≥ 99 %", (fid >= 99) if fid is not None else None, _fmt(fid)),
        crit("Couverture ≥ 95 %", (cov >= 95) if cov is not None else None, _fmt(cov)),
        crit("Auto-pass ≥ 90 %", (ap >= 90) if ap is not None else None, _fmt(ap)),
        crit("Validation ≤ 20 s", (val <= 20) if val is not None else None, _fmt(val, " s")),
        crit("0 régression sur 3 versions", stable,
             "≥ 3 runs requis" if stable is None else ("stable" if stable else "régression détectée")),
    ]


def format_phase_status(status: list[dict]) -> str:
    glyph = {"met": "✓", "failed": "✗", "pending": "·"}
    lines = ["Phase R&D — critères de sortie vers Production :", ""]
    for c in status:
        lines.append(f"  {glyph[c['status']]} {c['criterion']:<28} {c['detail']}")
    remaining = sum(1 for c in status if c["status"] != "met")
    lines += ["", f"{remaining} critère(s) restant(s) avant le statut Production." if remaining
              else "Tous les critères atteints → Brique 4 prête pour la Production."]
    return "\n".join(lines)


def verify_replay(history: dict | None, report: BenchmarkReport) -> tuple[bool, str]:
    """Replay check: does this fresh run reproduce a recorded one exactly? Matches
    by fingerprint against the most recent stored run — the unambiguous answer to
    "did anything change since run #N?"."""
    runs = (history or {}).get("runs", [])
    if not runs:
        return False, "Aucun run enregistré — rien à rejouer."
    last = runs[-1]
    if last.get("fingerprint") == report.fingerprint:
        return True, f"Reproduit à l'identique le run #{last.get('run')} ({report.fingerprint})."
    return False, (
        f"Divergence vs run #{last.get('run')} : "
        f"{last.get('fingerprint')} → {report.fingerprint}."
    )
