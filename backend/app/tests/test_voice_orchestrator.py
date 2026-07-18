"""Tests for the Voice Orchestrator (V3.3 L4).

Every step is exercised with a deterministic fake injected through its port —
no database, no real LLM, no network. The L1 mock STT/TTS are used directly.
Coverage: nominal flow, mandatory-slot clarification (adjustment #2), the three
confidence bands, unmatched prestations, centralized failure handling + retry,
illegal transitions, the normalized event stream, per-step metrics,
conversational revision (adjustment #4), and the no-business-database boundary.
"""

import ast
import pathlib
import uuid

import pytest

from app.ai.exceptions import AIProviderUnavailableError
from app.ai.factory import get_stt_provider, get_tts_provider
from app.voice_quote import orchestrator as orchestrator_module
from app.voice_quote.errors import classify
from app.voice_quote.events import CollectingEventSink, EventType
from app.voice_quote.orchestrator import VoiceOrchestrator
from app.voice_quote.schemas import ExtractionResult, MatchedService, ServiceRequest
from app.voice_quote.states import (
    VOICE_TRANSITIONS,
    ConversationState,
    InvalidTransition,
    can_transition,
)

_AUDIO = b"fake-audio"


# --- deterministic fakes for the injected ports ------------------------------


def make_service(
    *,
    description: str = "installation climatiseur",
    stt: float = 0.95,
    nlu: float = 0.96,
    unit_type: str | None = "mono-split",
    outdoor_unit: str | None = "oui",
) -> ServiceRequest:
    attributes: dict[str, str] = {}
    if unit_type is not None:
        attributes["unit_type"] = unit_type
    if outdoor_unit is not None:
        attributes["outdoor_unit"] = outdoor_unit
    return ServiceRequest(
        service_type="ac_install",
        description=description,
        stt_confidence=stt,
        nlu_confidence=nlu,
        raw_span=description,
        attributes=attributes,
    )


class FakeExtractor:
    """Returns a preset batch of prestations per call (a queue lets a revision
    turn return different prestations from the first turn)."""

    def __init__(self, *batches: list[ServiceRequest]) -> None:
        self._batches = list(batches) or [[]]

    async def extract(self, transcription, *, language: str = "fr") -> ExtractionResult:
        batch = self._batches.pop(0) if len(self._batches) > 1 else self._batches[0]
        return ExtractionResult(services=list(batch), language=language)


class FakeMatcher:
    """Applies a rule ``service -> match fields | None`` to each prestation, in
    order, so ``source_index`` reflects the real position in the list passed."""

    def __init__(self, rule) -> None:
        self._rule = rule

    async def match(self, services, *, company_id):
        matched = []
        for index, service in enumerate(services):
            fields = self._rule(service)
            if fields is not None:
                matched.append(MatchedService(source_index=index, **fields))
        return matched


class FailingExtractor:
    def __init__(self, exc: Exception) -> None:
        self._exc = exc

    async def extract(self, transcription, *, language: str = "fr") -> ExtractionResult:
        raise self._exc


def _match_fields(designation="Climatiseur mono-split 3.5kW", qty="1", confidence=0.98):
    from decimal import Decimal

    return {
        "catalog_item_id": uuid.uuid4(),
        "designation": designation,
        "quantity": Decimal(qty),
        "match_confidence": confidence,
        "reason": "correspondance",
    }


def build_orchestrator(*, extractor, matcher, tts=None, sink=None) -> VoiceOrchestrator:
    return VoiceOrchestrator(
        company_id=uuid.uuid4(),
        client_id=uuid.uuid4(),
        stt=get_stt_provider(),
        extractor=extractor,
        matcher=matcher,
        tts=tts,
        event_sink=sink,
    )


# --- state machine (pure) ----------------------------------------------------


def test_created_is_terminal_and_only_reached_from_confirming() -> None:
    assert VOICE_TRANSITIONS[ConversationState.CREATED] == frozenset()
    sources = [s for s, targets in VOICE_TRANSITIONS.items() if ConversationState.CREATED in targets]
    assert sources == [ConversationState.CONFIRMING]
    # No drafting/reviewing shortcut into CREATED.
    assert not can_transition(ConversationState.DRAFTING, ConversationState.CREATED)
    assert not can_transition(ConversationState.REVIEWING, ConversationState.CREATED)


# --- nominal flow ------------------------------------------------------------


