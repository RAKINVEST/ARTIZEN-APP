"""Session Manager — loads/saves the conversational session, tenant-scoped.

A session is pure conversational state: the append-only turns, the automatic
summary of older turns (so long conversations never lose context), the slots
collected for slot-filling, and the single action awaiting validation. It holds
no business data. Keys are namespaced by ``company_id`` so one tenant can never
load another's session (a foreign session id simply isn't found → 404).
"""

import uuid
from typing import Literal

from pydantic import BaseModel, Field

from app.ai_companion.exceptions import SessionNotFoundError
from app.ai_companion.memory import MemoryStore
from app.ai_companion.schemas import ConversationTurn, ProposedAction


class CompanionSession(BaseModel):
    session_id: str
    company_id: str
    turns: list[ConversationTurn] = Field(default_factory=list)
    pending_action: ProposedAction | None = None
    slots: dict = Field(default_factory=dict)  # accumulated parameters
    summary: str = ""


class SessionManager:
    def __init__(
        self, store: MemoryStore, *, company_id: uuid.UUID, ttl: int, max_turns: int
    ) -> None:
        self._store = store
        self._company_id = company_id
        self._ttl = ttl
        self._max_turns = max_turns

    def _key(self, session_id: str) -> str:
        return f"companion:{self._company_id}:session:{session_id}"

    def new_session(self) -> CompanionSession:
        return CompanionSession(session_id=uuid.uuid4().hex, company_id=str(self._company_id))

    async def load(self, session_id: str, *, required: bool = True) -> CompanionSession:
        raw = await self._store.get(self._key(session_id))
        if raw is None:
            if required:
                raise SessionNotFoundError(f"Session {session_id} not found or expired.")
            # Not required (a Redis-absent chat continuation): start fresh but
            # keep the id the caller referenced, so the client stays consistent.
            return CompanionSession(session_id=session_id, company_id=str(self._company_id))
        return CompanionSession.model_validate_json(raw)

    async def save(self, session: CompanionSession) -> None:
        await self._store.set(
            self._key(session.session_id), session.model_dump_json(), ttl=self._ttl
        )

    async def delete(self, session_id: str) -> None:
        await self._store.delete(self._key(session_id))

    def record_turn(
        self, session: CompanionSession, *, role: Literal["user", "assistant"],
        text: str, intent: str = "",
    ) -> None:
        session.turns.append(ConversationTurn(role=role, text=text, intent=intent))
        self._maybe_summarize(session)

    def _maybe_summarize(self, session: CompanionSession) -> None:
        """Fold the oldest turns into a running summary once the conversation
        grows past ``max_turns`` — deterministic, keeps the gist, never drops
        context silently. Keeps the most recent half verbatim."""
        if len(session.turns) <= self._max_turns:
            return
        keep = self._max_turns // 2
        overflow = session.turns[:-keep]
        session.turns = session.turns[-keep:]
        folded = "; ".join(
            f"{t.role}: {t.text[:80]}" for t in overflow if t.text
        )
        session.summary = (f"{session.summary} | " if session.summary else "") + folded
