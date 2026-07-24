"""Sprint 4 — the oracle must measure what the eye sees, not font names.

Two laws, one test each way:

* a **visually identical** render must **not** be penalised — proven with two
  metric-compatible typefaces bearing *different names* (Helvetica ↔ Liberation
  Sans have the same advance widths by design, which is exactly why they are
  interchangeable). The old name-based oracle scored this 0 %;
* a **visible** difference must still be caught — a different typeface class
  (serif) or a different size changes the rendering and must be detected.

Plus: every page must count, not only page 1.
"""

import io
import os
import re

import fitz
import pytest
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

from app.document_clone.comparator import compare_pdfs

_LIBERATION = "/usr/share/fonts/truetype/liberation"
_SANS = os.path.join(_LIBERATION, "LiberationSans-Regular.ttf")
_SERIF = os.path.join(_LIBERATION, "LiberationSerif-Regular.ttf")

_TEXT = ("Devis DEV-2026-0001", "Fourniture et pose", "Total TTC 1 410,00 EUR")


def _register(name: str, path: str) -> bool:
    if not os.path.exists(path):
        return False
    try:
        pdfmetrics.registerFont(TTFont(name, path))
    except Exception:
        return False
    return True


def _pdf(font: str, size: float = 10.0, pages: int = 1, last_page_text: tuple | None = None) -> bytes:
    """A tiny PDF drawing the same lines at the same coordinates, so the only
    variable between two fixtures is the font (or the size, or the page count)."""
    buffer = io.BytesIO()
    c = canvas.Canvas(buffer, pagesize=(400, 300))
    for page in range(pages):
        lines = _TEXT
        if last_page_text is not None and page == pages - 1:
            lines = last_page_text
        c.setFont(font, size)
        for index, line in enumerate(lines):
            c.drawString(40, 250 - index * 30, line)
        c.showPage()
    c.save()
    return buffer.getvalue()


def test_identical_render_scores_perfectly() -> None:
    """Sanity: the same bytes must be judged identical."""
    pdf = _pdf("Helvetica")
    report = compare_pdfs(pdf, pdf)

    assert report.text_recall == 100.0
    assert report.typography_score == 100.0
    assert report.overall > 99.0


def test_metric_compatible_font_with_a_different_name_is_not_penalised() -> None:
    """THE Sprint 4 law: invisible difference → no penalty.

    Helvetica and Liberation Sans share their advance widths, so the two PDFs
    look the same to a human. Only the internal font *name* differs — which the
    oracle must now ignore."""
    if not _register("LibSansTest", _SANS):
        pytest.skip("Liberation Sans not installed in this environment")

    reference = _pdf("Helvetica")
    candidate = _pdf("LibSansTest")

    report = compare_pdfs(reference, candidate)

    assert report.text_recall == 100.0, "the texts themselves must all be found"
    assert report.typography_score >= 90.0, (
        "a metric-compatible substitute renders the same and must not be "
        f"penalised (got {report.typography_score} %)"
    )


def test_a_different_typeface_is_still_detected() -> None:
    """The other law: a *visible* difference must still be caught. A serif face
    draws the same words at different widths."""
    if not _register("LibSerifTest", _SERIF):
        pytest.skip("Liberation Serif not installed in this environment")

    report = compare_pdfs(_pdf("Helvetica"), _pdf("LibSerifTest"))

    assert report.typography_score < 90.0, (
        "a genuinely different typeface changes the rendering and must be "
        f"detected (got {report.typography_score} %)"
    )


def test_a_different_size_is_still_detected() -> None:
    """Same font, bigger text: unmistakably visible, must be caught."""
    report = compare_pdfs(_pdf("Helvetica", size=10.0), _pdf("Helvetica", size=14.0))

    assert report.typography_score < 50.0


def test_every_page_is_measured_not_only_the_first() -> None:
    """U-014: page 1 alone was not representative. A document whose *last* page
    diverges must score lower than one that matches throughout."""
    reference = _pdf("Helvetica", pages=3)
    faithful = _pdf("Helvetica", pages=3)
    broken_last = _pdf(
        "Helvetica", pages=3, last_page_text=("Texte totalement different", "Autre ligne", "Encore")
    )

    assert compare_pdfs(reference, faithful).text_recall == 100.0
    degraded = compare_pdfs(reference, broken_last)
    assert degraded.text_recall < 100.0, "a divergence on page 3 must lower the score"
    assert any(gap.aspect == "texte_manquant" for gap in degraded.gaps)


def test_error_budget_decomposes_the_lost_fidelity() -> None:
    """The steering metric: a perfect document has no error budget; an imperfect
    one attributes 100 % across subsystems, and names the biggest contributor —
    which is what chooses the next sprint, by data not intuition."""
    perfect = compare_pdfs(_pdf("Helvetica"), _pdf("Helvetica"))
    assert sum(perfect.error_contributions.values()) == pytest.approx(0.0, abs=0.01)

    lossy = compare_pdfs(_pdf("Helvetica", size=10.0), _pdf("Helvetica", size=16.0))
    assert sum(lossy.error_contributions.values()) == pytest.approx(100.0, abs=0.5)
    top = max(lossy.error_contributions, key=lossy.error_contributions.get)
    assert top == "Typographie", "a pure size change is a typography loss"


