"""Authentication business logic: registration creates a brand-new
``Company`` (the tenant) alongside the first ``User`` that belongs to
it, login verifies credentials and issues a JWT, and token decoding
resolves the current request's ``User``.

Depends on ``branding.repository.CompanyRepository`` (one-directional,
the same allowed pattern ``quotes``/``template_import``/``quote_assistant``
already use) purely to create the tenant's ``Company`` row — this
module owns *accounts*, ``branding`` still owns everything about a
company's identity.
"""

import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.security import create_access_token, decode_access_token, hash_password, verify_password
from app.branding.models import Company
from app.branding.repository import CompanyRepository
from app.core.exceptions import UnauthorizedError
from app.users.exceptions import EmailAlreadyRegisteredError
from app.users.models import User
from app.users.repository import UserRepository
from app.users.schemas import TokenRead, UserLogin, UserRead, UserRegister


class AuthService:
    def __init__(
        self, session: AsyncSession, users: UserRepository, companies: CompanyRepository
    ) -> None:
        self._session = session
        self._users = users
        self._companies = companies

    async def register(self, data: UserRegister) -> TokenRead:
        existing = await self._users.get_by_email(data.email)
        if existing is not None:
            raise EmailAlreadyRegisteredError(f"Email {data.email} is already registered.")

        company = await self._companies.create(Company(name=data.company_name))
        user = await self._users.create(
            User(
                company_id=company.id,
                email=data.email,
                hashed_password=hash_password(data.password),
                full_name=data.full_name,
            )
        )
        return self._issue_token(user)

    async def login(self, data: UserLogin) -> TokenRead:
        user = await self._users.get_by_email(data.email)
        if user is None or not verify_password(data.password, user.hashed_password):
            raise UnauthorizedError("Invalid email or password.")
        if not user.is_active:
            raise UnauthorizedError("This account has been deactivated.")
        return self._issue_token(user)

    async def get_user_from_token(self, token: str) -> User:
        payload = decode_access_token(token)
        if payload is None or "sub" not in payload:
            raise UnauthorizedError("Invalid or expired token.")
        try:
            user_id = uuid.UUID(payload["sub"])
        except ValueError as exc:
            raise UnauthorizedError("Invalid or expired token.") from exc

        user = await self._users.get(user_id)
        if user is None or not user.is_active:
            raise UnauthorizedError("Invalid or expired token.")
        return user

    def _issue_token(self, user: User) -> TokenRead:
        token = create_access_token(subject=str(user.id))
        return TokenRead(access_token=token, user=UserRead.model_validate(user))
