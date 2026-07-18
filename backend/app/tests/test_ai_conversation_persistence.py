"""Tests for AI-conversation persistence (V3.3 persistence lot).

End-to-end: drive the real ``VoiceOrchestrator`` with a ``PersistingEventSink``
bound to a real session, then read the ``ai_*`` rows back. Proves persistence is
100% event-driven (the engine is untouched), that ``engine_version`` and unique
``decision_id``s land, and that a revision replaces decisions rather than
duplicating them.
"""

import uuid

import pytest

from app.ai.factory import get_stt_provider
from app.ai_conversations.repository import AiConversationRepository
from app.ai_conversations.sink import PersistingEventSink
from app.branding.models import Company
from app.database.session import AsyncSessionLocal
from app.tests.test_voice_orchestrator import (
    FailingExtractor,
    FakeExtractor,
    FakeMatcher,
    _match_fields,
    make_service,
)
from app.voice_quote import ENGINE_VERSION
from app.voice_quote.orchestrator import VoiceOrchestrator

_AUDIO = b"fake-audio"


@pytest.fixture
async def company_id() -> uuid.UUID:
    """A real company row — ai_conversations.company_id is a FK to it."""
    async with AsyncSessionLocal() as session:
        company = Company(name="Persistence Test Co")
        session.add(company)
        await session.commit()
        return company.id


def _orchestrator(company_id, session, *, extractor, matcher) -> VoiceOrchestrator:
    return VoiceOrchestrator(
        company_id=company_id,
        stt=get_stt_provider(),
        extractor=extractor,
        matcher=matcher,
        event_sink=PersistingEventSink(session),
    )


async def test_full_conversation_is_persisted(company_id) -> None:
    async with AsyncSessionLocal() as session:
        orch = _orchestrator(
            company_id,
            session,
            extractor=FakeExtractor([make_service()]),
            matcher=FakeMatcher(lambda s: _match_fields()),
        )
        await orch.start()
        await orch.submit_audio(_AUDIO)
        await orch.confirm()
        await orch.mark_created("DEV-2026-0007")
        cid = orch.snapshot().conversation_id

    async with AsyncSessionLocal() as q:
        repo = AiConversationRepository(q)
        conv = await repo.get_conversation(cid)
        assert conv is not None
        assert conv.state == "created"
        assert conv.engine_version == ENGINE_VERSION
        assert conv.draft_line_count == 1
        assert conv.overall_confidence is not None and conv.overall_confidence > 0
        assert conv.quote_reference == "DEV-2026-0007"
        # Per-step timings were captured for latency analytics.
        assert set(conv.timings) >= {"stt", "extract", "match"}
        assert conv.total_duration_ms is not None

        turns = await repo.list_turns(cid)
        assert any(t.role == "user" for t in turns)  # the transcript turn

        decisions = await repo.list_decisions(cid)
        assert len(decisions) == 1
        assert decisions[0].decision == "include"


async def test_engine_version_and_unique_decision_ids(company_id) -> None:
    # One include, one clarify, one omit -> three decisions, three distinct ids.
    services = [
        make_service(description="include", stt=0.98, nlu=0.98),
        make_service(description="review", stt=0.90, nlu=0.90),
        make_service(description="omit", stt=0.90, nlu=0.70),
    ]

    def rule(service):
        by_desc = {"include": 0.98, "review": 0.85, "omit": 0.60}
        return _match_fields(designation=service.description, confidence=by_desc[service.description])

    async with AsyncSessionLocal() as session:
        orch = _orchestrator(
            company_id, session, extractor=FakeExtractor(services), matcher=FakeMatcher(rule)
        )
        await orch.start()
        snap = await orch.submit_audio(_AUDIO)
        cid = snap.conversation_id
        expected_ids = {line.decision_id for line in snap.draft_lines} | {
            item.decision_id for item in snap.unresolved
        }

    async with AsyncSessionLocal() as q:
        decisions = await AiConversationRepository(q).list_decisions(cid)
        persisted_ids = {d.id for d in decisions}
        assert len(persisted_ids) == len(decisions)  # all unique
        assert persisted_ids == expected_ids  # exactly the engine's decision_ids
        outcomes = {d.decision for d in decisions}
        assert outcomes == {"include", "clarify", "omit"}
        # The omitted decision carries no catalog item, the kept ones do.
        omit = next(d for d in decisions if d.decision == "omit")
        assert omit.catalog_item_id is None


async def test_clarification_turns_and_question_count_are_persisted(company_id) -> None:
    async with AsyncSessionLocal() as session:
        orch = _orchestrator(
            company_id,
            session,
            extractor=FakeExtractor([make_service(unit_type=None)]),
            matcher=FakeMatcher(lambda s: _match_fields()),
        )
        await orch.start()
        await orch.submit_audio(_AUDIO)
        await orch.provide_answer("mono-split")
        cid = orch.snapshot().conversation_id

    async with AsyncSessionLocal() as q:
        repo = AiConversationRepository(q)
        conv = await repo.get_conversation(cid)
        assert conv.questions_asked == 1
        turns = await repo.list_turns(cid)
        assert "assistant" in [t.role for t in turns]  # the question
        seqs = [t.seq for t in turns]
        assert seqs == sorted(seqs) and len(set(seqs)) == len(seqs)  # ordered, unique
        assert any(t.content == "mono-split" for t in turns)  # the answer turn


async def test_failure_is_persisted(company_id) -> None:
    async with AsyncSessionLocal() as session:
        from app.ai.exceptions import AIProviderUnavailableError

        orch = _orchestrator(
            company_id,
            session,
            extractor=FailingExtractor(AIProviderUnavailableError("down")),
            matcher=FakeMatcher(lambda s: _match_fields()),
        )
        await orch.start()
        await orch.submit_audio(_AUDIO)
        cid = orch.snapshot().conversation_id

    async with AsyncSessionLocal() as q:
        conv = await AiConversationRepository(q).get_conversation(cid)
        assert conv.state == "failed"
        assert conv.error_code == "provider_unavailable"


async def test_revision_replaces_decisions_not_duplicates(company_id) -> None:
    async with AsyncSessionLocal() as session:
        orch = _orchestrator(
            company_id,
            session,
            extractor=FakeExtractor(
                [make_service(description="clim salon")], [make_service(description="clim chambre")]
            ),
            matcher=FakeMatcher(lambda s: _match_fields(designation=s.description)),
        )
        await orch.start()
        await orch.submit_audio(_AUDIO)
        await orch.revise_by_voice(_AUDIO)
        cid = orch.snapshot().conversation_id

    async with AsyncSessionLocal() as q:
        repo = AiConversationRepository(q)
        conv = await repo.get_conversation(cid)
        decisions = await repo.list_decisions(cid)
        # Replaced with the current 2-line draft, not 1 + 2 accumulated.
        assert conv.draft_line_count == 2
        assert len(decisions) == 2
