"""Availability & assignment — pure, deterministic, DB-free (unit-testable).

Availability is the absence of any conflict. Auto-assignment picks the first
candidate artisan free on the slot (deterministic given the candidate order).
"""

from app.planning.conflicts import ConflictDetector, ExistingEntry
from app.planning.slots import TimeSlot


class AvailabilityEngine:
    @staticmethod
    def is_available(
        slot: TimeSlot, *, artisan: str, vehicle: str, existing: list[ExistingEntry]
    ) -> bool:
        return not ConflictDetector.detect(
            slot, artisan=artisan, vehicle=vehicle, existing=existing
        )


class AssignmentEngine:
    @staticmethod
    def auto_assign(
        candidates: list[str], slot: TimeSlot, existing: list[ExistingEntry]
    ) -> str | None:
        """First candidate free on the slot, or None. Deterministic."""
        for candidate in candidates:
            if AvailabilityEngine.is_available(
                slot, artisan=candidate, vehicle="", existing=existing
            ):
                return candidate
        return None
