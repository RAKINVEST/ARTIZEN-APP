"""FastAPI dependencies for the users module.

``CurrentUserDep`` is the one dependency every other module's router now
adds to require a valid session and resolve the caller's real
``company_id`` — see the root README's "Authentification (Étape 10)"
section for why enforcement lives at the router layer rather than
threading ``company_id`` through every service method.
"""

from typing import Annotated

from fastapi import Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from app.api.deps import SessionDep
from app.branding.repository import CompanyRepository
from app.email.deps import EmailProviderDep
from app.users.models import User
from app.users.repository import UserRepository
from app.users.service import AuthService

# HTTPBearer (not OAuth2PasswordBearer): this API's login endpoint takes a
# JSON body (email/password), not an OAuth2 form-encoded username/password
# — HTTPBearer only asserts "there is a Bearer token", without implying a
# specific login flow shape.
_bearer_scheme = HTTPBearer(auto_error=True)


def get_auth_service(session: SessionDep, email: EmailProviderDep) -> AuthService:
    return AuthService(
        session=session,
        users=UserRepository(session),
        companies=CompanyRepository(session),
        email=email,
    )


AuthServiceDep = Annotated[AuthService, Depends(get_auth_service)]


async def get_current_user(
    credentials: Annotated[HTTPAuthorizationCredentials, Depends(_bearer_scheme)],
    service: AuthServiceDep,
) -> User:
    return await service.get_user_from_token(credentials.credentials)


CurrentUserDep = Annotated[User, Depends(get_current_user)]
