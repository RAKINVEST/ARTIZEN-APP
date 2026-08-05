"""Anti-fabrication safety net for the V2 import engine.

The whole reason V2 exists is that V1 rendered a hard-coded demonstration quote
(``sample_document``) whose fictitious client, number, address and lines leaked
to real users. This module makes that class of failure *impossible to ship*: if
any known demonstration literal appears in an extraction result, we raise rather
than render. It is a defence in depth — the extractor should never produce these
— and a permanent regression guard.
"""

from app.quote_extraction.exceptions import FabricatedDataError
from app.quote_extraction.schemas import ExtractedQuote

#: The exact literals the V1 ``sample_document`` injected. Matched
#: case-insensitively against every extracted string. Extend this list, never
#: shorten it: each entry is a value that must never again reach a user.
_FORBIDDEN_LITERALS: tuple[str, ...] = (
    "client démonstration",
    "dev-2026-0001",
    "10 rue de l'exemple",
    "fourniture et pose (exemple)",
    "main-d'œuvre (exemple)",
    "main-d'oeuvre (exemple)",
)


def _iter_strings(value: object) -> list[str]:
    """Flatten every string reachable inside a (pydantic) value tree."""
    if isinstance(value, str):
        return [value]
    if isinstance(value, dict):
        out: list[str] = []
        for item in value.values():
            out.extend(_iter_strings(item))
        return out
    if isinstance(value, (list, tuple)):
        out = []
        for item in value:
            out.extend(_iter_strings(item))
        return out
    return []


def reject_fabricated_data(extracted: ExtractedQuote) -> None:
    """Raise ``FabricatedDataError`` if the extraction contains any known
    demonstration literal. Called after every extraction, before any render or
    persistence. A no-op on genuine data — which is the point."""
    haystack = _iter_strings(extracted.model_dump())
    lowered = [s.lower() for s in haystack]
    for needle in _FORBIDDEN_LITERALS:
        for text in lowered:
            if needle in text:
                raise FabricatedDataError(
                    "Extraction rejected: it contains the demonstration literal "
                    f"{needle!r}. The imported PDF is the only source of truth; "
                    "no hard-coded sample value may be rendered."
                )
