"""Knowledge module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, NotFoundError


class KnowledgeError(AppException):
    """Base class for knowledge-layer errors."""


class KnowledgeNotFoundError(NotFoundError):
    error_code = "knowledge_not_found"
