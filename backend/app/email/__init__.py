"""Transactional email — the same provider-abstraction pattern as ``app.ai``
and ``app.storage``.

Business code depends only on ``EmailProvider`` (``base.py``); the concrete
provider is chosen by ``factory.py`` from configuration. The default is a
fully-offline mock that logs the message and keeps it in an in-process outbox —
so the app boots and every email-backed feature (password reset, welcome…)
works **without any email account**. Adding a real provider (SMTP/Postmark/…)
later is a config switch, not a code change.
"""
