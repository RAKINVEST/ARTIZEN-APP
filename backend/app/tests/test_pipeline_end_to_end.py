"""End-to-end regression guard for the whole P1 pipeline.

The unit tests exercise the renderer on hand-authored models; this one drives the
**complete** chain — ``extract`` → ``render_artizen`` → ``compare_pdfs`` — on a
realistic, two-page, multi-font *native* devis, and asserts a high fidelity.

It uses a **synthetic** source (reportlab), so it is committable and CI-able
where the real corpus (private client devis) is not: the corpus proves the engine
on reality; this proves the engine *stays* faithful, run after run, forever.
"""

import io

from PIL import Image as PILImage
from reportlab.lib.utils import ImageReader
from reportlab.pdfgen import canvas

from app.document_clone.comparator import compare_pdfs
from app.document_clone.extraction.pdf_extractor import extract
from app.document_clone.renderer import render_artizen


def _logo_png() -> io.BytesIO:
    image = PILImage.new("RGB", (80, 60), (20, 30, 120))
    buffer = io.BytesIO()
    image.save(buffer, format="PNG")
    buffer.seek(0)
    return buffer


def _synthetic_devis() -> bytes:
    """A native devis with the ingredients the P1 engine must reproduce: a
    coloured header band, an image (logo), several fonts / sizes / weights /
    colours, and two pages."""
    buffer = io.BytesIO()
    c = canvas.Canvas(buffer, pagesize=(595, 842))

    # --- Page 1
    c.setFillColorRGB(0.08, 0.055, 0.33)
    c.rect(30, 745, 535, 55, fill=1, stroke=0)  # header band
    c.drawImage(ImageReader(_logo_png()), 40, 748, 80, 45, mask="auto")
    c.setFillColorRGB(0.95, 0.79, 0.36)
    c.setFont("Helvetica-Bold", 22)
    c.drawString(430, 762, "DEVIS")

    c.setFillColorRGB(0.1, 0.1, 0.1)
    c.setFont("Helvetica", 11)
    c.drawString(40, 710, "SARL Menuiserie Dupont")
    c.setFont("Helvetica", 9)
    c.drawString(40, 694, "12 rue des Artisans, 75011 Paris")
    c.setFont("Helvetica-Bold", 10)
    c.drawString(40, 660, "Devis N DEV-2026-0001 du 27/07/2026")

    c.setFont("Times-Roman", 10)
    lines = [
        "1 - Fourniture et pose fenetre PVC ......... 850,00 EUR",
        "2 - Main d'oeuvre installation ............. 300,00 EUR",
        "3 - Deplacement et forfait chantier ........ 80,00 EUR",
    ]
    for index, line in enumerate(lines):
        c.drawString(45, 620 - index * 22, line)
    c.setFillColorRGB(0.08, 0.055, 0.33)
    c.setFont("Helvetica-Bold", 12)
    c.drawString(380, 540, "Total TTC : 1 476,00 EUR")
    c.showPage()

    # --- Page 2
    c.setFillColorRGB(0.1, 0.1, 0.1)
    c.setFont("Helvetica", 8)
    footer = [
        "Conditions generales de vente.",
        "Garantie decennale incluse. RCS Paris 123 456 789.",
        "SARL Menuiserie Dupont - SIRET 12345678900012 - TVA FR12345678901",
    ]
    for index, line in enumerate(footer):
        c.drawString(40, 780 - index * 14, line)
    c.setFont("Helvetica", 7)
    c.drawString(40, 40, "Page 2/2")
    c.save()
    return buffer.getvalue()


def test_pipeline_reproduces_a_realistic_native_devis() -> None:
    original = _synthetic_devis()

    template = extract(original)
    candidate = render_artizen(template, fields={}, rows=[])
    report = compare_pdfs(original, candidate)

    # Sanity: the fixture is substantial and multi-page.
    assert report.reference_texts >= 12
    assert len(template.graphic.pages) == 2

    # The whole chain must reproduce it faithfully.
    assert report.text_recall >= 99.0, f"every label must be reproduced ({report.text_recall})"
    assert report.page_score == 100.0, "both pages"
    assert report.categories["Structure"] >= 99.0
    assert report.categories["Typographie"] >= 90.0, f"metrics-based ({report.typography_score})"
    assert report.categories["Images"] >= 90.0, f"logo reproduced ({report.image_score})"
    assert report.overall >= 92.0, f"end-to-end fidelity floor ({report.overall})"
