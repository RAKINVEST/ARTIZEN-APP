"""Quotes-specific errors, built on the shared ``AppException`` hierarchy
(see ``app/core/exceptions.py``).
"""

from app.core.exceptions import AppException


class InactiveCatalogItemError(AppException):
    """Raised when a quote line tries to use a deactivated catalog item."""

    status_code = 409
    error_code = "inactive_catalog_item"
