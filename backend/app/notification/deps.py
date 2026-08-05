"""FastAPI dependencies for the notification module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.notification.repository import NotificationRepository
from app.notification.service import NotificationService


def get_notification_service(session: SessionDep) -> NotificationService:
    return NotificationService(session, NotificationRepository(session))


NotificationServiceDep = Annotated[NotificationService, Depends(get_notification_service)]
