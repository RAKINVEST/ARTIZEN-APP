"""The public runtime-config endpoint — the single source the client reads the
support address from (Paramètres + legal pages), never a baked-in copy."""

from httpx import AsyncClient

from app.core.config import settings


async def test_public_config_exposes_the_support_email(client: AsyncClient) -> None:
    # Public: a visitor reading the legal pages is not signed in.
    del client.headers["Authorization"]

    response = await client.get("/api/config")

    assert response.status_code == 200
    assert response.json()["support_email"] == settings.SUPPORT_EMAIL
