"""Tests for the document-analysis module: upload, hashing, metadata,
status transitions, full pipeline execution, and invalid-PDF handling.

Same known limitation as ``test_branding.py``: these hit the real
database configured for the running environment, no dedicated test DB.
"""

import hashlib
import io
from io import BytesIO

import pytest
from httpx import AsyncClient
from pypdf import PdfWriter


def _make_pdf_bytes(pages: int = 1) -> bytes:
    """Build a minimal, genuinely valid PDF using pypdf itself — no extra
    test-only dependency needed since pypdf is already required by the
    pipeline."""
    writer = PdfWriter()
    for _ in range(pages):
        writer.add_blank_page(width=200, height=200)
    buffer = BytesIO()
    writer.write(buffer)
    return buffer.getvalue()


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


async def test_upload_valid(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=1)

    response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["status"] == "uploaded"
    assert body["filename"] == "devis.pdf"
    assert body["mime_type"] == "application/pdf"
    assert body["file_size"] == len(pdf_bytes)
    assert body["document_type"] == "quote"
    assert body["page_count"] is None  # not known until /process runs


async def test_hash_computation(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=1)
    expected_hash = hashlib.sha256(pdf_bytes).hexdigest()

    response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "invoice"},
        files={"file": ("facture.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["file_hash"] == expected_hash
    assert len(body["file_hash"]) == 64


async def test_metadata_extraction(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=2)
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]

    process_response = await client.post(f"/api/document-analysis/{analysis_id}/process")

    assert process_response.status_code == 200
    metadata = process_response.json()["extracted_metadata"]
    assert metadata["filename"] == "devis.pdf"
    assert metadata["mime_type"] == "application/pdf"
    assert metadata["file_size"] == len(pdf_bytes)
    assert metadata["page_count"] == 2
    assert "imported_at" in metadata


async def test_status_transitions(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=1)
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]
    assert upload_response.json()["status"] == "uploaded"

    get_response = await client.get(f"/api/document-analysis/{analysis_id}")
    assert get_response.json()["status"] == "uploaded"

    process_response = await client.post(f"/api/document-analysis/{analysis_id}/process")
    assert process_response.json()["status"] == "completed"

    get_after_response = await client.get(f"/api/document-analysis/{analysis_id}")
    assert get_after_response.json()["status"] == "completed"


async def test_full_pipeline_execution(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=3)
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "invoice"},
        files={"file": ("facture.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]

    response = await client.post(f"/api/document-analysis/{analysis_id}/process")

    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "completed"
    assert body["page_count"] == 3
    assert isinstance(body["extracted_text"], str)
    assert body["processing_time_ms"] is not None
    assert body["processing_time_ms"] >= 0

    layout = body["detected_layout"]
    assert layout["page_count"] == 3
    assert len(layout["pages"]) == 3

    blueprint = body["blueprint"]
    assert blueprint["version"] == 1
    assert blueprint["page_count"] == 3
    assert blueprint["text_zones"] == []
    assert set(blueprint.keys()) == {
        "version",
        "page_count",
        "logo",
        "text_zones",
        "main_table",
        "footer",
        "variables",
        "company_coordinates",
    }


async def test_invalid_pdf_handling(client: AsyncClient, company_id: str) -> None:
    garbage = b"this is not a real PDF file"
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        # Content-type claims PDF so it passes the shallow upload check —
        # the actual structural validation only happens during /process.
        files={"file": ("broken.pdf", io.BytesIO(garbage), "application/pdf")},
    )
    assert upload_response.status_code == 201
    analysis_id = upload_response.json()["id"]

    process_response = await client.post(f"/api/document-analysis/{analysis_id}/process")

    assert process_response.status_code == 200
    body = process_response.json()
    assert body["status"] == "failed"
    assert body["page_count"] is None
    assert body["blueprint"] is None


async def test_list_analyses(client: AsyncClient, company_id: str) -> None:
    pdf_bytes = _make_pdf_bytes(pages=1)
    await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(pdf_bytes), "application/pdf")},
    )

    response = await client.get("/api/document-analysis", params={"company_id": company_id})

    assert response.status_code == 200
    body = response.json()
    assert isinstance(body, list)
    assert len(body) >= 1
    assert all(item["company_id"] == company_id for item in body)
