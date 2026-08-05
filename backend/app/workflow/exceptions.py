"""Workflow module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, ConflictError, NotFoundError


class WorkflowError(AppException):
    """Base class for workflow-layer errors."""


class UnknownWorkflowError(WorkflowError):
    error_code = "unknown_workflow"  # 400: no such definition


class WorkflowNotFoundError(NotFoundError):
    error_code = "workflow_not_found"  # 404: no such instance (or wrong tenant)


class InvalidTransitionError(ConflictError):
    error_code = "invalid_transition"  # 409: event not allowed from current state
