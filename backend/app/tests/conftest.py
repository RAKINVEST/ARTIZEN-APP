import uuid
from collections.abc import AsyncIterator

import pytest
from httpx import ASGITransport, AsyncClient

from app.database.session import engine
from app.main import app

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
