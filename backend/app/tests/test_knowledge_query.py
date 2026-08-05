"""Pure unit tests for the Knowledge Engine (no DB, no HTTP).

Pin the deterministic core — parsing, search, taxonomy filtering, the
validated-only default, ranking and a search-performance bound. Run without a
database (``pytest --noconftest app/tests/test_knowledge_query.py``).
"""

import time

from app.knowledge.loader import parse_item
from app.knowledge.query import search
from app.knowledge.schemas import KnowledgeItem

_SAMPLE = """# Remplacer un mitigeur

| Statut | Brouillon |
| Indice de confiance | **C** |

- **Tags** : `metier:plomberie famille:fluides sous-famille:robinetterie intervention:remplacer equipement:mitigeur`

Rétablir l'étanchéité d'un mitigeur.

Voir [kit](../../../kits/plomberie/kit-robinetterie.md).
"""


def _item(slug: str, *, status: str = "valide", confidence: str = "", tags=None, type_="card",
          title="Mitigeur") -> KnowledgeItem:
    return KnowledgeItem(
        slug=slug, type=type_, title=title, status=status, confidence=confidence,
        tags=list(tags or []),
    )


def test_parse_item_extracts_metadata() -> None:
    item = parse_item("professions/plomberie/cards/remplacer-mitigeur.md", _SAMPLE)
    assert item.slug == "remplacer-mitigeur"
    assert item.type == "card"
    assert item.title == "Remplacer un mitigeur"
    assert item.status == "brouillon"
    assert item.confidence == "C"
    assert item.profession == "plomberie"
    assert "metier:plomberie" in item.tags
    assert "intervention:remplacer" in item.tags
    assert "kit-robinetterie" in item.relations


def test_search_returns_validated_only_by_default() -> None:
    validated = _item("v", status="valide", tags=["metier:plomberie"])
    draft = _item("d", status="brouillon", tags=["metier:plomberie"])
    result = search([validated, draft], q="mitigeur")
    assert [m.item.slug for m in result] == ["v"]  # draft excluded by default
    with_drafts = search([validated, draft], q="mitigeur", include_drafts=True)
    assert {m.item.slug for m in with_drafts} == {"v", "d"}


def test_search_filters_by_taxonomy() -> None:
    a = _item("a", tags=["metier:plomberie"])
    b = _item("b", tags=["metier:peinture"])
    result = search([a, b], filters={"metier": "plomberie"})
    assert [m.item.slug for m in result] == ["a"]


def test_search_filters_by_type_and_explains() -> None:
    kit = _item("k", type_="kit", title="Kit")
    card = _item("c", type_="card", title="Card")
    result = search([kit, card], filters={"type": "kit"})
    assert [m.item.slug for m in result] == ["k"]
    assert result[0].why  # never a black box (Loi 6)


def test_ranking_prefers_higher_confidence_and_is_deterministic() -> None:
    high = _item("h", confidence="A")
    low = _item("l", confidence="D")
    result = search([low, high], q="mitigeur")
    assert result[0].item.slug == "h"  # equal relevance -> confidence decides
    assert search([low, high], q="mitigeur") == search([low, high], q="mitigeur")


def test_search_performance_over_many_items() -> None:
    items = [
        _item(f"s{i}", tags=["metier:plomberie"], title=f"Mitigeur {i}") for i in range(2000)
    ]
    start = time.perf_counter()
    result = search(items, q="mitigeur", limit=20)
    elapsed = time.perf_counter() - start
    assert len(result) == 20
    assert elapsed < 1.0  # generous bound; deterministic search stays fast
