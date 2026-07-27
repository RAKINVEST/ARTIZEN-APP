"""Tests for the corpus anonymiser.

The legal guard rail: structured PII must be gone from a document before it lands
in the corpus, while the layout the clone engine studies stays intact. Text-level
tests pin the detection; a synthetic PDF proves the redaction actually removes the
data from the file (re-extracted text no longer contains it).
"""

import io

import fitz  # PyMuPDF
from PIL import Image as PILImage
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


def test_international_phone_is_redacted() -> None:
    """The +33 international form used to slip through: a leading ``\\b`` never
    matches before "+". Regression guard for that leak."""
    result = anonymize_text("Appelez le +33 6 59 19 25 95 svp")

    assert "+33 6 59 19 25 95" not in result.text
    assert result.counts.get("phone") == 1


def test_siren_alone_is_caught_but_a_siret_is_not_double_counted() -> None:
    # A bare 9-digit SIREN is redacted…
    assert anonymize_text("SIREN 812 345 678 ici").counts == {"siren": 1}
    # …and inside a 14-digit SIRET the longer pattern wins — no double count.
    assert anonymize_text("SIRET 812 345 678 00012").counts == {"siret": 1}


def test_letter_spaced_pii_is_a_known_gap_left_for_manual_review() -> None:
    """Documented limit (U-006): glyph-by-glyph digits (Mediabat) are *not*
    caught by the deterministic pass. The test pins the behaviour so it is a
    conscious, flagged gap — not a surprise regression."""
    result = anonymize_text("S i r e t 9 4 8  0 8 1  8 0 7  0 0 0 1 8")

    assert result.counts == {}  # surfaced for the semantic/manual pass, not trusted clean


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


def test_image_only_pdf_does_not_crash_and_is_returned() -> None:
    """A scan carries its PII in pixels: the anonymiser must not crash on a
    text-less page and must return the file, its empty structured tally flagging
    that a semantic/OCR pass is still owed — never pretending it is clean."""
    photo = PILImage.new("RGB", (200, 100), (120, 120, 120))
    buffer = io.BytesIO()
    photo.save(buffer, format="PNG")
    doc = fitz.open()
    doc.new_page(width=300, height=200).insert_image(
        fitz.Rect(10, 10, 210, 110), stream=buffer.getvalue()
    )
    content = doc.tobytes()
    doc.close()

    result = anonymize_pdf(content)

    assert result.content  # returned, no exception
    assert result.counts == {}  # nothing structured caught → the OCR pass is owed
