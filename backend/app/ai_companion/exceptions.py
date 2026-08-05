"""AI Companion errors, typed by domain (never a bare ``except``).

The Companion owns no business data; its only errors are conversational
(unknown/expired session) or a refusal to act without confirmation.
"""

from app.core.exceptions import AppException, NotFoundError


class CompanionError(AppException):
    """Base class for companion-layer errors (400 by default)."""


class SessionNotFoundError(NotFoundError):
    error_code = "companion_session_not_found"  # 404 (expired or wrong tenant)


class NoPendingActionError(CompanionError):
    """Confirm/cancel called with nothing awaiting validation."""

    error_code = "companion_no_pending_action"


class ActionNotReadyError(CompanionError):
    """A proposed action is still missing required parameters."""

    error_code = "companion_action_not_ready"
