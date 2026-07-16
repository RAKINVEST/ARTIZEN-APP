"""Template-import-specific errors, built on the shared ``AppException``
hierarchy (see ``app/core/exceptions.py``).
"""

from app.core.exceptions import AppException


class InvalidDocumentTypeForTemplateError(AppException):
    """Raised when trying to turn a non-quote ``DocumentAnalysis`` (e.g.
    an imported invoice) into a quote template — this feature is
    specifically "importer un ancien devis"."""

    status_code = 409
    error_code = "invalid_document_type_for_template"
