"""The Voice Orchestrator — the engine that drives one conversation.

It owns the state machine and the control flow; it owns *no* step. Speech-to-
text and text-to-speech come from ``app.ai`` abstractions; extraction and
catalog matching are injected ports (``ports.py``). That is what keeps the
engine free of the business database and every step independently testable with
a fake.

Cross-cutting concerns are handled in exactly one place each:

- **State**: every change goes through ``_transition_to``, validated against
  ``VOICE_TRANSITIONS``. An illegal move raises ``InvalidTransition``.
- **Events**: every step surfaces as a normalized ``VoiceEvent`` via ``_emit``.
- **Errors**: every fallible step runs through ``_run_step``, which times it,
  and on failure moves to ``FAILED`` (keeping the draft), emits ``STEP_FAILED``,
  and aborts the current turn — nothing else invents failure handling.
- **Metrics**: ``_run_step`` (and ``_maybe_speak``) record per-step durations.
- **Logging**: every transition and every step failure is logged with the
  conversation id.

One instance == one conversation. No persistence: a later lot maps
``snapshot()`` onto the ``ai_*`` tables.
"""

import logging
import time
import uuid

from app.ai.base import SttProvider, TtsProvider
from app.core.config import settings
from app.voice_quote.confidence import ConfidencePolicy
from app.voice_quote.errors import classify
from app.voice_quote.events import EventSink, EventType, VoiceEvent
from app.voice_quote.metrics import StepMetrics
from app.voice_quote.ports import CatalogMatcher, ServiceExtractor
from app.voice_quote.questions import MandatoryInfoQuestionStrategy
from app.voice_quote.schemas import ConversationSnapshot, DraftLine, UnresolvedItem
from app.voice_quote.states import (
    ConversationState,
    InvalidTransition,
    can_transition,
)

logger = logging.getLogger(__name__)


class _PipelineAborted(Exception):
    """Internal control-flow signal: a step failed, the turn is over. Caught at
    the public method boundary so a failure returns the FAILED snapshot instead
    of propagating a raw exception to the caller."""


