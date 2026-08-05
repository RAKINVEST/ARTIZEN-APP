"""Conversational memory store — ephemeral, tenant-scoped, never business data.

Two levels live here, both keyed by ``company_id`` (multi-tenant isolation): the
session (current pending action + collected slots) and the conversation (the
append-only turns). Storage is a small injectable interface so the same logic
runs on Redis (with a TTL = "expiration configurable") in production and on an
in-process dict in tests. Every Redis call is best-effort: if Redis is down the
Companion still answers this turn, only losing cross-turn memory — it never
crashes (the project's "always usable without configuration" rule).
"""

import logging
from typing import Protocol, runtime_checkable

logger = logging.getLogger(__name__)


@runtime_checkable
class MemoryStore(Protocol):
    async def get(self, key: str) -> str | None: ...
    async def set(self, key: str, value: str, *, ttl: int) -> None: ...
    async def delete(self, key: str) -> None: ...


@runtime_checkable
class RedisClient(Protocol):
    """The subset of the async Redis client the store uses (structural — avoids
    importing the redis package here just for a type)."""

    async def get(self, key: str) -> str | None: ...
    async def set(self, key: str, value: str, *, ex: int) -> object: ...
    async def delete(self, key: str) -> object: ...


class InMemoryStore:
    """Process-local store for tests and the Redis-absent fallback. Not shared
    across processes and not persistent — exactly the semantics a single test or
    a degraded single worker needs."""

    def __init__(self) -> None:
        self._data: dict[str, str] = {}

    async def get(self, key: str) -> str | None:
        return self._data.get(key)

    async def set(self, key: str, value: str, *, ttl: int) -> None:
        self._data[key] = value

    async def delete(self, key: str) -> None:
        self._data.pop(key, None)


class RedisMemoryStore:
    """Redis-backed store with per-key TTL. Best-effort: a Redis failure logs
    and degrades (returns ``None`` / silently skips) rather than raising."""

    def __init__(self, redis: RedisClient) -> None:
        self._redis = redis

    async def get(self, key: str) -> str | None:
        try:
            return await self._redis.get(key)
        except Exception:  # noqa: BLE001 — Redis absent degrades, never crashes
            logger.warning("companion.memory.get_failed key=%s", key)
            return None

    async def set(self, key: str, value: str, *, ttl: int) -> None:
        try:
            await self._redis.set(key, value, ex=ttl)
        except Exception:  # noqa: BLE001
            logger.warning("companion.memory.set_failed key=%s", key)

    async def delete(self, key: str) -> None:
        try:
            await self._redis.delete(key)
        except Exception:  # noqa: BLE001
            logger.warning("companion.memory.delete_failed key=%s", key)
