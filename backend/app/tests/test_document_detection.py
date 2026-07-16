"""Tests for the document-detection module.

Unit tests exercise each regex-based text detector directly on crafted
text — fast and precise, no PDF machinery needed since these detectors
only ever consume ``extracted_text``. Integration tests drive the full
HTTP flow (upload -> process -> get detection) to check the wiring,
the 409 guard, and result caching.
"""

import io

import pytest
from httpx import AsyncClient
from pypdf import PdfWriter

from app.document_detection.contact_detector import ContactDetector
from app.document_detection.siret_detector import SiretDetector
from app.document_detection.vat_detector import VatDetector
from app.document_detection.aggregator import DetectionAggregator
from app.document_detection.color_detector import ColorDetector
from app.document_detection.footer_detector import FooterDetector
from app.document_detection.header_detector import HeaderDetector
from app.document_detection.legal_notice_detector import LegalNoticeDetector
from app.document_detection.logo_detector import LogoDetector
from app.document_detection.table_detector import TableDetector

_SAMPLE_TEXT = """Menuiserie Dupont
12 rue des Artisans
75011 Paris

SIRET : 123 456 789 00012
TVA : FR12345678901

Tél : 01 23 45 67 89
Email : contact@menuiserie-dupont.fr
Site : www.menuiserie-dupont.fr

Désignation          Quantité      Prix unitaire
Porte en bois           2            250.00
Fenêtre PVC              3            180.00
Volet roulant            1            320.00

Conditions générales de vente. RCS Paris 123 456 789.
Garantie décennale incluse."""


async def test_siret_detector_finds_valid_siret() -> None:
    result = await SiretDetector().detect(_SAMPLE_TEXT)

    assert result.detected is True
    assert result.data["siret"] == "12345678900012"
    assert result.confidence > 0.5


async def test_siret_detector_no_siret() -> None:
    result = await SiretDetector().detect("Un devis sans aucune reference chiffree.")

    assert result.detected is False
    assert result.data["siret"] is None


async def test_vat_detector_finds_french_vat() -> None:
    result = await VatDetector().detect(_SAMPLE_TEXT)

    assert result.detected is True
    assert result.data["vat_number"] == "FR12345678901"


async def test_contact_detector_finds_email() -> None:
    result = await ContactDetector().detect(_SAMPLE_TEXT)

    assert result.data["email"] == "contact@menuiserie-dupont.fr"


async def test_contact_detector_finds_phone() -> None:
    result = await ContactDetector().detect(_SAMPLE_TEXT)

    assert result.data["phone"] == "0123456789"


async def test_contact_detector_finds_website() -> None:
    result = await ContactDetector().detect(_SAMPLE_TEXT)

    assert result.data["website"] is not None
    assert "menuiserie-dupont.fr" in result.data["website"]


async def test_contact_detector_no_coordinates() -> None:
    result = await ContactDetector().detect("Ceci est un texte qui ne contient aucune coordonnee.")

    assert result.detected is False
    assert result.confidence == 0.0
    assert result.data["email"] is None
    assert result.data["phone"] is None
    assert result.data["website"] is None
    assert result.data["address"] is None


async def test_legal_notice_detector_finds_keywords() -> None:
    result = await LegalNoticeDetector().detect(_SAMPLE_TEXT)

    assert result.detected is True
    assert "rcs" in result.data["matched_keywords"]
    assert "garantie décennale" in result.data["matched_keywords"]


async def test_table_detector_finds_aligned_rows() -> None:
    result = await TableDetector().detect(_SAMPLE_TEXT)

    assert result.detected is True
    assert result.data["row_count"] >= 3


async def test_aggregator_confidence_score() -> None:
    writer = PdfWriter()
    writer.add_blank_page(width=200, height=200)
    buffer = io.BytesIO()
    writer.write(buffer)

    aggregator = DetectionAggregator(
        logo_detector=LogoDetector(),
        color_detector=ColorDetector(),
        header_detector=HeaderDetector(),
        footer_detector=FooterDetector(),
        contact_detector=ContactDetector(),
        siret_detector=SiretDetector(),
        vat_detector=VatDetector(),
        legal_notice_detector=LegalNoticeDetector(),
        table_detector=TableDetector(),
    )

    fields = await aggregator.aggregate(text=_SAMPLE_TEXT, content=buffer.getvalue())

    assert 0.0 <= fields["confidence_score"] <= 1.0
    assert fields["siret"] == "12345678900012"
    assert fields["vat_number"] == "FR12345678901"
    assert fields["table_detected"] is True
    assert len(fields["detection_details"]) == 9


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


def _make_pdf_bytes(pages: int = 1) -> bytes:
    writer = PdfWriter()
    for _ in range(pages):
        writer.add_blank_page(width=200, height=200)
    buffer = io.BytesIO()
    writer.write(buffer)
    return buffer.getvalue()


async def test_detection_requires_processed_document(client: AsyncClient, company_id: str) -> None:
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "quote"},
        files={"file": ("devis.pdf", io.BytesIO(_make_pdf_bytes()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]

    response = await client.get(f"/api/document-analysis/{analysis_id}/detection")

    assert response.status_code == 409
    assert response.json()["error"]["code"] == "document_not_processed"


async def test_detection_full_flow_and_caching(client: AsyncClient, company_id: str) -> None:
    upload_response = await client.post(
        "/api/document-analysis/upload",
        data={"company_id": company_id, "document_type": "invoice"},
        files={"file": ("facture.pdf", io.BytesIO(_make_pdf_bytes()), "application/pdf")},
    )
    analysis_id = upload_response.json()["id"]
    await client.post(f"/api/document-analysis/{analysis_id}/process")

    first_response = await client.get(f"/api/document-analysis/{analysis_id}/detection")
    assert first_response.status_code == 200
    first_body = first_response.json()
    assert first_body["document_analysis_id"] == analysis_id
    # Blank test PDF: no extractable text, so text-based fields stay empty —
    # this doubles as the "document sans coordonnées" full-flow case.
    assert first_body["siret"] is None
    assert first_body["email"] is None
    assert first_body["logo_detected"] is False

    second_response = await client.get(f"/api/document-analysis/{analysis_id}/detection")
    assert second_response.status_code == 200
    assert second_response.json()["id"] == first_body["id"]  # cached, not recomputed
