"""Detects dominant colors from the first embedded image on page 1.

No full-page rasterization (that would need a system-level renderer like
Poppler, a heavy addition to the Docker image) — this only inspects the
first image pypdf/Pillow already extracts, which is enough for a rough
palette without adding that dependency.
"""

import asyncio
import logging
from io import BytesIO

from pypdf import PdfReader

# Imported for its import-time side effect: it caps how large an image
# Pillow will decode. See the module docstring.
from app.document_detection import image_limits  # noqa: F401
from app.document_detection.interfaces import DetectorResult, VisualDetector

logger = logging.getLogger(__name__)

_MAX_COLORS = 3
_THUMBNAIL_SIZE = (50, 50)


class ColorDetector(VisualDetector):
    async def detect(self, content: bytes) -> DetectorResult:
        # Same reasoning as LogoDetector: pypdf + Pillow are synchronous
        # and CPU-bound, and must not run on the event loop.
        return await asyncio.to_thread(self._detect_sync, content)

    def _detect_sync(self, content: bytes) -> DetectorResult:
        try:
            reader = PdfReader(BytesIO(content))
            if not reader.pages:
                return DetectorResult(detected=False, confidence=0.0, data={"colors": []})
            # Indexed, not list(...): only the first image is sampled, and
            # materializing the sequence decodes every image on the page.
            images = reader.pages[0].images
            if len(images) == 0:
                return DetectorResult(detected=False, confidence=0.0, data={"colors": []})

            image = images[0].image.convert("RGB")
            image.thumbnail(_THUMBNAIL_SIZE)
            color_counts = image.getcolors(maxcolors=_THUMBNAIL_SIZE[0] * _THUMBNAIL_SIZE[1])
            if not color_counts:
                return DetectorResult(detected=False, confidence=0.0, data={"colors": []})

            color_counts.sort(key=lambda item: item[0], reverse=True)
            hex_colors = [
                "#{:02x}{:02x}{:02x}".format(*rgb) for _, rgb in color_counts[:_MAX_COLORS]
            ]
            return DetectorResult(detected=True, confidence=0.6, data={"colors": hex_colors})
        except Exception:
            logger.warning("color_detector.failed", exc_info=True)
            return DetectorResult(detected=False, confidence=0.0, data={"colors": []})
