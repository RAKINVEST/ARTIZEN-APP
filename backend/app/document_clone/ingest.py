"""Corpus ingest pipeline — the last piece of infrastructure that is genuinely
justified before Brique 4, because it makes **no assumption about the documents**:
it only automates their safe entry into the corpus.

    PDF original
        ↓  Validation      (lisible ? pages ?)
        ↓  Analyzer        (natif/hybride/image + ★)
        ↓  Anonymiseur     (PII structurée retirée)
        ↓  Classement      Corpus/<logiciel>/<id>.pdf   (version anonymisée)
        ↓  Manifeste       manifest.json (source de vérité) — statut pending_extraction

**Governance rule, enforced here:** a document *never* enters the Gold Standard
automatically. Ingest always records ``gold_standard: false`` /
``status: pending_extraction``. Only :func:`promote_to_gold_standard` — an
explicit human step, requiring the full validated triplet on disk — flips it.
This is what prevents a wrong reference from poisoning every later benchmark.
"""

import json
import re
import unicodedata
from dataclasses import dataclass, field
from pathlib import Path

import fitz  # PyMuPDF

from app.document_analysis.pdf_classifier import PdfKind, classify_pdf
from app.document_clone.anonymizer import anonymize_pdf

_MANIFEST = "manifest.json"

# The corpus lifecycle — a document climbs these, and only the last is a trusted
# reference. Ingest sets the first; a human sets the last.
STATUS_PENDING_EXTRACTION = "pending_extraction"
STATUS_EXTRACTED = "extracted"
STATUS_PENDING_VALIDATION = "pending_validation"
STATUS_GOLD_STANDARD = "gold_standard"
STATUS_REJECTED = "rejected"


@dataclass
class IngestResult:
    ok: bool
    id: str | None = None
    software: str | None = None
    stored_path: str | None = None
    entry: dict | None = None
    messages: list[str] = field(default_factory=list)


def _slug(text: str) -> str:
    ascii_text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()
    return re.sub(r"[^a-z0-9]+", "-", ascii_text.lower()).strip("-") or "doc"


def validate_pdf(content: bytes) -> tuple[bool, str]:
    """The gate: is this a readable PDF with at least one page? Text-selectability
    is *not* a reject reason — a scan is a legitimate corpus member (OCR route),
    only flagged. A truly unreadable file is turned away before it enters."""
    try:
        doc = fitz.open(stream=content, filetype="pdf")
    except Exception:
        return False, "PDF illisible (ouverture impossible)"
    try:
        if doc.page_count == 0:
            return False, "PDF sans page"
    finally:
        doc.close()
    return True, ""


def load_manifest(corpus_dir: Path) -> dict:
    path = corpus_dir / _MANIFEST
    if path.exists():
        return json.loads(path.read_text(encoding="utf-8"))
    return {"documents": []}


def save_manifest(corpus_dir: Path, manifest: dict) -> None:
    (corpus_dir / _MANIFEST).write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def _upsert(manifest: dict, entry: dict) -> None:
    docs = manifest.setdefault("documents", [])
    for i, existing in enumerate(docs):
        if existing.get("id") == entry["id"]:
            docs[i] = entry
            return
    docs.append(entry)


def _next_id(manifest: dict, software_slug: str) -> str:
    highest = 0
    for doc in manifest.get("documents", []):
        m = re.fullmatch(rf"{re.escape(software_slug)}-(\d+)", doc.get("id", ""))
        if m:
            highest = max(highest, int(m.group(1)))
    return f"{software_slug}-{highest + 1:03d}"


def _resolve_source_dir(corpus_dir: Path, software: str) -> Path:
    """Match an existing source folder case-insensitively, else create one."""
    for child in corpus_dir.iterdir():
        if child.is_dir() and child.name.lower() == software.lower():
            return child
    target = corpus_dir / software
    target.mkdir(parents=True, exist_ok=True)
    return target


