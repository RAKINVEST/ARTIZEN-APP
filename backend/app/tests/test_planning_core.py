"""Pure unit tests for the Planning Engine core (no DB, no HTTP).

Pin slots, conflict detection, availability, auto-assignment and the calendar —
runnable locally (``pytest --noconftest app/tests/test_planning_core.py``).
Weekdays are derived (not hard-coded) so the tests never depend on a guess.
"""

from dataclasses import dataclass
from datetime import datetime, timedelta, timezone

from app.planning.availability import AssignmentEngine, AvailabilityEngine
from app.planning.calendar import group_by_day
from app.planning.conflicts import ConflictDetector, ExistingEntry
from app.planning.slots import TimeSlot, is_closed_day, within_working_hours

_REF = datetime(2026, 6, 15, 0, 0, tzinfo=timezone.utc)
_MONDAY = (_REF - timedelta(days=_REF.weekday())).replace(hour=0)  # guaranteed Monday
_SUNDAY = _MONDAY - timedelta(days=1)  # guaranteed Sunday


def _mon(hour: int, minute: int = 0) -> datetime:
    return _MONDAY.replace(hour=hour, minute=minute)


def test_timeslot_overlap() -> None:
    a = TimeSlot.of(_mon(9), 120)  # 9–11
    b = TimeSlot.of(_mon(10), 120)  # 10–12 overlaps
    c = TimeSlot.of(_mon(11), 60)  # 11–12 touches a's end -> no overlap
    assert a.overlaps(b)
    assert not a.overlaps(c)


def test_working_hours_and_closed_days() -> None:
    assert within_working_hours(TimeSlot.of(_mon(9), 120))
    assert not within_working_hours(TimeSlot.of(_mon(7), 60))  # before opening
    assert not within_working_hours(TimeSlot.of(_mon(17, 30), 60))  # ends after 18h
    assert is_closed_day(_SUNDAY)
    assert not is_closed_day(_MONDAY)


def test_conflict_detection_types() -> None:
    existing = [
        ExistingEntry("e1", artisan="alice", vehicle="v1", slot=TimeSlot.of(_mon(10), 120))
    ]
    slot = TimeSlot.of(_mon(9), 120)  # overlaps e1

    same_artisan = ConflictDetector.detect(slot, artisan="alice", vehicle="", existing=existing)
    assert [c.type for c in same_artisan] == ["artisan_indisponible"]

    same_vehicle = ConflictDetector.detect(slot, artisan="bob", vehicle="v1", existing=existing)
    assert [c.type for c in same_vehicle] == ["vehicule_indisponible"]

    # Different resources overlapping = legitimate parallel work, not a conflict.
    parallel = ConflictDetector.detect(slot, artisan="bob", vehicle="v2", existing=existing)
    assert parallel == []

    closed = ConflictDetector.detect(
        TimeSlot.of(_SUNDAY.replace(hour=9), 60), artisan="", vehicle="", existing=[]
    )
    assert [c.type for c in closed] == ["planning_ferme"]

    out = ConflictDetector.detect(TimeSlot.of(_mon(7), 60), artisan="", vehicle="", existing=[])
    assert [c.type for c in out] == ["hors_horaires"]


def test_availability_and_auto_assignment() -> None:
    existing = [
        ExistingEntry("e1", artisan="alice", vehicle="", slot=TimeSlot.of(_mon(9), 120))
    ]
    slot = TimeSlot.of(_mon(9), 60)  # 9–10 overlaps e1
    assert not AvailabilityEngine.is_available(slot, artisan="alice", vehicle="", existing=existing)
    assert AvailabilityEngine.is_available(slot, artisan="bob", vehicle="", existing=existing)

    # Auto-assign picks the first free candidate (deterministic).
    assert AssignmentEngine.auto_assign(["alice", "bob"], slot, existing) == "bob"
    both_busy = [
        ExistingEntry("e1", artisan="alice", vehicle="", slot=TimeSlot.of(_mon(9), 120)),
        ExistingEntry("e2", artisan="bob", vehicle="", slot=TimeSlot.of(_mon(9), 120)),
    ]
    assert AssignmentEngine.auto_assign(["alice", "bob"], slot, both_busy) is None


def test_calendar_group_by_day() -> None:
    @dataclass
    class _E:
        id: str
        start_at: datetime

    entries = [
        _E("b", _mon(14)),
        _E("a", _mon(9)),
        _E("c", (_MONDAY + timedelta(days=1)).replace(hour=9)),
    ]
    grouped = group_by_day(entries)
    assert len(grouped) == 2  # two distinct days
    # Same-day entries ordered by start time (a before b).
    assert [e.id for e in grouped[0]["entries"]] == ["a", "b"]
