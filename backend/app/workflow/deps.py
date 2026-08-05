"""FastAPI dependencies for the workflow module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.workflow.repository import WorkflowInstanceRepository
from app.workflow.service import WorkflowService


def get_workflow_service(session: SessionDep) -> WorkflowService:
    return WorkflowService(session, WorkflowInstanceRepository(session))


WorkflowServiceDep = Annotated[WorkflowService, Depends(get_workflow_service)]
