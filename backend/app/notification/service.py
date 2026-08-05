"""Notification business logic — the exclusive owner of notifications.

``notify`` is the public entry point other engines (Orchestration, Mission,
Quote) call to send a notification: it validates the channel, optionally renders
a template, dispatches through the channel provider, and persists the result
with its append-only history. A dispatch failure is recorded (status=failed),
never silent. No amount is computed (ADR-023).
"""

import logging
import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.notification.channels import is_valid_channel
from app.notification.dispatcher import (
    STATUS_FAILED,
    STATUS_SENT,
    NotificationDispatcher,
)
from app.notification.exceptions import NotificationError, NotificationNotFoundError
from app.notification.history import EventPublisher
from app.notification.models import Notification
from app.notification.repository import NotificationRepository
from app.notification.schemas import NotificationRead
from app.notification.templates import render

logger = logging.getLogger(__name__)


class NotificationService:
    def __init__(self, session: AsyncSession, notifications: NotificationRepository) -> None:
        self._session = session
        self._notifications = notifications

    async def notify(
        self,
        *,
        company_id: uuid.UUID,
        actor: str,
        channel: str,
        recipient: str,
        subject: str = "",
        body: str = "",
        template_key: str = "",
        context: dict | None = None,
        related_type: str = "",
        related_id: str = "",
    ) -> Notification:
        if not is_valid_channel(channel):
            raise NotificationError(f"Unknown channel '{channel}'.")
        if not recipient:
            raise NotificationError("A recipient is required.")
        if template_key:
            subject, body = render(template_key, context or {})

        history: list[dict] = []
        EventPublisher.record(history, event="NotificationCreated", actor=actor, detail=channel)
        status = NotificationDispatcher.dispatch(
            channel=channel, recipient=recipient, subject=subject, body=body
        )
        EventPublisher.record(
            history,
            event="NotificationSent" if status == STATUS_SENT else "NotificationFailed",
            actor=actor,
            detail=recipient,
        )
        notification = Notification(
            company_id=company_id,
            channel=channel,
            recipient=recipient,
            subject=subject,
            body=body,
            status=status,
            template_key=template_key,
            related_type=related_type,
            related_id=related_id,
            history=history,
        )
        logger.info(
            "notification.notify company_id=%s channel=%s status=%s", company_id, channel, status
        )
        return await self._notifications.create(notification)

    async def get(self, notification_id: uuid.UUID) -> Notification:
        notification = await self._notifications.get(notification_id)
        if notification is None:
            raise NotificationNotFoundError(f"Notification {notification_id} not found.")
        return notification

    async def list(
        self, *, company_id: uuid.UUID, offset: int = 0, limit: int = 100
    ) -> list[Notification]:
        return await self._notifications.list_by_company(company_id, offset=offset, limit=limit)

    async def resend(self, *, notification_id: uuid.UUID, actor: str) -> Notification:
        notification = await self.get(notification_id)
        status = NotificationDispatcher.dispatch(
            channel=notification.channel, recipient=notification.recipient,
            subject=notification.subject, body=notification.body,
        )
        notification.status = status
        new_history = list(notification.history)
        EventPublisher.record(
            new_history,
            event="NotificationSent" if status == STATUS_SENT else "NotificationFailed",
            actor=actor, detail="resend",
        )
        notification.history = new_history
        await self._session.flush()
        await self._session.refresh(notification)
        return notification

    @staticmethod
    def to_read(notification: Notification) -> NotificationRead:
        return NotificationRead(
            id=notification.id,
            company_id=notification.company_id,
            channel=notification.channel,
            recipient=notification.recipient,
            subject=notification.subject,
            body=notification.body,
            status=notification.status,
            template_key=notification.template_key,
            related_type=notification.related_type,
            related_id=notification.related_id,
            history=notification.history,
            created_at=notification.created_at,
            updated_at=notification.updated_at,
        )


# Statuses re-exported for callers.
__all__ = ["STATUS_FAILED", "STATUS_SENT", "NotificationService"]
