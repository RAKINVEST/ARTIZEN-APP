"""Orchestration Engine HTTP endpoints — the coordinator.

Receives a validated-decision context, runs the saga across the owning engines
(Mission, Workflow) through their public services, and exposes the correlation
id, plan, timeline, results and status. ``company_id`` comes from the JWT; a
tenant mismatch is 404. It owns no business data — only orchestration state.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.orchestration.deps import OrchestrationServiceDep
from app.orchestration.schemas import OrchestrationRead, StartOrchestrationRequest
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/orchestrations", tags=["orchestrations"])


def _actor(current_user: CurrentUserDep) -> str:
    return getattr(current_user, "email", None) or str(current_user.company_id)


@router.post("", response_model=OrchestrationRead, status_code=status.HTTP_201_CREATED)
async def start_orchestration(
    service: OrchestrationServiceDep,
    current_user: CurrentUserDep,
    payload: StartOrchestrationRequest,
) -> OrchestrationRead:
    instance = await service.start(
        company_id=current_user.company_id,
        actor=_actor(current_user),
        plan_kind=payload.plan_kind,
        context=payload.context,
    )
    return service.to_read(instance)


@router.get("", response_model=list[OrchestrationRead])
async def list_orchestrations(
    service: OrchestrationServiceDep,
    current_user: CurrentUserDep,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[OrchestrationRead]:
    instances = await service.list(
        company_id=current_user.company_id, offset=offset, limit=limit
    )
    return [service.to_read(i) for i in instances]


@router.get("/{instance_id}", response_model=OrchestrationRead)
async def get_orchestration(
    service: OrchestrationServiceDep, current_user: CurrentUserDep, instance_id: uuid.UUID
) -> OrchestrationRead:
    instance = await service.get(instance_id)
    ensure_same_company(instance.company_id, instance_id, current_user.company_id)
    return service.to_read(instance)


@router.post("/{instance_id}/retry", response_model=OrchestrationRead)
async def retry_orchestration(
    service: OrchestrationServiceDep, current_user: CurrentUserDep, instance_id: uuid.UUID
) -> OrchestrationRead:
    existing = await service.get(instance_id)
    ensure_same_company(existing.company_id, instance_id, current_user.company_id)
    instance = await service.retry(
        instance_id=instance_id, company_id=current_user.company_id, actor=_actor(current_user)
    )
    return service.to_read(instance)
