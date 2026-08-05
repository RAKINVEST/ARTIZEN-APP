"""FastAPI dependencies for the AI Companion.

Reuses every owning engine's **public service** (Decision, Knowledge, Mission,
Planning, Notification, Quote, Orchestration) — never their repositories — and
the shared AI provider abstraction. Conversational memory lives in Redis
(``RedisMemoryStore``), which degrades gracefully when Redis is unreachable.
"""

from typing import Annotated

from fastapi import Depends

from app.ai.deps import AIProviderDep
from app.ai_companion.memory import RedisMemoryStore
from app.ai_companion.service import CompanionService
from app.core.config import settings
from app.decision.deps import DecisionServiceDep
from app.knowledge.deps import KnowledgeServiceDep
from app.mission.deps import MissionServiceDep
from app.notification.deps import NotificationServiceDep
from app.orchestration.deps import OrchestrationServiceDep
from app.planning.deps import PlanningServiceDep
from app.quotes.deps import QuoteServiceDep
from app.redis_client import get_redis


def get_companion_service(
    ai: AIProviderDep,
    decision: DecisionServiceDep,
    knowledge: KnowledgeServiceDep,
    missions: MissionServiceDep,
    planning: PlanningServiceDep,
    notification: NotificationServiceDep,
    quotes: QuoteServiceDep,
    orchestration: OrchestrationServiceDep,
) -> CompanionService:
    return CompanionService(
        store=RedisMemoryStore(get_redis()),
        ttl=settings.COMPANION_SESSION_TTL_SECONDS,
        max_turns=settings.COMPANION_MAX_TURNS,
        ai=ai,
        decision=decision,
        knowledge=knowledge,
        missions=missions,
        planning=planning,
        notification=notification,
        quotes=quotes,
        orchestration=orchestration,
    )


CompanionServiceDep = Annotated[CompanionService, Depends(get_companion_service)]
