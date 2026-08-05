"""Time slots & working hours — pure, deterministic, DB-free (unit-testable).

A ``TimeSlot`` is a [start, end) interval. Working hours and closed days are
V1 constants (a configurable calendar is a later increment).
"""

from dataclasses import dataclass
from datetime import datetime, timedelta

# V1 working calendar (local business hours). Mon=0 … Sun=6.
WORKING_START_HOUR = 8
WORKING_END_HOUR = 18
CLOSED_WEEKDAYS = frozenset({6})  # Sunday closed


@dataclass(frozen=True)
class TimeSlot:
    start: datetime
    end: datetime

    @classmethod
    def of(cls, start: datetime, duration_minutes: int) -> "TimeSlot":
        return cls(start=start, end=start + timedelta(minutes=duration_minutes))

    def overlaps(self, other: "TimeSlot") -> bool:
        # Half-open intervals: touching at a boundary is not an overlap.
        return self.start < other.end and other.start < self.end


def is_closed_day(moment: datetime) -> bool:
    return moment.weekday() in CLOSED_WEEKDAYS


def within_working_hours(slot: TimeSlot) -> bool:
    if slot.start.date() != slot.end.date():
        return False  # V1: a slot stays within one day
    if slot.start.hour < WORKING_START_HOUR:
        return False
    end_minutes = slot.end.hour * 60 + slot.end.minute
    return end_minutes <= WORKING_END_HOUR * 60
