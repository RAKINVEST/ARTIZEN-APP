"""ARTIZEN Document Analyzer — classifies an uploaded PDF by how much
*structure* it carries. The first step of the documentary-clone pipeline.

A PDF is not one thing:

* **native** — a real export (Word, LibreOffice, EBP, Sage, Batappli, Mediabat…)
  carries actual text runs (with position/font/size/colour), vector shapes and
  usually embedded fonts. Everything needed to rebuild the model faithfully →
  the structural engine.
* **hybrid** — text *plus* a large image or mixed content → a mixed pipeline.
* **image** — a scan or a "flattened to image" export: a single raster where a
  structural reader finds nothing → OCR + vision.

So the engine must **first identify the nature** of the document and route it to
the right pipeline. This module answers that question **deterministically, with
no AI**, and produces a report the artisan can read at a glance (★ rating, what
was found, expected fidelity) — exactly what the POC on a real file showed is
necessary (that file turned out to be a full-page image).
"""

import logging
from dataclasses import dataclass
from enum import Enum

import fitz  # PyMuPDF

logger = logging.getLogger(__name__)


class PdfKind(str, Enum):
    NATIVE = "native"   # real text + vectors → structural extraction
    HYBRID = "hybrid"   # text + a large image / mixed
    IMAGE = "image"     # scan / flattened → OCR + vision
    EMPTY = "empty"     # unreadable / nothing to read


class CloneEngine(str, Enum):
    STRUCTURAL = "structural"
    HYBRID = "hybrid"
    OCR_VISION = "ocr_vision"
    MANUAL = "manual"


@dataclass(frozen=True)
class PdfQualityReport:
    """What we found, and what it means for cloning fidelity."""

    kind: PdfKind
    stars: int                 # 1..5, for the artisan-facing badge
    engine: CloneEngine
    estimated_fidelity: int    # %, a guide not a guarantee
    page_count: int
    text_char_count: int
    vector_count: int
    image_count: int
    embedded_font_count: int
    image_coverage: float      # largest single image's area / page area, 0..1
    has_text: bool
    has_vectors: bool
    has_embedded_fonts: bool
    has_images: bool


# Per-page character count above which a page reads as "text-rich".
_TEXT_RICH = 180
# Fraction of a page one image must cover to call the page "image-dominated".
_IMAGE_DOMINATED = 0.55
# Below this per-page character count, there is effectively no readable text.
_TEXT_FLOOR = 40


def classify_pdf(content: bytes) -> PdfQualityReport:
    """Reads the PDF's structure and returns a :class:`PdfQualityReport`.

    Never raises: an unreadable or empty file degrades to an ``EMPTY`` report
    (routed to manual setup), because "we couldn't read this one" is a valid,
    useful answer for the import flow — not a crash.
    """
    try:
        doc = fitz.open(stream=content, filetype="pdf")
    except Exception:
        logger.warning("pdf_classifier.open_failed", exc_info=True)
        return _empty_report()

    try:
        pages = doc.page_count
        if pages == 0:
            return _empty_report()

        text_chars = 0
        vector_count = 0
        image_count = 0
        embedded_fonts: set[str] = set()
        max_coverage = 0.0

        for page in doc:
            text_chars += len(page.get_text("text").strip())
            try:
                vector_count += len(page.get_drawings())
            except Exception:
                pass
            images = page.get_images(full=True)
            image_count += len(images)
            for font in page.get_fonts(full=True):
                # font[1] (ext) is non-empty when the font file is embedded.
                if font[1]:
                    embedded_fonts.add(str(font[3]))
            page_area = (page.rect.width * page.rect.height) or 1.0
            for img in images:
                try:
                    for rect in page.get_image_rects(img[0]):
                        max_coverage = max(
                            max_coverage, (rect.width * rect.height) / page_area
                        )
                except Exception:
                    pass

        avg_text = text_chars / pages
        kind, engine, stars, fidelity = _decide(
            avg_text=avg_text,
            vectors=vector_count,
            coverage=max_coverage,
            fonts=len(embedded_fonts),
        )
        return PdfQualityReport(
            kind=kind,
            stars=stars,
            engine=engine,
            estimated_fidelity=fidelity,
            page_count=pages,
            text_char_count=text_chars,
            vector_count=vector_count,
            image_count=image_count,
            embedded_font_count=len(embedded_fonts),
            image_coverage=round(max_coverage, 3),
            has_text=avg_text >= _TEXT_FLOOR,
            has_vectors=vector_count > 0,
            has_embedded_fonts=bool(embedded_fonts),
            has_images=image_count > 0,
        )
    finally:
        doc.close()


def _decide(
    *, avg_text: float, vectors: int, coverage: float, fonts: int
) -> tuple[PdfKind, CloneEngine, int, int]:
    # A scan / flattened export: a page-sized image with little or no text.
    if avg_text < _TEXT_FLOOR and coverage >= _IMAGE_DOMINATED:
        return PdfKind.IMAGE, CloneEngine.OCR_VISION, 2, 85
    # Nothing readable at all.
    if avg_text < _TEXT_FLOOR and vectors == 0:
        return PdfKind.EMPTY, CloneEngine.MANUAL, 1, 0
    # Text-rich and not image-dominated: a genuine native export.
    if avg_text >= _TEXT_RICH and coverage < _IMAGE_DOMINATED:
        if fonts > 0:
            return PdfKind.NATIVE, CloneEngine.STRUCTURAL, 5, 98
        return PdfKind.NATIVE, CloneEngine.STRUCTURAL, 4, 95
    # Otherwise: text alongside a big image, or thin text — a hybrid.
    return PdfKind.HYBRID, CloneEngine.HYBRID, 3, 90


def _empty_report() -> PdfQualityReport:
    return PdfQualityReport(
        kind=PdfKind.EMPTY,
        stars=1,
        engine=CloneEngine.MANUAL,
        estimated_fidelity=0,
        page_count=0,
        text_char_count=0,
        vector_count=0,
        image_count=0,
        embedded_font_count=0,
        image_coverage=0.0,
        has_text=False,
        has_vectors=False,
        has_embedded_fonts=False,
        has_images=False,
    )
