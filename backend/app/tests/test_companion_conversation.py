"""Pure multi-turn tests for the Companion Conversation Engine (no DB).

Drives the real ``ConversationEngine`` (real dispatcher.propose, real session
manager over ``InMemoryStore``) with tiny leaf fakes for reasoning and the
read-only services. Pins the hardest behaviours: slot-filling across turns,
resuming a pending action, interruption by a new intent, and summarize. Run with
``pytest --noconftest``.
"""

import asyncio
import uuid

from app.ai_companion.context import ContextBuilder
from app.ai_companion.conversation import ConversationEngine
from app.ai_companion.dispatcher import ToolDispatcher
from app.ai_companion.intents import CompanionIntent
from app.ai_companion.memory import InMemoryStore
from app.ai_companion.reasoning import ReasoningResult
from app.ai_companion.session import SessionManager

_COMPANY = uuid.uuid4()


class _FakeReasoning:
    def reason(self, resolved) -> ReasoningResult:
        return ReasoningResult(engine="knowledge")


class _FakeList:
    async def list(self, *, company_id, limit=5, **kwargs):
        return []


class _FakeCalc:
    def model_dump(self, mode="json"):
        return {"total_ttc": "240.00"}


class _FakeQuotes:
    async def calculate(self, data):
        return _FakeCalc()


def _build(store: InMemoryStore) -> tuple[SessionManager, ConversationEngine]:
    sessions = SessionManager(store, company_id=_COMPANY, ttl=3600, max_turns=8)
    engine = ConversationEngine(
        reasoning=_FakeReasoning(),
        dispatcher=ToolDispatcher(
            orchestration=None, planning=None, notification=None, quotes=_FakeQuotes(),
            company_id=_COMPANY, actor="tester",
        ),
        context_builder=ContextBuilder(missions=_FakeList(), planning=_FakeList()),
        session_manager=sessions,
    )
    return sessions, engine


async def _turn(sessions, engine, message, *, session_id=None, params=None):
    session = (
        await sessions.load(session_id, required=False) if session_id
        else sessions.new_session()
    )
    return await engine.handle(
        company_id=_COMPANY, session=session, message=message, params=params or {}
    )


def test_read_intent_yields_no_action():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        r = await _turn(sessions, engine, "comment remplacer un chauffe-eau ?")
        assert r.intent == CompanionIntent.SEARCH_KNOWLEDGE.value
        assert r.proposed_action is None
        assert r.needs_confirmation is False

    asyncio.run(scenario())


def test_write_missing_then_resumes_across_turns():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        first = await _turn(sessions, engine, "planifie une intervention")
        assert first.intent == CompanionIntent.PLAN_INTERVENTION.value
        assert first.proposed_action.missing == ["customer_id"]
        assert first.needs_confirmation is False

        # A follow-up with no new intent + the missing slot RESUMES the action.
        second = await _turn(
            sessions, engine, "pour ce client",
            session_id=first.session_id, params={"customer_id": str(uuid.uuid4())},
        )
        assert second.intent == CompanionIntent.PLAN_INTERVENTION.value  # not clarify
        assert second.proposed_action.ready is True
        assert second.needs_confirmation is True

    asyncio.run(scenario())


def test_new_intent_interrupts_pending_action():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        first = await _turn(sessions, engine, "planifie une intervention")  # incomplete
        second = await _turn(
            sessions, engine, "prépare un devis",
            session_id=first.session_id,
            params={"client_id": str(uuid.uuid4()),
                    "lines": [{"catalog_item_id": str(uuid.uuid4()), "quantity": "1"}]},
        )
        # The new, clear intent takes over instead of resuming the plan.
        assert second.intent == CompanionIntent.CREATE_QUOTE.value
        assert second.proposed_action.tool == "create_quote"

    asyncio.run(scenario())


def test_create_quote_previews_without_persisting():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        r = await _turn(
            sessions, engine, "prépare un devis",
            params={"client_id": str(uuid.uuid4()),
                    "lines": [{"catalog_item_id": str(uuid.uuid4()), "quantity": "2"}]},
        )
        assert r.proposed_action.ready is True
        assert r.result is not None and "preview" in r.result  # read-only preview
        assert r.needs_confirmation is True

    asyncio.run(scenario())


def test_summarize_uses_context():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        r = await _turn(sessions, engine, "résume la situation")
        assert r.intent == CompanionIntent.SUMMARIZE.value
        assert "Récapitulatif" in r.message

    asyncio.run(scenario())


def test_turns_are_persisted_across_the_conversation():
    async def scenario():
        sessions, engine = _build(InMemoryStore())
        first = await _turn(sessions, engine, "bonjour")
        await _turn(sessions, engine, "comment purger un radiateur", session_id=first.session_id)
        reloaded = await sessions.load(first.session_id)
        # user+assistant per turn, two turns → four recorded.
        assert len(reloaded.turns) == 4

    asyncio.run(scenario())
