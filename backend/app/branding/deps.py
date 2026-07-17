"""FastAPI dependencies for the branding module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.branding.service import BrandingService

# Re-exported, not defined here: it moved to app/storage.py once `quotes`
# became a second consumer. Kept as a name in this module so existing
# imports keep working.
from app.storage import StorageDep  # noqa: F401


def get_branding_service(session: SessionDep, storage: StorageDep) -> BrandingService:
    return BrandingService(session=session, storage=storage)


BrandingServiceDep = Annotated[BrandingService, Depends(get_branding_service)]
