"""Planning module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, ConflictError, NotFoundError


class PlanningError(AppException):
    """Base class for planning-layer errors (400 by default)."""


class PlanningNotFoundError(NotFoundError):
    error_code = "planning_not_found"  # 404 (also tenant mismatch)


class PlanningConflictError(ConflictError):
    error_code = "planning_conflict"  # 409: a conflict blocks the schedule/move

    def __init__(self, detail: str, *, conflicts: list | None = None) -> None:
        super().__init__(detail)
        self.conflicts = conflicts or []
