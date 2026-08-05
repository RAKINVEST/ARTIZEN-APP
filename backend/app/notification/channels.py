"""Notification channels & providers — provider-abstraction (like AI/storage).

Channels: email, sms, push. V1 ships deterministic mock providers (offline,
never fail); the real email (SMTP, via ``app/email``), SMS and push providers
plug in behind the same ``ChannelProvider`` interface with no caller change — a
missing/unconfigured provider is never an error (the project's cardinal rule).
This is provider fallback, not a permanent mock.
"""

import logging
from typing import Protocol, runtime_checkable

logger = logging.getLogger(__name__)

NOTIFICATION_CHANNELS: tuple[str, ...] = ("email", "sms", "push")


@runtime_checkable
class ChannelProvider(Protocol):
    def send(self, *, recipient: str, subject: str, body: str) -> bool: ...


class MockChannelProvider:
    """Records the send and returns success — deterministic, offline."""

    def __init__(self, channel: str) -> None:
        self._channel = channel

    def send(self, *, recipient: str, subject: str, body: str) -> bool:
        logger.info(
            "notification.mock_send channel=%s recipient=%s subject=%s",
            self._channel, recipient, subject,
        )
        return True


def is_valid_channel(channel: str) -> bool:
    return channel in NOTIFICATION_CHANNELS


def get_provider(channel: str) -> ChannelProvider:
    # V1: mock for every channel. Real providers become new branches here.
    return MockChannelProvider(channel)
