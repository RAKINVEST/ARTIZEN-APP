"""Saga coordinator — the deterministic heart of the Orchestration Engine.

Runs an :class:`ExecutionPlan` over injected step *handlers* (the owning
engines' public services), applying retry (bounded) and compensation (reverse
order, via the owning engines — never a hard delete). It performs no DB IO
itself: handlers are injected, so it is fully unit-testable with fakes. Given
deterministic handlers, the emitted event sequence is deterministic.

Events: step_started, step_completed, step_failed, retry_requested,
retry_succeeded, retry_failed, compensation_started, compensation_completed,
compensation_failed, orchestration_completed, orchestration_failed.
"""

import asyncio
from collections.abc import Awaitable, Callable
from dataclasses import dataclass, field

from app.orchestration.plan import ExecutionPlan, ExecutionStep
from app.orchestration.retry import RetryPolicy

# Orchestration statuses (shared with the persisted model).
ORCH_A_TRAITER = "a_traiter"
ORCH_EN_COURS = "en_cours"
ORCH_REUSSI = "reussi"
ORCH_PARTIELLEMENT_REUSSI = "partiellement_reussi"
ORCH_ECHEC = "echec"
ORCH_ANNULE = "annule"

# handler(step, context, results) -> result ; compensator(step, context, results) -> None
Handler = Callable[[ExecutionStep, dict, dict], Awaitable[object]]
Compensator = Callable[[ExecutionStep, dict, dict], Awaitable[None]]


def _ev(event_type: str, step: str = "", *, attempt: int | None = None, detail: str = "") -> dict:
    event: dict[str, object] = {"type": event_type, "step": step}
    if attempt is not None:
        event["attempt"] = attempt
    if detail:
        event["detail"] = detail[:500]
    return event


@dataclass
class SagaResult:
    status: str
    events: list[dict] = field(default_factory=list)
    results: dict = field(default_factory=dict)


class SagaCoordinator:
    def __init__(self, policy: RetryPolicy | None = None) -> None:
        self._policy = policy or RetryPolicy()

    async def run(
        self,
        plan: ExecutionPlan,
        executor: Handler,
        compensator: Compensator,
        *,
        context: dict,
    ) -> SagaResult:
        events: list[dict] = []
        results: dict = {}
        completed: list[ExecutionStep] = []

        for step in plan.steps:
            events.append(_ev("step_started", step.id))
            ok, error = await self._run_step(step, executor, context, results, events)
            if ok:
                completed.append(step)
                continue
            status = await self._compensate(completed, compensator, context, results, events)
            events.append(_ev("orchestration_failed", detail=str(error)))
            return SagaResult(status=status, events=events, results=results)

        events.append(_ev("orchestration_completed"))
        return SagaResult(status=ORCH_REUSSI, events=events, results=results)

    async def _run_step(
        self, step: ExecutionStep, executor: Handler, context: dict, results: dict,
        events: list[dict],
    ) -> tuple[bool, BaseException | None]:
        last_error: BaseException | None = None
        for attempt in range(1, self._policy.max_attempts + 1):
            try:
                results[step.id] = await executor(step, context, results)
                events.append(_ev("step_completed", step.id, attempt=attempt))
                if attempt > 1:
                    events.append(_ev("retry_succeeded", step.id, attempt=attempt))
                return True, None
            except Exception as error:  # noqa: BLE001 — classified below, never swallowed
                last_error = error
                retryable = step.retryable and self._policy.is_retryable(error)
                if retryable and attempt < self._policy.max_attempts:
                    events.append(_ev("retry_requested", step.id, attempt=attempt, detail=str(error)))
                    await asyncio.sleep(self._policy.delay(attempt))
                    continue
                if attempt > 1:
                    events.append(_ev("retry_failed", step.id, attempt=attempt))
                events.append(_ev("step_failed", step.id, attempt=attempt, detail=str(error)))
                return False, last_error
        return False, last_error

    @staticmethod
    async def _compensate(
        completed: list[ExecutionStep], compensator: Compensator, context: dict, results: dict,
        events: list[dict],
    ) -> str:
        any_failed = False
        # Reverse order: undo the most recent successful step first.
        for step in reversed(completed):
            events.append(_ev("compensation_started", step.id))
            try:
                await compensator(step, context, results)
                events.append(_ev("compensation_completed", step.id))
            except Exception as error:  # noqa: BLE001 — irreversible step, recorded not hidden
                any_failed = True
                events.append(_ev("compensation_failed", step.id, detail=str(error)))
        # An irreversible remainder -> partiellement_reussi; a clean undo -> echec.
        return ORCH_PARTIELLEMENT_REUSSI if any_failed else ORCH_ECHEC
