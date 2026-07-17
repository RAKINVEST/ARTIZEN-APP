"""FastAPI dependencies for the quotes module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.branding.deps import BrandingServiceDep
from app.quotes.service import QuoteService
from app.storage import StorageDep


def get_quote_service(
    session: SessionDep, branding: BrandingServiceDep, storage: StorageDep
) -> QuoteService:
    return QuoteService(session, branding=branding, storage=storage)


QuoteServiceDep = Annotated[QuoteService, Depends(get_quote_service)]