# --------------------------------------------------------------- images (U-015)

def _swatch(gray: int) -> "fitz.Pixmap":
    pix = fitz.Pixmap(fitz.csRGB, fitz.IRect(0, 0, 40, 40))
    pix.clear_with(gray)
    return pix


def _image_pdf(rects: list[tuple], size: int = 200) -> bytes:
    """A PDF drawing one image at each given rect."""
    doc = fitz.open()
    page = doc.new_page(width=size, height=size)
    for rect in rects:
        page.insert_image(fitz.Rect(*rect), pixmap=_swatch(150))
    data = doc.tobytes()
    doc.close()
    return data


def _phantom_pdf(drawn_rect: tuple, phantoms: int = 2, size: int = 200) -> bytes:
    """A page that **references** ``phantoms + 1`` image resources but **draws**
    only one — the "multiple references, a single occurrence" case. Built by
    inserting several distinct images then stripping all but the first ``Do``
    operator from the content stream, so the extra XObjects linger in the page
    resources (``get_images`` sees them) while only one is painted
    (``get_image_info`` sees it)."""
    doc = fitz.open()
    page = doc.new_page(width=size, height=size)
    page.insert_image(fitz.Rect(*drawn_rect), pixmap=_swatch(150))  # the one kept
    for index in range(phantoms):
        page.insert_image(
            fitz.Rect(5 + index, 5 + index, 30 + index, 30 + index), pixmap=_swatch(60 + index * 30)
        )
    page.clean_contents()
    _, contents = doc.xref_get_key(page.xref, "Contents")
    cxref = int(contents.split()[0])
    stream = doc.xref_stream(cxref).decode("latin-1")
    seen = [0]

    def keep_first(match: "re.Match") -> str:
        seen[0] += 1
        return match.group(0) if seen[0] == 1 else ""

    doc.update_stream(cxref, re.sub(r"/\w+ Do", keep_first, stream).encode("latin-1"))
    data = doc.tobytes()
    doc.close()
    return data


def test_image_faithfully_reproduced_is_not_penalised() -> None:
    """LOI 1 — an image drawn at the same place and size scores perfectly."""
    reference = _image_pdf([(20, 20, 90, 90)])
    candidate = _image_pdf([(20, 20, 90, 90)])
    assert compare_pdfs(reference, candidate).image_score == 100.0


def test_missing_image_is_detected() -> None:
    """LOI 2 — an image present in the original but absent from the candidate
    must be caught, and reported as a gap."""
    reference = _image_pdf([(20, 20, 90, 90)])
    candidate = _image_pdf([])  # blank page

    report = compare_pdfs(reference, candidate)

    assert report.image_score < 50.0
    assert any(gap.aspect == "image" for gap in report.gaps)


def test_displaced_image_is_detected() -> None:
    """An image drawn somewhere else is not the same rendering — caught."""
    reference = _image_pdf([(20, 20, 90, 90)])
    candidate = _image_pdf([(110, 110, 180, 180)])
    assert compare_pdfs(reference, candidate).image_score < 50.0


def test_phantom_resources_are_ignored_only_drawn_images_count() -> None:
    """THE required test: multiple references, a single occurrence drawn.

    The old oracle compared ``get_images`` (the resources) and would penalise a
    faithful reproduction that draws the one real image; the new oracle compares
    what is actually drawn and scores it perfectly."""
    drawn = (20, 20, 90, 90)
    reference = _phantom_pdf(drawn, phantoms=2)  # 3 resources, 1 drawn
    candidate = _image_pdf([drawn])              # 1 resource, 1 drawn

    # The artefact really exists: resources over-count the drawings.
    doc = fitz.open(stream=reference, filetype="pdf")
    resources = len(doc[0].get_images(full=True))
    drawn_count = len(doc[0].get_image_info())
    doc.close()
    assert resources > drawn_count, "fixture must reference more images than it draws"

    # New oracle: the single drawn image matches → perfect.
    assert compare_pdfs(reference, candidate).image_score == 100.0
    # Old, count-based oracle would have failed on the same pair.
    old_style = max(0.0, 1.0 - abs(resources - 1) / max(1, resources)) * 100
    assert old_style < 100.0


def test_the_two_indicators_are_reported() -> None:
    """Structural (content in place) and perceptual (what the eye sees) are two
    readings of the same measurement."""
    pdf = _pdf("Helvetica")
    report = compare_pdfs(pdf, pdf)

    assert report.structural_fidelity == pytest.approx(100.0, abs=0.5)
    assert report.perceptual_fidelity == pytest.approx(100.0, abs=0.5)
