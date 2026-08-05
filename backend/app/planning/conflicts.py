"""Conflict detection — pure, deterministic, DB-free (unit-testable).

Given a proposed slot (with an artisan/vehicle) and the existing entries,
returns every conflict with a full explanation. Never guesses: it reports what
it finds. A time overlap between **different** resources is legitimate parallel
work and is *not* a conflict. Conflict types: planning_ferme, hors_horaires,
artisan_indisponible, vehicule_indisponible.
"""

from dataclasses import dataclass

from app.planning.slots import (
    WORKING_END_HOUR,
    WORKING_START_HOUR,
    TimeSlot,
    is_closed_day,
    within_working_hours,
)


@dataclass(frozen=True)
class PlanningConflict:
    type: str
    detail: str
    entry_id: str = ""  # the conflicting entry, when applicable


@dataclass(frozen=True)
class ExistingEntry:
    """A DB-free view of an existing planning entry (adapter fills it)."""

    entry_id: str
    artisan: str
    vehicle: str
    slot: TimeSlot


class ConflictDetector:
    @staticmethod
    def detect(
        slot: TimeSlot, *, artisan: str, vehicle: str, existing: list[ExistingEntry]
    ) -> list[PlanningConflict]:
        conflicts: list[PlanningConflict] = []

        if is_closed_day(slot.start):
            conflicts.append(
                PlanningConflict("planning_ferme", "Le planning est fermé ce jour-là.")
            )
        elif not within_working_hours(slot):
            conflicts.append(
                PlanningConflict(
                    "hors_horaires",
                    f"Créneau hors des horaires d'ouverture "
                    f"({WORKING_START_HOUR}h–{WORKING_END_HOUR}h).",
                )
            )

        for other in existing:
            if not slot.overlaps(other.slot):
                continue
            if artisan and other.artisan == artisan:
                conflicts.append(
                    PlanningConflict(
                        "artisan_indisponible",
                        f"L'artisan « {artisan} » est déjà planifié sur ce créneau.",
                        other.entry_id,
                    )
                )
            elif vehicle and other.vehicle == vehicle:
                conflicts.append(
                    PlanningConflict(
                        "vehicule_indisponible",
                        f"Le véhicule « {vehicle} » est déjà utilisé sur ce créneau.",
                        other.entry_id,
                    )
                )
            # A time overlap with different (or no) shared resource is allowed
            # parallel work — deliberately not reported as a conflict.
        return conflicts
