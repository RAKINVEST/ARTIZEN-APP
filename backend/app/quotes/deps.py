"""FastAPI dependencies for the quotes module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.quotes.service import QuoteService


def get_quote_service(session: SessionDep) -> QuoteService:
    return QuoteService(session)


QuoteServiceDep = Annotated[QuoteService, Depends(get_quote_service)]
