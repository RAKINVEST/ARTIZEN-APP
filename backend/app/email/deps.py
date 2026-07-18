"""FastAPI-injectable accessor for the configured email provider."""

from typing import Annotated

from fastapi import Depends

from app.email.base import EmailProvider
from app.email.factory import get_email_provider


def get_default_email_provider() -> EmailProvider:
    return get_email_provider()


EmailProviderDep = Annotated[EmailProvider, Depends(get_default_email_provider)]
