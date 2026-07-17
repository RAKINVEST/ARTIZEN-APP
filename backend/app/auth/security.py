"""JWT and password-hashing primitives.

Pure infrastructure, shared by ``app.users`` (which owns the ``User``
model and the /auth routes): the hashing scheme and token format are
decided here, once, and nothing else in the app needs to know them.
"""

import secrets
from datetime import datetime, timedelta, timezone
from typing import Any

from jose import JWTError, jwt
from passlib.context import CryptContext

from app.core.config import settings

_pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# A hash of a random value nobody will ever submit. Its only purpose is to
# be verified against — see spend_dummy_verify. Built at import so no real
# credential is ever hard-coded here.
_DUMMY_HASH = _pwd_context.hash(secrets.token_urlsafe(32))


def hash_password(password: str) -> str:
    return _pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return _pwd_context.verify(plain_password, hashed_password)


def spend_dummy_verify() -> None:
    """Burn one bcrypt verification against a throwaway hash.

    Login answers "invalid email or password" either way, but the work it
    does differs: an unknown email short-circuits before bcrypt runs, while
    a known one pays for a full verification. That gap is measurable from
    outside — tens of milliseconds — and turns a deliberately uniform
    message back into an oracle for whether an account exists.

    Callers spend the same work on the unknown-email path so both answers
    cost the same.
    """
    _pwd_context.verify("dummy", _DUMMY_HASH)


def create_access_token(
    subject: str,
    expires_delta: timedelta | None = None,
    extra_claims: dict[str, Any] | None = None,
) -> str:
    expire = datetime.now(timezone.utc) + (
        expires_delta or timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    )
    payload: dict[str, Any] = {"sub": subject, "exp": expire}
    if extra_claims:
        payload.update(extra_claims)
    return jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.JWT_ALGORITHM)


def decode_access_token(token: str) -> dict[str, Any] | None:
    try:
        return jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.JWT_ALGORITHM])
    except JWTError:
        return None