async def test_nominal_flow_reaches_reviewing_then_created() -> None:
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service()]),
        matcher=FakeMatcher(lambda s: _match_fields()),
    )
    await orch.start()
    snap = await orch.submit_audio(_AUDIO)

    assert snap.state is ConversationState.REVIEWING
    assert len(snap.draft_lines) == 1
    assert snap.draft_lines[0].needs_review is False  # high confidence band
    assert snap.pending_question is None
    assert snap.timings_ms.keys() >= {"stt", "extract", "match"}

    await orch.confirm()
    final = await orch.mark_created("DEV-2026-0001")
    assert final.state is ConversationState.CREATED


# --- clarification (adjustment #2) -------------------------------------------


async def test_missing_mandatory_slot_triggers_a_question_then_resolves() -> None:
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service(unit_type=None)]),  # unit_type missing
        matcher=FakeMatcher(lambda s: _match_fields()),
    )
    await orch.start()
    snap = await orch.submit_audio(_AUDIO)

    assert snap.state is ConversationState.CLARIFYING
    assert snap.pending_question is not None
    assert snap.pending_question.slot == "unit_type"
    assert snap.questions_asked == 1

    resolved = await orch.provide_answer("mono-split")
    assert resolved.state is ConversationState.REVIEWING
    assert resolved.pending_question is None
    assert len(resolved.draft_lines) == 1


async def test_questions_stop_when_no_mandatory_slot_remains_not_at_a_fixed_cap() -> None:
    # Both slots missing -> exactly two questions, then draft. The count is
    # driven by remaining mandatory info, not a constant.
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service(unit_type=None, outdoor_unit=None)]),
        matcher=FakeMatcher(lambda s: _match_fields()),
    )
    await orch.start()
    await orch.submit_audio(_AUDIO)
    snap = await orch.provide_answer("mono-split")
    assert snap.state is ConversationState.CLARIFYING  # still one slot to go
    final = await orch.provide_answer("oui")
    assert final.state is ConversationState.REVIEWING
    assert final.questions_asked == 2


# --- confidence bands (Blueprint §5) ----------------------------------------


async def test_confidence_bands_include_review_and_omit() -> None:
    # Three prestations engineered to land in each band via stt*nlu*match:
    #   include: 0.98*0.98*0.98 = 0.941
    #   review : 0.90*0.90*0.85 = 0.688  (in [0.50, 0.80))
    #   omit   : 0.90*0.70*0.60 = 0.378  (< 0.50)
    services = [
        make_service(description="include", stt=0.98, nlu=0.98),
        make_service(description="review", stt=0.90, nlu=0.90),
        make_service(description="omit", stt=0.90, nlu=0.70),
    ]

    def rule(service):
        by_desc = {"include": 0.98, "review": 0.85, "omit": 0.60}
        return _match_fields(designation=service.description, confidence=by_desc[service.description])

    orch = build_orchestrator(extractor=FakeExtractor(services), matcher=FakeMatcher(rule))
    await orch.start()
    snap = await orch.submit_audio(_AUDIO)

    designations = {line.designation: line for line in snap.draft_lines}
    assert designations["include"].needs_review is False
    assert designations["review"].needs_review is True
    assert "omit" not in designations  # dropped
    assert any(u.description == "omit" for u in snap.unresolved)


async def test_unmatched_service_becomes_unresolved_never_invented() -> None:
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service(description="pompe à chaleur")]),
        matcher=FakeMatcher(lambda s: None),  # matches nothing
    )
    await orch.start()
    snap = await orch.submit_audio(_AUDIO)

    assert snap.draft_lines == []
    assert len(snap.unresolved) == 1
    assert "aucun article" in snap.unresolved[0].reason


# --- centralized failure handling -------------------------------------------


async def test_step_failure_moves_to_failed_and_preserves_recoverability() -> None:
    sink = CollectingEventSink()
    orch = build_orchestrator(
        extractor=FailingExtractor(AIProviderUnavailableError("upstream down")),
        matcher=FakeMatcher(lambda s: _match_fields()),
        sink=sink,
    )
    await orch.start()
    snap = await orch.submit_audio(_AUDIO)

    assert snap.state is ConversationState.FAILED
    assert snap.error is not None
    failed = sink.of_type(EventType.STEP_FAILED)
    assert len(failed) == 1
    assert failed[0].payload["step"] == "extract"
    assert failed[0].payload["recoverable"] is True
    # The step's cost is still timed even though it failed.
    assert "extract" in snap.timings_ms


