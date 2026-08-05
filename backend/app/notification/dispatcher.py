"""Notification dispatcher — sends via a channel provider, returns the outcome.

Pure control flow (provider injectable for tests). A dispatch failure is
recorded as ``failed``, never swallowed silently and never raised as a 500 (the
notification is persisted with its status either way).
"""

import logging

from app.notification.channels import ChannelProvider, get_provider

logger = logging.getLogger(__name__)

STATUS_PENDING = "pending"
STATUS_SENT = "sent"
STATUS_FAILED = "failed"


class NotificationDispatcher:
    @staticmethod
    def dispatch(
        *, channel: str, recipient: str, subject: str, body: str,
        provider: ChannelProvider | None = None,
    ) -> str:
        provider = provider or get_provider(channel)
        try:
            ok = provider.send(recipient=recipient, subject=subject, body=body)
        except Exception as error:  # noqa: BLE001 — recorded as failed, not hidden
            logger.warning("notification.dispatch_failed channel=%s error=%s", channel, error)
            ok = False
        return STATUS_SENT if ok else STATUS_FAILED
