"""FastAPI dependencies for the clients module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.clients.service import ClientService


def get_client_service(session: SessionDep) -> ClientService:
    return ClientService(session)


ClientServiceDep = Annotated[ClientService, Depends(get_client_service)]
