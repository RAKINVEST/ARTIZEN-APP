"""Detects contact/coordinate information: company name, address, phone,
email and website, all via regex over the already-extracted text.

Each field is independent — a document missing a phone number can still
have its email detected. ``detected``/``confidence`` are based only on
the four true "coordinate" fields (address, phone, email, website):
``company_name`` is a best-effort guess (the first meaningful text line)
that is present on essentially every document, so it would make
``detected`` trivially True even for documents with no contact
information at all — it's still reported in ``data`` for consumers who
want it, just not counted toward the confidence score.
"""

import re

from app.document_detection.interfaces import DetectorResult, TextDetector

_EMAIL_PATTERN = re.compile(r"[\w.+-]+@[\w-]+\.[\w.-]+")
_PHONE_PATTERN = re.compile(r"(?:\+33|0)\s?[1-9](?:[\s.-]?\d{2}){4}")
_WEBSITE_PATTERN = re.compile(
    r"\b(?:https?://)?(?:www\.)?[a-z0-9-]+\.[a-z]{2,}(?:/[^\s]*)?\b", re.IGNORECASE
)
_POSTAL_ADDRESS_PATTERN = re.compile(r"[^\n]*\b\d{5}\s+[A-ZÀ-Ü][A-Za-zÀ-ÿ\-\s]{1,40}")


def _guess_company_name(text: str) -> str | None:
    for line in text.splitlines():
        candidate = line.strip()
        if len(candidate) >= 3 and not candidate.isdigit():
            return candidate
    return None


def _normalize_phone(raw: str) -> str:
    return re.sub(r"[\s.-]", "", raw)


def _find_website(text: str, email_match: re.Match[str] | None) -> str | None:
    for match in _WEBSITE_PATTERN.finditer(text):
        value = match.group(0)
        if "@" in value:
            continue
        if email_match is not None and value in email_match.group(0):
            continue
        return value
    return None


class ContactDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        email_match = _EMAIL_PATTERN.search(text)
        phone_match = _PHONE_PATTERN.search(text)
        address_match = _POSTAL_ADDRESS_PATTERN.search(text)

        coordinates = {
            "address": address_match.group(0).strip() if address_match else None,
            "phone": _normalize_phone(phone_match.group(0)) if phone_match else None,
            "email": email_match.group(0) if email_match else None,
            "website": _find_website(text, email_match),
        }
        found_count = sum(1 for value in coordinates.values() if value)
        detected = found_count > 0
        confidence = min(1.0, found_count / 4) if detected else 0.0

        data = {"company_name": _guess_company_name(text), **coordinates}
        return DetectorResult(detected=detected, confidence=confidence, data=data)
