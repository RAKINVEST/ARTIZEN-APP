"""The single entry point the app uses to push work to the worker.

Returns an arq job id the caller can hand back to the client for polling.
If Redis is unreachable it raises :class:`TaskQueueUnavailable` rather than
blocking or silently dropping the work — a router turns that into a clean
503, so a missing broker degrades the feature instead of the whole app.
"""

import logging

from arq import create_pool
from arq.connections import ArqRedis, RedisSettings

from app.core.config import settings

logger = logging.getLogger(__name__)


class TaskQueueUnavailable(RuntimeError):
    """Raised when the task broker (Redis) cannot be reached."""


_pool: ArqRedis | None = None


async def get_pool() -> ArqRedis:
    global _pool
    if _pool is None:
        try:
            _pool = await create_pool(RedisSettings.from_dsn(settings.REDIS_URL))
        except Exception as exc:  # noqa: BLE001 — any connection failure degrades the same way
            raise TaskQueueUnavailable(str(exc)) from exc
    return _pool


async def enqueue(function: str, *args: object, **kwargs: object) -> str:
    """Enqueue ``function`` (its registered name in the worker) and return the
    job id. Raises :class:`TaskQueueUnavailable` if the broker is down."""
    try:
        pool = await get_pool()
        job = await pool.enqueue_job(function, *args, **kwargs)
    except TaskQueueUnavailable:
        raise
    except Exception as exc:  # noqa: BLE001
        raise TaskQueueUnavailable(str(exc)) from exc
    if job is None:
        # arq returns None when a job with the same id already exists — the
        # caller asked for work that is already queued, not an error.
        raise TaskQueueUnavailable("job could not be enqueued (duplicate id)")
    logger.info("tasks.enqueued function=%s job_id=%s", function, job.job_id)
    return job.job_id


async def queue_depth() -> int | None:
    """Best-effort number of jobs waiting in the default queue, for monitoring.
    ``None`` if the broker is unreachable."""
    try:
        pool = await get_pool()
        return await pool.zcard("arq:queue")
    except Exception:  # noqa: BLE001
        return None


async def close_pool() -> None:
    global _pool
    if _pool is not None:
        try:
            await _pool.aclose()
        finally:
            _pool = None
