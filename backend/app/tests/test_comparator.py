"""Tests for the fidelity comparator (Brique 3.5).

The oracle has to be trustworthy: a PDF compared to itself is ~100 %, the same
content shifted loses on position (not on recall), and different content loses
on recall. Built with reportlab so positions/colours are controlled exactly.
"""

import io

from reportlab.lib.colors import HexColor
from reportlab.pdfgen import canvas

from app.document_clone.comparator import compare_pdfs

_W, _H = 595.0, 842.0


def _pdf(texts, fills=()) -> bytes:
    """texts: list of (string, x, y_top). fills: list of (hex, (x, y_top, w, h))."""
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=(_W, _H))
    for hexcol, (x, y, w, h) in fills:
        c.setFillColor(HexColor(hexcol))
        c.rect(x, _H - y - h, w, h, fill=1, stroke=0)
    c.setFillColorRGB(0, 0, 0)
    c.setFont("Helvetica", 10)
    for text, x, y in texts:
        c.drawString(x, _H - y - 10, text)
    c.save()
    return buf.getvalue()


_TEXTS = [
    ("ARTIZEN PLOMBERIE", 45.0, 40.0),
    ("DEVIS N DEV-2026-0007", 400.0, 30.0),
    ("Chauffe-eau ATLANTIC 150L", 40.0, 200.0),
    ("617,50", 500.0, 200.0),
]
_FILLS = [("#140E55", (30.0, 20.0, 535.0, 55.0))]


def test_identical_pdf_scores_near_100() -> None:
    a = _pdf(_TEXTS, _FILLS)

    report = compare_pdfs(a, a)

    assert report.overall >= 99.0
    assert report.text_recall == 100.0
    assert report.position_score >= 99.0
    assert report.color_score == 100.0
    assert report.shape_score == 100.0
    assert report.gaps == ()  # nothing to fix


def test_shifted_content_loses_on_position_not_recall() -> None:
    a = _pdf(_TEXTS, _FILLS)
    shifted = _pdf([(t, x + 60, y + 60) for (t, x, y) in _TEXTS], _FILLS)

    report = compare_pdfs(a, shifted)

    # Same words → full recall; moved → lower position; overall below perfect.
    assert report.text_recall == 100.0
    assert report.position_score < 95.0
    assert report.overall < compare_pdfs(a, a).overall
    # The detailed report pinpoints the displaced elements, worst first.
    position_gaps = [g for g in report.gaps if g.aspect == "position"]
    assert position_gaps
    assert position_gaps[0].delta >= 60.0


def test_different_content_loses_on_recall() -> None:
    a = _pdf(_TEXTS, _FILLS)
    other = _pdf(
        [
            ("SARL MENUISERIE DUPONT", 45.0, 40.0),
            ("FACTURE 2024-0099", 400.0, 30.0),
            ("Porte en chene massif", 40.0, 200.0),
        ]
    )

    report = compare_pdfs(a, other)

    assert report.text_recall < 40.0
    assert report.overall < 55.0
    # Every missing label is listed by name.
    assert any(g.aspect == "texte_manquant" for g in report.gaps)


def test_report_counts_texts() -> None:
    a = _pdf(_TEXTS, _FILLS)

    report = compare_pdfs(a, a)

    assert report.reference_texts == len(_TEXTS)
    assert report.matched_texts == len(_TEXTS)
