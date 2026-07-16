"""FastAPI dependencies for the catalog module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.catalog.service import CatalogService


def get_catalog_service(session: SessionDep) -> CatalogService:
    return CatalogService(session)


CatalogServiceDep = Annotated[CatalogService, Depends(get_catalog_service)]
