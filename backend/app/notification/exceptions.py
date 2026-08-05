"""Notification module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, NotFoundError


class NotificationError(AppException):
    """Base class for notification-layer errors (400 by default)."""


class NotificationNotFoundError(NotFoundError):
    error_code = "notification_not_found"  # 404 (also tenant mismatch)
