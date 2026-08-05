"""FastAPI dependencies for the sites module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.sites.service import SiteService


def get_site_service(session: SessionDep) -> SiteService:
    return SiteService(session)


SiteServiceDep = Annotated[SiteService, Depends(get_site_service)]
