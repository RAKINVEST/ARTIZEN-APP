"""Retry policy — pure, deterministic. Exponential backoff + optional jitter.

Never an infinite retry: attempts are bounded. Errors are classified
retryable/non-retryable (a ``StepExecutionError`` carries the flag; anything
else is treated as non-retryable — safe by default).
"""

from dataclasses import dataclass
from random import Random

from app.orchestration.exceptions import StepExecutionError


@dataclass(frozen=True)
class RetryPolicy:
    max_attempts: int = 3
    base_delay: float = 0.0  # seconds; 0 in tests (no real sleep)
    max_delay: float = 30.0

    def is_retryable(self, error: BaseException) -> bool:
        if isinstance(error, StepExecutionError):
            return error.retryable
        return False  # unknown errors are not retried

    def delay(self, attempt: int) -> float:
        """Deterministic exponential backoff, capped. ``attempt`` is 1-based."""
        raw = self.base_delay * (2 ** max(0, attempt - 1))
        return min(raw, self.max_delay)

    def jittered_delay(self, attempt: int, rng: Random) -> float:
        """Full-ish jitter in [0.5·delay, delay]. ``rng`` is injected so tests
        stay deterministic (``random.Random(seed)``)."""
        base = self.delay(attempt)
        return base * (0.5 + 0.5 * rng.random())
