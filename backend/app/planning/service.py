"""Planning business logic — the sole owner of the schedule.

Creates/moves/cancels/assigns planning entries, computes availability and
detects conflicts (through the pure engines), and keeps the append-only
history. It receives Mission references only; it never reaches into another
engine's data. No amount is computed (ADR-023). Read-decide-write with conflict
guards on every schedule change.
"""

# The public ``list`` method would shadow the builtin ``list`` for any
# annotation evaluated later in the class body; deferring annotations keeps
# ``list[...]`` hints valid without evaluating them at class-definition time.
from __future__ import annotations

import logging
import uuid
from datetime import datetime

from sqlalchemy.ext.asyncio import AsyncSession

from app.planning.availability import AssignmentEngine
from app.planning.conflicts import ConflictDetector, ExistingEntry, PlanningConflict
from app.planning.exceptions import PlanningConflictError, PlanningNotFoundError
from app.planning.history import EventPublisher
from app.planning.models import (
    PLANNING_ANNULEE,
    PLANNING_DEPLACEE,
    PLANNING_TERMINEE,
    PlanningEntry,
)
from app.planning.repository import PlanningEntryRepository
from app.planning.schemas import (
    AvailabilityRead,
    PlanningAssignRequest,
    PlanningConflictRead,
    PlanningCreate,
    PlanningPatch,
    PlanningRead,
)
from app.planning.slots import TimeSlot

logger = logging.getLogger(__name__)

_TERMINAL = frozenset({PLANNING_ANNULEE, PLANNING_TERMINEE})


def _as_existing(entries: list[PlanningEntry]) -> list[ExistingEntry]:
    """Project persisted entries onto the pure ``ExistingEntry`` the conflict
    engine consumes. Module-level so ``list[...]`` resolves to the builtin, not
    the service's ``list`` method (which shadows it inside the class body)."""
    return [
        ExistingEntry(
            entry_id=str(e.id), artisan=e.artisan, vehicle=e.vehicle,
            slot=TimeSlot.of(e.start_at, e.duration_minutes),
        )
        for e in entries
    ]


