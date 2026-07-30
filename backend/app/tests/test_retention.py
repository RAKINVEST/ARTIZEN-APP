"""RGPD retention engine (app/retention).

Two properties matter and are pinned here: the engine is a **strict no-op**
until a duration is configured (nothing is ever purged by default), and once a
duration is set it purges exactly the tenants inactive beyond it — the policy
lives in configuration, never in the engine.

Note (shared test DB, no isolation): the fixtures create their own tenants with
an explicit, very old `last_active_at`; a NULL/`now` `last_active_at` (every
other test's account) is never in scope, so nothing else is touched.
"""

import uuid
from datetime import datetime, timedelta, timezone

from app.branding.models import Company
from app.core.config import settings
from app.database.session import AsyncSessionLocal
from app.retention.service import purge_expired


async def test_retention_is_a_strict_noop_when_unconfigured(monkeypatch) -> None:
    old_id = uuid.uuid4()
    async with AsyncSessionLocal() as session:
        session.add(
            Company(
                id=old_id,
                name="Inactive",
                last_active_at=datetime.now(timezone.utc) - timedelta(days=800),
            )
        )
        await session.commit()

    monkeypatch.setattr(settings, "RETENTION_INACTIVE_ACCOUNT_DAYS", None)
    async with AsyncSessionLocal() as session:
        report = await purge_expired(session)
        await session.commit()

    assert report.total == 0
    async with AsyncSessionLocal() as session:
        assert await session.get(Company, old_id) is not None  # nothing purged


async def test_retention_purges_inactive_accounts_when_configured(monkeypatch) -> None:
    old_id = uuid.uuid4()
    recent_id = uuid.uuid4()
    async with AsyncSessionLocal() as session:
        session.add(
            Company(
                id=old_id,
                name="Vieux",
                last_active_at=datetime.now(timezone.utc) - timedelta(days=800),
            )
        )
        session.add(
            Company(id=recent_id, name="Récent", last_active_at=datetime.now(timezone.utc))
        )
        await session.commit()

    monkeypatch.setattr(settings, "RETENTION_INACTIVE_ACCOUNT_DAYS", 365)
    async with AsyncSessionLocal() as session:
        report = await purge_expired(session)
        await session.commit()

    assert report.inactive_accounts_deleted >= 1
    async with AsyncSessionLocal() as session:
        assert await session.get(Company, old_id) is None  # purged (inactive > 365 j)
        assert await session.get(Company, recent_id) is not None  # kept (actif)
