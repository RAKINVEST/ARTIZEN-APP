"""Selects the configured email provider (mock by default), cached at startup."""

from functools import lru_cache

from app.core.config import settings
from app.core.exceptions import AppException
from app.email.base import EmailProvider
from app.email.providers.mock import MockEmailProvider


@lru_cache
def get_email_provider(provider_name: str | None = None) -> EmailProvider:
    name = provider_name or settings.EMAIL_PROVIDER
    if name == "mock":
        return MockEmailProvider()
    raise AppException(f"Unknown email provider: {name}")