async def test_failed_can_retry_or_fall_back_to_manual() -> None:
    orch = build_orchestrator(
        extractor=FailingExtractor(RuntimeError("boom")),
        matcher=FakeMatcher(lambda s: _match_fields()),
    )
    await orch.start()
    await orch.submit_audio(_AUDIO)
    resumed = await orch.retry()
    assert resumed.state is ConversationState.LISTENING
    assert resumed.error is None

    # And from a fresh failure, manual fallback is reachable and terminal.
    await orch.submit_audio(_AUDIO)
    fell_back = await orch.fallback_to_manual()
    assert fell_back.state is ConversationState.MANUAL_FALLBACK
    assert VOICE_TRANSITIONS[ConversationState.MANUAL_FALLBACK] == frozenset()


def test_classify_maps_provider_error_to_recoverable() -> None:
    assert classify("stt", AIProviderUnavailableError("x")).recoverable is True
    assert classify("stt", ValueError("x")).recoverable is False


# --- illegal transitions -----------------------------------------------------


async def test_illegal_calls_raise_invalid_transition() -> None:
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service()]),
        matcher=FakeMatcher(lambda s: _match_fields()),
    )
    # Cannot submit audio before start (still IDLE).
    with pytest.raises(InvalidTransition):
        await orch.submit_audio(_AUDIO)
    # Cannot confirm before there is a draft to review.
    await orch.start()
    with pytest.raises(InvalidTransition):
        await orch.confirm()


# --- normalized event stream + metrics --------------------------------------


async def test_event_stream_is_normalized_and_sequenced() -> None:
    sink = CollectingEventSink()
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service()]),
        matcher=FakeMatcher(lambda s: _match_fields()),
        sink=sink,
    )
    await orch.start()
    await orch.submit_audio(_AUDIO)

    assert sink.events, "events were emitted"
    # Same envelope on every event, strictly increasing sequence.
    sequences = [e.sequence for e in sink.events]
    assert sequences == sorted(sequences)
    assert len(set(sequences)) == len(sequences)
    cid = orch.snapshot().conversation_id
    assert all(e.conversation_id == cid for e in sink.events)
    # The first event is the IDLE -> LISTENING transition.
    first = sink.events[0]
    assert first.type is EventType.STATE_CHANGED
    assert first.payload["from_state"] == "idle" and first.payload["to_state"] == "listening"
    # The pipeline announced a ready quote.
    assert sink.of_type(EventType.QUOTE_READY)


# --- conversational revision (adjustment #4) --------------------------------


async def test_revision_merges_a_new_prestation_into_the_draft() -> None:
    orch = build_orchestrator(
        extractor=FakeExtractor([make_service(description="clim salon")], [make_service(description="clim chambre")]),
        matcher=FakeMatcher(lambda s: _match_fields(designation=s.description)),
    )
    await orch.start()
    first = await orch.submit_audio(_AUDIO)
    assert len(first.draft_lines) == 1

    revised = await orch.revise_by_voice(_AUDIO)
    assert revised.state is ConversationState.REVIEWING
    assert len(revised.draft_lines) == 2  # merged, not replaced
    designations = {line.designation for line in revised.draft_lines}
    assert designations == {"clim salon", "clim chambre"}


# --- architecture boundary: no business-database dependency ------------------


def test_voice_quote_never_imports_the_business_database() -> None:
    """Enforces the core constraint: the orchestrator package imports only the
    AI abstractions, config and its own modules — never the DB, catalog, quotes
    or SQLAlchemy. Parsed statically so it holds even for code paths a test
    never runs."""
    package_dir = pathlib.Path(orchestrator_module.__file__).parent
    forbidden = ("app.database", "app.catalog", "app.quotes", "app.quote_assistant", "sqlalchemy")

    offenders: list[str] = []
    for source_file in package_dir.glob("*.py"):
        tree = ast.parse(source_file.read_text(encoding="utf-8"))
        for node in ast.walk(tree):
            modules: list[str] = []
            if isinstance(node, ast.ImportFrom) and node.module:
                modules.append(node.module)
            elif isinstance(node, ast.Import):
                modules.extend(alias.name for alias in node.names)
            for module in modules:
                if any(module == f or module.startswith(f + ".") for f in forbidden):
                    offenders.append(f"{source_file.name}: {module}")

    assert offenders == [], f"forbidden imports in voice_quote: {offenders}"
