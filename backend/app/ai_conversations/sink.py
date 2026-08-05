"""``PersistingEventSink`` — turns the orchestrator's normalized event stream
into rows in the ``ai_*`` tables.

This is the *entire* bridge between the engine and the database. The
orchestrator emits ``VoiceEvent``s to an ``EventSink``; this implementation is
the one that writes. Because it consumes only events, the engine never learns a
database exists — constraint honoured structurally, not by convention.

Resilience: a persistence failure must never break a live conversation
(the V3 "always usable" rule). Each event is handled in its own transaction;
on error the sink rolls back and logs, and the conversation carries on — that
event's data is lost, nothing else is.
"""

import logging
import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.ai_conversations.repository import AiConversationRepository
from app.voice_quote.events import EventType, VoiceEvent

logger = logging.getLogger(__name__)


def _decisions_from_payload(payload: dict) -> list[dict]:
    """Flatten a DRAFT_UPDATED payload into ``AiDecision`` field dicts. Both
    kept lines and omissions are decisions, each with its engine-minted
    ``decision_id`` → ``ai_decisions.id``."""
    decisions: list[dict] = []
    for line in payload.get("draft_lines", []):
        decisions.append(
            {
                "id": uuid.UUID(line["decision_id"]),
                "source_index": line["source_index"],
                "decision": "clarify" if line["needs_review"] else "include",
                "catalog_item_id": uuid.UUID(line["catalog_item_id"]),
                "designation": line["designation"],
                "quantity": float(line["quantity"]),
                "confidence": line["confidence"],
                "needs_review": line["needs_review"],
                "reason": line["reason"],
            }
        )
    for item in payload.get("unresolved", []):
        decisions.append(
            {
                "id": uuid.UUID(item["decision_id"]),
                "source_index": item["source_index"],
                "decision": "omit",
                "description": item["description"],
                "reason": item["reason"],
            }
        )
    return decisions


class PersistingEventSink:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._repo = AiConversationRepository(session)

    async def emit(self, event: VoiceEvent) -> None:
        try:
            await self._handle(event)
            await self._session.commit()
        except Exception:  # noqa: BLE001 — persistence must never break the conversation
            await self._session.rollback()
            logger.warning(
                "ai_persistence.event_failed conversation=%s type=%s",
                event.conversation_id,
                event.type.value,
                exc_info=True,
            )

    async def _handle(self, event: VoiceEvent) -> None:
        cid = event.conversation_id
        payload = event.payload

        if event.type is EventType.CONVERSATION_STARTED:
            client_id = payload.get("client_id")
            await self._repo.create_conversation(
                conversation_id=cid,
                company_id=uuid.UUID(payload["company_id"]),
                client_id=uuid.UUID(client_id) if client_id else None,
                language=payload.get("language", "fr"),
                engine_version=payload["engine_version"],
                state="idle",
            )

        elif event.type is EventType.STATE_CHANGED:
            await self._repo.set_state(cid, payload["to_state"])

        elif event.type is EventType.TRANSCRIPT_READY:
            await self._repo.add_turn(
                cid, role="user", content=payload["text"], stt_confidence=payload.get("confidence")
            )
            await self._repo.append_transcript(cid, payload["text"])

        elif event.type is EventType.QUESTION_RAISED:
            await self._repo.add_turn(
                cid, role="assistant", content=payload["question"]["prompt_text"]
            )
            await self._repo.increment_questions(cid)

        elif event.type is EventType.ANSWER_APPLIED:
            await self._repo.add_turn(cid, role="user", content=payload.get("answer", ""))

        elif event.type is EventType.DRAFT_UPDATED:
            await self._repo.replace_decisions(
                cid,
                decisions=_decisions_from_payload(payload),
                draft_line_count=payload["line_count"],
                unresolved_count=payload["unresolved_count"],
                overall_confidence=payload["overall_confidence"],
            )

        elif event.type is EventType.COMPLETED:
            await self._repo.set_completed(cid, payload.get("quote_reference", ""))

        elif event.type is EventType.STEP_FAILED:
            await self._repo.set_error(cid, payload["error_code"], payload["message"])

        elif event.type is EventType.METRIC_RECORDED:
            await self._repo.record_timing(cid, payload["step"], payload["duration_ms"])
