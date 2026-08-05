"""FastAPI dependencies for the mission module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.clients.repository import ClientRepository
from app.mission.repository import MissionRepository
from app.mission.service import MissionService
from app.sites.repository import SiteRepository
from app.workflow.repository import WorkflowInstanceRepository


def get_mission_service(session: SessionDep) -> MissionService:
    return MissionService(
        session,
        MissionRepository(session),
        ClientRepository(session),
        SiteRepository(session),
        WorkflowInstanceRepository(session),
    )


MissionServiceDep = Annotated[MissionService, Depends(get_mission_service)]
