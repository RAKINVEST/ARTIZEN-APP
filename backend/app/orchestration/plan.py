"""Execution plan — the ordered steps a validated decision decomposes into.

Pure, DB-free. A step names *which owning engine* does *what*; the coordinator
executes it through that engine's public service, never its repository/DB. The
intervention plan coordinates Mission, Workflow, Planning and Notification.
"""

from dataclasses import dataclass, field

from app.orchestration.exceptions import OrchestrationError


@dataclass(frozen=True)
class ExecutionStep:
    id: str
    engine: str  # "mission" | "workflow" | "planning" | "notification"
    action: str
    retryable: bool = True
    params: dict = field(default_factory=dict)


@dataclass(frozen=True)
class ExecutionPlan:
    kind: str
    steps: tuple[ExecutionStep, ...]


def _intervention_plan() -> ExecutionPlan:
    # Coordinate Mission + Workflow + Planning + Notification: create the mission,
    # start its workflow, associate the two, schedule it (when the decision
    # carries a slot), then notify the customer. Scheduling is transactional (a
    # conflict rolls the intervention back); the notification is best-effort — a
    # comms failure never undoes a real mission. Every step is idempotent-guarded.
    return ExecutionPlan(
        kind="intervention",
        steps=(
            ExecutionStep(id="create_mission", engine="mission", action="create_mission"),
            ExecutionStep(id="start_workflow", engine="workflow", action="start_workflow"),
            ExecutionStep(
                id="associate_workflow", engine="mission", action="associate_workflow"
            ),
            ExecutionStep(id="schedule_mission", engine="planning", action="schedule_mission"),
            ExecutionStep(
                id="notify_customer", engine="notification", action="notify_customer"
            ),
        ),
    )


_PLANS = {"intervention": _intervention_plan}


def build_plan(kind: str) -> ExecutionPlan:
    builder = _PLANS.get(kind)
    if builder is None:
        raise OrchestrationError(f"Unknown orchestration plan '{kind}'.")
    return builder()


def available_plans() -> list[str]:
    return list(_PLANS)
