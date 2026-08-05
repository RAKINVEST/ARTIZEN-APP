"""Calendar builder — pure grouping of entries into day buckets (day/week views).

Pure and DB-free: operates on anything carrying a ``start_at`` datetime.
"""

from datetime import date


def group_by_day(entries: list) -> list[dict]:
    """Return ``[{date, entries}]`` ordered by day, each day's entries ordered
    by start time. Deterministic."""
    buckets: dict[date, list] = {}
    for entry in sorted(entries, key=lambda e: e.start_at):
        day = entry.start_at.date()
        buckets.setdefault(day, []).append(entry)
    return [{"date": day.isoformat(), "entries": items} for day, items in sorted(buckets.items())]
