"""Knowledge service — read-side orchestration over the cached corpus.

Loads nothing new per request (the source is cached), searches/filters/ranks
via the pure query engine, and resolves relations. It **never creates or
modifies** a card, has no repository/model/migration — the corpus files are the
source of truth (docs/blueprint/engines/knowledge/).
"""

from app.knowledge.query import search as query_search
from app.knowledge.schemas import (
    KnowledgeDetail,
    KnowledgeItem,
    KnowledgeSearchResult,
)


class KnowledgeService:
    def __init__(self, items: list[KnowledgeItem]) -> None:
        self._items = items
        self._by_slug: dict[str, KnowledgeItem] = {item.slug: item for item in items}

    def search(
        self,
        *,
        q: str | None = None,
        filters: dict[str, str] | None = None,
        include_drafts: bool = False,
        limit: int = 20,
    ) -> KnowledgeSearchResult:
        matches = query_search(
            self._items, q=q, filters=filters, include_drafts=include_drafts, limit=limit
        )
        return KnowledgeSearchResult(
            total=len(matches), include_drafts=include_drafts, matches=matches
        )

    def get(self, type_name: str, slug: str) -> KnowledgeDetail | None:
        item = self._by_slug.get(slug)
        if item is None or item.type != type_name:
            return None
        related = [self._by_slug[rel] for rel in item.relations if rel in self._by_slug]
        return KnowledgeDetail(item=item, related=related)
