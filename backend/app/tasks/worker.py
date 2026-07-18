"""The arq worker: the process that runs queued tasks off the request path.

Started in its own container (`arq app.tasks.worker.WorkerSettings`, see
docker-compose). Business tasks register their coroutine in ``functions``
when their module lands; this foundations sprint ships a single infra
smoke-test task that proves the enqueue -> worker -> result round-trip.
"""

import logging
from typing import Any

from arq.connections import RedisSettings

from app.core.config import settings
from app.core.logging import setup_logging

logger = logging.getLogger(__name__)


async def demo_task(ctx: dict[str, Any], payload: dict[str, Any]) -> dict[str, Any]:
    """Infra smoke task — no business logic. Echoes its payload so a caller
    can verify the queue is wired end to end and measure round-trip latency."""
    logger.info("tasks.demo.received job_id=%s", ctx.get("job_id"))
    return {"processed": True, "echo": payload, "job_id": ctx.get("job_id")}


async def _on_startup(ctx: dict[str, Any]) -> None:
    setup_logging()
    logger.info("arq.worker.started redis=%s", settings.REDIS_URL)


async def _on_shutdown(ctx: dict[str, Any]) -> None:
    logger.info("arq.worker.stopped")


class WorkerSettings:
    """arq entry point. New tasks are added to ``functions`` — nothing else
    about the worker changes as the V3 modules grow."""

    functions = [demo_task]
    redis_settings = RedisSettings.from_dsn(settings.REDIS_URL)
    on_startup = _on_startup
    on_shutdown = _on_shutdown
    max_jobs = 10
    job_timeout = 300  # seconds — STT/LLM/OCR can be slow; never unbounded.
    keep_result = 3600  # keep results for 1h so a client can poll a job id.
