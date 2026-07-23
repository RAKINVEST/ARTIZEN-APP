"""Corpus anonymiser — the data-hygiene step every real document passes through
**before** it is stored in the corpus.

The biggest risk of a real-PDF corpus is no longer technical, it is legal: a
devis carries names, addresses, SIRET, phones, IBAN, signatures, logos. So the
ingest pipeline is::

    PDF original  ->  Anonymiseur  ->  Corpus ARTIZEN

Handled **deterministically** here (distinctive shapes, low false-positive):
email, IBAN, French phone, SIRET/SIREN. Replaced by stable neutral tokens so the
document's *structure* — the only thing the clone engine studies — is untouched
while the personal data is gone.

Deliberately honest about its limits: **names, postal addresses, BIC and
signatures are not auto-redacted** (they need the semantic/AI pass or a human).
:data:`MANUAL_REVIEW_PII` lists them so the ingest flow flags them instead of
pretending the file is clean.
"""

import logging
import re
from dataclasses import dataclass, field

import fitz  # PyMuPDF

logger = logging.getLogger(__name__)


# Ordered by priority: earlier patterns win when two overlap (an IBAN before a
# SIREN that would nibble its digits). Each entry: (kind, regex, neutral token).
_PATTERNS: tuple[tuple[str, re.Pattern[str], str], ...] = (
    ("email", re.compile(r"\b[\w.+-]+@[\w-]+\.[\w.-]+\b"), "contact@exemple.fr"),
    ("iban", re.compile(r"\bFR\d{2}(?:\s?[0-9A-Z]){23}\b", re.I), "FR76 3000 0000 0000 0000 0000 000"),
    ("siret", re.compile(r"\b\d{3}[ .]?\d{3}[ .]?\d{3}[ .]?\d{5}\b"), "000 000 000 00000"),
    ("phone", re.compile(r"\b(?:\+33\s?|0)\d(?:[ .]?\d{2}){4}\b"), "00 00 00 00 00"),
    ("siren", re.compile(r"\b\d{3}[ .]?\d{3}[ .]?\d{3}\b"), "000 000 000"),
)

#: PII the deterministic pass cannot safely catch — surfaced for manual review
#: rather than silently missed. A regex for these would nuke brand names and
#: legitimate uppercase words; they belong to the semantic pass / a human.
MANUAL_REVIEW_PII = ("nom", "adresse", "bic", "signature")


@dataclass(frozen=True)
class AnonymizationResult:
    text: str
    #: kind -> how many were replaced. Never echoes the original PII (echoing it
    #: back would defeat the point if the result is ever logged).
    counts: dict[str, int] = field(default_factory=dict)


@dataclass(frozen=True)
class AnonymizedPdf:
    content: bytes
    counts: dict[str, int] = field(default_factory=dict)


def _scan(text: str) -> list[tuple[int, int, str, str]]:
    """Return the non-overlapping matches to redact, as (start, end, kind, token),
    resolving overlaps by pattern priority then by length."""
    raw: list[tuple[int, int, int, str, str]] = []
    for prio, (kind, rx, token) in enumerate(_PATTERNS):
        for m in rx.finditer(text):
            raw.append((m.start(), m.end(), prio, kind, token))
    raw.sort(key=lambda t: (t[0], t[2], -(t[1] - t[0])))
    chosen: list[tuple[int, int, str, str]] = []
    taken: list[tuple[int, int]] = []
    for s, e, _prio, kind, token in raw:
        if any(not (e <= os or s >= oe) for os, oe in taken):
            continue
        chosen.append((s, e, kind, token))
        taken.append((s, e))
    chosen.sort()
    return chosen


def anonymize_text(text: str) -> AnonymizationResult:
    """Replace structured PII in a plain string with neutral tokens."""
    matches = _scan(text)
    counts: dict[str, int] = {}
    out: list[str] = []
    cursor = 0
    for s, e, kind, token in matches:
        out.append(text[cursor:s])
        out.append(token)
        counts[kind] = counts.get(kind, 0) + 1
        cursor = e
    out.append(text[cursor:])
    return AnonymizationResult(text="".join(out), counts=counts)


def anonymize_pdf(content: bytes) -> AnonymizedPdf:
    """Redact structured PII from a PDF in place (native text only), keeping the
    layout intact — the matched words are blanked and the neutral token drawn in
    their place, so positions/fonts/colours the engine studies are preserved.

    Image-only pages carry no extractable text: a scan's PII lives in pixels and
    is left for the OCR/vision pass — reported, not silently passed as clean.
    """
    counts: dict[str, int] = {}
    try:
        doc = fitz.open(stream=content, filetype="pdf")
    except Exception:
        logger.warning("anonymizer.open_failed", exc_info=True)
        return AnonymizedPdf(content=content, counts=counts)

    try:
        for page in doc:
            words = page.get_text("words")  # (x0,y0,x1,y1, word, block, line, word_no)
            if not words:
                continue
            # Reconstruct the page text with each word's char range, so a match
            # found in the text maps back to the exact boxes to redact.
            full_parts: list[str] = []
            ranges: list[tuple[int, int]] = []
            pos = 0
            for w in words:
                token = w[4]
                start = pos
                full_parts.append(token)
                pos += len(token)
                ranges.append((start, pos))
                full_parts.append(" ")
                pos += 1
            full = "".join(full_parts)

            for s, e, kind, token in _scan(full):
                hit = [
                    fitz.Rect(words[i][:4])
                    for i, (ws, we) in enumerate(ranges)
                    if ws < e and we > s
                ]
                if not hit:
                    continue
                box = hit[0]
                for r in hit[1:]:
                    box |= r
                page.add_redact_annot(box, text=token, fontsize=8, align=fitz.TEXT_ALIGN_LEFT)
                counts[kind] = counts.get(kind, 0) + 1
            page.apply_redactions()

        return AnonymizedPdf(content=doc.tobytes(), counts=counts)
    finally:
        doc.close()
