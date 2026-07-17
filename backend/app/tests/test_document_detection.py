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


@pytest.mark.parametrize(
    "text",
    [
        "Facture N 20240101120000",
        "Devis du 20240101120000 pour travaux",
        "Reference 12345678901234",
    ],
)
async def test_siret_detector_ignores_unlabeled_digits_that_fail_luhn(text: str) -> None:
    """Unlabeled, the Luhn checksum is the only evidence there is — without
    it, any 14-digit run qualifies, and a timestamp like "20240101120000"
    was reported as a SIRET."""
    result = await SiretDetector().detect(text)

    assert result.detected is False
    assert result.data["siret"] is None


async def test_siret_detector_trusts_a_labeled_siret_even_if_luhn_fails() -> None:
    """The label is strong evidence in itself: a bad checksum next to the
    word "SIRET" is likelier a typo or an OCR slip than a coincidence. It
    is reported, at lower confidence."""
    result = await SiretDetector().detect("SIRET : 123 456 789 00012")

    assert result.detected is True
    assert result.data["siret"] == "12345678900012"
    assert result.confidence == 0.6


async def test_siret_detector_finds_unlabeled_siret_that_passes_luhn() -> None:
    result = await SiretDetector().detect("Entreprise Dupont 35600000000048 Paris")

    assert result.detected is True
    assert result.data["siret"] == "35600000000048"


async def test_siret_detector_skips_a_date_preceding_the_real_siret() -> None:
    """Scanning stops at the first *valid* candidate, not the first
    14-digit run — a document often carries a date or an invoice number
    before the SIRET itself."""
    result = await SiretDetector().detect("Emis le 20240101120000 - SARL X - 35600000000048")

    assert result.data["siret"] == "35600000000048"


async def test_vat_detector_finds_french_vat() -> None:
    result = await VatDetector().detect(_SAMPLE_TEXT)

    assert result.detected is True
    assert result.data["vat_number"] == "FR12345678901"


@pytest.mark.parametrize(
    "word",
    ["DESIGNATION", "PLOMBERIE", "ELECTRICITE", "SERRURERIE"],
)
async def test_vat_detector_ignores_uppercase_french_words(word: str) -> None:
    """The EU fallback matches a country code followed by an alphanumeric
    body. Without a digit floor, ordinary uppercase words are valid
    candidates — "DESIGNATION" reads as DE + SIGNATION, and it happens to
    be the column header of essentially every French quote, so almost any
    document reported a VAT number the artisan could then validate into
    ``Company.vat_number``."""
    result = await VatDetector().detect(f"SARL {word} DUPONT\n{word}   QTE   PRIX")

    assert result.detected is False
    assert result.data["vat_number"] is None


@pytest.mark.parametrize(
    "text,expected",
    [
        ("TVA intracom : DE123456789", "DE123456789"),
        ("BE0123456789", "BE0123456789"),
        ("IE1234567FA", "IE1234567FA"),
        # 12-character body: the longest real format still has to match.
        ("NL123456789B01", "NL123456789B01"),
    ],
)
async def test_vat_detector_still_finds_real_eu_vat(text: str, expected: str) -> None:
    result = await VatDetector().detect(text)

    assert result.detected is True
    assert result.data["vat_number"] == expected


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
