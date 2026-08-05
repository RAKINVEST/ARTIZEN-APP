"""Step handlers & compensators — the only place orchestration touches other
engines, and it does so through their **public services**, never their
repositories/DB. Compensations use legitimate engine operations (cancel a
mission/workflow), never a hard delete (Loi 5).
"""

import uuid

from app.mission.schemas import MissionCreate
from app.mission.service import MissionService
from app.notification.exceptions import NotificationError
from app.notification.service import NotificationService
from app.orchestration.exceptions import StepExecutionError
from app.orchestration.plan import ExecutionStep
from app.planning.exceptions import PlanningConflictError
from app.planning.schemas import PlanningCreate
from app.planning.service import PlanningService
from app.workflow.service import WorkflowService


class EngineExecutors:
    def __init__(
        self, missions: MissionService, workflows: WorkflowService,
        planning: PlanningService, notifications: NotificationService, *,
        company_id: uuid.UUID, actor: str,
    ) -> None:
        self._missions = missions
        self._workflows = workflows
        self._planning = planning
        self._notifications = notifications
        self._company_id = company_id
        self._actor = actor

    async def execute(self, step: ExecutionStep, context: dict, results: dict) -> dict:
        if step.action == "create_mission":
            customer_id = context.get("customer_id")
            if not customer_id:
                raise StepExecutionError("customer_id manquant dans le contexte.", retryable=False)
            site_id = context.get("site_id")
            mission = await self._missions.create(
                company_id=self._company_id,
                data=MissionCreate(
                    customer_id=uuid.UUID(str(customer_id)),
                    site_id=uuid.UUID(str(site_id)) if site_id else None,
                    title=context.get("title", "Intervention"),
                ),
            )
            return {"mission_id": str(mission.id)}

        if step.action == "start_workflow":
            instance = await self._workflows.start(
                company_id=self._company_id,
                definition_slug=context.get("workflow_slug", "intervention"),
                context=context,
            )
            return {"workflow_id": str(instance.id)}

        if step.action == "associate_workflow":
            mission_id = uuid.UUID(results["create_mission"]["mission_id"])
            workflow_id = uuid.UUID(results["start_workflow"]["workflow_id"])
            await self._missions.associate_workflow(
                mission_id=mission_id, workflow_instance_id=workflow_id,
                company_id=self._company_id, actor=self._actor,
            )
            return {"associated": True}

        if step.action == "schedule_mission":
            # Only schedules when the decision carried a slot; otherwise a
            # graceful no-op (not every intervention is scheduled up front).
            start_at = context.get("start_at")
            duration = context.get("duration_minutes")
            if not start_at or not duration:
                return {"scheduled": False, "reason": "no_schedule_requested"}
            mission_id = uuid.UUID(results["create_mission"]["mission_id"])
            try:
                entry = await self._planning.create(
                    company_id=self._company_id,
                    actor=self._actor,
                    data=PlanningCreate(
                        mission_id=mission_id,
                        start_at=start_at,  # Pydantic coerces an ISO 8601 string
                        duration_minutes=int(duration),
                        artisan=context.get("artisan", ""),
                    ),
                )
            except PlanningConflictError as error:
                # A schedule conflict is a real, non-transient failure: fail the
                # step so the saga rolls the whole intervention back.
                raise StepExecutionError(str(error), retryable=False) from error
            return {"scheduled": True, "planning_entry_id": str(entry.id)}

        if step.action == "notify_customer":
            # Best-effort: a comms failure never fails the orchestration — the
            # Notification Engine records a failed send rather than raising.
            recipient = context.get("recipient")
            if not recipient:
                return {"notified": False, "reason": "no_recipient"}
            mission_id = results.get("create_mission", {}).get("mission_id", "")
            try:
                notification = await self._notifications.notify(
                    company_id=self._company_id,
                    actor=self._actor,
                    channel=context.get("channel", "email"),
                    recipient=recipient,
                    template_key="mission_scheduled",
                    context={
                        "title": context.get("title", "Intervention"),
                        "date": context.get("start_at", ""),
                    },
                    related_type="mission",
                    related_id=mission_id,
                )
            except NotificationError as error:
                return {"notified": False, "reason": str(error)}
            return {
                "notified": True,
                "notification_id": str(notification.id),
                "status": notification.status,
            }

        raise StepExecutionError(f"Unknown action '{step.action}'.", retryable=False)

    async def compensate(self, step: ExecutionStep, context: dict, results: dict) -> None:
        if step.action == "create_mission" and "create_mission" in results:
            mission_id = uuid.UUID(results["create_mission"]["mission_id"])
            await self._missions.change_status(
                mission_id=mission_id, target="annulee", actor=self._actor
            )
        elif step.action == "start_workflow" and "start_workflow" in results:
            workflow_id = uuid.UUID(results["start_workflow"]["workflow_id"])
            await self._workflows.transition(
                instance_id=workflow_id, event="annuler", actor=self._actor
            )
        elif step.action == "schedule_mission" and results.get("schedule_mission", {}).get(
            "planning_entry_id"
        ):
            entry_id = uuid.UUID(results["schedule_mission"]["planning_entry_id"])
            await self._planning.cancel(entry_id=entry_id, actor=self._actor)  # Loi 5
        # associate_workflow: association is idempotent metadata — nothing to undo.
        # notify_customer: a sent notification cannot be unsent — nothing to undo.
