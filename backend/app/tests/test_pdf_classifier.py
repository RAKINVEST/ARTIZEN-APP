"""Tests for the ARTIZEN Document Analyzer (pdf_classifier).

Pure unit tests: bytes in, a classification out. Fixtures are built with
reportlab/Pillow (already dependencies) so a "native" PDF really carries text +
vectors and an "image" PDF really is a single raster — the exact distinction the
clone pipeline routes on.
"""

import io

from PIL import Image as PILImage
from reportlab.lib.pagesizes import A4
from reportlab.lib.utils import ImageReader
from reportlab.pdfgen import canvas
from pypdf import PdfWriter

from app.document_analysis.pdf_classifier import (
    CloneEngine,
    PdfKind,
    classify_pdf,
)


def _native_pdf() -> bytes:
    """A real export: many text runs + a filled vector rectangle."""
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=A4)
    c.setFillColorRGB(0.08, 0.05, 0.33)
    c.rect(30, 740, 535, 70, fill=1, stroke=0)  # a header band (vector)
    c.setFillColorRGB(0, 0, 0)
    text = c.beginText(40, 720)
    for i in range(1, 26):
        text.textLine(
            f"{i} - Fourniture et pose article {i}  |  Qte 1  |  PU 120,00 EUR HT  |  TVA 10%"
        )
    c.drawText(text)
    c.save()
    return buf.getvalue()


def _image_pdf() -> bytes:
    """A flattened export / scan: the whole page is one raster, no text."""
    raster = PILImage.new("RGB", (800, 1130), (10, 14, 85))
    raster_buf = io.BytesIO()
    raster.save(raster_buf, format="PNG")
    raster_buf.seek(0)
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=(800, 1130))
    c.drawImage(ImageReader(raster_buf), 0, 0, width=800, height=1130)
    c.save()
    return buf.getvalue()


def _blank_pdf() -> bytes:
    writer = PdfWriter()
    writer.add_blank_page(width=595, height=842)
    buf = io.BytesIO()
    writer.write(buf)
    return buf.getvalue()


def test_native_pdf_is_structural() -> None:
    report = classify_pdf(_native_pdf())

    assert report.kind == PdfKind.NATIVE
    assert report.engine == CloneEngine.STRUCTURAL
    assert report.has_text
    assert report.has_vectors
    assert report.stars >= 4
    assert report.estimated_fidelity >= 95


def test_flattened_image_pdf_needs_ocr() -> None:
    """The exact shape of the user's real model file: a page-sized image, no
    text — structural extraction can't touch it, OCR/vision must."""
    report = classify_pdf(_image_pdf())

    assert report.kind == PdfKind.IMAGE
    assert report.engine == CloneEngine.OCR_VISION
    assert not report.has_text
    assert report.image_coverage >= 0.9
    assert report.stars == 2


def test_blank_pdf_is_empty() -> None:
    report = classify_pdf(_blank_pdf())

    assert report.kind == PdfKind.EMPTY
    assert report.engine == CloneEngine.MANUAL
    assert report.stars == 1


def test_garbage_bytes_degrade_gracefully() -> None:
    """An unreadable upload is a report, never a crash."""
    report = classify_pdf(b"this is not a pdf")

    assert report.kind == PdfKind.EMPTY
    assert report.page_count == 0
