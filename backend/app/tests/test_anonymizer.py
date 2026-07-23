"""Tests for the corpus anonymiser.

The legal guard rail: structured PII must be gone from a document before it lands
in the corpus, while the layout the clone engine studies stays intact. Text-level
tests pin the detection; a synthetic PDF proves the redaction actually removes the
data from the file (re-extracted text no longer contains it).
"""

import io

import fitz  # PyMuPDF
from reportlab.pdfgen import canvas

from app.document_clone.anonymizer import anonymize_pdf, anonymize_text


def test_structured_pii_is_replaced_by_neutral_tokens() -> None:
    text = (
        "SARL Dupont — email jean.dupont@artisan-plomberie.fr — "
        "IBAN FR76 3000 4000 0123 4567 8901 234 — "
        "tel 06 12 34 56 78 — SIRET 812 345 678 00012"
    )

    result = anonymize_text(text)

    assert "jean.dupont@artisan-plomberie.fr" not in result.text
    assert "FR76 3000 4000 0123 4567 8901 234" not in result.text
    assert "06 12 34 56 78" not in result.text
    assert "812 345 678 00012" not in result.text
    assert result.counts == {"email": 1, "iban": 1, "phone": 1, "siret": 1}
    # Neutral tokens took their place.
    assert "contact@exemple.fr" in result.text


def test_non_pii_text_is_left_untouched() -> None:
    text = "Chauffe-eau ATLANTIC 150L — Forfait main d'oeuvre — Total HT 617,50 €"

    result = anonymize_text(text)

    assert result.text == text
    assert result.counts == {}


def test_result_never_echoes_the_original_pii() -> None:
    result = anonymize_text("IBAN FR76 3000 4000 0123 4567 8901 234")

    # counts carry a tally, not the sensitive value.
    assert result.counts == {"iban": 1}
    assert "4567 8901" not in "".join(map(str, result.counts))


def _pdf_with_pii() -> bytes:
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=(595, 842))
    c.setFont("Helvetica", 10)
    c.drawString(40, 800, "SARL Dupont Plomberie")
    c.drawString(40, 780, "IBAN FR76 3000 4000 0123 4567 8901 234")
    c.drawString(40, 760, "Tel 06 12 34 56 78")
    c.drawString(40, 740, "SIRET 812 345 678 00012")
    c.drawString(40, 720, "Chauffe-eau ATLANTIC 150L")  # not PII — must survive
    c.save()
    return buf.getvalue()


def test_pdf_redaction_removes_the_data_from_the_file() -> None:
    result = anonymize_pdf(_pdf_with_pii())

    doc = fitz.open(stream=result.content, filetype="pdf")
    try:
        text = doc[0].get_text("text")
    finally:
        doc.close()

    # The sensitive strings are gone from the actual file bytes' text layer…
    assert "4567 8901 234" not in text
    assert "06 12 34 56 78" not in text
    assert "812 345 678 00012" not in text
    # …but the document's non-PII content is preserved.
    assert "ATLANTIC" in text
    assert result.counts.get("iban") == 1
    assert result.counts.get("phone") == 1
