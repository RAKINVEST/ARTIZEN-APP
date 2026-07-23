"""Gold Standard certification — the scientific guarantee that the *reference
itself* is trustworthy.

The oracle proves the engine is faithful **to the Gold Standard**. But who proves
the Gold Standard is correct? A benchmark built on a wrong reference certifies
nothing. So a reference is not one person's reconstruction — it is a **Double
Gold**:

    PDF ──▶ Gold A   (annotator 1, independently)
    PDF ──▶ Gold B   (annotator 2, independently)
    Gold A ──vs── Gold B   →   agreement

If A and B agree (renders match above threshold), the reference is **certified**.
If they disagree, it goes to **review** — never silently trusted. The agreement
score is the 6th KPI (*inter-annotator agreement*): the higher it is, the more
credible the corpus.

Governance in three states — **Draft → Reviewed → Certified** — and only a
``certified`` document enters the *official* benchmark. ``certified`` can be
reached **only** through :func:`certify_gold_standard` (a measured double-gold
agreement), never set by hand.
"""

import json
from dataclasses import dataclass, field
from pathlib import Path

from app.document_clone.artizen_format import ArtizenTemplate
from app.document_clone.comparator import compare_pdfs
from app.document_clone.ingest import (
    STATUS_GOLD_STANDARD,
    _resolve_source_dir,
    load_manifest,
    save_manifest,
)
from app.document_clone.renderer import render_artizen

# The three governance states of a reference.
GOLD_DRAFT = "draft"          # a Gold has been authored
GOLD_REVIEWED = "reviewed"    # a human has checked it (or A/B disagreed)
GOLD_CERTIFIED = "certified"  # two independent Golds agree — official truth

#: Renders of two independent Golds must match at least this much to certify.
#: **Empirical and provisional** — a starting point, not a truth. To be
#: recalibrated from the first real data (see GOLD_STANDARD_PROTOCOL.md §1);
#: changing it is a dated amendment, not a silent tweak.
AGREEMENT_THRESHOLD = 99.0


@dataclass
class CertificationResult:
    ok: bool
    doc_id: str
    agreement: float | None = None
    state: str = GOLD_DRAFT
    messages: list[str] = field(default_factory=list)


def _render_gold(tpl_path: Path, data_path: Path) -> bytes:
    template = ArtizenTemplate.model_validate_json(tpl_path.read_text(encoding="utf-8"))
    data = json.loads(data_path.read_text(encoding="utf-8")) if data_path.exists() else {}
    return render_artizen(template, data.get("fields", {}), data.get("rows", []))


def inter_annotator_agreement(render_a: bytes, render_b: bytes) -> float:
    """How much two independent reconstructions agree — measured by the very same
    oracle used for fidelity. This *is* the 6th KPI."""
    return compare_pdfs(render_a, render_b).overall


def _find_entry(manifest: dict, doc_id: str) -> dict | None:
    return next((d for d in manifest.get("documents", []) if d.get("id") == doc_id), None)


def set_gold_status(corpus_dir: Path, doc_id: str, status: str) -> CertificationResult:
    """Manual state transitions — **Draft** and **Reviewed** only. ``certified``
    is refused here: it is earned, not declared (see :func:`certify_gold_standard`)."""
    if status == GOLD_CERTIFIED:
        return CertificationResult(
            ok=False, doc_id=doc_id, state=GOLD_DRAFT,
            messages=["'certified' ne peut être posé que par certify_gold_standard (double gold)."],
        )
    manifest = load_manifest(corpus_dir)
    entry = _find_entry(manifest, doc_id)
    if entry is None:
        return CertificationResult(ok=False, doc_id=doc_id, messages=[f"Inconnu : {doc_id}"])
    entry["gold_status"] = status
    save_manifest(corpus_dir, manifest)
    return CertificationResult(ok=True, doc_id=doc_id, state=status, messages=[f"{doc_id} → {status}"])


def certify_gold_standard(
    corpus_dir: Path, doc_id: str, *, threshold: float = AGREEMENT_THRESHOLD
) -> CertificationResult:
    """Run the Double Gold protocol and certify the reference iff the two
    independent Golds agree. Requires Gold A (``<id>.artizen.json`` + ``.data``)
    **and** Gold B (``<id>.gold-b.artizen.json`` + ``.gold-b.data.json``). On
    success, freezes ``<id>.expected.pdf`` from Gold A and marks the manifest
    certified; on disagreement, marks it reviewed and asks for resolution."""
    manifest = load_manifest(corpus_dir)
    entry = _find_entry(manifest, doc_id)
    if entry is None:
        return CertificationResult(ok=False, doc_id=doc_id, messages=[f"Inconnu au manifeste : {doc_id}"])

    src = _resolve_source_dir(corpus_dir, entry["software"])
    a_tpl, a_data = src / f"{doc_id}.artizen.json", src / f"{doc_id}.data.json"
    b_tpl, b_data = src / f"{doc_id}.gold-b.artizen.json", src / f"{doc_id}.gold-b.data.json"

    if not (a_tpl.exists() and a_data.exists()):
        return CertificationResult(
            ok=False, doc_id=doc_id, state=GOLD_DRAFT,
            messages=["Gold A absent (.artizen.json + .data.json)."],
        )
    if not (b_tpl.exists() and b_data.exists()):
        # A single reconstruction can never be certified — that is the whole point.
        entry.setdefault("gold_status", GOLD_DRAFT)
        save_manifest(corpus_dir, manifest)
        return CertificationResult(
            ok=False, doc_id=doc_id, state=entry["gold_status"],
            messages=["Certification impossible : un second Gold indépendant (gold-b) est requis."],
        )

    agreement = round(inter_annotator_agreement(_render_gold(a_tpl, a_data), _render_gold(b_tpl, b_data)), 2)
    entry["agreement"] = agreement

    if agreement >= threshold:
        (src / f"{doc_id}.expected.pdf").write_bytes(_render_gold(a_tpl, a_data))
        entry["gold_status"] = GOLD_CERTIFIED
        entry["gold_standard"] = True
        entry["status"] = STATUS_GOLD_STANDARD
        entry["manual_review_required"] = False
        save_manifest(corpus_dir, manifest)
        return CertificationResult(
            ok=True, doc_id=doc_id, agreement=agreement, state=GOLD_CERTIFIED,
            messages=[f"Accord A/B {agreement} % ≥ {threshold} % → certifié."],
        )

    entry["gold_status"] = GOLD_REVIEWED
    entry["gold_standard"] = False
    save_manifest(corpus_dir, manifest)
    return CertificationResult(
        ok=False, doc_id=doc_id, agreement=agreement, state=GOLD_REVIEWED,
        messages=[f"Désaccord A/B : {agreement} % < {threshold} % → révision humaine requise."],
    )
