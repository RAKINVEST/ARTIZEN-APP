"""Async Redis access — the shared store behind the V3 foundations: the task
queue's broker, the cross-worker rate limiter, and future caching.

One lazily-created client per process, with short socket timeouts so a Redis
that is down fails fast rather than hanging a request. **Every caller must
tolerate Redis being absent**: the app starts without it and each dependent
feature degrades (in-memory rate limit, tasks refused with a clear 503),
exactly the "always starts, always usable without configuration" rule the V2
provider abstractions already follow.
"""

import logging

from redis.asyncio import Redis
from redis.asyncio import from_url as _redis_from_url

from app.core.config import settings

logger = logging.getLogger(__name__)

_client: Redis | None = None


def get_redis() -> Redis:
    """The shared async client. Created on first use; never at import, so the
    app (and the test suite) start without a running Redis."""
    global _client
    if _client is None:
        _client = _redis_from_url(
            settings.REDIS_URL,
            encoding="utf-8",
            decode_responses=True,
            socket_connect_timeout=2,
            socket_timeout=2,
        )
    return _client


async def redis_healthy() -> bool:
    """True if Redis answers a PING. Used by the health probe; never raises."""
    try:
        return bool(await get_redis().ping())
    except Exception:
        logger.warning("redis.ping_failed url=%s", settings.REDIS_URL)
        return False


async def close_redis() -> None:
    """Close the shared client if one is open. Best-effort: closing a client
    bound to a dead event loop (or a Redis that has gone away) must never raise
    out of a shutdown or a test teardown — the client is dropped either way."""
    global _client
    if _client is None:
        return
    try:
        await _client.aclose()
    except Exception:  # noqa: BLE001 — dropping a broken/stale client must not raise
        logger.debug("redis.close: aclose failed, dropping client anyway", exc_info=True)
    finally:
        _client = None
