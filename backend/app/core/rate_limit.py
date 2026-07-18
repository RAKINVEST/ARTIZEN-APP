"""Per-IP rate limiting for the authentication routes.

Why these routes specifically: ``POST /auth/login`` and
``POST /auth/register`` are the only endpoints reachable without a token,
and both answer differently depending on whether an email exists (register
returns 409 vs 201 — a deliberate, tested trade-off). Without a request
ceiling, that difference makes the entire user base enumerable, and
``login`` brute-forceable, at whatever rate the network allows. bcrypt
makes each guess expensive for *us*, not for the attacker.

Implementation is a fixed-window counter held in this process's memory —
no new dependency, and nothing to operate. That choice has two honest
consequences:

- **It does not survive multiple workers or replicas.** The production CMD
  runs 4 uvicorn workers, each with its own counter, so the effective
  ceiling is roughly 4x what is configured here. It still turns unlimited
  into bounded, which is the whole gap being closed.
- **It trusts the socket's peer address.** Behind a reverse proxy every
  request appears to come from the proxy, so this must be revisited
  together with ``X-Forwarded-For`` handling when one is put in front (see
  docs/AUDIT-V1.md).

A shared store (Redis) keyed the same way is now available (V3 foundations):
set ``RATE_LIMIT_BACKEND=redis`` and the counter lives in Redis, shared across
all workers and replicas, closing the ~4x-ceiling gap. It degrades to the
in-memory counter if Redis is unreachable, and the test suite always builds
the deterministic in-memory limiter (the backend is a constructor argument).
The ``X-Forwarded-For`` trust issue still stands and is a reverse-proxy
concern.
"""

import logging
import time
from collections import defaultdict, deque

from starlette.responses import JSONResponse
from starlette.types import ASGIApp, Receive, Scope, Send

logger = logging.getLogger(__name__)

# Generous for a human (a mistyped password a few times over), useless for
# enumeration: probing a 10 000-address list would take ~14 hours per IP.
_MAX_REQUESTS = 10
_WINDOW_SECONDS = 60

# Only the unauthenticated routes. Everything else already requires a valid
# JWT, which is its own gate — and rate-limiting the app's normal traffic
# on a per-IP counter would punish an office where several artisans share
# one connection.
_PROTECTED_PATH_SUFFIXES = (
    "/auth/login",
    "/auth/register",
    # Reset endpoints are unauthenticated and trigger emails / accept tokens —
    # rate-limited to stop email-bombing an address and brute-forcing a token.
    "/auth/forgot-password",
    "/auth/reset-password",
)


class AuthRateLimitMiddleware:
    def __init__(
        self,
        app: ASGIApp,
        max_requests: int = _MAX_REQUESTS,
        window_seconds: int = _WINDOW_SECONDS,
        backend: str = "memory",
    ) -> None:
        self._app = app
        self._max_requests = max_requests
        self._window_seconds = window_seconds
        # "memory" = per-worker (V2). "redis" = shared across workers/replicas,
        # closing the ~4x-ceiling gap. The backend is a constructor argument so
        # the test suite always builds the deterministic in-memory limiter,
        # whatever the environment sets for production.
        self._backend = backend
        self._hits: dict[str, deque[float]] = defaultdict(deque)

    def _is_protected(self, scope: Scope) -> bool:
        if scope.get("method") != "POST":
            return False
        path = scope.get("path", "")
        return path.endswith(_PROTECTED_PATH_SUFFIXES)

    @staticmethod
    def _client_key(scope: Scope) -> str:
        client = scope.get("client")
        return client[0] if client else "unknown"

    def _is_over_limit(self, key: str, now: float) -> bool:
        hits = self._hits[key]
        cutoff = now - self._window_seconds
        while hits and hits[0] <= cutoff:
            hits.popleft()

        if len(hits) >= self._max_requests:
            return True

        hits.append(now)
        return False

    def _evict_idle(self, now: float) -> None:
        """Drop keys whose window has fully elapsed.

        Without this the dict keeps an entry for every IP that ever hit
        /login — a slow leak in a long-running process, and one an attacker
        could feed deliberately by rotating source addresses.
        """
        cutoff = now - self._window_seconds
        for key in [key for key, hits in self._hits.items() if not hits or hits[-1] <= cutoff]:
            del self._hits[key]

    def _memory_over_limit(self, key: str) -> bool:
        now = time.monotonic()
        self._evict_idle(now)
        return self._is_over_limit(key, now)

    async def _redis_over_limit(self, key: str) -> bool:
        """Shared fixed-window counter in Redis: INCR the current window's
        bucket, set its TTL on creation, refuse past the ceiling. Same
        allow-``max``-then-refuse semantics as the in-memory path (count starts
        at 1, so the (max+1)th request is the first over)."""
        from app.redis_client import get_redis

        bucket = int(time.time() // self._window_seconds)
        redis_key = f"ratelimit:auth:{key}:{bucket}"
        redis = get_redis()
        count = await redis.incr(redis_key)
        if count == 1:
            await redis.expire(redis_key, self._window_seconds)
        return count > self._max_requests

    async def __call__(self, scope: Scope, receive: Receive, send: Send) -> None:
        if scope["type"] != "http" or not self._is_protected(scope):
            await self._app(scope, receive, send)
            return

        key = self._client_key(scope)
        if self._backend == "redis":
            try:
                over_limit = await self._redis_over_limit(key)
            except Exception:
                # A missing/failing broker must never lock users out: fall back
                # to the per-worker counter, which still bounds the hole.
                logger.warning("rate_limit.redis_unavailable — falling back to in-memory")
                over_limit = self._memory_over_limit(key)
        else:
            over_limit = self._memory_over_limit(key)

        if over_limit:
            await JSONResponse(
                status_code=429,
                headers={"Retry-After": str(self._window_seconds)},
                content={
                    "error": {
                        "code": "too_many_requests",
                        "message": (
                            "Too many authentication attempts. Please wait "
                            f"{self._window_seconds} seconds and try again."
                        ),
                    }
                },
            )(scope, receive, send)
            return

        await self._app(scope, receive, send)
