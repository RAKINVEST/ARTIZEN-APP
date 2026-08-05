"""FastAPI dependencies for the planning module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.planning.repository import PlanningEntryRepository
from app.planning.service import PlanningService


def get_planning_service(session: SessionDep) -> PlanningService:
    return PlanningService(session, PlanningEntryRepository(session))


PlanningServiceDep = Annotated[PlanningService, Depends(get_planning_service)]
