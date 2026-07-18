"""Normalized events emitted by the orchestrator.

Every step the engine takes surfaces as a ``VoiceEvent`` with the *same*
envelope — type, conversation id, a per-conversation sequence number, elapsed
milliseconds since the conversation started, and a JSON-safe payload. That
uniformity is the point: the same stream feeds live UI (SSE/WebSocket, later),
persistence (later), and logs, without any consumer special-casing shapes.

The orchestrator emits through an ``EventSink``. A sink is optional and purely
additive: the engine always logs internally regardless, so nothing is lost if
no sink is attached. Tests attach a collecting sink to assert the exact stream.
"""

import enum
import uuid
from typing import Any, Protocol, runtime_checkable

from pydantic import BaseModel, Field


class EventType(str, enum.Enum):
    STATE_CHANGED = "state_changed"
    TRANSCRIPT_READY = "transcript_ready"
    SERVICES_EXTRACTED = "services_extracted"
    QUESTION_RAISED = "question_raised"
    ANSWER_APPLIED = "answer_applied"
    DRAFT_UPDATED = "draft_updated"
    QUOTE_READY = "quote_ready"  # draft complete; creation is the client's POST /quotes
    COMPLETED = "completed"  # quote actually created (terminal)
    STEP_FAILED = "step_failed"
    METRIC_RECORDED = "metric_recorded"


class VoiceEvent(BaseModel):
    type: EventType
    conversation_id: uuid.UUID
    sequence: int = Field(ge=0)
    elapsed_ms: float = Field(ge=0)
    payload: dict[str, Any] = Field(default_factory=dict)


@runtime_checkable
class EventSink(Protocol):
    """Where normalized events go beyond the internal log. A real deployment
    plugs an SSE/WebSocket broadcaster or a persistence writer here."""

    async def emit(self, event: VoiceEvent) -> None: ...


class CollectingEventSink:
    """In-memory sink that records every event in order. Not test-only by
    accident — it is also the simplest way to inspect a finished conversation's
    event stream (e.g. for a debugging endpoint)."""

    def __init__(self) -> None:
        self.events: list[VoiceEvent] = []

    async def emit(self, event: VoiceEvent) -> None:
        self.events.append(event)

    def of_type(self, event_type: EventType) -> list[VoiceEvent]:
        return [event for event in self.events if event.type == event_type]
