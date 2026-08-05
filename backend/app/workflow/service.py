"""Workflow business logic — the engine that owns and drives processes.

Instantiates a workflow (from a code-defined definition, e.g. started by a
validated decision), applies transitions through the pure state machine, records
events into the append-only history, and tracks progression. Write-side: it owns
``WorkflowInstance``. No amount is ever computed here (ADR-023).
"""

import logging
import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.workflow.definitions import all_definitions, get_definition
from app.workflow.events import EventPublisher
from app.workflow.exceptions import UnknownWorkflowError, WorkflowNotFoundError
from app.workflow.models import (
    WORKFLOW_STATUS_CANCELLED,
    WORKFLOW_STATUS_COMPLETED,
    WORKFLOW_STATUS_RUNNING,
    WorkflowInstance,
)
from app.workflow.repository import WorkflowInstanceRepository
from app.workflow.schemas import (
    TransitionRead,
    WorkflowDefinitionRead,
    WorkflowInstanceRead,
)
from app.workflow.state_machine import apply_transition, available_events, is_terminal

logger = logging.getLogger(__name__)

_CANCELLED_STATES = frozenset({"annulee", "annule"})


class WorkflowService:
    def __init__(self, session: AsyncSession, instances: WorkflowInstanceRepository) -> None:
        self._session = session
        self._instances = instances

    @staticmethod
    def definitions() -> list[WorkflowDefinitionRead]:
        return [
            WorkflowDefinitionRead(
                slug=d.slug,
                name=d.name,
                initial_state=d.initial_state,
                states=list(d.states),
                terminal_states=list(d.terminal_states),
                transitions=[
                    TransitionRead(
                        event=t.event,
                        source=t.source,
                        target=t.target,
                        requires_validation=t.requires_validation,
                    )
                    for t in d.transitions
                ],
            )
            for d in all_definitions()
        ]

    async def start(
        self, *, company_id: uuid.UUID, definition_slug: str, context: dict
    ) -> WorkflowInstance:
        definition = get_definition(definition_slug)
        if definition is None:
            raise UnknownWorkflowError(f"Unknown workflow '{definition_slug}'.")
        history: list[dict] = []
        EventPublisher.record(
            history, event="start", from_state="", to_state=definition.initial_state,
            actor=str(company_id),
        )
        instance = WorkflowInstance(
            company_id=company_id,
            definition_slug=definition_slug,
            current_state=definition.initial_state,
            status=WORKFLOW_STATUS_RUNNING,
            context=context or {},
            history=history,
        )
        return await self._instances.create(instance)

    async def get(self, instance_id: uuid.UUID) -> WorkflowInstance:
        instance = await self._instances.get(instance_id)
        if instance is None:
            raise WorkflowNotFoundError(f"Workflow instance {instance_id} not found.")
        return instance

    async def list(
        self, *, company_id: uuid.UUID, offset: int = 0, limit: int = 100
    ) -> list[WorkflowInstance]:
        return await self._instances.list_by_company(company_id, offset=offset, limit=limit)

    async def transition(
        self, *, instance_id: uuid.UUID, event: str, actor: str
    ) -> WorkflowInstance:
        instance = await self.get(instance_id)
        definition = get_definition(instance.definition_slug)
        if definition is None:
            raise UnknownWorkflowError(f"Unknown workflow '{instance.definition_slug}'.")

        from_state = instance.current_state
        # Raises InvalidTransitionError (409) if not allowed — read-decide-write.
        new_state = apply_transition(definition, from_state, event, instance.context)

        instance.current_state = new_state
        # Reassign (not in-place mutate) so SQLAlchemy flags the JSON dirty.
        new_history = list(instance.history)
        EventPublisher.record(
            new_history, event=event, from_state=from_state, to_state=new_state, actor=actor
        )
        instance.history = new_history
        if is_terminal(definition, new_state):
            instance.status = (
                WORKFLOW_STATUS_CANCELLED
                if new_state in _CANCELLED_STATES
                else WORKFLOW_STATUS_COMPLETED
            )
        await self._session.flush()
        await self._session.refresh(instance)
        return instance

    @staticmethod
    def to_read(instance: WorkflowInstance) -> WorkflowInstanceRead:
        definition = get_definition(instance.definition_slug)
        events = available_events(definition, instance.current_state) if definition else []
        terminal = is_terminal(definition, instance.current_state) if definition else True
        return WorkflowInstanceRead(
            id=instance.id,
            company_id=instance.company_id,
            definition_slug=instance.definition_slug,
            current_state=instance.current_state,
            status=instance.status,
            context=instance.context,
            history=instance.history,
            available_events=events,
            is_terminal=terminal,
            created_at=instance.created_at,
            updated_at=instance.updated_at,
        )
