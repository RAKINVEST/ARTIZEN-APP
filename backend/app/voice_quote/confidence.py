"""The confidence composition and decision policy (Blueprint §5).

One place, like ``QuoteCalculator`` for money and ``SuggestionScorer`` for the
V2 match score, decides how the three signals combine and what to do with the
result. The thresholds are read from configuration (adjustment #1), never
hardcoded, so they can be recalibrated without a code change — and injected in
the constructor so tests are deterministic whatever the environment sets.
"""

from dataclasses import dataclass
from typing import Literal

from app.core.config import settings

Outcome = Literal["include", "clarify", "omit"]


@dataclass(frozen=True)
class Decision:
    outcome: Outcome
    confidence: float


class ConfidencePolicy:
    def __init__(self, *, auto: float | None = None, clarify: float | None = None) -> None:
        self._auto = settings.VOICE_CONFIDENCE_AUTO if auto is None else auto
        self._clarify = settings.VOICE_CONFIDENCE_CLARIFY if clarify is None else clarify

    @staticmethod
    def compose(*, stt: float, nlu: float, match: float) -> float:
        """Combine the per-stage confidences into the line's final score.

        A product, not an average: a line is only as trustworthy as its weakest
        link — a perfect match on a badly-heard phrase must not average out to
        "confident". Clamped to [0, 1] and rounded to 2 dp, mirroring
        ``SuggestionScorer``."""
        return round(max(0.0, min(1.0, stt * nlu * match)), 2)

    def decide(self, confidence: float) -> Decision:
        if confidence >= self._auto:
            return Decision("include", confidence)
        if confidence >= self._clarify:
            return Decision("clarify", confidence)
        return Decision("omit", confidence)
