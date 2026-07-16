"""Document-analysis-specific errors, built on the shared ``AppException``
hierarchy (see ``app/core/exceptions.py``) so the global exception
handlers already know how to render them as JSON.
"""

from app.core.exceptions import AppException


class InvalidDocumentError(AppException):
    """Raised when a stored file cannot be parsed as a valid PDF."""

    status_code = 422
    error_code = "invalid_document"
