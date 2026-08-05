"""Planning Engine HTTP endpoints — the sole owner of the schedule.

Create/patch/move/cancel entries, assign an artisan/team/vehicle, and query
availability/conflicts (with a full explanation). ``company_id`` comes from the
JWT; a tenant mismatch is 404. A schedule change that conflicts is refused
(409). There is no hard delete (Loi 5): an entry is cancelled.
"""

import uuid
from datetime import datetime

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.planning.deps import PlanningServiceDep
from app.planning.schemas import (
    AvailabilityRead,
    PlanningAssignRequest,
    PlanningCreate,
    PlanningMoveRequest,
    PlanningPatch,
    PlanningRead,
)
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/planning", tags=["planning"])


def _actor(current_user: CurrentUserDep) -> str:
    return getattr(current_user, "email", None) or str(current_user.company_id)


# Static sub-paths declared BEFORE /{entry_id} so they are not captured as ids.
@router.get("/availability", response_model=AvailabilityRead)
async def availability(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    start_at: datetime,
    duration_minutes: int = Query(gt=0, le=24 * 60),
    artisan: str = "",
    vehicle: str = "",
    exclude_id: uuid.UUID | None = None,
) -> AvailabilityRead:
    return await service.check_availability(
        company_id=current_user.company_id, start_at=start_at, duration_minutes=duration_minutes,
        artisan=artisan, vehicle=vehicle, exclude_id=exclude_id,
    )


@router.get("/conflicts", response_model=AvailabilityRead)
async def conflicts(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    start_at: datetime,
    duration_minutes: int = Query(gt=0, le=24 * 60),
    artisan: str = "",
    vehicle: str = "",
    exclude_id: uuid.UUID | None = None,
) -> AvailabilityRead:
    return await service.check_availability(
        company_id=current_user.company_id, start_at=start_at, duration_minutes=duration_minutes,
        artisan=artisan, vehicle=vehicle, exclude_id=exclude_id,
    )


@router.post("", response_model=PlanningRead, status_code=status.HTTP_201_CREATED)
async def create_planning(
    service: PlanningServiceDep, current_user: CurrentUserDep, payload: PlanningCreate
) -> PlanningRead:
    entry = await service.create(
        company_id=current_user.company_id, actor=_actor(current_user), data=payload
    )
    return service.to_read(entry)


@router.get("", response_model=list[PlanningRead])
async def list_planning(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    offset: int = Query(0, ge=0),
    limit: int = Query(200, ge=1, le=500),
) -> list[PlanningRead]:
    entries = await service.list(company_id=current_user.company_id, offset=offset, limit=limit)
    return [service.to_read(e) for e in entries]


@router.get("/{entry_id}", response_model=PlanningRead)
async def get_planning(
    service: PlanningServiceDep, current_user: CurrentUserDep, entry_id: uuid.UUID
) -> PlanningRead:
    entry = await service.get(entry_id)
    ensure_same_company(entry.company_id, entry_id, current_user.company_id)
    return service.to_read(entry)


@router.patch("/{entry_id}", response_model=PlanningRead)
async def patch_planning(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    entry_id: uuid.UUID,
    payload: PlanningPatch,
) -> PlanningRead:
    existing = await service.get(entry_id)
    ensure_same_company(existing.company_id, entry_id, current_user.company_id)
    entry = await service.patch(entry_id=entry_id, data=payload, actor=_actor(current_user))
    return service.to_read(entry)


@router.post("/{entry_id}/assign", response_model=PlanningRead)
async def assign_planning(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    entry_id: uuid.UUID,
    payload: PlanningAssignRequest,
) -> PlanningRead:
    existing = await service.get(entry_id)
    ensure_same_company(existing.company_id, entry_id, current_user.company_id)
    entry = await service.assign(entry_id=entry_id, data=payload, actor=_actor(current_user))
    return service.to_read(entry)


@router.post("/{entry_id}/move", response_model=PlanningRead)
async def move_planning(
    service: PlanningServiceDep,
    current_user: CurrentUserDep,
    entry_id: uuid.UUID,
    payload: PlanningMoveRequest,
) -> PlanningRead:
    existing = await service.get(entry_id)
    ensure_same_company(existing.company_id, entry_id, current_user.company_id)
    entry = await service.move(
        entry_id=entry_id, start_at=payload.start_at,
        duration_minutes=payload.duration_minutes, actor=_actor(current_user),
    )
    return service.to_read(entry)


@router.post("/{entry_id}/cancel", response_model=PlanningRead)
async def cancel_planning(
    service: PlanningServiceDep, current_user: CurrentUserDep, entry_id: uuid.UUID
) -> PlanningRead:
    existing = await service.get(entry_id)
    ensure_same_company(existing.company_id, entry_id, current_user.company_id)
    entry = await service.cancel(entry_id=entry_id, actor=_actor(current_user))
    return service.to_read(entry)
