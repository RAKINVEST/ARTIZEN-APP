"""Tests for the async task infrastructure (V3 foundations).

The queue's end-to-end round-trip (enqueue -> worker -> result) needs a live
Redis + worker and is exercised in the container, not here. These tests cover
what is deterministic without infrastructure: the task function itself, and
that a missing broker degrades cleanly rather than hanging.
"""

import pytest

from app.tasks import queue
from app.tasks.worker import demo_task


async def test_demo_task_echoes_its_payload() -> None:
    """The infra smoke task returns its input untouched — no business logic,
    just proof the worker receives and answers."""
    result = await demo_task({"job_id": "job-123"}, {"hello": "world"})

    assert result == {"processed": True, "echo": {"hello": "world"}, "job_id": "job-123"}


async def test_enqueue_refuses_cleanly_when_broker_is_down(monkeypatch: pytest.MonkeyPatch) -> None:
    """A missing/unreachable Redis must raise ``TaskQueueUnavailable`` (which a
    router turns into a 503), never block the caller."""
    from app.core.config import settings

    # A port nothing listens on → connection refused, fast.
    monkeypatch.setattr(settings, "REDIS_URL", "redis://127.0.0.1:6390/0")
    await queue.close_pool()
    try:
        with pytest.raises(queue.TaskQueueUnavailable):
            await queue.enqueue("demo_task", {"x": 1})
    finally:
        await queue.close_pool()
