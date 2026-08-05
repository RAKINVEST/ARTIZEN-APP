"""Conversation Engine — the multi-turn orchestration of a single message.

One turn: resolve the intent, record it, keep the collected slots, reason via the
owning engines, then either answer (read), summarize (context), or propose a
business action that awaits validation (write). It never executes a write here —
execution only happens on an explicit ``confirm``. Context is built every turn so
the Companion always has an up-to-date, engine-sourced picture.
"""

import logging
import uuid

from app.ai_companion.context import ContextBuilder
from app.ai_companion.dispatcher import ToolDispatcher
from app.ai_companion.intents import (
    INTENT_ENGINE,
    CompanionIntent,
    ResolvedIntent,
    resolve_intent,
)
from app.ai_companion.reasoning import ReasoningCoordinator
from app.ai_companion.response_builder import ResponseComposer
from app.ai_companion.schemas import ChatResponse, Explanation, SourceRef
from app.ai_companion.session import CompanionSession, SessionManager

logger = logging.getLogger(__name__)


def _resume(tool: str, message: str) -> ResolvedIntent:
    """Rebuild the write intent a pending action belongs to, so a follow-up turn
    keeps completing it instead of resolving to a fresh (and wrong) intent."""
    intent = CompanionIntent(tool)
    return ResolvedIntent(
        intent=intent, engine=INTENT_ENGINE[intent], is_write=True,
        verb="", target="", raw=message, confidence=0.9,
    )


class ConversationEngine:
    def __init__(
        self,
        *,
        reasoning: ReasoningCoordinator,
        dispatcher: ToolDispatcher,
        context_builder: ContextBuilder,
        session_manager: SessionManager,
    ) -> None:
        self._reasoning = reasoning
        self._dispatcher = dispatcher
        self._context = context_builder
        self._sessions = session_manager

    async def handle(
        self,
        *,
        company_id: uuid.UUID,
        session: CompanionSession,
        message: str,
        params: dict,
    ) -> ChatResponse:
        resolved = resolve_intent(message)
        # Slot-filling across turns: keep every non-empty provided parameter.
        session.slots.update({k: v for k, v in params.items() if v not in (None, "")})
        # Resume a write intent still awaiting parameters: a follow-up that carries
        # no new clear intent ("pour ce client", "oui") continues the pending
        # action rather than losing it — no context is dropped between turns. A
        # genuinely new intent instead interrupts and replaces it.
        if (
            resolved.intent == CompanionIntent.CLARIFY
            and session.pending_action is not None
            and session.pending_action.missing
        ):
            resolved = _resume(session.pending_action.tool, message)
        self._sessions.record_turn(
            session, role="user", text=message, intent=resolved.intent.value
        )

        context = await self._context.build(company_id=company_id, session=session)
        logger.info(
            "companion.turn company_id=%s intent=%s context=%s",
            company_id, resolved.intent.value, context.brief(),
        )

        if resolved.intent == CompanionIntent.SUMMARIZE:
            response = self._summarize(session.session_id, context)
        else:
            reasoning = self._reasoning.reason(resolved)
            proposed_action = None
            result = None
            if resolved.is_write:
                proposed_action = self._dispatcher.propose(resolved, session.slots)
                if resolved.intent == CompanionIntent.CREATE_QUOTE and proposed_action.ready:
                    preview = await self._dispatcher.preview_quote(session.slots)
                    if preview is not None:
                        result = {"preview": preview}
                # Kept in the session whether ready or not: a ready action awaits
                # confirmation, an incomplete one awaits its missing parameters
                # (and is resumed on the next turn). ``confirm`` refuses an
                # incomplete action, so storing it is safe.
                session.pending_action = proposed_action
            response = ResponseComposer.compose(
                session_id=session.session_id,
                resolved=resolved,
                reasoning=reasoning,
                proposed_action=proposed_action,
                result=result,
            )

        self._sessions.record_turn(
            session, role="assistant", text=response.message, intent=response.intent
        )
        await self._sessions.save(session)
        return response

    def _summarize(self, session_id: str, context) -> ChatResponse:
        missions = context.recent_missions
        plannings = context.recent_plannings
        parts = [
            f"{len(missions)} intervention(s) récente(s)",
            f"{len(plannings)} créneau(x) au planning",
        ]
        message = "Récapitulatif : " + ", ".join(parts) + "."
        if missions:
            message += " Dernières interventions : " + ", ".join(
                m["title"] for m in missions[:3]
            ) + "."
        if context.conversation_summary:
            message += f" Fil de la conversation : {context.conversation_summary[:200]}."
        return ChatResponse(
            session_id=session_id,
            intent=CompanionIntent.SUMMARIZE.value,
            message=message,
            explanation=Explanation(
                why="Synthèse construite à partir des moteurs Mission et Planning et de la conversation.",
                engine="companion",
                confidence=1.0,
            ),
            sources=[
                SourceRef(kind="mission", ref=m["id"], title=m["title"]) for m in missions[:3]
            ],
        )
