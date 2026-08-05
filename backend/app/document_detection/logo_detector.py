"""Detects a logo on the first page of the PDF.

Heuristic (no vision model): the first embedded image on page 1 is a logo
candidate — *unless it covers the page*, in which case it is the document
itself (a scan or an "export as image" PDF), not a logo. Its placement and
drawn size come from the transformation matrix immediately preceding the
image's draw operator in the content stream; a page-sized draw is rejected so
the whole page never ends up stamped into the little header logo box. Any
failure degrades gracefully to "not detected" rather than raising: PDF content
streams vary too much across producers to guarantee this parses on every file,
and a wrong guess here should never break the whole detection run.
"""

import asyncio
import logging
import math
from io import BytesIO

from pypdf import PdfReader
from pypdf.generic import ContentStream

# Imported for its import-time side effect: it caps how large an image
# Pillow will decode, which is what keeps a decompression bomb from being
# expanded in full below. See the module docstring.
from app.document_detection import image_limits  # noqa: F401
from app.document_detection.interfaces import DetectorResult, VisualDetector

logger = logging.getLogger(__name__)

# A logo drawn at ≥60% of the page in *both* dimensions is treated as the page
# itself, not a logo. Chosen loose: real logos sit well under half the page,
# full-page rasters sit at ~100%, so the gap is wide.
_PAGE_COVER_RATIO = 0.6


def _first_image_placement(
    page: object,
    page_width: float,
    page_height: float,
) -> tuple[str | None, float | None, float | None]:
    """(corner, drawn_width_pt, drawn_height_pt) for the first image drawn.

    Reads the CTM (``cm``) set just before the first image operator (``Do``):
    the transformed axes give the size the image is *painted* at, in points,
    which is what tells a small logo from a full-page raster. Returns
    ``(None, None, None)`` if the content stream can't be parsed.
    """
    try:
        content_stream = ContentStream(page.get_contents(), page.pdf)  # type: ignore[attr-defined]
    except Exception:
        return None, None, None
    matrix = None
    for operands, operator in content_stream.operations:
        if operator == b"cm":
            matrix = operands
        elif operator == b"Do" and matrix is not None:
            a, b, c, d = (
                float(matrix[0]),
                float(matrix[1]),
                float(matrix[2]),
                float(matrix[3]),
            )
            e, f = float(matrix[4]), float(matrix[5])
            drawn_width = math.hypot(a, b)
            drawn_height = math.hypot(c, d)
            horizontal = "left" if e < page_width / 2 else "right"
            vertical = "top" if f > page_height / 2 else "bottom"
            return f"{vertical}_{horizontal}", drawn_width, drawn_height
    return None, None, None


def _covers_page(
    drawn_width: float | None,
    drawn_height: float | None,
    pixel_width: int,
    pixel_height: int,
    page_width: float,
    page_height: float,
) -> bool:
    """Whether the first image is effectively the whole page.

    Prefers the *drawn* size (authoritative). When the matrix couldn't be
    read, falls back to the pixel aspect ratio: a raster shaped like the page
    (a portrait full-page scan) is almost never a logo, which are wider or
    squarish.
    """
    if drawn_width is not None and drawn_height is not None:
        return (
            drawn_width >= page_width * _PAGE_COVER_RATIO
            and drawn_height >= page_height * _PAGE_COVER_RATIO
        )
    if page_height <= 0 or pixel_height <= 0:
        return False
    page_ratio = page_width / page_height
    image_ratio = pixel_width / pixel_height
    return abs(image_ratio - page_ratio) < 0.12


def extract_first_image_png(content: bytes) -> bytes | None:
    """Returns the first embedded image of page 1, re-encoded as PNG bytes.

    Same candidate the ``LogoDetector`` scores — the first image on the first
    page — but materialised so ``template_import`` can persist it as the company
    logo. Kept next to the detector on purpose: both answer "what is the logo in
    this PDF?", and the detector already owns the fragile pypdf/Pillow reading.
    Re-encoded to PNG so the stored bytes are a format the PDF renderer and
    browsers both handle, whatever exotic codec the source used. Returns
    ``None`` — a logo we can't read, or a page-sized image that is not a logo,
    is simply not imported, never a crash.
    """
    try:
        reader = PdfReader(BytesIO(content))
        if not reader.pages:
            return None
        page = reader.pages[0]
        images = page.images
        if len(images) == 0:
            return None
        image = images[0].image
        if image is None:
            return None
        # Defence in depth: never return a page-sized image as a logo, even if
        # this is called without going through the detector's gate.
        page_width = float(page.mediabox.width)
        page_height = float(page.mediabox.height)
        _, drawn_width, drawn_height = _first_image_placement(
            page, page_width, page_height
        )
        if _covers_page(
            drawn_width, drawn_height, image.width, image.height, page_width, page_height
        ):
            logger.info("logo_extractor.skipped_full_page_image")
            return None
        # PNG can't hold CMYK or palette-with-transparency cleanly; normalise
        # to a mode it always encodes rather than let .save() raise.
        if image.mode not in ("RGB", "RGBA", "L", "LA"):
            image = image.convert("RGBA")
        buffer = BytesIO()
        image.save(buffer, format="PNG")
        return buffer.getvalue()
    except Exception:
        logger.warning("logo_extractor.failed", exc_info=True)
        return None


class LogoDetector(VisualDetector):
    async def detect(self, content: bytes) -> DetectorResult:
        # pypdf parsing and Pillow decoding are synchronous and CPU-bound;
        # off the loop so one large image doesn't stall every other request.
        return await asyncio.to_thread(self._detect_sync, content)

    def _detect_sync(self, content: bytes) -> DetectorResult:
        try:
            reader = PdfReader(BytesIO(content))
            if not reader.pages:
                return DetectorResult(detected=False, confidence=0.0, data={"position": None})
            page = reader.pages[0]
            # Indexed, not list(...): only the first image is a logo
            # candidate, and materializing the sequence decodes every image
            # on the page to reach it.
            images = page.images
            if len(images) == 0:
                return DetectorResult(detected=False, confidence=0.0, data={"position": None})

            width, height = images[0].image.size
            page_width = float(page.mediabox.width)
            page_height = float(page.mediabox.height)

            position, drawn_width, drawn_height = _first_image_placement(
                page, page_width, page_height
            )

            # A page-sized image is the document itself, not a logo. Reject it
            # here so `logo_detected` (which gates the import's logo extraction)
            # stays False — otherwise the whole page is stamped into the header.
            if _covers_page(
                drawn_width, drawn_height, width, height, page_width, page_height
            ):
                return DetectorResult(
                    detected=False,
                    confidence=0.0,
                    data={"position": position, "reason": "full_page_image"},
                )

            # Size relative to the page, from the drawn points when known.
            if drawn_width is not None and drawn_height is not None:
                is_small = (
                    drawn_width < page_width * 0.5 and drawn_height < page_height * 0.35
                )
            else:
                is_small = False

            confidence = 0.55
            if is_small:
                confidence += 0.2
            if position == "top_left":
                confidence += 0.2
            confidence = min(1.0, confidence)

            return DetectorResult(
                detected=True,
                confidence=confidence,
                data={"position": position, "width": width, "height": height},
            )
        except Exception:
            logger.warning("logo_detector.failed", exc_info=True)
            return DetectorResult(detected=False, confidence=0.0, data={"position": None})
