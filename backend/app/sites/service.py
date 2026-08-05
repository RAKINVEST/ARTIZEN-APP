"""Sites business logic. Routes never touch the repository directly.

Depends on ``clients`` (read-only): a site must reference a real client of
the same tenant. This is the same justified, one-directional dependency
``quotes`` already has on ``clients`` — a jobsite without a real client is
meaningless.
"""

import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.clients.repository import ClientRepository
from app.core.exceptions import NotFoundError
from app.sites.models import SITE_STATUS_ARCHIVED, Site
from app.sites.repository import SiteRepository
from app.sites.schemas import SiteCreate, SiteUpdate


class SiteService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._sites = SiteRepository(session)
        self._clients = ClientRepository(session)

    async def create(self, data: SiteCreate) -> Site:
        # The referenced client must exist AND belong to the caller's company.
        # Anything else is reported as "customer not found" (404) — never a
        # 403 that would confirm another tenant's client exists.
        await self._ensure_customer_in_company(data.customer_id, data.company_id)
        return await self._sites.create(Site(**data.model_dump()))

    async def get(self, site_id: uuid.UUID) -> Site:
        site = await self._sites.get(site_id)
        if site is None:
            raise NotFoundError(f"Site {site_id} not found.")
        return site

    async def list(
        self,
        *,
        company_id: uuid.UUID,
        customer_id: uuid.UUID | None = None,
        include_archived: bool = False,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Site]:
        return await self._sites.list_for_company(
            company_id,
            customer_id=customer_id,
            include_archived=include_archived,
            offset=offset,
            limit=limit,
        )

    async def update(self, site_id: uuid.UUID, data: SiteUpdate) -> Site:
        site = await self.get(site_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(site, field, value)
        await self._session.flush()
        await self._session.refresh(site)
        return site

    async def archive(self, site_id: uuid.UUID) -> Site:
        # Business data is never destroyed (Loi 5): "deleting" a site archives
        # it. Idempotent — archiving an already-archived site is a no-op.
        site = await self.get(site_id)
        site.status = SITE_STATUS_ARCHIVED
        await self._session.flush()
        await self._session.refresh(site)
        return site

    async def _ensure_customer_in_company(
        self, customer_id: uuid.UUID, company_id: uuid.UUID | None
    ) -> None:
        client = await self._clients.get(customer_id)
        if client is None or client.company_id != company_id:
            raise NotFoundError(f"Customer {customer_id} not found.")
