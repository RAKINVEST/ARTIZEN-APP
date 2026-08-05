"""FastAPI dependencies for the orchestration module.

Reuses the owning engines' **public service** constructors (Mission, Workflow,
Planning, Notification) — never their repositories directly — keeping the
coordination on public interfaces and avoiding any duplication.
"""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.mission.deps import get_mission_service
from app.notification.deps import get_notification_service
from app.orchestration.repository import OrchestrationInstanceRepository
from app.orchestration.service import OrchestrationService
from app.planning.deps import get_planning_service
from app.workflow.deps import get_workflow_service


def get_orchestration_service(session: SessionDep) -> OrchestrationService:
    return OrchestrationService(
        session,
        get_mission_service(session),
        get_workflow_service(session),
        get_planning_service(session),
        get_notification_service(session),
        OrchestrationInstanceRepository(session),
    )


OrchestrationServiceDep = Annotated[OrchestrationService, Depends(get_orchestration_service)]