class VoiceOrchestrator:
    def __init__(
        self,
        *,
        company_id: uuid.UUID,
        stt: SttProvider,
        extractor: ServiceExtractor,
        matcher: CatalogMatcher,
        client_id: uuid.UUID | None = None,
        language: str = "fr",
        conversation_id: uuid.UUID | None = None,
        tts: TtsProvider | None = None,
        question_strategy: MandatoryInfoQuestionStrategy | None = None,
        confidence: ConfidencePolicy | None = None,
        event_sink: EventSink | None = None,
        max_questions: int | None = None,
    ) -> None:
        self._company_id = company_id
        self._client_id = client_id
        self._language = language
        self._conversation_id = conversation_id or uuid.uuid4()
        self._stt = stt
        self._extractor = extractor
        self._matcher = matcher
        self._tts = tts
        self._questions = question_strategy or MandatoryInfoQuestionStrategy()
        self._confidence = confidence or ConfidencePolicy()
        self._event_sink = event_sink
        self._max_questions = settings.VOICE_MAX_QUESTIONS if max_questions is None else max_questions

        self._state = ConversationState.IDLE
        self._services: list = []
        self._draft: list[DraftLine] = []
        self._unresolved: list[UnresolvedItem] = []
        self._transcript = ""
        self._pending_question = None
        self._questions_asked = 0
        self._overall_confidence = 0.0
        self._error: str | None = None
        self._metrics = StepMetrics()
        self._sequence = 0
        self._started_at = time.monotonic()

    # --- public API ----------------------------------------------------------

    async def start(self) -> ConversationSnapshot:
        self._require_state(ConversationState.IDLE)
        await self._transition_to(ConversationState.LISTENING, trigger="start")
        return self.snapshot()

    async def submit_audio(self, audio: bytes, *, hint: str | None = None) -> ConversationSnapshot:
        """Process one spoken turn end-to-end. Returns the resulting snapshot;
        on a step failure the snapshot's state is ``FAILED`` and the draft so
        far is preserved."""
        self._require_state(ConversationState.LISTENING)
        return await self._process_turn(audio, hint=hint, revision=False)

    async def provide_answer(self, answer: str) -> ConversationSnapshot:
        """Answer the pending clarification question. Fills the mandatory slot,
        then either asks the next one (still ``CLARIFYING``) or builds the
        draft (``DRAFTING`` → ``REVIEWING``)."""
        self._require_state(ConversationState.CLARIFYING)
        if self._pending_question is None:
            raise InvalidTransition(self._state, ConversationState.DRAFTING)
        question = self._pending_question
        service = self._services[question.target_service_index]
        if question.slot:
            service.attributes[question.slot] = answer.strip()
        self._pending_question = None
        await self._emit(
            EventType.ANSWER_APPLIED,
            slot=question.slot,
            target=question.target_service_index,
        )
        try:
            await self._advance_from_understanding()
        except _PipelineAborted:
            pass
        return self.snapshot()

    async def revise_by_voice(self, audio: bytes, *, hint: str | None = None) -> ConversationSnapshot:
        """Conversational revision of the draft (Blueprint §7.1, adjustment
        #4): capture another turn, merge its prestations into the draft. Always
        precedes confirmation — revising is never creating."""
        self._require_state(ConversationState.REVIEWING)
        await self._transition_to(ConversationState.LISTENING, trigger="revise")
        return await self._process_turn(audio, hint=hint, revision=True)

    async def confirm(self) -> ConversationSnapshot:
        """The explicit gesture before creation. Moves to ``CONFIRMING``; the
        client then performs the real ``POST /quotes`` (the engine never does)."""
        self._require_state(ConversationState.REVIEWING)
        await self._transition_to(ConversationState.CONFIRMING, trigger="confirm")
        return self.snapshot()

    async def mark_created(self, quote_reference: str) -> ConversationSnapshot:
        """Record that the client's ``POST /quotes`` succeeded — the only path
        to the terminal ``CREATED`` state."""
        self._require_state(ConversationState.CONFIRMING)
        await self._transition_to(ConversationState.CREATED, trigger="created")
        await self._emit(
            EventType.COMPLETED,
            quote_reference=quote_reference,
            line_count=len(self._draft),
        )
        return self.snapshot()

    async def abandon(self) -> ConversationSnapshot:
        await self._transition_to(ConversationState.ABANDONED, trigger="abandon")
        return self.snapshot()

    async def retry(self) -> ConversationSnapshot:
        self._require_state(ConversationState.FAILED)
        self._error = None
        await self._transition_to(ConversationState.LISTENING, trigger="retry")
        return self.snapshot()

    async def fallback_to_manual(self) -> ConversationSnapshot:
        self._require_state(ConversationState.FAILED)
        await self._transition_to(ConversationState.MANUAL_FALLBACK, trigger="fallback")
        return self.snapshot()

    def snapshot(self) -> ConversationSnapshot:
        return ConversationSnapshot(
            conversation_id=self._conversation_id,
            company_id=self._company_id,
            client_id=self._client_id,
            language=self._language,
            state=self._state,
            transcript=self._transcript,
            draft_lines=list(self._draft),
            pending_question=self._pending_question,
            unresolved=list(self._unresolved),
            overall_confidence=self._overall_confidence,
            questions_asked=self._questions_asked,
            error=self._error,
            timings_ms=self._metrics.timings_ms,
        )

    # --- pipeline ------------------------------------------------------------

    async def _process_turn(
        self, audio: bytes, *, hint: str | None, revision: bool
    ) -> ConversationSnapshot:
        try:
            await self._transition_to(ConversationState.TRANSCRIBING, trigger="listen_complete")
            transcription = await self._run_step(
                "stt", self._stt.transcribe(audio, language=self._language, hint=hint)
            )
            self._transcript = (
                f"{self._transcript} {transcription.text}".strip()
                if revision
                else transcription.text
            )
            await self._emit(
                EventType.TRANSCRIPT_READY,
                text=transcription.text,
                confidence=transcription.confidence,
            )

            await self._transition_to(ConversationState.UNDERSTANDING, trigger="transcribed")
            extraction = await self._run_step(
                "extract", self._extractor.extract(transcription, language=self._language)
            )
            if revision:
                self._services.extend(extraction.services)
            else:
                self._services = list(extraction.services)
            await self._emit(EventType.SERVICES_EXTRACTED, count=len(extraction.services))

            await self._advance_from_understanding()
        except _PipelineAborted:
            pass
        return self.snapshot()

    async def _advance_from_understanding(self) -> None:
        """Decide the next move once prestations are known: ask the next
        mandatory-slot question (adjustment #2), or build the draft."""
        question = self._questions.next_question(self._services)
        if question is not None and self._questions_asked < self._max_questions:
            self._pending_question = question
            self._questions_asked += 1
            if self._state is not ConversationState.CLARIFYING:
                await self._transition_to(ConversationState.CLARIFYING, trigger="needs_clarification")
            await self._emit(EventType.QUESTION_RAISED, question=question.model_dump(mode="json"))
            await self._maybe_speak(question.prompt_text)
            return
        self._pending_question = None
        await self._build_draft()

    async def _build_draft(self) -> None:
        await self._transition_to(ConversationState.DRAFTING, trigger="understood")
        matched = await self._run_step(
            "match", self._matcher.match(self._services, company_id=self._company_id)
        )

        draft: list[DraftLine] = []
        unresolved: list[UnresolvedItem] = []
        matched_indices: set[int] = set()
        for match in matched:
            service = self._services[match.source_index]
            matched_indices.add(match.source_index)
            confidence = ConfidencePolicy.compose(
                stt=service.stt_confidence,
                nlu=service.nlu_confidence,
                match=match.match_confidence,
            )
            decision = self._confidence.decide(confidence)
            if decision.outcome == "omit":
                unresolved.append(
                    UnresolvedItem(
                        source_index=match.source_index,
                        description=service.description,
                        reason=f"confiance insuffisante ({confidence})",
                    )
                )
                continue
            draft.append(
                DraftLine(
                    source_index=match.source_index,
                    catalog_item_id=match.catalog_item_id,
                    designation=match.designation,
                    quantity=match.quantity,
                    reason=match.reason,
                    confidence=confidence,
                    needs_review=decision.outcome == "clarify",
                )
            )

        for index, service in enumerate(self._services):
            if index not in matched_indices:
                unresolved.append(
                    UnresolvedItem(
                        source_index=index,
                        description=service.description,
                        reason="aucun article correspondant au catalogue",
                    )
                )

        self._draft = draft
        self._unresolved = unresolved
        self._overall_confidence = (
            round(sum(line.confidence for line in draft) / len(draft), 2) if draft else 0.0
        )
        await self._emit(
            EventType.DRAFT_UPDATED,
            line_count=len(draft),
            unresolved_count=len(unresolved),
            overall_confidence=self._overall_confidence,
        )
        await self._transition_to(ConversationState.REVIEWING, trigger="draft_ready")
        await self._emit(EventType.QUOTE_READY, line_count=len(draft))
        await self._maybe_speak("Votre devis est prêt.")

    # --- cross-cutting -------------------------------------------------------

    def _require_state(self, *allowed: ConversationState) -> None:
        if self._state not in allowed:
            raise InvalidTransition(self._state, allowed[0])

    async def _transition_to(self, target: ConversationState, *, trigger: str) -> None:
        if not can_transition(self._state, target):
            raise InvalidTransition(self._state, target)
        source = self._state
        self._state = target
        logger.info(
            "voice.transition conversation=%s %s -> %s trigger=%s",
            self._conversation_id,
            source.value,
            target.value,
            trigger,
        )
        await self._emit(
            EventType.STATE_CHANGED,
            from_state=source.value,
            to_state=target.value,
            trigger=trigger,
        )

    async def _emit(self, event_type: EventType, **payload: object) -> None:
        event = VoiceEvent(
            type=event_type,
            conversation_id=self._conversation_id,
            sequence=self._sequence,
            elapsed_ms=round((time.monotonic() - self._started_at) * 1000, 2),
            payload=dict(payload),
        )
        self._sequence += 1
        logger.debug(
            "voice.event conversation=%s type=%s seq=%s",
            self._conversation_id,
            event_type.value,
            event.sequence,
        )
        if self._event_sink is not None:
            await self._event_sink.emit(event)

    async def _run_step(self, step: str, coro):
        """Run one fallible step: time it (even on failure), and on failure move
        to FAILED (keeping the draft), emit STEP_FAILED, and abort the turn."""
        try:
            with self._metrics.measure(step):
                result = await coro
        except Exception as exc:  # noqa: BLE001 — every step failure funnels here
            failure = classify(step, exc)
            logger.warning(
                "voice.step_failed conversation=%s step=%s code=%s recoverable=%s error=%s",
                self._conversation_id,
                step,
                failure.error_code,
                failure.recoverable,
                exc,
            )
            self._error = failure.message
            await self._transition_to(ConversationState.FAILED, trigger=f"{step}_failed")
            await self._emit(
                EventType.STEP_FAILED,
                step=failure.step,
                error_code=failure.error_code,
                message=failure.message,
                recoverable=failure.recoverable,
            )
            raise _PipelineAborted from exc
        await self._emit(
            EventType.METRIC_RECORDED, step=step, duration_ms=self._metrics.timings_ms[step]
        )
        return result

    async def _maybe_speak(self, text: str) -> None:
        """Speak a line if a TTS provider is attached. Best-effort: TTS is
        optional (Blueprint §7), so a failure here never fails the turn — the
        client falls back to showing the text."""
        if self._tts is None:
            return
        try:
            with self._metrics.measure("tts"):
                await self._tts.synthesize(text, language=self._language)
        except Exception:  # noqa: BLE001 — TTS is optional, never fatal
            logger.warning("voice.tts_failed conversation=%s", self._conversation_id)
