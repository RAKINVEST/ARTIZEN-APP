"""Offline mock email provider — the default.

Logs each message and appends it to an in-process ``outbox`` so that, without
any email account, (a) the app runs, (b) an operator can read a reset link from
the logs during a local/beta run, and (c) tests can assert what would have been
sent. Never performs network I/O, never raises.

The day a real provider is configured, the factory returns it instead and no
caller changes.
"""

import logging

from app.email.base import EmailAttachment, EmailProvider

logger = logging.getLogger(__name__)


class MockEmailProvider(EmailProvider):
    #: Class-level so every reference shares one outbox (the factory caches a
    #: single instance anyway). Tests read it, filtering by recipient — each
    #: test uses a unique address, so entries never collide across tests.
    outbox: list[dict] = []

    async def send(
        self,
        *,
        to: str,
        subject: str,
        text_body: str,
        html_body: str | None = None,
        attachments: list[EmailAttachment] | None = None,
    ) -> None:
        self.outbox.append(
            {
                "to": to,
                "subject": subject,
                "text": text_body,
                "attachments": [a.filename for a in attachments or []],
            }
        )
        logger.info(
            "email.mock_sent to=%s subject=%s attachments=%d",
            to,
            subject,
            len(attachments or []),
        )

    @classmethod
    def last_for(cls, to: str) -> dict | None:
        for message in reversed(cls.outbox):
            if message["to"] == to:
                return message
        return None
