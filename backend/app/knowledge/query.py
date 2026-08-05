"""Query engine — pure, deterministic search/filter/rank over knowledge items.

Read-side and DB-free: it selects and orders existing corpus items; it never
creates or mutates one. By default it returns **only validated** knowledge
(docs/blueprint/engines/knowledge/): the corpus being currently all-draft, a
validated-only query is legitimately empty — this is surfaced, not hidden.
"""

from app.knowledge.schemas import KnowledgeItem, KnowledgeMatch

_CONFIDENCE_WEIGHT = {"A": 1.0, "B": 0.8, "C": 0.6, "D": 0.4, "": 0.3}


def _terms(text: str) -> set[str]:
    return {"".join(c for c in tok if c.isalnum()) for tok in text.lower().split()} - {""}


def _matches_filters(item: KnowledgeItem, filters: dict[str, str]) -> bool:
    for axis, value in filters.items():
        if not value:
            continue
        if axis == "type":
            if item.type != value:
                return False
        elif f"{axis}:{value}" not in item.tags:
            return False
    return True


def _relevance(item: KnowledgeItem, query_terms: set[str]) -> float:
    if not query_terms:
        return 1.0  # no text query -> filters/taxonomy carry the selection
    haystack = " ".join([item.title, item.summary, *item.tags, item.profession])
    overlap = query_terms & _terms(haystack)
    return len(overlap) / len(query_terms)


def _why(item: KnowledgeItem, query_terms: set[str], filters: dict[str, str]) -> str:
    reasons: list[str] = []
    if query_terms:
        reasons.append(f"correspond à « {' '.join(sorted(query_terms))} »")
    active = [f"{a}={v}" for a, v in filters.items() if v]
    if active:
        reasons.append("filtres " + ", ".join(active))
    reasons.append(f"statut {item.status}, confiance {item.confidence or '—'}")
    return " ; ".join(reasons)


def search(
    items: list[KnowledgeItem],
    *,
    q: str | None = None,
    filters: dict[str, str] | None = None,
    include_drafts: bool = False,
    min_relevance: float = 0.0,
    limit: int = 20,
) -> list[KnowledgeMatch]:
    filters = filters or {}
    query_terms = _terms(q) if q else set()

    matches: list[tuple[KnowledgeItem, float]] = []
    for item in items:
        if not include_drafts and item.status != "valide":
            continue  # validated-only by default
        if not _matches_filters(item, filters):
            continue
        relevance = _relevance(item, query_terms)
        if query_terms and relevance <= min_relevance:
            continue
        status_weight = 1.0 if item.status == "valide" else 0.5
        score = relevance * 0.6 + _CONFIDENCE_WEIGHT.get(item.confidence, 0.3) * 0.25 + status_weight * 0.15
        matches.append((item, min(1.0, score)))

    # Deterministic: score desc, then title, then slug.
    matches.sort(key=lambda m: (-m[1], m[0].title, m[0].slug))
    return [
        KnowledgeMatch(item=item, score=round(score, 3), why=_why(item, query_terms, filters))
        for item, score in matches[:limit]
    ]
