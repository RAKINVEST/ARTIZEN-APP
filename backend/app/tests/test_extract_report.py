"""Tests for the Extract Report Engine.

Coverage is the second KPI (beside fidelity): "what share of the document did we
recognise?". These pin the coverage arithmetic — detected raises it,
*confirmed-absent* leaves the denominator, *unknown* stays in it — and that the
plain-text account reads like the report the artisan/support desk sees.
"""

from app.document_analysis.pdf_classifier import CloneEngine, PdfKind, PdfQualityReport
from app.document_clone.artizen_format import DocumentType, SectionPresence
from app.document_clone.extract_report import (
    ElementStatus,
    build_extraction_report,
    format_report,
)


def _native_quality() -> PdfQualityReport:
    return PdfQualityReport(
        kind=PdfKind.NATIVE,
        stars=5,
        engine=CloneEngine.STRUCTURAL,
        estimated_fidelity=98,
        page_count=2,
        text_char_count=1800,
        vector_count=12,
        image_count=1,
        embedded_font_count=2,
        image_coverage=0.05,
        has_text=True,
        has_vectors=True,
        has_embedded_fonts=True,
        has_images=True,
    )


def _all_recognised() -> SectionPresence:
    return SectionPresence(
        logo=True, company=True, client=True, worksite=True, table=True,
        vat=True, totals=True, deposit=True, signature=True, legal=True, footer=True,
    )


def test_full_recognition_is_full_coverage() -> None:
    report = build_extraction_report(
        document="devis_batappli_001.pdf",
        document_type=DocumentType.DEVIS,
        quality=_native_quality(),
        sections=_all_recognised(),
        columns=["Description", "Qté", "PU", "TVA", "Montant"],
    )

    assert report.coverage == 100.0
    # extraction_score falls back to the analyzer's estimated fidelity for now.
    assert report.extraction_score == 98.0
    cols = next(e for e in report.elements if e.name == "Colonnes")
    assert cols.status is ElementStatus.DETECTED
    assert "Description" in cols.detail


def test_unknown_sections_lower_coverage_but_stay_in_denominator() -> None:
    # Nothing recognised → every element UNKNOWN → 0 % coverage over all 12.
    report = build_extraction_report(
        document="mystere.pdf",
        document_type=DocumentType.DEVIS,
        quality=_native_quality(),
        sections=SectionPresence(),
    )

    assert report.coverage == 0.0
    assert all(e.status is ElementStatus.UNKNOWN for e in report.elements)


def test_confirmed_absent_leaves_the_denominator() -> None:
    sections = _all_recognised()
    report = build_extraction_report(
        document="sans_signature.pdf",
        document_type=DocumentType.DEVIS,
        quality=_native_quality(),
        sections=sections,
        columns=["Description", "Montant"],
        # The extractor *confirmed* there is no signature / worksite here.
        statuses={
            "Signature": ElementStatus.ABSENT,
            "Adresse chantier": ElementStatus.ABSENT,
        },
    )

    # 12 elements, 2 confirmed-absent (N/A), 10 detected → 10/10 applicable.
    assert report.coverage == 100.0
    absents = [e.name for e in report.elements if e.status is ElementStatus.ABSENT]
    assert set(absents) == {"Signature", "Adresse chantier"}


def test_confidence_is_the_third_kpi_and_flags_what_needs_review() -> None:
    report = build_extraction_report(
        document="devis_batappli_001.pdf",
        document_type=DocumentType.DEVIS,
        quality=_native_quality(),
        sections=_all_recognised(),
        columns=["Description", "Montant"],
        confidences={
            "Logo": 99.0, "Entreprise": 98.0, "Client": 97.0, "TVA": 100.0,
            "Signature": 43.0,  # detected but the engine is unsure
        },
    )

    # A low-confidence DETECTED element and every UNKNOWN want a human check;
    # a high-confidence one does not — Studio surfaces only the doubtful.
    to_review = {e.name for e in report.needs_review()}
    assert "Signature" in to_review
    assert "Logo" not in to_review
    assert report.average_confidence is not None
    sig = next(e for e in report.elements if e.name == "Signature")
    assert sig.confidence == 43.0


def test_format_report_reads_like_the_support_account() -> None:
    report = build_extraction_report(
        document="devis_ebp_007.pdf",
        document_type=DocumentType.DEVIS,
        quality=_native_quality(),
        sections=SectionPresence(logo=True, company=True, client=True, table=True, totals=True),
        columns=["Désignation", "Qté", "PU HT", "Montant HT"],
        statuses={"Signature": ElementStatus.ABSENT},
    )

    text = format_report(report)

    assert "Document : devis_ebp_007.pdf" in text
    assert "PDF natif (★★★★★)" in text
    assert "✓ détecté" in text          # a recognised section
    assert "⚠ absent" in text           # the signature
    assert "Désignation" in text        # the columns detail
    assert "Couverture" in text
    assert "Score extraction" in text
