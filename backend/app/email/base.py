"""The contract every email provider implements. Callers depend only on this."""

from abc import ABC, abstractmethod
from dataclasses import dataclass


@dataclass(frozen=True)
class EmailAttachment:
    """A file to attach to an email — e.g. a quote rendered to PDF."""

    filename: str
    content: bytes
    media_type: str = "application/pdf"


class EmailProvider(ABC):
    @abstractmethod
    async def send(
        self,
        *,
        to: str,
        subject: str,
        text_body: str,
        html_body: str | None = None,
        attachments: list[EmailAttachment] | None = None,
    ) -> None:
        """Send one transactional email, optionally with [attachments] (e.g. the
        quote PDF). Providers must not raise for a normal delivery attempt — a
        failing email must never break the request that triggered it (e.g. a
        password-reset request still answers 204)."""
        raise NotImplementedError
