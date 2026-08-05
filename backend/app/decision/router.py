"""Decision Engine HTTP endpoints.

Read-side only: turns an intention into an explained *proposal* sourced
**exclusively** from the Knowledge Engine. It never creates a Quote, never
persists, never computes an amount. ``company_id`` comes from the JWT (auth);
the shared knowledge corpus is not tenant-scoped.
"""

from fastapi import APIRouter

from app.decision.deps import DecisionServiceDep
from app.decision.intents import interpret_intent
from app.decision.schemas import DecisionRequest, DecisionResponse, Intent
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/decision", tags=["decision"])


@router.post("/propose", response_model=DecisionResponse)
async def propose(
    service: DecisionServiceDep, _current_user: CurrentUserDep, payload: DecisionRequest
) -> DecisionResponse:
    """Intention -> proposition expliquée, issue de la base de savoir (à valider)."""
    return service.decide(intent_text=payload.intent)


@router.post("/interpret", response_model=Intent)
async def interpret(_current_user: CurrentUserDep, payload: DecisionRequest) -> Intent:
    """Comprend l'intention (verbe + cible)."""
    return interpret_intent(payload.intent)
