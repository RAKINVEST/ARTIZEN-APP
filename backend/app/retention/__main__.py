"""Runnable RGPD retention purge: ``python -m app.retention``.

Cron-activatable (see ``scripts/retention_purge.sh``). A strict no-op unless a
retention duration is configured — scheduling it is a deployment concern; the
policy behind it is the juriste's.
"""

import asyncio
import logging

from app.database.session import AsyncSessionLocal
from app.retention.service import purge_expired

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("app.retention")


async def _run() -> None:
    async with AsyncSessionLocal() as session:
        report = await purge_expired(session)
        await session.commit()
    logger.info(
        "retention.purge inactive_accounts_deleted=%d total=%d",
        report.inactive_accounts_deleted,
        report.total,
    )


if __name__ == "__main__":
    asyncio.run(_run())
