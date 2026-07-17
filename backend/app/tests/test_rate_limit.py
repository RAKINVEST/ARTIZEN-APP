"""Tests for the auth rate limiter.

Driven against a throwaway Starlette app rather than the real one: the
suite disables the limiter globally (see conftest — every test registers
an account, which the limiter would otherwise refuse), so exercising it
here on its own keeps it covered without that conflict. It also needs no
database, which keeps these fast and exact.
"""

import pytest
from httpx import ASGITransport, AsyncClient
from starlette.applications import Starlette
from starlette.responses import JSONResponse
from starlette.routing import Route

from app.core.rate_limit import AuthRateLimitMiddleware


async def _ok(request: object) -> JSONResponse:
    return JSONResponse({"ok": True})


def _build_app(*, max_requests: int = 3, window_seconds: int = 60) -> Starlette:
    app = Starlette(
        routes=[
            Route("/api/auth/login", _ok, methods=["POST"]),
            Route("/api/auth/register", _ok, methods=["POST"]),
            Route("/api/clients", _ok, methods=["POST"]),
        ]
    )
    app.add_middleware(
        AuthRateLimitMiddleware, max_requests=max_requests, window_seconds=window_seconds
    )
    return app


@pytest.fixture
async def limited_client() -> AsyncClient:
    transport = ASGITransport(app=_build_app())
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac


async def test_login_is_refused_past_the_limit(limited_client: AsyncClient) -> None:
    codes = [
        (await limited_client.post("/api/auth/login", json={})).status_code for _ in range(5)
    ]

    assert codes == [200, 200, 200, 429, 429]


async def test_refusal_says_how_long_to_wait(limited_client: AsyncClient) -> None:
    for _ in range(4):
        response = await limited_client.post("/api/auth/login", json={})

    assert response.status_code == 429
    assert response.json()["error"]["code"] == "too_many_requests"
    # Without Retry-After a client can only guess, and guessing means
    # hammering the endpoint it was just told to back off from.
    assert response.headers["retry-after"] == "60"


async def test_register_shares_the_login_budget(limited_client: AsyncClient) -> None:
    """Both routes leak whether an account exists, so spending the budget
    on one must not leave a fresh budget on the other."""
    for _ in range(3):
        await limited_client.post("/api/auth/login", json={})

    response = await limited_client.post("/api/auth/register", json={})

    assert response.status_code == 429


async def test_business_routes_are_never_throttled(limited_client: AsyncClient) -> None:
    """Authenticated routes are gated by the JWT, not by a per-IP counter —
    throttling them would punish an office whose artisans share one
    connection."""
    codes = [
        (await limited_client.post("/api/clients", json={})).status_code for _ in range(10)
    ]

    assert codes == [200] * 10


def test_counter_forgets_requests_older_than_the_window() -> None:
    middleware = AuthRateLimitMiddleware(_build_app(), max_requests=2, window_seconds=10)

    assert middleware._is_over_limit("1.2.3.4", 100.0) is False
    assert middleware._is_over_limit("1.2.3.4", 101.0) is False
    assert middleware._is_over_limit("1.2.3.4", 102.0) is True
    # Window elapsed: the same caller is welcome again.
    assert middleware._is_over_limit("1.2.3.4", 120.0) is False


def test_idle_callers_are_evicted() -> None:
    """The counter dict is process memory: without eviction it grows by one
    entry per address that ever touched /login, which an attacker can feed
    by rotating source addresses."""
    middleware = AuthRateLimitMiddleware(_build_app(), max_requests=2, window_seconds=10)
    middleware._is_over_limit("1.2.3.4", 100.0)

    middleware._evict_idle(200.0)

    assert len(middleware._hits) == 0


def test_callers_are_counted_independently() -> None:
    middleware = AuthRateLimitMiddleware(_build_app(), max_requests=1, window_seconds=60)

    assert middleware._is_over_limit("1.1.1.1", 100.0) is False
    assert middleware._is_over_limit("1.1.1.1", 100.0) is True
    # A second caller must not inherit the first one's exhausted budget.
    assert middleware._is_over_limit("2.2.2.2", 100.0) is False
