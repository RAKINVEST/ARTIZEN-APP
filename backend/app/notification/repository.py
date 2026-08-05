"""Data-access layer for the notification module."""

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.notification.models import Notification
from app.repositories.base import BaseRepository


class NotificationRepository(BaseRepository[Notification]):
    def __init__(self, session: AsyncSession) -> None:
        super().__init__(Notification, session)

    async def list_by_company(
        self, company_id: uuid.UUID, *, offset: int = 0, limit: int = 100
    ) -> list[Notification]:
        result = await self.session.execute(
            select(Notification)
            .where(Notification.company_id == company_id)
            .order_by(Notification.created_at.desc())
            .offset(offset)
            .limit(limit)
        )
        return list(result.scalars().all())
