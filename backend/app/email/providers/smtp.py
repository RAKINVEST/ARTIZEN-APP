"""Real SMTP email provider.

Sends through any standard SMTP service (Brevo, Postmark, Mailjet, Amazon SES,
Gmail relay…). Selected by ``EMAIL_PROVIDER=smtp`` (see ``factory.py``); nothing
that sends email changes when switching from the mock — that is the whole point
of the ``EmailProvider`` abstraction.

Uses the standard-library ``smtplib`` (no new dependency) run **off the event
loop** via ``asyncio.to_thread`` — the same pattern the codebase uses for
reportlab: a blocking, I/O-bound call must not stall the async server.

Honours the ``EmailProvider`` contract: a delivery failure is **logged, not
raised**, so a misconfigured or momentarily-down mail server can never break the
request that triggered the email (e.g. a password-reset request still answers
204). Operators watch the logs / monitoring for ``email.smtp_send_failed``.
"""

import asyncio
import logging
import smtplib
from email.message import EmailMessage

from app.email.base import EmailProvider

logger = logging.getLogger(__name__)

_TIMEOUT_SECONDS = 10


class SmtpEmailProvider(EmailProvider):
    def __init__(
        self,
        *,
        host: str,
        port: int,
        username: str,
        password: str,
        use_tls: bool,
        use_ssl: bool,
        sender: str,
    ) -> None:
        self._host = host
        self._port = port
        self._username = username
        self._password = password
        self._use_tls = use_tls
        self._use_ssl = use_ssl
        self._sender = sender

    async def send(
        self, *, to: str, subject: str, text_body: str, html_body: str | None = None
    ) -> None:
        message = EmailMessage()
        message["From"] = self._sender
        message["To"] = to
        message["Subject"] = subject
        message.set_content(text_body)
        if html_body:
            message.add_alternative(html_body, subtype="html")

        try:
            await asyncio.to_thread(self._deliver, message)
            logger.info("email.smtp_sent to=%s subject=%s", to, subject)
        except Exception:  # noqa: BLE001 — a failed email must never break the request
            logger.error(
                "email.smtp_send_failed to=%s subject=%s host=%s",
                to,
                subject,
                self._host,
                exc_info=True,
            )

    def _deliver(self, message: EmailMessage) -> None:
        """Blocking SMTP send. Runs in a worker thread (never on the loop)."""
        if self._use_ssl:
            with smtplib.SMTP_SSL(self._host, self._port, timeout=_TIMEOUT_SECONDS) as server:
                self._authenticate_and_send(server, message)
        else:
            with smtplib.SMTP(self._host, self._port, timeout=_TIMEOUT_SECONDS) as server:
                if self._use_tls:
                    server.starttls()
                self._authenticate_and_send(server, message)

    def _authenticate_and_send(self, server: smtplib.SMTP, message: EmailMessage) -> None:
        if self._username:
            server.login(self._username, self._password)
        server.send_message(message)
