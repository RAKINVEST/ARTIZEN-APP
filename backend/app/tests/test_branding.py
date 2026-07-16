"""Tests for the branding module's upload and profile endpoints.

These hit the real database configured for the running environment (same
pattern as ``test_health.py``): there is no dedicated test database or
per-test transaction rollback yet. That is an acceptable simplification
for this foundation phase, not a target for this test module.
"""

import io

from httpx import AsyncClient

_PNG_BYTES = b"\x89PNG\r\n\x1a\n" + b"0" * 128


async def test_upload_logo_valid(client: AsyncClient) -> None:
    response = await client.post(
        "/api/branding/logo",
        files={"file": ("logo.png", io.BytesIO(_PNG_BYTES), "image/png")},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["filename"] == "logo.png"
    assert body["content_type"] == "image/png"
    assert body["size_bytes"] == len(_PNG_BYTES)
    assert body["path"].startswith("logos/")


async def test_upload_logo_wrong_type(client: AsyncClient) -> None:
    response = await client.post(
        "/api/branding/logo",
        files={"file": ("logo.txt", io.BytesIO(b"not an image"), "text/plain")},
    )

    assert response.status_code == 415
    assert response.json()["error"]["code"] == "unsupported_file_type"


async def test_upload_logo_too_large(client: AsyncClient) -> None:
    oversized = b"0" * (6 * 1024 * 1024)  # comfortably over the 5 MB logo limit

    response = await client.post(
        "/api/branding/logo",
        files={"file": ("logo.png", io.BytesIO(oversized), "image/png")},
    )

    assert response.status_code == 413
    assert response.json()["error"]["code"] == "file_too_large"


async def test_upload_quote_template_valid(client: AsyncClient) -> None:
    pdf_bytes = b"%PDF-1.4\n" + b"0" * 128

    response = await client.post(
        "/api/branding/template/quote",
        files={"file": ("devis.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["template"]["type"] == "quote"
    assert body["template"]["is_active"] is True
    assert body["file"]["content_type"] == "application/pdf"


async def test_upload_template_wrong_type(client: AsyncClient) -> None:
    response = await client.post(
        "/api/branding/template/invoice",
        files={"file": ("facture.png", io.BytesIO(_PNG_BYTES), "image/png")},
    )

    assert response.status_code == 415
    assert response.json()["error"]["code"] == "unsupported_file_type"


async def test_get_profile(client: AsyncClient) -> None:
    response = await client.get("/api/branding/profile")

    assert response.status_code == 200
    body = response.json()
    assert "company" in body
    assert "brand" in body
    assert "templates" in body
    assert isinstance(body["templates"], list)


async def test_update_company_applies_only_provided_fields(client: AsyncClient) -> None:
    response = await client.put("/api/branding/company", json={"legal_name": "Plomberie Martin"})

    assert response.status_code == 200
    assert response.json()["legal_name"] == "Plomberie Martin"


async def test_update_company_partial_update_does_not_touch_other_fields(
    client: AsyncClient,
) -> None:
    await client.put("/api/branding/company", json={"phone": "0102030405"})

    response = await client.put("/api/branding/company", json={"email": "contact@example.com"})

    assert response.status_code == 200
    body = response.json()
    assert body["email"] == "contact@example.com"
    assert body["phone"] == "0102030405"  # untouched by the second call


async def test_update_brand_profile(client: AsyncClient) -> None:
    response = await client.put(
        "/api/branding/brand", json={"primary_color": "#ff0000", "tagline": "Votre artisan de confiance"}
    )

    assert response.status_code == 200
    body = response.json()
    assert body["primary_color"] == "#ff0000"
    assert body["tagline"] == "Votre artisan de confiance"
