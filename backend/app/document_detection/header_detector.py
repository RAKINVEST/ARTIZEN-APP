"""Detects a header zone by checking whether the first few non-empty
lines of the already-extracted text hold enough content.

A coarse heuristic — no positional PDF data is used, only the mutualized
``extracted_text`` — but a letterhead (company name, address) reliably
shows up in the first lines of a quote/invoice, so this is a reasonable
proxy without re-parsing the PDF.
"""

from app.document_detection.interfaces import DetectorResult, TextDetector

_ZONE_LINE_COUNT = 3
_MIN_ZONE_LENGTH = 10


class HeaderDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        lines = [line.strip() for line in text.splitlines() if line.strip()]
        zone = " ".join(lines[:_ZONE_LINE_COUNT])
        detected = len(zone) >= _MIN_ZONE_LENGTH
        confidence = min(1.0, len(zone) / (_MIN_ZONE_LENGTH * 4)) if detected else 0.0
        return DetectorResult(
            detected=detected, confidence=confidence, data={"header_text": zone or None}
        )