def ingest_pdf(
    corpus_dir: Path,
    pdf_path: Path,
    *,
    software: str,
    document_type: str = "devis",
    doc_id: str | None = None,
    layout_family: str | None = None,
) -> IngestResult:
    """Run the full pipeline for one PDF and register it in the manifest.

    ``layout_family`` groups documents that share the *same underlying layout*
    (e.g. two devis from one Word template). The Starter Corpus must be
    structurally diverse, so a repeated family is a *disguised duplicate* — it is
    flagged, not silently accepted."""
    content = pdf_path.read_bytes()

    ok, reason = validate_pdf(content)
    if not ok:
        return IngestResult(ok=False, software=software, messages=[reason])

    quality = classify_pdf(content)
    native = quality.kind is PdfKind.NATIVE
    anonymized = anonymize_pdf(content)

    corpus_dir.mkdir(parents=True, exist_ok=True)  # bootstrap an empty corpus
    manifest = load_manifest(corpus_dir)
    doc_id = doc_id or _next_id(manifest, _slug(software))
    source_dir = _resolve_source_dir(corpus_dir, software)
    stored = source_dir / f"{doc_id}.pdf"
    stored.write_bytes(anonymized.content)

    messages = [
        f"Analyzer : {quality.kind.value} {'★' * quality.stars} ({quality.page_count} p.)",
        f"Anonymiseur : {anonymized.counts or 'aucune PII structurée détectée'}",
        "⚠ Relecture humaine requise : noms, adresses, BIC et signatures ne sont "
        "PAS auto-anonymisés" + ("" if native else " ; PII en image non retirée (scan)"),
    ]

    if layout_family and any(
        d.get("layout_family") == layout_family for d in manifest.get("documents", [])
    ):
        messages.append(
            f"⚠ Doublon déguisé possible : la layout_family '{layout_family}' existe "
            "déjà — le Starter Corpus doit être structurellement diversifié."
        )

    entry = {
        "id": doc_id,
        "software": software,
        "document_type": document_type,
        "layout_family": layout_family,
        "pages": quality.page_count,
        "kind": quality.kind.value,
        "stars": quality.stars,
        "native_pdf": native,
        "anonymized": True,
        "anonymized_counts": anonymized.counts,
        "manual_review_required": True,
        "gold_standard": False,           # never set automatically — governance
        "status": STATUS_PENDING_EXTRACTION,
    }
    _upsert(manifest, entry)
    save_manifest(corpus_dir, manifest)

    return IngestResult(
        ok=True,
        id=doc_id,
        software=software,
        stored_path=str(stored),
        entry=entry,
        messages=messages,
    )


def promote_to_gold_standard(corpus_dir: Path, doc_id: str) -> IngestResult:
    """The **only** path to a Gold Standard, and an explicit human act. Requires
    the full triplet on disk (``.pdf`` + ``.artizen.json`` + ``.expected.pdf``);
    refuses otherwise, so no half-built reference can ever skew the benchmark."""
    manifest = load_manifest(corpus_dir)
    entry = next(
        (d for d in manifest.get("documents", []) if d.get("id") == doc_id), None
    )
    if entry is None:
        return IngestResult(ok=False, id=doc_id, messages=[f"Inconnu au manifeste : {doc_id}"])

    source_dir = _resolve_source_dir(corpus_dir, entry["software"])
    required = [
        source_dir / f"{doc_id}.pdf",
        source_dir / f"{doc_id}.artizen.json",
        source_dir / f"{doc_id}.expected.pdf",
    ]
    missing = [p.name for p in required if not p.exists()]
    if missing:
        return IngestResult(
            ok=False,
            id=doc_id,
            messages=[f"Triplet incomplet, promotion refusée. Manque : {', '.join(missing)}"],
        )

    entry["gold_standard"] = True
    entry["status"] = STATUS_GOLD_STANDARD
    entry["manual_review_required"] = False
    _upsert(manifest, entry)
    save_manifest(corpus_dir, manifest)
    return IngestResult(ok=True, id=doc_id, entry=entry, messages=[f"{doc_id} promu Gold Standard."])
