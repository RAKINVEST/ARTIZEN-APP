"""FastAPI dependencies for the decision module.

The Decision Engine depends **only** on the Knowledge Engine's public read-side
service (dependency inversion): no database session, no catalog/quote
repository, no direct corpus access.
"""

from typing import Annotated

from fastapi import Depends

from app.decision.service import DecisionService
from app.knowledge.deps import KnowledgeServiceDep


def get_decision_service(knowledge: KnowledgeServiceDep) -> DecisionService:
    return DecisionService(knowledge=knowledge)


DecisionServiceDep = Annotated[DecisionService, Depends(get_decision_service)]
