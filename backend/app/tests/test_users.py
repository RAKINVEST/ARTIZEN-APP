"""Tests for the users/auth module (Étape 10): registration, login,
``/me``, and the two distinct "you're not allowed in" shapes FastAPI
itself produces (403 when no token is sent at all, via `HTTPBearer`'s
own `auto_error`; 401 when a token is present but invalid/expired, via
`AuthService.get_user_from_token` raising our own `UnauthorizedError`).
"""

import uuid

from httpx import ASGITransport, AsyncClient

from app.main import app


async def test_register_creates_a_new_account_and_company(client: AsyncClient) -> None:
    response = await client.post(
        "/api/auth/register",
        json={"email": f"new-{uuid.uuid4()}@artizen-qa.io", "password": "Password123!"},
    )

    assert response.status_code == 201
    body = response.json()
    assert "access_token" in body
    assert body["token_type"] == "bearer"
    assert body["user"]["email"].startswith("new-")
    assert body["user"]["company_id"]


async def test_register_rejects_duplicate_email(client: AsyncClient) -> None:
    email = f"dup-{uuid.uuid4()}@artizen-qa.io"
    first = await client.post(
        "/api/auth/register", json={"email": email, "password": "Password123!"}
    )
    assert first.status_code == 201

    second = await client.post(
        "/api/auth/register", json={"email": email, "password": "Password123!"}
    )

    assert second.status_code == 409
    assert second.json()["error"]["code"] == "email_already_registered"


async def test_register_creates_a_distinct_company_per_account(client: AsyncClient) -> None:
    """Two accounts registered independently must never end up sharing
    a company — the whole point of replacing the old implicit-singleton
    company with real registration."""
    first = await client.post(
        "/api/auth/register",
        json={"email": f"a-{uuid.uuid4()}@artizen-qa.io", "password": "Password123!"},
    )
    second = await client.post(
        "/api/auth/register",
        json={"email": f"b-{uuid.uuid4()}@artizen-qa.io", "password": "Password123!"},
    )

    assert first.json()["user"]["company_id"] != second.json()["user"]["company_id"]


async def test_login_succeeds_with_correct_credentials(client: AsyncClient) -> None:
    email = f"login-{uuid.uuid4()}@artizen-qa.io"
    await client.post("/api/auth/register", json={"email": email, "password": "Password123!"})

    response = await client.post(
        "/api/auth/login", json={"email": email, "password": "Password123!"}
    )

    assert response.status_code == 200
    assert "access_token" in response.json()


async def test_login_rejects_wrong_password(client: AsyncClient) -> None:
    email = f"wrongpw-{uuid.uuid4()}@artizen-qa.io"
    await client.post("/api/auth/register", json={"email": email, "password": "Password123!"})

    response = await client.post(
        "/api/auth/login", json={"email": email, "password": "WrongPassword!"}
    )

    assert response.status_code == 401
    assert response.json()["error"]["code"] == "unauthorized"


async def test_login_rejects_unknown_email(client: AsyncClient) -> None:
    response = await client.post(
        "/api/auth/login",
        json={"email": "does-not-exist@artizen-qa.io", "password": "whatever123"},
    )

    assert response.status_code == 401


async def test_me_returns_the_authenticated_user(client: AsyncClient) -> None:
    response = await client.get("/api/auth/me")

    assert response.status_code == 200
    body = response.json()
    assert "id" in body
    assert "company_id" in body
    assert body["is_active"] is True


async def test_delete_me_erases_the_account_and_cascades(client: AsyncClient) -> None:
    """RGPD right to erasure: DELETE /auth/me removes the tenant and everything
    that references it. The company row is deleted and the database cascades
    (ON DELETE CASCADE on companies.id) to the user, branding and all data — so
    a successful 204 with a referencing branding row present is itself the
    cascade proof: a missing cascade would raise a FK violation, not 204."""
    # Touch branding so a BrandProfile row referencing the company exists —
    # deleting the company must cascade through it, not fail on its FK.
    profile = await client.get("/api/branding/profile")
    assert profile.status_code == 200

    deleted = await client.delete("/api/auth/me")
    assert deleted.status_code == 204

    # The account is gone: the token no longer resolves to a live user.
    after = await client.get("/api/auth/me")
    assert after.status_code == 401


async def test_protected_endpoint_requires_a_token() -> None:
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as anonymous:
        response = await anonymous.get("/api/branding/profile")

    # HTTPBearer's own auto_error for a completely missing header is a
    # 403 ("Not authenticated"), not a 401 — see module docstring.
    assert response.status_code == 403
    assert response.json()["error"]["code"] == "forbidden"


async def test_protected_endpoint_rejects_an_invalid_token() -> None:
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as anonymous:
        anonymous.headers["Authorization"] = "Bearer not-a-real-token"
        response = await anonymous.get("/api/branding/profile")

    assert response.status_code == 401
    assert response.json()["error"]["code"] == "unauthorized"
