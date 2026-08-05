"""Mission module errors, typed by domain (never a bare ``except``)."""

from app.core.exceptions import AppException, ConflictError, NotFoundError


class MissionError(AppException):
    """Base class for mission-layer errors (400 by default)."""


class MissionNotFoundError(NotFoundError):
    error_code = "mission_not_found"  # 404 (also tenant mismatch)


class InvalidMissionTransitionError(ConflictError):
    error_code = "invalid_mission_transition"  # 409
