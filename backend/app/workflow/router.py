"""Workflow Engine HTTP endpoints.

Owns and drives business processes. A validated decision can start a workflow
(``POST /workflow/instances``); transitions move it through its state machine
(``POST /workflow/instances/{id}/transition``), enforcing valid transitions and
human validation. ``company_id`` comes from the JWT; a tenant mismatch is 404.
"""

import uuid

from fastapi import APIRouter, Query, status

from app.core.authorization import ensure_same_company
from app.users.deps import CurrentUserDep
from app.workflow.deps import WorkflowServiceDep
from app.workflow.schemas import (
    StartWorkflowRequest,
    TransitionRequest,
    WorkflowDefinitionRead,
    WorkflowInstanceRead,
)

router = APIRouter(prefix="/workflow", tags=["workflow"])


@router.get("/definitions", response_model=list[WorkflowDefinitionRead])
async def list_definitions(
    service: WorkflowServiceDep, _current_user: CurrentUserDep
) -> list[WorkflowDefinitionRead]:
    return service.definitions()


@router.post(
    "/instances", response_model=WorkflowInstanceRead, status_code=status.HTTP_201_CREATED
)
async def start_instance(
    service: WorkflowServiceDep, current_user: CurrentUserDep, payload: StartWorkflowRequest
) -> WorkflowInstanceRead:
    instance = await service.start(
        company_id=current_user.company_id,
        definition_slug=payload.definition_slug,
        context=payload.context,
    )
    return service.to_read(instance)


@router.get("/instances", response_model=list[WorkflowInstanceRead])
async def list_instances(
    service: WorkflowServiceDep,
    current_user: CurrentUserDep,
    offset: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=200),
) -> list[WorkflowInstanceRead]:
    instances = await service.list(
        company_id=current_user.company_id, offset=offset, limit=limit
    )
    return [service.to_read(i) for i in instances]


@router.get("/instances/{instance_id}", response_model=WorkflowInstanceRead)
async def get_instance(
    service: WorkflowServiceDep, current_user: CurrentUserDep, instance_id: uuid.UUID
) -> WorkflowInstanceRead:
    instance = await service.get(instance_id)
    ensure_same_company(instance.company_id, instance_id, current_user.company_id)
    return service.to_read(instance)


@router.post("/instances/{instance_id}/transition", response_model=WorkflowInstanceRead)
async def transition_instance(
    service: WorkflowServiceDep,
    current_user: CurrentUserDep,
    instance_id: uuid.UUID,
    payload: TransitionRequest,
) -> WorkflowInstanceRead:
    existing = await service.get(instance_id)
    ensure_same_company(existing.company_id, instance_id, current_user.company_id)
    actor = getattr(current_user, "email", None) or str(current_user.company_id)
    instance = await service.transition(
        instance_id=instance_id, event=payload.event, actor=actor
    )
    return service.to_read(instance)
