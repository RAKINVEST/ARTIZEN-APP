"""Quote-assistant HTTP endpoint.

Only ever returns a *proposal* — creating the quote itself still goes
through the existing ``POST /quotes`` (see ``quotes/router.py``). This
router never touches ``QuoteService`` or the database beyond reading
the catalog: it cannot create a quote even if it wanted to.

Requires ``CurrentUserDep`` (Étape 10): the suggestion is always scoped
to ``current_user.company_id``, never the client-supplied value in
``QuoteSuggestionRequest``.
"""

from fastapi import APIRouter

from app.quote_assistant.deps import QuoteAssistantServiceDep
from app.quote_assistant.schemas import QuoteSuggestionRead, QuoteSuggestionRequest
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/quote-assistant", tags=["quote-assistant"])


@router.post("/suggest", response_model=QuoteSuggestionRead)
async def suggest_quote(
    service: QuoteAssistantServiceDep, current_user: CurrentUserDep, payload: QuoteSuggestionRequest
) -> QuoteSuggestionRead:
    return await service.suggest(company_id=current_user.company_id, description=payload.description)
