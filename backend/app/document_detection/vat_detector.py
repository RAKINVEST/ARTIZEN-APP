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
# Body up to 12 characters so the longest real formats (e.g. NL's
# "123456789B01") match; the digit floor below is what keeps that widening
# from re-admitting ordinary words.
_EU_PATTERN = re.compile(r"\b([A-Z]{2})([0-9A-Z]{6,12})\b")

# Every real EU VAT body is mostly digits — the shortest (Ireland) still has
# 7. Requiring them is what separates a VAT number from an ordinary
# uppercase French word, which the country-code check alone does not:
# "DESIGNATION" is DE + SIGNATION, "PLOMBERIE" is PL + OMBERIE, and
# DESIGNATION is the standard column header of essentially every French
# quote — so the fallback used to report a VAT number on almost any
# document, and the artisan could then validate it into Company.vat_number.
_MIN_EU_VAT_DIGITS = 6


class VatDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        match = _FR_PATTERN.search(text)
        if match is not None:
            vat = re.sub(r"\s", "", match.group(0)).upper()
            return DetectorResult(detected=True, confidence=0.85, data={"vat_number": vat})

        for candidate in _EU_PATTERN.finditer(text):
            country_code, body = candidate.group(1).upper(), candidate.group(2).upper()
            if country_code not in _EU_COUNTRY_CODES:
                continue
            if sum(char.isdigit() for char in body) < _MIN_EU_VAT_DIGITS:
                continue
            return DetectorResult(
                detected=True, confidence=0.5, data={"vat_number": country_code + body}
            )

        return DetectorResult(detected=False, confidence=0.0, data={"vat_number": None})
