"""Searches already-extracted text for common French legal-notice
keywords found on quotes and invoices (mandatory mentions, company form,
insurance, payment terms).
"""

import re

from app.document_detection.interfaces import DetectorResult, TextDetector

_KEYWORDS = [
    "conditions générales",
    "tva non applicable",
    "auto-entrepreneur",
    "rcs",
    "capital social",
    "assurance décennale",
    "garantie décennale",
    "pénalités de retard",
    "escompte",
    "sasu",
    "sarl",
    "eurl",
    "sas",
]
_PATTERNS = [
    (keyword, re.compile(rf"\b{re.escape(keyword)}\b", re.IGNORECASE)) for keyword in _KEYWORDS
]


class LegalNoticeDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        matched = [keyword for keyword, pattern in _PATTERNS if pattern.search(text)]
        detected = len(matched) > 0
        confidence = min(1.0, len(matched) / 3) if detected else 0.0
        return DetectorResult(
            detected=detected, confidence=confidence, data={"matched_keywords": matched}
        )
