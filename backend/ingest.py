#!/usr/bin/env python
"""Corpus ingest CLI — ``python ingest.py``.

Runs the full ingest pipeline (validation → analyzer → anonymisation →
classement → manifeste) for one or more PDFs, lists the corpus, and performs the
human governance step that promotes a document to Gold Standard.

Meant to be run in the backend container (drop your PDFs somewhere under
``backend/`` first, since only that tree is mounted)::

    docker compose exec backend python ingest.py inbox/mon-devis.pdf --software Batappli
    docker compose exec backend python ingest.py --list
    docker compose exec backend python ingest.py --promote batappli-001
"""

import argparse
from pathlib import Path

from app.document_clone.ingest import (
    ingest_pdf,
    load_manifest,
    promote_to_gold_standard,
)

_DEFAULT_CORPUS = Path(__file__).parent / "Corpus"


def _print_list(corpus_dir: Path) -> None:
    docs = load_manifest(corpus_dir).get("documents", [])
    if not docs:
        print("Manifeste vide — aucun document ingéré.")
        return
    print(f"{len(docs)} document(s) au manifeste :\n")
    for d in docs:
        gs = "★ Gold Standard" if d.get("gold_standard") else d.get("status", "?")
        review = "  ⚠ à relire" if d.get("manual_review_required") else ""
        print(f"  {d['id']:<20} {d['software']:<12} {d.get('kind','?'):<8} {gs}{review}")


def main() -> None:
    parser = argparse.ArgumentParser(description="ARTIZEN corpus ingest")
    parser.add_argument("pdfs", nargs="*", type=Path, help="PDF(s) to ingest")
    parser.add_argument("--corpus", type=Path, default=_DEFAULT_CORPUS)
    parser.add_argument("--software", help="source software, e.g. Batappli")
    parser.add_argument("--type", default="devis", dest="document_type")
    parser.add_argument("--id", dest="doc_id", help="force an id (else auto-numbered)")
    parser.add_argument(
        "--layout-family",
        dest="layout_family",
        help="shared layout id (e.g. word-modele-A) — flags disguised duplicates",
    )
    parser.add_argument("--list", action="store_true", help="show the manifest")
    parser.add_argument("--promote", metavar="ID", help="human step: promote to Gold Standard")
    args = parser.parse_args()

    if args.list:
        _print_list(args.corpus)
        return

    if args.promote:
        result = promote_to_gold_standard(args.corpus, args.promote)
        print("\n".join(result.messages))
        return

    if not args.pdfs or not args.software:
        parser.error("donnez au moins un PDF et --software (ou utilisez --list / --promote)")

    for pdf in args.pdfs:
        result = ingest_pdf(
            args.corpus,
            pdf,
            software=args.software,
            document_type=args.document_type,
            doc_id=args.doc_id if len(args.pdfs) == 1 else None,
            layout_family=args.layout_family,
        )
        header = f"✓ {result.id}" if result.ok else f"✗ {pdf.name}"
        print(f"\n{header}")
        for m in result.messages:
            print(f"  {m}")
        if result.ok:
            print(f"  → {result.stored_path}  (status: {result.entry['status']})")


if __name__ == "__main__":
    main()
