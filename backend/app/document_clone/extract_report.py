"""The Extract Report Engine — the honest, human-readable account of what the
import pipeline understood of a document, and *how completely*.

Where the fidelity comparator answers **"is what we reproduced faithful?"**,
this report answers the second, equally decisive question:
**"what proportion of the document did ARTIZEN actually recognise?"** — the
*coverage*. A clone can be 99.8 % faithful on the fifth of the document it
understood and still miss the signature block, the worksite address and the
legal mentions. Fidelity and coverage are two axes; a mature engine grows both.

The report is deliberately generic (it works for a devis, a facture, an avoir…)
and **pure**: it takes already-computed inputs — the analyzer's
:class:`PdfQualityReport`, the recognised :class:`SectionPresence`, the extracted
column labels — and turns them into a structured, serialisable report plus a
plain-text rendering. Wiring it to the real detectors is the extraction layer's
job (Brique 4), exactly like the renderer stays free of "quote".
"""

from collections.abc import Sequence
from dataclasses import dataclass
from enum import Enum

from pydantic import BaseModel, Field, computed_field

from app.document_analysis.pdf_classifier import CloneEngine, PdfKind, PdfQualityReport
from app.document_clone.artizen_format import DocumentType, SectionPresence


class ElementStatus(str, Enum):
    """The three honest outcomes for one expected element."""

    DETECTED = "detected"  # ✓ found and extracted
    ABSENT = "absent"      # ⚠ confirmed not present in this document (N/A)
    UNKNOWN = "unknown"    # ⚠ could not be determined yet


class ReportElement(BaseModel):
    name: str                       # "Logo", "Entreprise", "Tableau"…
    status: ElementStatus
    detail: str = ""                # e.g. the column labels for "Colonnes"
    #: 0..100 — how *sure* the engine is of this element (the 3rd KPI). ``None``
    #: until extraction can measure it; a low value on a DETECTED element is the
    #: signal Template Studio uses to ask for a human check.
    confidence: float | None = None


@dataclass(frozen=True)
class _ElementSpec:
    """One line of the per-document-type checklist. ``section`` is the attribute
    to read on :class:`SectionPresence`, or ``None`` for elements resolved
    another way (e.g. the table columns)."""

    name: str
    section: str | None


#: The reference checklist per document type — it *defines* the coverage
#: denominator: coverage measures recognition against this catalogue. Every name
#: except "Colonnes" maps onto an existing :class:`SectionPresence` flag.
_DEVIS_SPEC: tuple[_ElementSpec, ...] = (
    _ElementSpec("Logo", "logo"),
    _ElementSpec("Entreprise", "company"),
    _ElementSpec("Client", "client"),
    _ElementSpec("Adresse chantier", "worksite"),
    _ElementSpec("Tableau", "table"),
    _ElementSpec("Colonnes", None),
    _ElementSpec("TVA", "vat"),
    _ElementSpec("Totaux", "totals"),
    _ElementSpec("Acompte", "deposit"),
    _ElementSpec("Signature", "signature"),
    _ElementSpec("Mentions légales", "legal"),
    _ElementSpec("Pied de page", "footer"),
)

#: Factures/avoirs share the devis anatomy today; only the business rules differ,
#: so they reuse the same checklist until a type earns its own.
_SPECS: dict[DocumentType, tuple[_ElementSpec, ...]] = {
    DocumentType.DEVIS: _DEVIS_SPEC,
    DocumentType.FACTURE: _DEVIS_SPEC,
    DocumentType.AVOIR: _DEVIS_SPEC,
}

#: A DETECTED element below this confidence still wants a human's eyes.
_REVIEW_THRESHOLD = 90.0


class ExtractionReport(BaseModel):
    """What the pipeline understood of one document — the artefact the artisan,
    the support desk and the extraction dev loop all read."""

    document: str
    document_type: DocumentType
    kind: PdfKind
    engine: CloneEngine
    stars: int
    page_count: int
    elements: list[ReportElement] = Field(default_factory=list)
    #: 0..100 — the quality of what *was* extracted. Until Brique 4 emits real
    #: per-element confidence, it carries the analyzer's estimated fidelity.
    extraction_score: float = 0.0

    @computed_field  # type: ignore[prop-decorator]
    @property
    def coverage(self) -> float:
        """Share of the *applicable* elements the engine recognised. Confirmed-
        absent elements leave the denominator (they are genuinely N/A); elements
        still ``UNKNOWN`` stay in it — resolving them is the work that remains."""
        total = len(self.elements)
        absent = sum(1 for e in self.elements if e.status is ElementStatus.ABSENT)
        detected = sum(1 for e in self.elements if e.status is ElementStatus.DETECTED)
        applicable = total - absent
        return round(100 * detected / applicable, 1) if applicable else 100.0

    @computed_field  # type: ignore[prop-decorator]
    @property
    def average_confidence(self) -> float | None:
        """Mean confidence over the elements that carry one — the 3rd KPI at
        document level. ``None`` while nothing has been measured yet."""
        scored = [e.confidence for e in self.elements if e.confidence is not None]
        return round(sum(scored) / len(scored), 1) if scored else None

    def needs_review(self, threshold: float = _REVIEW_THRESHOLD) -> list[ReportElement]:
        """The elements a human should validate: everything still ``UNKNOWN``,
        plus anything ``DETECTED`` the engine isn't confident about. This is what
        Template Studio surfaces — only the doubtful, never the whole document."""
        return [
            e
            for e in self.elements
            if e.status is ElementStatus.UNKNOWN
            or (
                e.status is ElementStatus.DETECTED
                and e.confidence is not None
                and e.confidence < threshold
            )
        ]


