"""Orchestration business logic — coordinates the engines, owns only its state.

Builds the plan from a validated-decision context, runs the saga (retry +
compensation) through the owning engines' public services, and persists the
correlation id, plan, saga timeline, results and final status. It never writes
another engine's data directly. No amount is computed (ADR-023).
"""

import logging
import uuid
from datetime import datetime, timezone

from sqlalchemy.ext.asyncio import AsyncSession

from app.mission.service import MissionService
from app.notification.service import NotificationService
from app.orchestration.exceptions import OrchestrationNotFoundError
from app.orchestration.executors import EngineExecutors
from app.orchestration.models import OrchestrationInstance
from app.orchestration.plan import build_plan
from app.orchestration.repository import OrchestrationInstanceRepository
from app.orchestration.saga import SagaCoordinator, SagaResult
from app.orchestration.schemas import OrchestrationRead
from app.planning.service import PlanningService
from app.workflow.service import WorkflowService

logger = logging.getLogger(__name__)

_TERMINAL = frozenset({"reussi", "partiellement_reussi", "echec", "annule"})


def _now() -> str:
    return datetime.now(timezone.utc).isoformat()


def _stamp(events: list[dict]) -> list[dict]:
    return [{**event, "at": _now()} for event in events]


class OrchestrationService:
    def __init__(
        self,
        session: AsyncSession,
        missions: MissionService,
        workflows: WorkflowService,
        planning: PlanningService,
        notifications: NotificationService,
        instances: OrchestrationInstanceRepository,
    ) -> None:
        self._session = session
        self._missions = missions
        self._workflows = workflows
        self._planning = planning
        self._notifications = notifications
        self._instances = instances

    async def start(
        self, *, company_id: uuid.UUID, actor: str, plan_kind: str, context: dict
    ) -> OrchestrationInstance:
        plan = build_plan(plan_kind)  # OrchestrationError (400) if unknown
        result = await self._run(plan_kind, company_id, actor, context)
        instance = OrchestrationInstance(
            company_id=company_id,
            correlation_id=uuid.uuid4().hex,
            plan_kind=plan_kind,
            status=result.status,
            context=context,
            plan=[{"id": s.id, "engine": s.engine, "action": s.action} for s in plan.steps],
            timeline=_stamp(result.events),
            results=result.results,
        )
        logger.info(
            "orchestration.completed company_id=%s kind=%s status=%s",
            company_id, plan_kind, result.status,
        )
        return await self._instances.create(instance)

    async def get(self, instance_id: uuid.UUID) -> OrchestrationInstance:
        instance = await self._instances.get(instance_id)
        if instance is None:
            raise OrchestrationNotFoundError(f"Orchestration {instance_id} not found.")
        return instance

    async def list(
        self, *, company_id: uuid.UUID, offset: int = 0, limit: int = 100
    ) -> list[OrchestrationInstance]:
        return await self._instances.list_by_company(company_id, offset=offset, limit=limit)

    async def retry(
        self, *, instance_id: uuid.UUID, company_id: uuid.UUID, actor: str
    ) -> OrchestrationInstance:
        instance = await self.get(instance_id)
        plan = build_plan(instance.plan_kind)
        result = await self._run(instance.plan_kind, company_id, actor, instance.context)
        instance.timeline = [
            *instance.timeline,
            {"type": "retry_run", "step": "", "at": _now()},
            *_stamp(result.events),
        ]
        instance.status = result.status
        instance.results = result.results
        # Keep the (possibly re-derived) plan for observability.
        instance.plan = [{"id": s.id, "engine": s.engine, "action": s.action} for s in plan.steps]
        await self._session.flush()
        await self._session.refresh(instance)
        return instance

    async def _run(
        self, plan_kind: str, company_id: uuid.UUID, actor: str, context: dict
    ) -> SagaResult:
        plan = build_plan(plan_kind)
        executors = EngineExecutors(
            self._missions, self._workflows, self._planning, self._notifications,
            company_id=company_id, actor=actor,
        )
        return await SagaCoordinator().run(
            plan, executors.execute, executors.compensate, context=context
        )

    @staticmethod
    def to_read(instance: OrchestrationInstance) -> OrchestrationRead:
        return OrchestrationRead(
            id=instance.id,
            company_id=instance.company_id,
            correlation_id=instance.correlation_id,
            plan_kind=instance.plan_kind,
            status=instance.status,
            is_terminal=instance.status in _TERMINAL,
            context=instance.context,
            plan=instance.plan,
            timeline=instance.timeline,
            results=instance.results,
            created_at=instance.created_at,
            updated_at=instance.updated_at,
        )
