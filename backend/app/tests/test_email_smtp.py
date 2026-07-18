"""Tests for the real SMTP email provider (last dev before beta).

No real SMTP server: ``smtplib`` is mocked, so we assert the provider builds the
right message and drives the connection correctly (STARTTLS / SSL / auth), and
that a delivery failure is swallowed rather than raised (EmailProvider contract).
"""

from unittest.mock import patch

from app.email.factory import get_email_provider
from app.email.providers.smtp import SmtpEmailProvider


def _provider(**overrides) -> SmtpEmailProvider:
    base = dict(
        host="smtp.example.com", port=587, username="user", password="secret",
        use_tls=True, use_ssl=False, sender="no-reply@artizen.fr",
    )
    base.update(overrides)
    return SmtpEmailProvider(**base)


async def test_starttls_flow_builds_and_sends_the_message() -> None:
    with patch("app.email.providers.smtp.smtplib.SMTP") as smtp_cls:
        server = smtp_cls.return_value.__enter__.return_value
        await _provider().send(to="artisan@exemple.fr", subject="Réinitialisation", text_body="Lien: …")

    smtp_cls.assert_called_once_with("smtp.example.com", 587, timeout=10)
    server.starttls.assert_called_once()
    server.login.assert_called_once_with("user", "secret")
    server.send_message.assert_called_once()
    message = server.send_message.call_args.args[0]
    assert message["To"] == "artisan@exemple.fr"
    assert message["From"] == "no-reply@artizen.fr"
    assert message["Subject"] == "Réinitialisation"
    assert "Lien: …" in message.get_content()


async def test_ssl_flow_uses_smtp_ssl_without_starttls() -> None:
    with patch("app.email.providers.smtp.smtplib.SMTP_SSL") as ssl_cls, \
         patch("app.email.providers.smtp.smtplib.SMTP") as plain_cls:
        server = ssl_cls.return_value.__enter__.return_value
        await _provider(use_ssl=True, use_tls=False, port=465).send(
            to="a@b.c", subject="X", text_body="Y"
        )

    ssl_cls.assert_called_once_with("smtp.example.com", 465, timeout=10)
    plain_cls.assert_not_called()
    server.starttls.assert_not_called()
    server.send_message.assert_called_once()


async def test_no_username_skips_login() -> None:
    with patch("app.email.providers.smtp.smtplib.SMTP") as smtp_cls:
        server = smtp_cls.return_value.__enter__.return_value
        await _provider(username="", password="").send(to="a@b.c", subject="X", text_body="Y")

    server.login.assert_not_called()
    server.send_message.assert_called_once()


async def test_delivery_failure_is_swallowed_not_raised() -> None:
    # A down/misconfigured server must never break the caller (a reset request
    # still answers 204). The provider logs and returns.
    with patch("app.email.providers.smtp.smtplib.SMTP", side_effect=OSError("connection refused")):
        await _provider().send(to="a@b.c", subject="X", text_body="Y")  # must not raise


def test_factory_selects_smtp_provider_by_config() -> None:
    assert isinstance(get_email_provider("smtp"), SmtpEmailProvider)
