"""Quote-assistant-specific errors, built on the shared ``AppException``
hierarchy (see ``app/core/exceptions.py``).
"""

from app.core.exceptions import AppException


class InvalidAIResponseError(AppException):
    """Raised when the configured AI provider's reply cannot be parsed
    into the strict JSON schema this module requires (missing fields,
    wrong types, or not JSON at all). 502: the fault is in what the
    upstream AI provider sent back, not in the caller's request."""

    status_code = 502
    error_code = "invalid_ai_response"
