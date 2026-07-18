"""Per-step timing for the orchestrator.

Each pipeline step is wrapped in ``measure(step)``; the elapsed wall-clock is
recorded in milliseconds and exposed as ``timings_ms`` on the snapshot — the
in-memory equivalent of the Blueprint's ``ai_jobs.timings``. Kept trivial and
dependency-free so timing never becomes a reason a step behaves differently.
"""

import time
from contextlib import contextmanager
from typing import Iterator


class StepMetrics:
    def __init__(self) -> None:
        self._timings_ms: dict[str, float] = {}

    @contextmanager
    def measure(self, step: str) -> Iterator[None]:
        """Time a step. The measurement is taken even if the step raises, so a
        failure's cost is still visible in the timings."""
        start = time.perf_counter()
        try:
            yield
        finally:
            self._timings_ms[step] = round((time.perf_counter() - start) * 1000, 2)

    @property
    def timings_ms(self) -> dict[str, float]:
        return dict(self._timings_ms)

    @property
    def total_ms(self) -> float:
        return round(sum(self._timings_ms.values()), 2)