def build_extraction_report(
    *,
    document: str,
    document_type: DocumentType,
    quality: PdfQualityReport,
    sections: SectionPresence,
    columns: Sequence[str] = (),
    statuses: dict[str, ElementStatus] | None = None,
    confidences: dict[str, float] | None = None,
    extraction_score: float | None = None,
) -> ExtractionReport:
    """Assemble the report from what the pipeline already computed.

    ``statuses`` lets a caller (Brique 4, once it can *confirm* absence) override
    any element; without it, a section flag that is ``False`` reads as
    ``UNKNOWN`` — the honest default, because "we didn't recognise it" is not the
    same claim as "it isn't there". ``confidences`` (element name → 0..100) is the
    3rd KPI, filled once extraction can measure per-element certainty.
    """
    overrides = statuses or {}
    scores = confidences or {}
    spec = _SPECS.get(document_type, _DEVIS_SPEC)
    elements: list[ReportElement] = []
    for item in spec:
        detail = ""
        if item.name in overrides:
            status = overrides[item.name]
        elif item.section is not None:
            present = bool(getattr(sections, item.section, False))
            status = ElementStatus.DETECTED if present else ElementStatus.UNKNOWN
        elif item.name == "Colonnes":
            status = ElementStatus.DETECTED if columns else ElementStatus.UNKNOWN
            detail = " · ".join(columns)
        else:
            status = ElementStatus.UNKNOWN
        elements.append(
            ReportElement(
                name=item.name,
                status=status,
                detail=detail,
                confidence=scores.get(item.name),
            )
        )

    return ExtractionReport(
        document=document,
        document_type=document_type,
        kind=quality.kind,
        engine=quality.engine,
        stars=quality.stars,
        page_count=quality.page_count,
        elements=elements,
        extraction_score=(
            float(quality.estimated_fidelity)
            if extraction_score is None
            else round(extraction_score, 1)
        ),
    )


_KIND_LABEL = {
    PdfKind.NATIVE: "PDF natif",
    PdfKind.HYBRID: "PDF hybride (texte + image)",
    PdfKind.IMAGE: "PDF image / scan",
    PdfKind.EMPTY: "illisible",
}
_STATUS_LABEL = {
    ElementStatus.DETECTED: "✓ détecté",
    ElementStatus.ABSENT: "⚠ absent",
    ElementStatus.UNKNOWN: "⚠ inconnu",
}


def format_report(report: ExtractionReport) -> str:
    """Render the report as the plain-text block the artisan/support desk reads —
    the "✓ Logo détecté / ⚠ Signature absente" account, in French."""
    stars = "★" * report.stars + "☆" * (5 - report.stars)
    lines = [
        f"Document : {report.document}",
        f"Type     : {_KIND_LABEL.get(report.kind, report.kind.value)} ({stars})",
        f"Pages    : {report.page_count}",
        "",
    ]
    review = set(id(e) for e in report.needs_review())
    pad = max((len(e.name) for e in report.elements), default=0)
    for e in report.elements:
        value = e.detail if (e.status is ElementStatus.DETECTED and e.detail) else _STATUS_LABEL[e.status]
        if e.confidence is not None:
            value = f"{value}  ({e.confidence:.0f} %)"
        if id(e) in review:
            value = f"{value}  ← à valider"
        lines.append(f"{e.name.ljust(pad)} : {value}")

    detected = sum(1 for e in report.elements if e.status is ElementStatus.DETECTED)
    applicable = len(report.elements) - sum(
        1 for e in report.elements if e.status is ElementStatus.ABSENT
    )
    lines += [
        "",
        f"{'Couverture'.ljust(pad)} : {report.coverage:.0f} % ({detected}/{applicable} éléments)",
        f"{'Score extraction'.ljust(pad)} : {report.extraction_score:.1f} %",
    ]
    if report.average_confidence is not None:
        lines.append(f"{'Confiance moyenne'.ljust(pad)} : {report.average_confidence:.1f} %")
    return "\n".join(lines)
