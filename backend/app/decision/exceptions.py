"""Decision module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException


class DecisionError(AppException):
    """Base class for decision-layer errors."""


class IntentNotUnderstoodError(DecisionError):
    # Not a 4xx by itself: the service turns an unclear intent into a
    # needs_confirmation response (ask, don't fail). Kept for the rare case a
    # caller wants a hard error path.
    error_code = "intent_not_understood"
