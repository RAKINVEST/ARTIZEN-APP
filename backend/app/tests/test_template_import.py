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
from PIL import Image as PILImage
from pypdf import PdfWriter
from reportlab.lib.utils import ImageReader
from reportlab.pdfgen import canvas


def _make_pdf_bytes(pages: int = 1) -> bytes:
    writer = PdfWriter()
    for _ in range(pages):
        writer.add_blank_page(width=200, height=200)
    buffer = io.BytesIO()
    writer.write(buffer)
    return buffer.getvalue()


def _make_pdf_with_logo() -> bytes:
    """A one-page PDF carrying a real embedded image in the top-left corner,
    so ``document_detection`` reports ``logo_detected`` and the import has a
    logo to extract. reportlab is a runtime dependency now (the PDF engine),
    so building a fixture with it costs no new dependency."""
    logo = PILImage.new("RGB", (60, 40), (200, 30, 30))
    logo_buffer = io.BytesIO()
    logo.save(logo_buffer, format="PNG")
    logo_buffer.seek(0)

    pdf_buffer = io.BytesIO()
    c = canvas.Canvas(pdf_buffer, pagesize=(400, 400))
    c.drawImage(ImageReader(logo_buffer), 20, 340, width=60, height=40)
    c.drawString(50, 50, "SARL Chapot")
    c.save()
    return pdf_buffer.getvalue()


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


def test_extract_first_image_png_returns_png_bytes() -> None:
    from app.document_detection.logo_detector import extract_first_image_png

    result = extract_first_image_png(_make_pdf_with_logo())

    assert result is not None
    assert result.startswith(b"\x89PNG\r\n\x1a\n")


def test_extract_first_image_png_returns_none_without_an_image() -> None:
    from app.document_detection.logo_detector import extract_first_image_png

    assert extract_first_image_png(_make_pdf_bytes()) is None


def _make_pdf_with_full_page_image() -> bytes:
    """A one-page PDF whose only image *is* the whole page — the shape of a
    scan or an "export as image" quote. It must never be mistaken for a logo:
    stamping a full page into the little header logo box was a real bug."""
    page = PILImage.new("RGB", (400, 400), (10, 14, 85))
    page_buffer = io.BytesIO()
    page.save(page_buffer, format="PNG")
    page_buffer.seek(0)

    pdf_buffer = io.BytesIO()
    c = canvas.Canvas(pdf_buffer, pagesize=(400, 400))
    c.drawImage(ImageReader(page_buffer), 0, 0, width=400, height=400)
    c.save()
    return pdf_buffer.getvalue()


def test_extract_first_image_png_skips_a_full_page_image() -> None:
    """A page-sized image is the document itself, not a logo."""
    from app.document_detection.logo_detector import extract_first_image_png

    assert extract_first_image_png(_make_pdf_with_full_page_image()) is None


async def test_logo_detector_rejects_a_full_page_image() -> None:
    """`logo_detected` must be False for a full-page image, so the import
    never extracts it as the company logo."""
    from app.document_detection.logo_detector import LogoDetector

    result = await LogoDetector().detect(_make_pdf_with_full_page_image())

    assert result.detected is False


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


async def test_validate_applies_detected_logo_to_the_brand(
    client: AsyncClient, company_id: str
) -> None:
    """The P1 bug: a real logo was detected on import but never stored, so
    every generated PDF still came out without it. Importing a PDF that
    carries a logo must leave the brand pointing at a stored logo file, and
    the rendered quote PDF must be produceable with it."""
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("ancien_devis.pdf", io.BytesIO(_make_pdf_with_logo()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]
    await client.post(f"/api/document-analysis/{analysis_id}/process")

    # Sanity: detection actually saw the logo, otherwise the test proves
    # nothing about the extraction path.
    detection = await client.get(f"/api/document-analysis/{analysis_id}/detection")
    assert detection.json()["logo_detected"] is True

    # Before validating, the brand has no logo.
    before = await client.get("/api/branding/profile")
    assert before.json()["brand"]["logo_path"] is None

    validate = await client.post(f"/api/template-import/{analysis_id}/validate", json={})

    assert validate.status_code == 200
    assert validate.json()["brand"]["logo_path"] is not None


async def test_validate_without_a_logo_leaves_the_brand_logo_untouched(
    client: AsyncClient, company_id: str
) -> None:
    """A blank import must not invent a logo: the extraction only runs when
    detection actually found one."""
    analysis_id = await _upload_and_process(client, company_id)

    validate = await client.post(f"/api/template-import/{analysis_id}/validate", json={})

    assert validate.status_code == 200
    assert validate.json()["brand"]["logo_path"] is None


async def test_sample_preview_returns_a_pdf_without_persisting_anything(
    client: AsyncClient, company_id: str
) -> None:
    """The "aperçu du rendu" (montrer avant le oui): it must render a real PDF
    from the proposed identity yet leave the company/brand untouched — the
    invariant is that nothing is applied before the artisan confirms via
    /validate."""
    analysis_id = await _upload_and_process(client, company_id)

    before = await client.get("/api/branding/profile")
    before_company = before.json()["company"]
    before_brand = before.json()["brand"]

    response = await client.post(
        f"/api/template-import/{analysis_id}/sample-preview",
        json={"legal_name": "Ne Doit Pas Etre Enregistre", "primary_color": "#abcdef"},
    )

    assert response.status_code == 200
    assert response.headers["content-type"] == "application/pdf"
    assert response.content[:4] == b"%PDF"

    after = await client.get("/api/branding/profile")
    assert after.json()["company"]["legal_name"] == before_company["legal_name"]
    assert after.json()["brand"]["primary_color"] == before_brand["primary_color"]


async def test_sample_preview_requires_completed_analysis(
    client: AsyncClient, company_id: str
) -> None:
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(_make_pdf_bytes()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]

    response = await client.post(
        f"/api/template-import/{analysis_id}/sample-preview", json={}
    )

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "document_not_processed"


async def test_sample_preview_rejects_invoice_document(
    client: AsyncClient, company_id: str
) -> None:
    analysis_id = await _upload_and_process(client, company_id, document_type="invoice")

    response = await client.post(
        f"/api/template-import/{analysis_id}/sample-preview", json={}
    )

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "invalid_document_type_for_template"


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
