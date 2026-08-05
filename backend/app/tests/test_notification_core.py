"""Pure unit tests for the Notification Engine core (no DB, no HTTP).

Covers channels, templates, dispatcher and history — the deterministic pieces
that must hold regardless of persistence. Run with ``pytest --noconftest``.
"""

import pytest

from app.notification.channels import (
    NOTIFICATION_CHANNELS,
    ChannelProvider,
    MockChannelProvider,
    get_provider,
    is_valid_channel,
)
from app.notification.dispatcher import (
    STATUS_FAILED,
    STATUS_SENT,
    NotificationDispatcher,
)
from app.notification.exceptions import NotificationError
from app.notification.history import EventPublisher
from app.notification.templates import available_templates, render

# --- channels ---------------------------------------------------------------

def test_channels_are_email_sms_push():
    assert NOTIFICATION_CHANNELS == ("email", "sms", "push")


@pytest.mark.parametrize("channel", ["email", "sms", "push"])
def test_is_valid_channel_accepts_known(channel):
    assert is_valid_channel(channel) is True


@pytest.mark.parametrize("channel", ["", "fax", "carrier_pigeon", "EMAIL"])
def test_is_valid_channel_rejects_unknown(channel):
    assert is_valid_channel(channel) is False


def test_get_provider_returns_channel_provider():
    provider = get_provider("email")
    assert isinstance(provider, ChannelProvider)
    assert provider.send(recipient="a@b.c", subject="s", body="b") is True


def test_mock_provider_is_deterministic_success():
    assert MockChannelProvider("sms").send(recipient="+33600000000", subject="", body="x") is True


# --- templates --------------------------------------------------------------

def test_render_mission_scheduled_fills_context():
    subject, body = render("mission_scheduled", {"title": "Chaudière", "date": "12/03"})
    assert subject == "Intervention planifiée"
    assert body == "Votre intervention « Chaudière » est planifiée le 12/03."


def test_render_quote_sent_fills_number():
    subject, body = render("quote_sent", {"number": "DEV-2026-0001"})
    assert "DEV-2026-0001" in subject
    assert "DEV-2026-0001" in body


def test_render_generic_passes_through():
    subject, body = render("generic", {"subject": "Bonjour", "body": "Coucou"})
    assert (subject, body) == ("Bonjour", "Coucou")


def test_render_unknown_template_raises():
    with pytest.raises(NotificationError):
        render("does_not_exist", {})


def test_render_missing_variable_raises_not_guesses():
    with pytest.raises(NotificationError):
        render("mission_scheduled", {"title": "Chaudière"})  # no {date}


def test_available_templates_lists_builtins():
    keys = available_templates()
    for key in ("mission_scheduled", "mission_cancelled", "quote_sent", "generic"):
        assert key in keys


# --- dispatcher -------------------------------------------------------------

class _OkProvider:
    def send(self, *, recipient: str, subject: str, body: str) -> bool:
        return True


class _RefusingProvider:
    def send(self, *, recipient: str, subject: str, body: str) -> bool:
        return False


class _RaisingProvider:
    def send(self, *, recipient: str, subject: str, body: str) -> bool:
        raise RuntimeError("smtp down")


def test_dispatch_success_returns_sent():
    status = NotificationDispatcher.dispatch(
        channel="email", recipient="a@b.c", subject="s", body="b", provider=_OkProvider()
    )
    assert status == STATUS_SENT


def test_dispatch_provider_returns_false_is_failed():
    status = NotificationDispatcher.dispatch(
        channel="sms", recipient="+33", subject="s", body="b", provider=_RefusingProvider()
    )
    assert status == STATUS_FAILED


def test_dispatch_provider_raising_is_failed_not_500():
    # A provider blowing up must be recorded as failed, never propagated.
    status = NotificationDispatcher.dispatch(
        channel="push", recipient="tok", subject="s", body="b", provider=_RaisingProvider()
    )
    assert status == STATUS_FAILED


def test_dispatch_default_mock_provider_sends():
    status = NotificationDispatcher.dispatch(
        channel="email", recipient="a@b.c", subject="s", body="b"
    )
    assert status == STATUS_SENT


# --- history ----------------------------------------------------------------

def test_event_publisher_appends_and_returns_entry():
    history: list = []
    entry = EventPublisher.record(history, event="NotificationCreated", actor="me", detail="email")
    assert history == [entry]
    assert entry["event"] == "NotificationCreated"
    assert entry["actor"] == "me"
    assert entry["detail"] == "email"
    assert "at" in entry and entry["at"].endswith("+00:00")


def test_event_publisher_is_append_only():
    history: list = []
    EventPublisher.record(history, event="NotificationCreated", actor="me")
    EventPublisher.record(history, event="NotificationSent", actor="me")
    assert [e["event"] for e in history] == ["NotificationCreated", "NotificationSent"]
