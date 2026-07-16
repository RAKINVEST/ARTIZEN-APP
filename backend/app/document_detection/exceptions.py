"""Document-detection-specific errors, built on the shared ``AppException``
hierarchy (see ``app/core/exceptions.py``).
"""

from app.core.exceptions import AppException


class DocumentNotProcessedError(AppException):
    """Raised when detection is requested before the document has finished processing."""

    status_code = 409
    error_code = "document_not_processed"
