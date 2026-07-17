"""Detects a logo on the first page of the PDF.

Heuristic (no vision model): the first embedded image on page 1 is
treated as a logo candidate. Its placement — via the transformation
matrix immediately preceding the image's draw operator in the content
stream — and its size relative to the page feed a rough corner estimate
and a confidence score. Any failure degrades gracefully to "not
detected" rather than raising: PDF content streams vary too much across
producers to guarantee this parses on every file, and a wrong guess here
should never break the whole detection run.
"""

import asyncio
import logging
from io import BytesIO

from pypdf import PdfReader
from pypdf.generic import ContentStream

from app.document_detection.interfaces import DetectorResult, VisualDetector

# Imported for its import-time side effect: it caps how large an image
# Pillow will decode, which is what keeps a decompression bomb from being
# expanded in full below. See the module docstring.
from app.document_detection import image_limits  # noqa: F401

logger = logging.getLogger(__name__)


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

            position = self._estimate_position(page, page_width, page_height)
            is_small = width < page_width * 0.5 and height < page_height * 0.35
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

    @staticmethod
    def _estimate_position(page: object, page_width: float, page_height: float) -> str | None:
        try:
            content_stream = ContentStream(page.get_contents(), page.pdf)  # type: ignore[attr-defined]
        except Exception:
            return None
        matrix = None
        for operands, operator in content_stream.operations:
            if operator == b"cm":
                matrix = operands
            elif operator == b"Do" and matrix is not None:
                e, f = float(matrix[4]), float(matrix[5])
                horizontal = "left" if e < page_width / 2 else "right"
                vertical = "top" if f > page_height / 2 else "bottom"
                return f"{vertical}_{horizontal}"
        return None
