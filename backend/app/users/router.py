"""Authentication HTTP endpoints.

Unlike every other router in this codebase, ``register``/``login`` are
deliberately the only two endpoints in the whole API that do NOT
require ``CurrentUserDep`` — they're how a caller obtains a token in
the first place.
"""

from fastapi import APIRouter, status

from app.users.deps import AuthServiceDep, CurrentUserDep
from app.users.schemas import (
    ForgotPasswordRequest,
    ResetPasswordRequest,
    TokenRead,
    UserLogin,
    UserRead,
    UserRegister,
)

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=TokenRead, status_code=status.HTTP_201_CREATED)
async def register(service: AuthServiceDep, payload: UserRegister) -> TokenRead:
    return await service.register(payload)


@router.post("/login", response_model=TokenRead)
async def login(service: AuthServiceDep, payload: UserLogin) -> TokenRead:
    return await service.login(payload)


@router.post("/forgot-password", status_code=status.HTTP_204_NO_CONTENT)
async def forgot_password(service: AuthServiceDep, payload: ForgotPasswordRequest) -> None:
    """Request a reset link. Always answers 204 — it never reveals whether the
    email is registered (anti-enumeration)."""
    await service.request_password_reset(payload.email)


@router.post("/reset-password", status_code=status.HTTP_204_NO_CONTENT)
async def reset_password(service: AuthServiceDep, payload: ResetPasswordRequest) -> None:
    """Set a new password from a valid reset token (single use, expiring)."""
    await service.reset_password(payload.token, payload.password)


@router.get("/me", response_model=UserRead)
async def get_me(current_user: CurrentUserDep) -> UserRead:
    return UserRead.model_validate(current_user)


@router.delete("/me", status_code=status.HTTP_204_NO_CONTENT)
async def delete_me(service: AuthServiceDep, current_user: CurrentUserDep) -> None:
    """RGPD right to erasure: permanently delete the account and ALL its data
    (company, documents, quotes, clients, catalogue, branding). Irreversible."""
    await service.delete_account(current_user)