class PlanningService:
    def __init__(self, session: AsyncSession, entries: PlanningEntryRepository) -> None:
        self._session = session
        self._entries = entries

    async def create(self, *, company_id: uuid.UUID, actor: str, data: PlanningCreate) -> PlanningEntry:
        slot = TimeSlot.of(data.start_at, data.duration_minutes)
        await self._guard(company_id, slot, artisan=data.artisan, vehicle=data.vehicle)
        history: list[dict] = []
        EventPublisher.record(history, event="PlanningCreated", actor=actor)
        entry = PlanningEntry(
            company_id=company_id,
            mission_id=data.mission_id,
            start_at=data.start_at,
            duration_minutes=data.duration_minutes,
            artisan=data.artisan,
            team=data.team,
            vehicle=data.vehicle,
            history=history,
        )
        return await self._entries.create(entry)

    async def get(self, entry_id: uuid.UUID) -> PlanningEntry:
        entry = await self._entries.get(entry_id)
        if entry is None:
            raise PlanningNotFoundError(f"Planning entry {entry_id} not found.")
        return entry

    async def list(
        self, *, company_id: uuid.UUID, offset: int = 0, limit: int = 200
    ) -> list[PlanningEntry]:
        return await self._entries.list_by_company(company_id, offset=offset, limit=limit)

    async def patch(self, *, entry_id: uuid.UUID, data: PlanningPatch, actor: str) -> PlanningEntry:
        entry = await self.get(entry_id)
        duration = data.duration_minutes if data.duration_minutes is not None else entry.duration_minutes
        artisan = data.artisan if data.artisan is not None else entry.artisan
        vehicle = data.vehicle if data.vehicle is not None else entry.vehicle
        slot = TimeSlot.of(entry.start_at, duration)
        await self._guard(entry.company_id, slot, artisan=artisan, vehicle=vehicle, exclude_id=entry.id)
        entry.duration_minutes = duration
        entry.artisan = artisan
        entry.vehicle = vehicle
        if data.team is not None:
            entry.team = data.team
        self._append(entry, event="PlanningUpdated", actor=actor)
        return await self._save(entry)

    async def move(
        self, *, entry_id: uuid.UUID, start_at: datetime, duration_minutes: int | None, actor: str
    ) -> PlanningEntry:
        entry = await self.get(entry_id)
        duration = duration_minutes if duration_minutes is not None else entry.duration_minutes
        slot = TimeSlot.of(start_at, duration)
        await self._guard(entry.company_id, slot, artisan=entry.artisan, vehicle=entry.vehicle, exclude_id=entry.id)
        entry.start_at = start_at
        entry.duration_minutes = duration
        if entry.status not in _TERMINAL:
            entry.status = PLANNING_DEPLACEE
        self._append(entry, event="PlanningMoved", actor=actor, detail=start_at.isoformat())
        return await self._save(entry)

    async def assign(
        self, *, entry_id: uuid.UUID, data: PlanningAssignRequest, actor: str
    ) -> PlanningEntry:
        entry = await self.get(entry_id)
        slot = TimeSlot.of(entry.start_at, entry.duration_minutes)
        existing = _as_existing(
            await self._entries.list_active_for_company(entry.company_id, exclude_id=entry.id)
        )
        artisan = data.artisan
        if data.auto:
            artisan = AssignmentEngine.auto_assign(data.candidates, slot, existing) or ""
            if not artisan:
                raise PlanningConflictError("Aucun artisan disponible sur ce créneau.")
        vehicle = data.vehicle or entry.vehicle
        conflicts = ConflictDetector.detect(slot, artisan=artisan, vehicle=vehicle, existing=existing)
        if conflicts:
            raise PlanningConflictError("; ".join(c.detail for c in conflicts), conflicts=conflicts)
        entry.artisan = artisan
        if data.team:
            entry.team = data.team
        if data.vehicle:
            entry.vehicle = data.vehicle
        self._append(entry, event="PlanningAssigned", actor=actor, detail=artisan)
        return await self._save(entry)

    async def cancel(self, *, entry_id: uuid.UUID, actor: str) -> PlanningEntry:
        entry = await self.get(entry_id)
        entry.status = PLANNING_ANNULEE  # never deleted (Loi 5)
        self._append(entry, event="PlanningCancelled", actor=actor)
        return await self._save(entry)

    async def check_availability(
        self, *, company_id: uuid.UUID, start_at: datetime, duration_minutes: int,
        artisan: str = "", vehicle: str = "", exclude_id: uuid.UUID | None = None,
    ) -> AvailabilityRead:
        slot = TimeSlot.of(start_at, duration_minutes)
        existing = _as_existing(
            await self._entries.list_active_for_company(company_id, exclude_id=exclude_id)
        )
        conflicts = ConflictDetector.detect(slot, artisan=artisan, vehicle=vehicle, existing=existing)
        return AvailabilityRead(
            available=not conflicts,
            conflicts=[
                PlanningConflictRead(type=c.type, detail=c.detail, entry_id=c.entry_id)
                for c in conflicts
            ],
        )

    @staticmethod
    def to_read(entry: PlanningEntry) -> PlanningRead:
        slot = TimeSlot.of(entry.start_at, entry.duration_minutes)
        return PlanningRead(
            id=entry.id,
            company_id=entry.company_id,
            mission_id=entry.mission_id,
            start_at=entry.start_at,
            end_at=slot.end,
            duration_minutes=entry.duration_minutes,
            artisan=entry.artisan,
            team=entry.team,
            vehicle=entry.vehicle,
            status=entry.status,
            is_terminal=entry.status in _TERMINAL,
            history=entry.history,
            created_at=entry.created_at,
            updated_at=entry.updated_at,
        )

    # --- internal helpers ---
    async def _guard(
        self, company_id: uuid.UUID, slot: TimeSlot, *, artisan: str, vehicle: str,
        exclude_id: uuid.UUID | None = None,
    ) -> None:
        existing = _as_existing(
            await self._entries.list_active_for_company(company_id, exclude_id=exclude_id)
        )
        conflicts = ConflictDetector.detect(slot, artisan=artisan, vehicle=vehicle, existing=existing)
        if conflicts:
            raise PlanningConflictError("; ".join(c.detail for c in conflicts), conflicts=conflicts)

    def _append(self, entry: PlanningEntry, *, event: str, actor: str, detail: str = "") -> None:
        new_history = list(entry.history)
        EventPublisher.record(new_history, event=event, actor=actor, detail=detail)
        entry.history = new_history  # reassign -> JSON dirty detection

    async def _save(self, entry: PlanningEntry) -> PlanningEntry:
        await self._session.flush()
        await self._session.refresh(entry)
        return entry


# Re-exported for callers that only need the conflict type.
__all__ = ["PlanningConflict", "PlanningService"]
