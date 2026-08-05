"""AI Companion HTTP endpoints — the conversational interface of Artizen.

Chat, continue, confirm, cancel, and manage the session. ``company_id`` comes
from the JWT; every session is tenant-scoped (a foreign session id is simply not
found → 404). The Companion proposes; a business action only runs after an
explicit ``confirm``.
"""

from fastapi import APIRouter, Query, status

from app.ai_companion.deps import CompanionServiceDep
from app.ai_companion.schemas import (
    CancelRequest,
    ChatRequest,
    ChatResponse,
    ConfirmRequest,
    ContinueRequest,
    SessionRead,
)
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/ai", tags=["ai_companion"])


def _actor(current_user: CurrentUserDep) -> str:
    return getattr(current_user, "email", None) or str(current_user.company_id)


@router.post("/chat", response_model=ChatResponse)
async def chat(
    service: CompanionServiceDep, current_user: CurrentUserDep, payload: ChatRequest
) -> ChatResponse:
    return await service.chat(
        company_id=current_user.company_id, actor=_actor(current_user),
        message=payload.message, session_id=payload.session_id, params=payload.params,
    )


@router.post("/continue", response_model=ChatResponse)
async def continue_conversation(
    service: CompanionServiceDep, current_user: CurrentUserDep, payload: ContinueRequest
) -> ChatResponse:
    return await service.continue_conversation(
        company_id=current_user.company_id, actor=_actor(current_user),
        session_id=payload.session_id, message=payload.message, params=payload.params,
    )


@router.post("/confirm", response_model=ChatResponse)
async def confirm(
    service: CompanionServiceDep, current_user: CurrentUserDep, payload: ConfirmRequest
) -> ChatResponse:
    return await service.confirm(
        company_id=current_user.company_id, actor=_actor(current_user),
        session_id=payload.session_id,
    )


@router.post("/cancel", response_model=ChatResponse)
async def cancel(
    service: CompanionServiceDep, current_user: CurrentUserDep, payload: CancelRequest
) -> ChatResponse:
    return await service.cancel(
        company_id=current_user.company_id, session_id=payload.session_id,
    )


@router.get("/session", response_model=SessionRead)
async def get_session(
    service: CompanionServiceDep, current_user: CurrentUserDep, session_id: str = Query(min_length=1)
) -> SessionRead:
    return await service.get_session(
        company_id=current_user.company_id, session_id=session_id
    )


@router.delete("/session", status_code=status.HTTP_204_NO_CONTENT)
async def delete_session(
    service: CompanionServiceDep, current_user: CurrentUserDep, session_id: str = Query(min_length=1)
) -> None:
    await service.delete_session(company_id=current_user.company_id, session_id=session_id)
