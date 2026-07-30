"""RGPD retention purge — the ENGINE, driven entirely by configuration.

The **policy** (which durations apply, to what data, with which exceptions) is
the juriste's, supplied as configuration in :mod:`app.core.config`. This engine
**never hard-codes a value**: a rule runs only when its configured duration is
not ``None``, so with the default configuration the whole engine is a **strict
no-op** — nothing is ever purged until a duration is set. Changing the policy is
a configuration change; the engine is untouched.

It reuses the erasure mechanism behind ``DELETE /auth/me``: deleting a
:class:`~app.branding.models.Company` cascades to all its data
(``ON DELETE CASCADE`` on ``companies.id``).
"""

from dataclasses import dataclass
from datetime import datetime, timedelta, timezone

from sqlalchemy import delete, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.branding.models import Company
from app.core.config import settings


@dataclass(frozen=True)
class PurgeReport:
    """What a purge run deleted. One counter per rule, so activation can be
    verified and logged without echoing any personal data."""

    inactive_accounts_deleted: int = 0

    @property
    def total(self) -> int:
        return self.inactive_accounts_deleted


async def purge_expired(session: AsyncSession) -> PurgeReport:
    """Apply every **enabled** retention rule (a rule is enabled only when its
    configured duration is not ``None``) and return what was purged. Flushes but
    does not commit — the caller owns the transaction."""
    inactive_deleted = 0

    days = settings.RETENTION_INACTIVE_ACCOUNT_DAYS
    if days is not None:
        cutoff = datetime.now(timezone.utc) - timedelta(days=days)
        # A NULL last_active_at (legacy row / never logged in) is never purged
        # automatically — only a *known* activity older than the cutoff qualifies.
        result = await session.execute(
            select(Company.id).where(
                Company.last_active_at.is_not(None),
                Company.last_active_at < cutoff,
            )
        )
        ids = [row[0] for row in result.all()]
        if ids:
            await session.execute(delete(Company).where(Company.id.in_(ids)))
            inactive_deleted = len(ids)

    await session.flush()
    return PurgeReport(inactive_accounts_deleted=inactive_deleted)
