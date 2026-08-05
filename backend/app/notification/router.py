"""Notification Engine HTTP endpoints — the exclusive owner of notifications.

Send a notification (optionally from a template), list them, resend one.
``company_id`` comes from the JWT; a tenant mismatch is 404.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.notification.deps import NotificationServiceDep
from app.notification.schemas import NotificationCreate, NotificationRead
from app.notification.templates import available_templates
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/notifications", tags=["notifications"])


def _actor(current_user: CurrentUserDep) -> str:
    return getattr(current_user, "email", None) or str(current_user.company_id)


@router.get("/templates", response_model=list[str])
async def list_templates(_current_user: CurrentUserDep) -> list[str]:
    return available_templates()


@router.post("", response_model=NotificationRead, status_code=status.HTTP_201_CREATED)
async def send_notification(
    service: NotificationServiceDep, current_user: CurrentUserDep, payload: NotificationCreate
) -> NotificationRead:
    notification = await service.notify(
        company_id=current_user.company_id,
        actor=_actor(current_user),
        channel=payload.channel,
        recipient=payload.recipient,
        subject=payload.subject,
        body=payload.body,
        template_key=payload.template_key,
        context=payload.context,
        related_type=payload.related_type,
        related_id=payload.related_id,
    )
    return service.to_read(notification)


@router.get("", response_model=list[NotificationRead])
async def list_notifications(
    service: NotificationServiceDep,
    current_user: CurrentUserDep,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[NotificationRead]:
    notifications = await service.list(
        company_id=current_user.company_id, offset=offset, limit=limit
    )
    return [service.to_read(n) for n in notifications]


@router.get("/{notification_id}", response_model=NotificationRead)
async def get_notification(
    service: NotificationServiceDep, current_user: CurrentUserDep, notification_id: uuid.UUID
) -> NotificationRead:
    notification = await service.get(notification_id)
    ensure_same_company(notification.company_id, notification_id, current_user.company_id)
    return service.to_read(notification)


@router.post("/{notification_id}/resend", response_model=NotificationRead)
async def resend_notification(
    service: NotificationServiceDep, current_user: CurrentUserDep, notification_id: uuid.UUID
) -> NotificationRead:
    existing = await service.get(notification_id)
    ensure_same_company(existing.company_id, notification_id, current_user.company_id)
    notification = await service.resend(
        notification_id=notification_id, actor=_actor(current_user)
    )
    return service.to_read(notification)
