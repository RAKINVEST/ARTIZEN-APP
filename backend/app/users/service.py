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

import logging
import uuid
from datetime import datetime, timedelta, timezone

from sqlalchemy import delete, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.security import (
    create_access_token,
    decode_access_token,
    generate_reset_token,
    hash_password,
    hash_reset_token,
    spend_dummy_verify,
    verify_password,
)
from app.branding.models import Company
from app.branding.repository import CompanyRepository
from app.core.config import settings
from app.core.exceptions import UnauthorizedError
from app.email.base import EmailProvider
from app.users.exceptions import EmailAlreadyRegisteredError, InvalidResetTokenError
from app.users.models import User
from app.users.repository import UserRepository
from app.users.schemas import TokenRead, UserLogin, UserRead, UserRegister

logger = logging.getLogger(__name__)


class AuthService:
    def __init__(
        self,
        session: AsyncSession,
        users: UserRepository,
        companies: CompanyRepository,
        email: EmailProvider,
    ) -> None:
        self._session = session
        self._users = users
        self._companies = companies
        self._email = email

    async def register(self, data: UserRegister) -> TokenRead:
        existing = await self._users.get_by_email(data.email)
        if existing is not None:
            raise EmailAlreadyRegisteredError(f"Email {data.email} is already registered.")

        company = await self._companies.create(
            Company(name=data.company_name, last_active_at=datetime.now(timezone.utc))
        )
        user = await self._users.create(
            User(
                company_id=company.id,
                email=data.email,
                hashed_password=hash_password(data.password),
                full_name=data.full_name,
            )
        )
        return self._issue_token(user)

    async def delete_account(self, user: User) -> None:
        """Erase the account and ALL its data — the RGPD right to erasure.
        Deletes the tenant ``Company``; the database cascades to the user,
        documents, quotes, clients, catalogue and branding (ON DELETE CASCADE on
        ``companies.id``). Irreversible, and scoped to the caller's own tenant."""
        await self._session.execute(delete(Company).where(Company.id == user.company_id))
        await self._session.flush()

    async def login(self, data: UserLogin) -> TokenRead:
        user = await self._users.get_by_email(data.email)
        if user is None:
            # Same work as the branch below, so an unknown email and a wrong
            # password take the same time to answer — otherwise the uniform
            # error message above is undone by a stopwatch.
            spend_dummy_verify()
            raise UnauthorizedError("Invalid email or password.")
        if not verify_password(data.password, user.hashed_password):
            raise UnauthorizedError("Invalid email or password.")
        if not user.is_active:
            raise UnauthorizedError("This account has been deactivated.")
        # Activity signal for RGPD retention (app/retention purges inactive tenants).
        await self._session.execute(
            update(Company)
            .where(Company.id == user.company_id)
            .values(last_active_at=datetime.now(timezone.utc))
        )
        return self._issue_token(user)

    async def request_password_reset(self, email: str) -> None:
        """Start a password reset: if the email belongs to an account, store a
        hashed, expiring token and email the raw one as a link.

        **Always succeeds (204), whether or not the email exists** — answering
        differently would turn this into an account-enumeration oracle, exactly
        what login already guards against. An email delivery failure is caught
        and logged for the same reason: the response must not depend on it.
        """
        user = await self._users.get_by_email(email)
        if user is None:
            return

        raw_token, token_hash = generate_reset_token()
        user.reset_token_hash = token_hash
        user.reset_token_expires_at = datetime.now(timezone.utc) + timedelta(
            minutes=settings.RESET_TOKEN_TTL_MINUTES
        )
        await self._session.flush()

        link = f"{settings.APP_BASE_URL}/reset-password?token={raw_token}"
        try:
            await self._email.send(
                to=user.email,
                subject="Réinitialisation de votre mot de passe ARTIZEN",
                text_body=(
                    "Bonjour,\n\n"
                    "Vous avez demandé à réinitialiser votre mot de passe ARTIZEN. "
                    f"Cliquez sur ce lien (valable {settings.RESET_TOKEN_TTL_MINUTES} minutes) :\n"
                    f"{link}\n\n"
                    "Si vous n'êtes pas à l'origine de cette demande, ignorez cet e-mail : "
                    "votre mot de passe reste inchangé."
                ),
            )
        except Exception:  # noqa: BLE001 — the response must not depend on delivery
            logger.warning("auth.reset_email_failed email=%s", email, exc_info=True)

    async def reset_password(self, token: str, new_password: str) -> None:
        """Set a new password from a valid, unexpired reset token, then consume
        the token (single use)."""
        user = await self._users.get_by_reset_token_hash(hash_reset_token(token))
        if (
            user is None
            or user.reset_token_expires_at is None
            or user.reset_token_expires_at < datetime.now(timezone.utc)
        ):
            raise InvalidResetTokenError("Ce lien de réinitialisation est invalide ou expiré.")

        user.hashed_password = hash_password(new_password)
        user.reset_token_hash = None
        user.reset_token_expires_at = None
        await self._session.flush()

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
