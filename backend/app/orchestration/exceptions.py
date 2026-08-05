"""Orchestration module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, NotFoundError


class OrchestrationError(AppException):
    """Base class for orchestration-layer errors (400 by default)."""


class OrchestrationNotFoundError(NotFoundError):
    error_code = "orchestration_not_found"  # 404 (also tenant mismatch)


class StepExecutionError(OrchestrationError):
    """Raised by a step handler. ``retryable`` drives the retry policy."""

    error_code = "step_execution_failed"

    def __init__(self, detail: str, *, retryable: bool = True) -> None:
        super().__init__(detail)
        self.retryable = retryable
