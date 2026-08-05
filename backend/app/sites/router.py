"""Sites (jobsites / "chantiers") HTTP endpoints. Every route only declares
the request shape and delegates to ``SiteService``.

Same multi-tenant pattern as ``clients/router.py``: creates use
``current_user.company_id`` (never a client-supplied one), lists are always
scoped to it, and by-id routes verify ownership via ``ensure_same_company``
before returning or mutating a resource.

There is deliberately no DELETE: a site is business data (Loi 5) and is
archived, not destroyed — see ``POST /sites/{id}/archive``.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.sites.deps import SiteServiceDep
from app.sites.schemas import SiteCreate, SiteRead, SiteUpdate
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/sites", tags=["sites"])


@router.post("", response_model=SiteRead, status_code=status.HTTP_201_CREATED)
async def create_site(
    service: SiteServiceDep, current_user: CurrentUserDep, payload: SiteCreate
) -> SiteRead:
    payload = payload.model_copy(update={"company_id": current_user.company_id})
    site = await service.create(payload)
    return SiteRead.model_validate(site)


@router.get("", response_model=list[SiteRead])
async def list_sites(
    service: SiteServiceDep,
    current_user: CurrentUserDep,
    customer_id: uuid.UUID | None = None,
    include_archived: bool = False,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[SiteRead]:
    """Lists the company's sites. Optionally filter by ``customer_id``;
    archived sites are excluded unless ``include_archived=true``."""
    sites = await service.list(
        company_id=current_user.company_id,
        customer_id=customer_id,
        include_archived=include_archived,
        offset=offset,
        limit=limit,
    )
    return [SiteRead.model_validate(site) for site in sites]


@router.get("/{site_id}", response_model=SiteRead)
async def get_site(
    service: SiteServiceDep, current_user: CurrentUserDep, site_id: uuid.UUID
) -> SiteRead:
    site = await service.get(site_id)
    ensure_same_company(site.company_id, site_id, current_user.company_id)
    return SiteRead.model_validate(site)


@router.put("/{site_id}", response_model=SiteRead)
async def update_site(
    service: SiteServiceDep,
    current_user: CurrentUserDep,
    site_id: uuid.UUID,
    payload: SiteUpdate,
) -> SiteRead:
    existing = await service.get(site_id)
    ensure_same_company(existing.company_id, site_id, current_user.company_id)
    site = await service.update(site_id, payload)
    return SiteRead.model_validate(site)


@router.post("/{site_id}/archive", response_model=SiteRead)
async def archive_site(
    service: SiteServiceDep, current_user: CurrentUserDep, site_id: uuid.UUID
) -> SiteRead:
    existing = await service.get(site_id)
    ensure_same_company(existing.company_id, site_id, current_user.company_id)
    site = await service.archive(site_id)
    return SiteRead.model_validate(site)
