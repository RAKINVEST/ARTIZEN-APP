"""FastAPI dependencies for the branding module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.branding.service import BrandingService
from app.storage import StorageProvider, get_storage_provider

StorageDep = Annotated[StorageProvider, Depends(get_storage_provider)]


def get_branding_service(session: SessionDep, storage: StorageDep) -> BrandingService:
    return BrandingService(session=session, storage=storage)


BrandingServiceDep = Annotated[BrandingService, Depends(get_branding_service)]
