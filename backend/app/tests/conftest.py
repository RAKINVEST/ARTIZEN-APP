import os
import uuid
from collections.abc import AsyncIterator

# Set before app.main is imported, and therefore before app.core.config
# builds its settings singleton — by the time `app` exists the middleware
# stack is already fixed, so this cannot be done from a fixture.
#
# Every test registers its own account (see below), from a single address:
# ~95 registrations in a burst is precisely the pattern AuthRateLimitMiddleware
# exists to refuse, and with it on, everything past the tenth test fails with
# a 429. The limiter itself is covered directly, without the HTTP stack, in
# test_rate_limit.py.
os.environ.setdefault("AUTH_RATE_LIMIT_ENABLED", "false")

import pytest  # noqa: E402
from httpx import ASGITransport, AsyncClient  # noqa: E402

from app.database.session import engine  # noqa: E402
from app.main import app  # noqa: E402
from app.redis_client import close_redis  # noqa: E402
from app.tasks.queue import close_pool as _close_task_pool  # noqa: E402

_TEST_PASSWORD = "TestPassword123!"


async def _register_and_authenticate(ac: AsyncClient) -> None:
    """Registers a brand-new account (and, with it, a brand-new
    ``Company``) and attaches its JWT as the client's default
    ``Authorization`` header. Every test gets its own real tenant — a
    side effect of Étape 10's real multi-tenancy that finally gives
    each test genuine data isolation, something the "shared singleton
    company" era never had."""
    email = f"test-{uuid.uuid4()}@artizen-qa.io"
    response = await ac.post(
        "/api/auth/register", json={"email": email, "password": _TEST_PASSWORD}
    )
    token = response.json()["access_token"]
    ac.headers["Authorization"] = f"Bearer {token}"


@pytest.fixture
async def client() -> AsyncIterator[AsyncClient]:
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        await _register_and_authenticate(ac)
        yield ac


@pytest.fixture
async def second_client() -> AsyncIterator[AsyncClient]:
    """A second client, independently registered under a different
    account/company — only for tests proving cross-tenant isolation
    (one company can never see or touch another's data)."""
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        await _register_and_authenticate(ac)
        yield ac


@pytest.fixture(autouse=True)
async def _dispose_engine_after_test() -> AsyncIterator[None]:
    """Drop pooled connections after every test.

    The SQLAlchemy async engine is a module-level singleton whose pooled
    connections bind to whichever event loop opened them. pytest-asyncio
    runs each test on its own loop by default, so a connection left open
    from one test breaks the next one ("attached to a different loop").
    Disposing the pool after each test forces a fresh connection under
    whatever loop the next test runs on.
    """
    yield
    await engine.dispose()


@pytest.fixture(autouse=True)
async def _reset_redis_singletons_after_test() -> AsyncIterator[None]:
    """Drop the process-wide Redis client and arq pool after every test.

    Same hazard as the SQLAlchemy engine above: both are module-level
    singletons that bind to whichever event loop created them (e.g. when a
    ``/health`` request pings Redis and reads ``queue_depth``). pytest-asyncio
    runs each test on its own loop, so a client left open from one test breaks
    the next with "attached to a different loop". ``close_*`` is best-effort,
    so this is safe even for the tests that never opened either one.
    """
    yield
    await _close_task_pool()
    await close_redis()
