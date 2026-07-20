"""Quotes HTTP endpoints. Every route only declares the request shape
and delegates to ``QuoteService`` — all calculation happens in
``QuoteCalculator``, never here.

Every route now requires ``CurrentUserDep`` (Étape 10): ``create``
overrides the payload's ``company_id`` with ``current_user.company_id``
(``QuoteService.create`` already verifies the referenced client and
catalog items belong to that same company — that check now doubles as
tenant isolation for the resources named *inside* the payload), ``list``
is always scoped to it, and ``get`` verifies ownership via
``ensure_same_company``.
"""

import uuid

from fastapi import APIRouter, status

from app.core.authorization import ensure_same_company
from app.quotes.deps import QuoteServiceDep
from app.quotes.schemas import QuoteCreate, QuoteRead, QuoteUpdate
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/quotes", tags=["quotes"])


@router.post("", response_model=QuoteRead, status_code=status.HTTP_201_CREATED)
async def create_quote(
    service: QuoteServiceDep, current_user: CurrentUserDep, payload: QuoteCreate
) -> QuoteRead:
    payload = payload.model_copy(update={"company_id": current_user.company_id})
    return await service.create(payload)


@router.get("", response_model=list[QuoteRead])
async def list_quotes(
    service: QuoteServiceDep,
    current_user: CurrentUserDep,
    client_id: uuid.UUID | None = None,
    offset: int = 0,
    limit: int = 100,
) -> list[QuoteRead]:
    """``client_id`` narrows the list to one client's quote history."""
    return await service.list(
        company_id=current_user.company_id,
        client_id=client_id,
        offset=offset,
        limit=limit,
    )


@router.put("/{quote_id}", response_model=QuoteRead)
async def update_quote(
    service: QuoteServiceDep,
    current_user: CurrentUserDep,
    quote_id: uuid.UUID,
    payload: QuoteUpdate,
) -> QuoteRead:
    """Replaces the quote's lines and recomputes its totals — a quote stays
    editable for as long as the artisan needs."""
    return await service.update(quote_id, payload, company_id=current_user.company_id)


@router.get("/{quote_id}", response_model=QuoteRead)
async def get_quote(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> QuoteRead:
    quote = await service.get(quote_id)
    ensure_same_company(quote.company_id, quote_id, current_user.company_id)
    return quote
