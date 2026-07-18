"""Selects the configured email provider (mock by default), cached at startup."""

from functools import lru_cache

from app.core.config import settings
from app.core.exceptions import AppException
from app.email.base import EmailProvider
from app.email.providers.mock import MockEmailProvider
from app.email.providers.smtp import SmtpEmailProvider


@lru_cache
def get_email_provider(provider_name: str | None = None) -> EmailProvider:
    name = provider_name or settings.EMAIL_PROVIDER
    if name == "mock":
        return MockEmailProvider()
    if name == "smtp":
        return SmtpEmailProvider(
            host=settings.SMTP_HOST,
            port=settings.SMTP_PORT,
            username=settings.SMTP_USERNAME,
            password=settings.SMTP_PASSWORD,
            use_tls=settings.SMTP_USE_TLS,
            use_ssl=settings.SMTP_USE_SSL,
            sender=settings.EMAIL_FROM,
        )
    raise AppException(f"Unknown email provider: {name}")
