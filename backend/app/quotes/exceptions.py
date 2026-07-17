"""Quotes-specific errors, built on the shared ``AppException`` hierarchy
(see ``app/core/exceptions.py``).
"""

from app.core.exceptions import AppException


class InactiveCatalogItemError(AppException):
    """Raised when a quote line tries to use a deactivated catalog item."""

    status_code = 409
    error_code = "inactive_catalog_item"


class QuoteNotEditableError(AppException):
    """Raised when a quote that has left DRAFT is asked to change.

    409 rather than 403: nothing is wrong with the caller's permissions —
    the quote is simply in a state where the request no longer makes sense.
    A sent quote is a document the customer already holds; changing it
    behind their back is the thing this refuses.
    """

    status_code = 409
    error_code = "quote_not_editable"


class InvalidQuoteTransitionError(AppException):
    """Raised when a status change isn't allowed from the current status.

    Sent -> Accepted is a fact the artisan records. Accepted -> Draft is
    not a fact, it is a rewrite of history — see ``QUOTE_TRANSITIONS``.
    """

    status_code = 409
    error_code = "invalid_quote_transition"
