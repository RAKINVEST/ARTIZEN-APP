"""FastAPI dependencies for the knowledge module.

No database session: the Knowledge Engine is filesystem-backed and read-only
(the corpus is cached in ``source.py``).
"""

from typing import Annotated

from fastapi import Depends

from app.knowledge.service import KnowledgeService
from app.knowledge.source import get_items


def get_knowledge_service() -> KnowledgeService:
    return KnowledgeService(get_items())


KnowledgeServiceDep = Annotated[KnowledgeService, Depends(get_knowledge_service)]
