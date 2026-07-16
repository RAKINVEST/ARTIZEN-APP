"""Authentication HTTP endpoints.

Unlike every other router in this codebase, ``register``/``login`` are
deliberately the only two endpoints in the whole API that do NOT
require ``CurrentUserDep`` — they're how a caller obtains a token in
the first place.
"""

from fastapi import APIRouter, status

from app.users.deps import AuthServiceDep, CurrentUserDep
from app.users.schemas import TokenRead, UserLogin, UserRead, UserRegister

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/register", response_model=TokenRead, status_code=status.HTTP_201_CREATED)
async def register(service: AuthServiceDep, payload: UserRegister) -> TokenRead:
    return await service.register(payload)


@router.post("/login", response_model=TokenRead)
async def login(service: AuthServiceDep, payload: UserLogin) -> TokenRead:
    return await service.login(payload)


@router.get("/me", response_model=UserRead)
async def get_me(current_user: CurrentUserDep) -> UserRead:
    return UserRead.model_validate(current_user)
