"""Mission Engine HTTP endpoints — owns the real interventions.

Create a mission, drive its lifecycle (ouvrir/clôturer via status), associate a
site and a workflow, attach photos/documents/notes, and read its timeline and
progress. ``company_id`` comes from the JWT; a tenant mismatch is 404. There is
deliberately no hard delete (Loi 5): a mission is cancelled/closed.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.mission.deps import MissionServiceDep
from app.mission.schemas import (
    AssociateWorkflowRequest,
    AttachmentRequest,
    MissionCreate,
    MissionRead,
    MissionStatusRequest,
)
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/missions", tags=["missions"])


def _actor(current_user: CurrentUserDep) -> str:
    return getattr(current_user, "email", None) or str(current_user.company_id)


@router.post("", response_model=MissionRead, status_code=status.HTTP_201_CREATED)
async def create_mission(
    service: MissionServiceDep, current_user: CurrentUserDep, payload: MissionCreate
) -> MissionRead:
    mission = await service.create(company_id=current_user.company_id, data=payload)
    return service.to_read(mission)


@router.get("", response_model=list[MissionRead])
async def list_missions(
    service: MissionServiceDep,
    current_user: CurrentUserDep,
    customer_id: uuid.UUID | None = None,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[MissionRead]:
    missions = await service.list(
        company_id=current_user.company_id, customer_id=customer_id, offset=offset, limit=limit
    )
    return [service.to_read(m) for m in missions]


@router.get("/{mission_id}", response_model=MissionRead)
async def get_mission(
    service: MissionServiceDep, current_user: CurrentUserDep, mission_id: uuid.UUID
) -> MissionRead:
    mission = await service.get(mission_id)
    ensure_same_company(mission.company_id, mission_id, current_user.company_id)
    return service.to_read(mission)


@router.post("/{mission_id}/status", response_model=MissionRead)
async def change_status(
    service: MissionServiceDep,
    current_user: CurrentUserDep,
    mission_id: uuid.UUID,
    payload: MissionStatusRequest,
) -> MissionRead:
    existing = await service.get(mission_id)
    ensure_same_company(existing.company_id, mission_id, current_user.company_id)
    mission = await service.change_status(
        mission_id=mission_id, target=payload.status, actor=_actor(current_user)
    )
    return service.to_read(mission)


@router.post("/{mission_id}/workflow", response_model=MissionRead)
async def associate_workflow(
    service: MissionServiceDep,
    current_user: CurrentUserDep,
    mission_id: uuid.UUID,
    payload: AssociateWorkflowRequest,
) -> MissionRead:
    existing = await service.get(mission_id)
    ensure_same_company(existing.company_id, mission_id, current_user.company_id)
    mission = await service.associate_workflow(
        mission_id=mission_id,
        workflow_instance_id=payload.workflow_instance_id,
        company_id=current_user.company_id,
        actor=_actor(current_user),
    )
    return service.to_read(mission)


@router.post("/{mission_id}/attachments", response_model=MissionRead)
async def add_attachment(
    service: MissionServiceDep,
    current_user: CurrentUserDep,
    mission_id: uuid.UUID,
    payload: AttachmentRequest,
) -> MissionRead:
    existing = await service.get(mission_id)
    ensure_same_company(existing.company_id, mission_id, current_user.company_id)
    mission = await service.add_attachment(
        mission_id=mission_id,
        kind=payload.kind,
        label=payload.label,
        reference=payload.reference,
        text=payload.text,
        actor=_actor(current_user),
    )
    return service.to_read(mission)
