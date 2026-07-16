"""Detects a French SIRET number (14 digits) in already-extracted text.

Heuristic: look for a labeled "SIRET" occurrence first (higher
confidence), then fall back to a bare 14-digit sequence. A Luhn checksum
— the real validation algorithm for SIRET — boosts confidence further
when it passes: a cheap way to make a "simple heuristic" meaningfully
more accurate without adding real complexity.
"""

import re

from app.document_detection.interfaces import DetectorResult, TextDetector

_LABELED_PATTERN = re.compile(r"SIRET\s*:?\s*(\d{3}\s?\d{3}\s?\d{3}\s?\d{5})", re.IGNORECASE)
_BARE_PATTERN = re.compile(r"\b(\d{3}\s?\d{3}\s?\d{3}\s?\d{5})\b")


def _luhn_valid(digits: str) -> bool:
    total = 0
    for index, char in enumerate(reversed(digits)):
        value = int(char)
        if index % 2 == 1:
            value *= 2
            if value > 9:
                value -= 9
        total += value
    return total % 10 == 0


class SiretDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        match = _LABELED_PATTERN.search(text)
        labeled = match is not None
        if match is None:
            match = _BARE_PATTERN.search(text)
        if match is None:
            return DetectorResult(detected=False, confidence=0.0, data={"siret": None})

        digits = re.sub(r"\s", "", match.group(1))
        confidence = 0.6 if labeled else 0.35
        if _luhn_valid(digits):
            confidence = min(1.0, confidence + 0.35)
        return DetectorResult(detected=True, confidence=confidence, data={"siret": digits})
