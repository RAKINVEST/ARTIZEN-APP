"""Data access for the ``ai_*`` tables.

Writes are called **only** from ``PersistingEventSink`` (all persistence is
event-driven). The read helpers exist for tests today and a future
explainability/analytics API. No business logic lives here — just CRUD over the
records the engine produced.
"""

import uuid

from sqlalchemy import delete, func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.ai_conversations.models import AiConversation, AiDecision, AiTurn


class AiConversationRepository:
    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    # --- conversation --------------------------------------------------------

    async def create_conversation(
        self,
        *,
        conversation_id: uuid.UUID,
        company_id: uuid.UUID,
        client_id: uuid.UUID | None,
        language: str,
        engine_version: str,
        state: str,
    ) -> AiConversation:
        conversation = AiConversation(
            id=conversation_id,
            company_id=company_id,
            client_id=client_id,
            language=language,
            engine_version=engine_version,
            state=state,
        )
        self.session.add(conversation)
        await self.session.flush()
        return conversation

    async def get_conversation(self, conversation_id: uuid.UUID) -> AiConversation | None:
        return await self.session.get(AiConversation, conversation_id)

    async def set_state(self, conversation_id: uuid.UUID, state: str) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is not None:
            conversation.state = state

    async def append_transcript(self, conversation_id: uuid.UUID, text: str) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is not None:
            conversation.transcript = f"{conversation.transcript} {text}".strip()

    async def increment_questions(self, conversation_id: uuid.UUID) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is not None:
            conversation.questions_asked += 1

    async def set_error(
        self, conversation_id: uuid.UUID, error_code: str, error_message: str
    ) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is not None:
            conversation.error_code = error_code
            conversation.error_message = error_message

    async def set_completed(self, conversation_id: uuid.UUID, quote_reference: str) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is not None:
            conversation.quote_reference = quote_reference

    async def record_timing(
        self, conversation_id: uuid.UUID, step: str, duration_ms: float
    ) -> None:
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is None:
            return
        # Reassign (not in-place mutate) so SQLAlchemy flags the JSONB dirty.
        timings = {**(conversation.timings or {}), step: duration_ms}
        conversation.timings = timings
        conversation.total_duration_ms = round(sum(timings.values()), 2)

    # --- turns ---------------------------------------------------------------

    async def add_turn(
        self,
        conversation_id: uuid.UUID,
        *,
        role: str,
        content: str,
        stt_confidence: float | None = None,
    ) -> None:
        result = await self.session.execute(
            select(func.max(AiTurn.seq)).where(AiTurn.conversation_id == conversation_id)
        )
        max_seq = result.scalar()
        next_seq = 0 if max_seq is None else max_seq + 1
        self.session.add(
            AiTurn(
                conversation_id=conversation_id,
                seq=next_seq,
                role=role,
                content=content,
                stt_confidence=stt_confidence,
            )
        )
        await self.session.flush()

    async def list_turns(self, conversation_id: uuid.UUID) -> list[AiTurn]:
        result = await self.session.execute(
            select(AiTurn)
            .where(AiTurn.conversation_id == conversation_id)
            .order_by(AiTurn.seq)
        )
        return list(result.scalars().all())

    # --- decisions -----------------------------------------------------------

    async def replace_decisions(
        self,
        conversation_id: uuid.UUID,
        *,
        decisions: list[dict],
        draft_line_count: int,
        unresolved_count: int,
        overall_confidence: float,
    ) -> None:
        """Replace the conversation's decisions with the current set (a revision
        recomputes the whole draft) and refresh its summary counters. Each dict
        carries an engine-minted ``id`` (the decision_id); ``company_id`` is
        filled here from the conversation for tenant-scoped analytics."""
        conversation = await self.session.get(AiConversation, conversation_id)
        if conversation is None:
            return

        await self.session.execute(
            delete(AiDecision).where(AiDecision.conversation_id == conversation_id)
        )
        for fields in decisions:
            self.session.add(
                AiDecision(conversation_id=conversation_id, company_id=conversation.company_id, **fields)
            )

        conversation.draft_line_count = draft_line_count
        conversation.unresolved_count = unresolved_count
        conversation.overall_confidence = overall_confidence
        await self.session.flush()

    async def list_decisions(self, conversation_id: uuid.UUID) -> list[AiDecision]:
        result = await self.session.execute(
            select(AiDecision).where(AiDecision.conversation_id == conversation_id)
        )
        return list(result.scalars().all())
