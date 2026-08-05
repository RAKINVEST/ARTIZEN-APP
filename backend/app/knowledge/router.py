"""Knowledge Engine HTTP endpoints — exclusively read-side.

Serves the knowledge corpus (search + detail). It never creates or modifies a
card. By default only *validated* knowledge is returned; drafts require an
explicit ``include_drafts=true`` (the corpus is currently all-draft, so the
default result is legitimately empty — surfaced, not hidden).
"""

from fastapi import APIRouter, Query

from app.knowledge.deps import KnowledgeServiceDep
from app.knowledge.exceptions import KnowledgeNotFoundError
from app.knowledge.schemas import KnowledgeDetail, KnowledgeSearchResult
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/knowledge", tags=["knowledge"])


@router.get("/search", response_model=KnowledgeSearchResult)
async def search_knowledge(
    service: KnowledgeServiceDep,
    _current_user: CurrentUserDep,
    q: str | None = None,
    metier: str | None = None,
    famille: str | None = None,
    sous_famille: str | None = None,
    intervention: str | None = None,
    probleme: str | None = None,
    equipement: str | None = None,
    # `type` is a query-param name but a Python builtin, so it is aliased.
    item_type: str | None = Query(None, alias="type"),
    include_drafts: bool = False,
    limit: int = Query(20, ge=1, le=100),
) -> KnowledgeSearchResult:
    filters = {
        "metier": metier or "",
        "famille": famille or "",
        "sous-famille": sous_famille or "",
        "intervention": intervention or "",
        "probleme": probleme or "",
        "equipement": equipement or "",
        "type": item_type or "",
    }
    return service.search(q=q, filters=filters, include_drafts=include_drafts, limit=limit)


@router.get("/{type_name}/{slug}", response_model=KnowledgeDetail)
async def get_knowledge(
    service: KnowledgeServiceDep, _current_user: CurrentUserDep, type_name: str, slug: str
) -> KnowledgeDetail:
    detail = service.get(type_name, slug)
    if detail is None:
        raise KnowledgeNotFoundError(f"Knowledge {type_name}/{slug} not found.")
    return detail
