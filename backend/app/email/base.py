"""The contract every email provider implements. Callers depend only on this."""

from abc import ABC, abstractmethod


class EmailProvider(ABC):
    @abstractmethod
    async def send(
        self, *, to: str, subject: str, text_body: str, html_body: str | None = None
    ) -> None:
        """Send one transactional email. Providers must not raise for a normal
        delivery attempt — a failing email must never break the request that
        triggered it (e.g. a password-reset request still answers 204)."""
        raise NotImplementedError
