"""Centralizes how a suggestion's final confidence score is computed —
the one place this arithmetic lives, mirroring ``QuoteCalculator`` for
financial amounts (see ``quotes/calculator.py``).

The final score starts from Claude's own self-reported confidence,
discounted by:

- how many of its proposed items actually survived ``MatchValidator``
  (a response where half the proposed items turned out to be invalid is
  objectively less trustworthy than its raw confidence alone would
  suggest, even if Claude was very sure of itself);
- how many of those proposals were exact duplicates of an item already
  accepted (Étape 9: proposing the same catalog item twice in one
  response is itself a sign of an ambiguous/less clean answer, even
  when every individual item is perfectly valid).
"""

_DUPLICATE_PENALTY = 0.05


class SuggestionScorer:
    def score(
        self,
        *,
        raw_confidence: float,
        total_count: int,
        valid_count: int,
        duplicate_count: int = 0,
    ) -> float:
        if total_count == 0:
            return 0.0
        raw_confidence = max(0.0, min(1.0, raw_confidence))
        validity_ratio = valid_count / total_count
        penalty = _DUPLICATE_PENALTY * duplicate_count
        return round(max(0.0, raw_confidence * validity_ratio - penalty), 2)
