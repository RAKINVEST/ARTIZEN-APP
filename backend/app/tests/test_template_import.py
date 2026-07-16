"""Tests for the template-import module (Étape 8): "importer un ancien
devis PDF" -> analyse -> detection -> preview -> validate -> the
imported PDF becomes the company's active quote template.

Reuses the same blank-PDF fixture pattern as document_analysis/
document_detection tests: a blank PDF has no extractable text, so
detection legitimately finds nothing — this still fully exercises the
preview/validate wiring end to end. Field values reaching
Company/BrandProfile are tested via explicit ``validate()`` payloads
(the "user reviewed the preview and confirmed these values" step), not
by relying on real text extraction from a hand-built PDF — the project
already established (document_analysis/document_detection tests) that
adding a PDF-text-drawing dependency (e.g. reportlab) just for tests is
disproportionate.
"""

import io

import pytest
from httpx import AsyncClient
from pypdf import PdfWriter


def _make_pdf_bytes(pages: int = 1) -> bytes:
    writer = PdfWriter()
    for _ in range(pages):
        writer.add_blank_page(width=200, height=200)
    buffer = io.BytesIO()
    writer.write(buffer)
    return buffer.getvalue()


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


async def _upload_and_process(
    client: AsyncClient, company_id: str, *, document_type: str = "quote"
) -> str:
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": document_type},
        files={"file": ("ancien_devis.pdf", io.BytesIO(_make_pdf_bytes()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]
    await client.post(f"/api/document-analysis/{analysis_id}/process")
    return analysis_id


async def test_preview_requires_completed_analysis(client: AsyncClient, company_id: str) -> None:
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(_make_pdf_bytes()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]

    response = await client.get(f"/api/template-import/{analysis_id}/preview")

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "document_not_processed"


async def test_preview_rejects_invoice_document(client: AsyncClient, company_id: str) -> None:
    analysis_id = await _upload_and_process(client, company_id, document_type="invoice")

    response = await client.get(f"/api/template-import/{analysis_id}/preview")

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "invalid_document_type_for_template"


async def test_preview_returns_analysis_detection_and_current_profile(
    client: AsyncClient, company_id: str
) -> None:
    analysis_id = await _upload_and_process(client, company_id)

    response = await client.get(f"/api/template-import/{analysis_id}/preview")

    assert response.status_code == 200
    body = response.json()
    assert body["analysis"]["id"] == analysis_id
    assert body["detection"]["document_analysis_id"] == analysis_id
    assert body["current_company"]["id"] == company_id
    assert "current_brand" in body


async def test_validate_rejects_invoice_document(client: AsyncClient, company_id: str) -> None:
    analysis_id = await _upload_and_process(client, company_id, document_type="invoice")

    response = await client.post(f"/api/template-import/{analysis_id}/validate", json={})

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "invalid_document_type_for_template"


async def test_validate_creates_active_template_and_links_analysis(
    client: AsyncClient, company_id: str
) -> None:
    analysis_id = await _upload_and_process(client, company_id)

    response = await client.post(f"/api/template-import/{analysis_id}/validate", json={})

    assert response.status_code == 200
    body = response.json()
    quote_templates = [t for t in body["templates"] if t["type"] == "quote"]
    active_quote_templates = [t for t in quote_templates if t["is_active"]]
    assert len(active_quote_templates) == 1
    assert active_quote_templates[0]["name"] == "ancien_devis.pdf"

    analysis_response = await client.get(f"/api/document-analysis/{analysis_id}")
    assert analysis_response.json()["document_template_id"] == active_quote_templates[0]["id"]


async def test_validate_applies_field_overrides(client: AsyncClient, company_id: str) -> None:
    analysis_id = await _upload_and_process(client, company_id)

    response = await client.post(
        f"/api/template-import/{analysis_id}/validate",
        json={
            "legal_name": "Menuiserie Dupont SARL",
            "siret": "12345678900012",
            "vat_number": "FR12345678901",
            "phone": "0123456789",
            "email": "contact@menuiserie-dupont.fr",
            "primary_color": "#1a2b3c",
            "secondary_color": "#ffffff",
        },
    )

    assert response.status_code == 200
    body = response.json()
    assert body["company"]["legal_name"] == "Menuiserie Dupont SARL"
    assert body["company"]["siret"] == "12345678900012"
    assert body["company"]["vat_number"] == "FR12345678901"
    assert body["company"]["phone"] == "0123456789"
    assert body["company"]["email"] == "contact@menuiserie-dupont.fr"
    assert body["brand"]["primary_color"] == "#1a2b3c"
    assert body["brand"]["secondary_color"] == "#ffffff"


async def test_validate_deactivates_previous_active_template(
    client: AsyncClient, company_id: str
) -> None:
    first_analysis_id = await _upload_and_process(client, company_id)
    first_response = await client.post(
        f"/api/template-import/{first_analysis_id}/validate", json={}
    )
    first_active = next(
        t for t in first_response.json()["templates"] if t["type"] == "quote" and t["is_active"]
    )

    second_analysis_id = await _upload_and_process(client, company_id)
    second_response = await client.post(
        f"/api/template-import/{second_analysis_id}/validate", json={}
    )
    quote_templates = [t for t in second_response.json()["templates"] if t["type"] == "quote"]
    active_quote_templates = [t for t in quote_templates if t["is_active"]]

    assert len(active_quote_templates) == 1
    second_active = active_quote_templates[0]
    assert second_active["id"] != first_active["id"]
    assert second_active["version"] > first_active["version"]
    deactivated = next(t for t in quote_templates if t["id"] == first_active["id"])
    assert deactivated["is_active"] is False
