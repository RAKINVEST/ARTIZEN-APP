"""Pure unit tests for the Orchestration saga (no DB, no HTTP).

Drive the async :class:`SagaCoordinator` via ``asyncio.run`` with fake handlers,
so the whole saga/retry/compensation/determinism surface is pinned locally
(``pytest --noconftest app/tests/test_orchestration_saga.py``).
"""

import asyncio
import random

import pytest

from app.orchestration.exceptions import OrchestrationError, StepExecutionError
from app.orchestration.plan import ExecutionPlan, ExecutionStep, build_plan
from app.orchestration.retry import RetryPolicy
from app.orchestration.saga import (
    ORCH_ECHEC,
    ORCH_PARTIELLEMENT_REUSSI,
    ORCH_REUSSI,
    SagaCoordinator,
)


def _plan(*ids: str) -> ExecutionPlan:
    return ExecutionPlan(kind="t", steps=tuple(ExecutionStep(id=i, engine="x", action=i) for i in ids))


def _types(events: list[dict]) -> list[str]:
    return [e["type"] for e in events]


def _run(plan, executor, compensator, policy=None, context=None):
    coordinator = SagaCoordinator(policy or RetryPolicy(base_delay=0.0))
    return asyncio.run(coordinator.run(plan, executor, compensator, context=context or {}))


def test_build_plan() -> None:
    assert build_plan("intervention").kind == "intervention"
    with pytest.raises(OrchestrationError):
        build_plan("nope")


def test_retry_policy_classification_and_backoff() -> None:
    policy = RetryPolicy(max_attempts=3, base_delay=1.0)
    assert policy.is_retryable(StepExecutionError("x", retryable=True))
    assert not policy.is_retryable(StepExecutionError("x", retryable=False))
    assert not policy.is_retryable(ValueError("x"))  # unknown -> not retried
    assert policy.delay(1) == 1.0
    assert policy.delay(2) == 2.0
    assert policy.delay(3) == 4.0
    assert RetryPolicy(base_delay=100.0, max_delay=30.0).delay(5) == 30.0  # capped
    jitter = policy.jittered_delay(1, random.Random(42))
    assert 0.5 <= jitter <= 1.0  # bounded, deterministic with a seeded rng


def test_saga_happy_path() -> None:
    calls: list[str] = []

    async def execute(step, ctx, res):
        calls.append(step.id)
        return {"ok": step.id}

    async def compensate(step, ctx, res):
        pass

    result = _run(_plan("a", "b", "c"), execute, compensate)
    assert result.status == ORCH_REUSSI
    assert calls == ["a", "b", "c"]
    assert _types(result.events)[-1] == "orchestration_completed"
    assert result.results["a"] == {"ok": "a"}


def test_saga_retries_then_succeeds() -> None:
    attempts = {"a": 0}

    async def execute(step, ctx, res):
        attempts["a"] += 1
        if attempts["a"] < 3:
            raise StepExecutionError("transient", retryable=True)
        return {}

    async def compensate(step, ctx, res):
        pass

    result = _run(_plan("a"), execute, compensate, RetryPolicy(max_attempts=3, base_delay=0.0))
    assert result.status == ORCH_REUSSI
    assert attempts["a"] == 3
    types = _types(result.events)
    assert "retry_requested" in types and "retry_succeeded" in types


def test_saga_non_retryable_fails_and_compensates_in_reverse() -> None:
    compensated: list[str] = []

    async def execute(step, ctx, res):
        if step.id == "c":
            raise StepExecutionError("boom", retryable=False)
        return {step.id: True}

    async def compensate(step, ctx, res):
        compensated.append(step.id)

    result = _run(_plan("a", "b", "c"), execute, compensate)
    assert result.status == ORCH_ECHEC
    assert compensated == ["b", "a"]  # reverse order of completed steps
    types = _types(result.events)
    assert "step_failed" in types and "orchestration_failed" in types


def test_saga_irreversible_compensation_is_partial() -> None:
    async def execute(step, ctx, res):
        if step.id == "b":
            raise StepExecutionError("boom", retryable=False)
        return {}

    async def compensate(step, ctx, res):
        raise RuntimeError("irreversible (e.g. email already sent)")

    result = _run(_plan("a", "b"), execute, compensate)
    assert result.status == ORCH_PARTIELLEMENT_REUSSI
    assert "compensation_failed" in _types(result.events)


def test_saga_is_deterministic() -> None:
    async def execute(step, ctx, res):
        return {}

    async def compensate(step, ctx, res):
        pass

    first = _run(_plan("a", "b"), execute, compensate)
    second = _run(_plan("a", "b"), execute, compensate)
    assert _types(first.events) == _types(second.events)
