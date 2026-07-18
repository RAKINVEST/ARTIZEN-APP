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

from fastapi import APIRouter, Response, status

from app.core.authorization import ensure_same_company
from app.quotes.deps import QuoteServiceDep
from app.quotes.schemas import QuoteCreate, QuoteRead, QuoteReadiness, QuoteStatusUpdate
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
    offset: int = 0,
    limit: int = 100,
) -> list[QuoteRead]:
    return await service.list(company_id=current_user.company_id, offset=offset, limit=limit)


@router.get(
    "/sample-pdf",
    response_class=Response,
    responses={
        200: {
            "content": {"application/pdf": {}},
            "description": "A demo quote rendered with the company's current branding.",
        }
    },
)
async def download_sample_pdf(service: QuoteServiceDep, current_user: CurrentUserDep) -> Response:
    """A demo quote rendered with the caller's current identity, logo and
    colours — the "aperçu du rendu" shown after importing a template, so an
    artisan can confirm their branding landed without creating a real quote.

    Declared before ``/{quote_id}`` so "sample-pdf" is matched as this static
    route, never parsed as a quote id.
    """
    filename, pdf = await service.render_sample_pdf(current_user.company_id)
    return Response(
        content=pdf,
        media_type="application/pdf",
        headers={"Content-Disposition": f'inline; filename="{filename}"'},
    )


@router.get("/{quote_id}", response_model=QuoteRead)
async def get_quote(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> QuoteRead:
    quote = await service.get(quote_id)
    ensure_same_company(quote.company_id, quote_id, current_user.company_id)
    return quote


@router.get("/{quote_id}/readiness", response_model=QuoteReadiness)
async def quote_readiness(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> QuoteReadiness:
    """Whether the quote is ready to emit, and if not, exactly what to fix —
    called before Download / Print / Send (Phase 1.1, Mission 2)."""
    existing = await service.get(quote_id)
    ensure_same_company(existing.company_id, quote_id, current_user.company_id)
    return await service.check_readiness(quote_id)


@router.post("/{quote_id}/duplicate", response_model=QuoteRead, status_code=status.HTTP_201_CREATED)
async def duplicate_quote(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> QuoteRead:
    """Creates a new draft from an existing quote — the edit path a quote
    doesn't otherwise have. The tenant check is on the *source*: you can
    only duplicate a quote you own, and the copy is created for your own
    company (``QuoteService.duplicate`` carries the source's company_id,
    which this route has just confirmed is the caller's)."""
    existing = await service.get(quote_id)
    ensure_same_company(existing.company_id, quote_id, current_user.company_id)
    return await service.duplicate(quote_id)


@router.get(
    "/{quote_id}/pdf",
    response_class=Response,
    responses={200: {"content": {"application/pdf": {}}, "description": "The quote as a PDF."}},
)
async def download_quote_pdf(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> Response:
    """The document the artisan sends to their customer.

    Available in every status, drafts included: an artisan needs to see
    what their quote will look like before committing to send it.

    ``Content-Disposition: attachment`` with the quote number as filename,
    so the file lands as "DEV-2026-0001.pdf" rather than as the UUID in
    the URL. The tenant check runs first — a PDF carries the company's
    identity and its customer's address, so it is the last thing that
    should leak across tenants.
    """
    existing = await service.get(quote_id)
    ensure_same_company(existing.company_id, quote_id, current_user.company_id)

    filename, pdf = await service.render_pdf(quote_id)
    return Response(
        content=pdf,
        media_type="application/pdf",
        headers={"Content-Disposition": f'attachment; filename="{filename}"'},
    )


@router.put("/{quote_id}/status", response_model=QuoteRead)
async def change_quote_status(
    service: QuoteServiceDep,
    current_user: CurrentUserDep,
    quote_id: uuid.UUID,
    payload: QuoteStatusUpdate,
) -> QuoteRead:
    """The only mutation a quote accepts — and note what it is *not*.

    There is still no `PUT /quotes/{id}`: lines and totals are never
    edited, because ``QuoteCalculator`` has no recalculation entry point
    for an existing quote and nothing would force a caller through it.
    Correcting a quote means deleting the draft and creating another, which
    goes back through ``create`` where totals are computed the only way
    they ever are. This route moves the quote through its commercial life;
    it never touches an amount.
    """
    existing = await service.get(quote_id)
    ensure_same_company(existing.company_id, quote_id, current_user.company_id)
    return await service.change_status(quote_id, payload.status)


@router.delete("/{quote_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_quote(
    service: QuoteServiceDep, current_user: CurrentUserDep, quote_id: uuid.UUID
) -> None:
    """Hard delete — but only while the quote is still a draft.

    Unlike a catalog item's soft delete: nothing references a quote, so
    there are no dependent rows to protect. What is protected is the
    document itself. A draft is the artisan's scratch pad and deleting it
    is how a mistyped quote gets undone (there is no update path — see
    ``QuoteService.delete``). Past 'draft', the customer holds a PDF and
    the trace has to survive; the service answers 409 rather than erasing
    it.
    """
    existing = await service.get(quote_id)
    ensure_same_company(existing.company_id, quote_id, current_user.company_id)
    await service.delete(quote_id)
