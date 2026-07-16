"""Detects a French or generic EU intra-community VAT number.

The French format (``FR`` + 2-character key + 9-digit SIREN) is checked
first and gets the higher confidence, since it's a well-defined,
unambiguous pattern. A looser EU-wide pattern (2-letter country code +
alphanumeric body), restricted to a whitelist of real EU country codes,
is used as a lower-confidence fallback for non-French documents.
"""

import re

from app.document_detection.interfaces import DetectorResult, TextDetector

_FR_PATTERN = re.compile(r"\bFR\s?[0-9A-Z]{2}\s?\d{9}\b", re.IGNORECASE)
_EU_COUNTRY_CODES = {
    "AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "EL", "ES", "FI", "FR",
    "HR", "HU", "IE", "IT", "LT", "LU", "LV", "MT", "NL", "PL", "PT", "RO",
    "SE", "SI", "SK",
}
_EU_PATTERN = re.compile(r"\b([A-Z]{2})([0-9A-Z]{6,10})\b")


class VatDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        match = _FR_PATTERN.search(text)
        if match is not None:
            vat = re.sub(r"\s", "", match.group(0)).upper()
            return DetectorResult(detected=True, confidence=0.85, data={"vat_number": vat})

        for candidate in _EU_PATTERN.finditer(text):
            if candidate.group(1).upper() in _EU_COUNTRY_CODES:
                vat = candidate.group(0).upper()
                return DetectorResult(detected=True, confidence=0.5, data={"vat_number": vat})

        return DetectorResult(detected=False, confidence=0.0, data={"vat_number": None})
