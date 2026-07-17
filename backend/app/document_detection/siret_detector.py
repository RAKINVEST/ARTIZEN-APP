"""Detects a French SIRET number (14 digits) in already-extracted text.

Heuristic: look for a labeled "SIRET" occurrence first (higher
confidence), then fall back to a bare 14-digit sequence. A Luhn checksum
— the real validation algorithm for SIRET — is what separates the two
cases:

- **Labeled** ("SIRET : ..."): trusted on the label alone. The word next
  to the digits is strong evidence, and a failing checksum there is more
  likely a typo or an OCR slip than a coincidence. Luhn only raises
  confidence.
- **Bare** (14 digits, no label): trusted *only* if Luhn passes. The
  checksum is the only evidence available, and without it any 14-digit
  run qualifies — "Facture N 20240101120000" was reported as a SIRET,
  which is a plain timestamp. Nothing else on a quote is 14 digits by
  accident *and* Luhn-valid.
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


def _digits_of(match: re.Match[str]) -> str:
    return re.sub(r"\s", "", match.group(1))


_NOT_DETECTED = DetectorResult(detected=False, confidence=0.0, data={"siret": None})


class SiretDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        labeled_match = _LABELED_PATTERN.search(text)
        if labeled_match is not None:
            digits = _digits_of(labeled_match)
            confidence = 0.95 if _luhn_valid(digits) else 0.6
            return DetectorResult(detected=True, confidence=confidence, data={"siret": digits})

        # Every candidate, not just the first: a document can carry a date
        # or an invoice number before the actual SIRET, and stopping at the
        # first 14-digit run would report that instead.
        for bare_match in _BARE_PATTERN.finditer(text):
            digits = _digits_of(bare_match)
            if _luhn_valid(digits):
                return DetectorResult(detected=True, confidence=0.7, data={"siret": digits})

        return _NOT_DETECTED
