"""Tests for the corpus ingest pipeline.

The pipeline must be safe (unreadable files turned away), private (PII gone from
the stored file), traceable (a manifest entry per document), and — the crux —
**governed**: a document only becomes a Gold Standard through the explicit human
step, never on ingest. Built on a temp corpus, no real PDFs needed.
"""

import io
import json

import fitz  # PyMuPDF
from reportlab.pdfgen import canvas

from app.document_clone.ingest import (
    ingest_pdf,
    load_manifest,
    promote_to_gold_standard,
)


def _pdf_with_pii() -> bytes:
    """A text-rich native devis (>180 chars → classified NATIVE) carrying PII."""
    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=(595, 842))
    c.setFont("Helvetica", 10)
    body = [
        "SARL Dupont Plomberie — DEVIS N DEV-2026-0007",
        "IBAN FR76 3000 4000 0123 4567 8901 234",
        "Client : M. Martin — 12 rue des Lilas, 75011 Paris",
        "Chauffe-eau ATLANTIC 150L ..................... 617,50 EUR",
        "Forfait main d'oeuvre pose et raccordement .... 200,00 EUR",
        "Depose et evacuation ancien appareil .......... 80,00 EUR",
        "Total HT 897,50 EUR — TVA 10% 89,75 EUR — TTC 987,25 EUR",
        "Conditions : acompte 30% a la commande, solde a la livraison.",
    ]
    y = 800
    for line in body:
        c.drawString(40, y, line)
        y -= 20
    c.save()
    return buf.getvalue()


def _write(tmp_path, name: str, content: bytes):
    p = tmp_path / name
    p.write_bytes(content)
    return p


def test_ingest_stores_anonymized_pdf_and_registers_manifest(tmp_path) -> None:
    src = _write(tmp_path, "in.pdf", _pdf_with_pii())

    result = ingest_pdf(tmp_path, src, software="Batappli")

    assert result.ok
    assert result.id == "batappli-001"
    stored = tmp_path / "Batappli" / "batappli-001.pdf"
    assert stored.exists()

    # The stored file is the anonymised one: the IBAN is gone, content survives.
    doc = fitz.open(stream=stored.read_bytes(), filetype="pdf")
    try:
        text = doc[0].get_text("text")
    finally:
        doc.close()
    assert "4567 8901 234" not in text
    assert "ATLANTIC" in text

    entry = load_manifest(tmp_path)["documents"][0]
    assert entry["software"] == "Batappli"
    assert entry["native_pdf"] is True
    assert entry["anonymized_counts"].get("iban") == 1
    # Governance: never a Gold Standard on ingest.
    assert entry["gold_standard"] is False
    assert entry["status"] == "pending_extraction"
    assert entry["manual_review_required"] is True


def test_ingest_auto_increments_ids_per_software(tmp_path) -> None:
    a = _write(tmp_path, "a.pdf", _pdf_with_pii())
    b = _write(tmp_path, "b.pdf", _pdf_with_pii())

    r1 = ingest_pdf(tmp_path, a, software="EBP")
    r2 = ingest_pdf(tmp_path, b, software="EBP")

    assert r1.id == "ebp-001"
    assert r2.id == "ebp-002"
    assert len(load_manifest(tmp_path)["documents"]) == 2


def test_layout_family_flags_disguised_duplicates(tmp_path) -> None:
    a = _write(tmp_path, "a.pdf", _pdf_with_pii())
    b = _write(tmp_path, "b.pdf", _pdf_with_pii())

    r1 = ingest_pdf(tmp_path, a, software="Word", layout_family="word-modele-A")
    r2 = ingest_pdf(tmp_path, b, software="Word", layout_family="word-modele-A")

    assert r1.entry["layout_family"] == "word-modele-A"
    # The second document reusing the family is flagged, not silently accepted.
    assert any("Doublon déguisé" in m for m in r2.messages)


def test_unreadable_file_is_rejected_not_ingested(tmp_path) -> None:
    bad = _write(tmp_path, "bad.pdf", b"this is not a pdf")

    result = ingest_pdf(tmp_path, bad, software="Word")

    assert result.ok is False
    assert not (tmp_path / "manifest.json").exists()


def test_gold_standard_requires_the_full_triplet_and_a_human_step(tmp_path) -> None:
    src = _write(tmp_path, "in.pdf", _pdf_with_pii())
    ingest_pdf(tmp_path, src, software="Batappli")

    # Promotion refused while the triplet is incomplete — no wrong reference.
    refused = promote_to_gold_standard(tmp_path, "batappli-001")
    assert refused.ok is False
    assert "incomplet" in refused.messages[0].lower()

    # Complete the triplet, then the explicit human promotion succeeds.
    folder = tmp_path / "Batappli"
    (folder / "batappli-001.artizen.json").write_text("{}", encoding="utf-8")
    (folder / "batappli-001.expected.pdf").write_bytes(_pdf_with_pii())

    promoted = promote_to_gold_standard(tmp_path, "batappli-001")
    assert promoted.ok is True

    entry = load_manifest(tmp_path)["documents"][0]
    assert entry["gold_standard"] is True
    assert entry["status"] == "gold_standard"
    assert entry["manual_review_required"] is False
