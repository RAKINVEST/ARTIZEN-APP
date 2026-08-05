"""AI Companion service — the single public entry point for the conversation.

Owns no business data. It assembles per-request the session manager, the tool
dispatcher and the conversation engine (each needs the caller's tenant/actor),
runs one turn, and — on an explicit ``confirm`` — executes the pending action
through the owning engine's public service. Everything it returns is explainable
and tenant-scoped.
"""

import logging
import uuid

from app.ai.base import AIProvider
from app.ai_companion.context import ContextBuilder
from app.ai_companion.conversation import ConversationEngine
from app.ai_companion.dispatcher import ToolDispatcher
from app.ai_companion.exceptions import ActionNotReadyError, NoPendingActionError
from app.ai_companion.memory import MemoryStore
from app.ai_companion.reasoning import ReasoningCoordinator
from app.ai_companion.response_builder import ResponseComposer
from app.ai_companion.schemas import ChatResponse, Explanation, SessionRead
from app.ai_companion.session import SessionManager
from app.decision.service import DecisionService
from app.knowledge.service import KnowledgeService
from app.mission.service import MissionService
from app.notification.service import NotificationService
from app.orchestration.service import OrchestrationService
from app.planning.service import PlanningService
from app.quotes.service import QuoteService

logger = logging.getLogger(__name__)


class CompanionService:
    def __init__(
        self,
        *,
        store: MemoryStore,
        ttl: int,
        max_turns: int,
        ai: AIProvider,
        decision: DecisionService,
        knowledge: KnowledgeService,
        missions: MissionService,
        planning: PlanningService,
        notification: NotificationService,
        quotes: QuoteService,
        orchestration: OrchestrationService,
    ) -> None:
        self._store = store
        self._ttl = ttl
        self._max_turns = max_turns
        # Wired for future LLM phrasing behind the same contract; V1 composes
        # responses deterministically (offline, testable) — see prompts.py.
        self._ai = ai
        self._decision = decision
        self._knowledge = knowledge
        self._missions = missions
        self._planning = planning
        self._notification = notification
        self._quotes = quotes
        self._orchestration = orchestration

    # --- per-request assembly (each needs the caller's tenant/actor) ---

    def _session_manager(self, company_id: uuid.UUID) -> SessionManager:
        return SessionManager(
            self._store, company_id=company_id, ttl=self._ttl, max_turns=self._max_turns
        )

    def _dispatcher(self, company_id: uuid.UUID, actor: str) -> ToolDispatcher:
        return ToolDispatcher(
            orchestration=self._orchestration, planning=self._planning,
            notification=self._notification, quotes=self._quotes,
            company_id=company_id, actor=actor,
        )

    def _engine(self, company_id: uuid.UUID, actor: str, sessions: SessionManager) -> ConversationEngine:
        return ConversationEngine(
            reasoning=ReasoningCoordinator(decision=self._decision, knowledge=self._knowledge),
            dispatcher=self._dispatcher(company_id, actor),
            context_builder=ContextBuilder(missions=self._missions, planning=self._planning),
            session_manager=sessions,
        )

    # --- public API ---

    async def chat(
        self, *, company_id: uuid.UUID, actor: str, message: str,
        session_id: str | None = None, params: dict | None = None,
    ) -> ChatResponse:
        sessions = self._session_manager(company_id)
        session = (
            await sessions.load(session_id, required=False)
            if session_id else sessions.new_session()
        )
        engine = self._engine(company_id, actor, sessions)
        return await engine.handle(
            company_id=company_id, session=session, message=message, params=params or {}
        )

    async def continue_conversation(
        self, *, company_id: uuid.UUID, actor: str, session_id: str, message: str,
        params: dict | None = None,
    ) -> ChatResponse:
        sessions = self._session_manager(company_id)
        session = await sessions.load(session_id, required=True)  # 404 if unknown/expired
        engine = self._engine(company_id, actor, sessions)
        return await engine.handle(
            company_id=company_id, session=session, message=message, params=params or {}
        )

    async def confirm(self, *, company_id: uuid.UUID, actor: str, session_id: str) -> ChatResponse:
        sessions = self._session_manager(company_id)
        session = await sessions.load(session_id, required=True)
        action = session.pending_action
        if action is None:
            raise NoPendingActionError("Aucune action en attente de validation.")
        if action.missing:
            # Never execute with missing parameters (would be a guess).
            raise ActionNotReadyError(
                f"Action incomplète — il manque : {', '.join(action.missing)}."
            )
        executed, result = await self._dispatcher(company_id, actor).execute(action)
        response = ResponseComposer.after_execution(
            session_id=session_id, action=action, executed=executed, result=result
        )
        session.pending_action = None
        sessions.record_turn(session, role="assistant", text=response.message, intent=action.tool)
        await sessions.save(session)
        logger.info(
            "companion.confirm company_id=%s tool=%s executed=%s", company_id, action.tool, executed
        )
        return response

    async def cancel(self, *, company_id: uuid.UUID, session_id: str) -> ChatResponse:
        sessions = self._session_manager(company_id)
        session = await sessions.load(session_id, required=True)
        action = session.pending_action
        if action is None:
            raise NoPendingActionError("Aucune action en attente d'annulation.")
        session.pending_action = None
        message = "C'est annulé — rien n'a été fait."
        sessions.record_turn(session, role="assistant", text=message, intent=action.tool)
        await sessions.save(session)
        return ChatResponse(
            session_id=session_id,
            intent=action.tool,
            message=message,
            explanation=Explanation(
                why="Action annulée à votre demande, avant toute exécution.",
                engine="companion", confidence=1.0,
            ),
        )

    async def get_session(self, *, company_id: uuid.UUID, session_id: str) -> SessionRead:
        session = await self._session_manager(company_id).load(session_id, required=True)
        return SessionRead(
            session_id=session.session_id,
            company_id=company_id,
            turns=session.turns,
            pending_action=session.pending_action,
            summary=session.summary,
        )

    async def delete_session(self, *, company_id: uuid.UUID, session_id: str) -> None:
        await self._session_manager(company_id).delete(session_id)
