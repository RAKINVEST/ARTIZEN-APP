"""Detects a footer zone by checking whether the last few non-empty
lines of the already-extracted text hold enough content.

Same heuristic as ``HeaderDetector``, applied to the tail of the
document instead of the head — legal mentions and page footers reliably
show up in the last lines of a quote/invoice.
"""

from app.document_detection.interfaces import DetectorResult, TextDetector

_ZONE_LINE_COUNT = 3
_MIN_ZONE_LENGTH = 10


class FooterDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        lines = [line.strip() for line in text.splitlines() if line.strip()]
        zone = " ".join(lines[-_ZONE_LINE_COUNT:]) if lines else ""
        detected = len(zone) >= _MIN_ZONE_LENGTH
        confidence = min(1.0, len(zone) / (_MIN_ZONE_LENGTH * 4)) if detected else 0.0
        return DetectorResult(
            detected=detected, confidence=confidence, data={"footer_text": zone or None}
        )
