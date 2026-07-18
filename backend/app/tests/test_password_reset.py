"""Tests for the password-reset flow (dev P0).

Covers the happy path, single-use + expiry, invalid tokens, and the
anti-enumeration guarantee (an unknown email answers exactly like a known one
and sends nothing). Uses the offline mock email provider's outbox to recover
the raw token that would have reached the user's inbox.
"""

import re
import uuid
from datetime import datetime, timedelta, timezone

from httpx import AsyncClient

from app.database.session import AsyncSessionLocal
from app.email.providers.mock import MockEmailProvider
from app.users.repository import UserRepository

_PASSWORD = "TestPassword123!"


async def _register(client: AsyncClient) -> str:
    email = f"reset-{uuid.uuid4().hex[:10]}@artizen-qa.io"
    r = await client.post("/api/auth/register", json={"email": email, "password": _PASSWORD})
    assert r.status_code == 201
    return email


def _token_from_outbox(email: str) -> str:
    message = MockEmailProvider.last_for(email)
    assert message is not None, "a reset email should have been sent"
    match = re.search(r"token=(\S+)", message["text"])
    assert match is not None, "the email should contain a reset link with a token"
    return match.group(1)


async def test_full_reset_flow(client: AsyncClient) -> None:
    email = await _register(client)

    assert (await client.post("/api/auth/forgot-password", json={"email": email})).status_code == 204
    token = _token_from_outbox(email)

    new_password = "BrandNewPass456!"
    reset = await client.post("/api/auth/reset-password", json={"token": token, "password": new_password})
    assert reset.status_code == 204

    # New password works, old one no longer does.
    assert (await client.post("/api/auth/login", json={"email": email, "password": new_password})).status_code == 200
    assert (await client.post("/api/auth/login", json={"email": email, "password": _PASSWORD})).status_code == 401


async def test_reset_token_is_single_use(client: AsyncClient) -> None:
    email = await _register(client)
    await client.post("/api/auth/forgot-password", json={"email": email})
    token = _token_from_outbox(email)

    first = await client.post("/api/auth/reset-password", json={"token": token, "password": "First123!"})
    assert first.status_code == 204
    # The same token can't be replayed.
    replay = await client.post("/api/auth/reset-password", json={"token": token, "password": "Second123!"})
    assert replay.status_code == 400


async def test_invalid_token_is_rejected(client: AsyncClient) -> None:
    r = await client.post("/api/auth/reset-password", json={"token": "not-a-real-token", "password": "Whatever123!"})
    assert r.status_code == 400


async def test_expired_token_is_rejected(client: AsyncClient) -> None:
    email = await _register(client)
    await client.post("/api/auth/forgot-password", json={"email": email})
    token = _token_from_outbox(email)

    # Force the token to have expired.
    async with AsyncSessionLocal() as session:
        user = await UserRepository(session).get_by_email(email)
        user.reset_token_expires_at = datetime.now(timezone.utc) - timedelta(minutes=1)
        await session.commit()

    r = await client.post("/api/auth/reset-password", json={"token": token, "password": "TooLate123!"})
    assert r.status_code == 400


async def test_unknown_email_answers_204_and_sends_nothing(client: AsyncClient) -> None:
    unknown = f"nobody-{uuid.uuid4().hex[:10]}@artizen-qa.io"
    r = await client.post("/api/auth/forgot-password", json={"email": unknown})
    assert r.status_code == 204  # same answer as a known email (anti-enumeration)
    assert MockEmailProvider.last_for(unknown) is None  # nothing sent


def test_reset_endpoints_are_rate_limited() -> None:
    from app.core.rate_limit import _PROTECTED_PATH_SUFFIXES

    assert "/auth/forgot-password" in _PROTECTED_PATH_SUFFIXES
    assert "/auth/reset-password" in _PROTECTED_PATH_SUFFIXES
