"""Loader tests against the REAL corpus (backend/knowledge_corpus) — no DB.

Proves the engine reads the actual corpus built in the earlier phases and
extracts its metadata, without inventing anything. Runs locally
(``pytest --noconftest app/tests/test_knowledge_loader_corpus.py``).
"""

from pathlib import Path

import pytest

from app.knowledge.loader import load_corpus


def _corpus_root() -> Path:
    # backend/app/tests/<file> -> parents[2] is the backend/ root.
    return Path(__file__).resolve().parents[2] / "knowledge_corpus"


@pytest.mark.skipif(not _corpus_root().is_dir(), reason="corpus not present")
def test_loads_the_real_plomberie_book() -> None:
    items = load_corpus(_corpus_root())
    slugs = {item.slug for item in items}

    # The Book I plomberie cards are found.
    assert "remplacer-cartouche-mitigeur" in slugs
    assert "deboucher-evacuation-sanitaire" in slugs
    cards = [item for item in items if item.type == "card"]
    assert len(cards) >= 6

    # Every content item has a known status (honest: current corpus is draft).
    assert all(item.status in {"brouillon", "valide", "archive"} for item in items)

    # A known card carries its taxonomy tags and its type.
    card = next(item for item in items if item.slug == "remplacer-cartouche-mitigeur")
    assert card.type == "card"
    assert "metier:plomberie" in card.tags
    assert card.status == "brouillon"

    # Supporting content types are picked up too.
    types = {item.type for item in items}
    assert {"kit", "diagnostic", "checklist", "procedure", "phrase"} & types
