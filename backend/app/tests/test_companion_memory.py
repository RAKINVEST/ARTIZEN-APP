"""Pure unit tests for Companion memory + session (no DB, no Redis).

Uses the in-process ``InMemoryStore`` (also the Redis-absent fallback) to pin the
session lifecycle: tenant-scoped keys, append-only turns, automatic summary of
older turns, and the "not found → 404" behaviour. Run with ``pytest --noconftest``.
"""

import asyncio
import uuid

import pytest

from app.ai_companion.exceptions import SessionNotFoundError
from app.ai_companion.memory import InMemoryStore
from app.ai_companion.session import SessionManager


def _manager(store, company_id=None, max_turns=6):
    return SessionManager(
        store, company_id=company_id or uuid.uuid4(), ttl=3600, max_turns=max_turns
    )


def test_in_memory_store_roundtrip():
    async def scenario():
        store = InMemoryStore()
        assert await store.get("k") is None
        await store.set("k", "v", ttl=10)
        assert await store.get("k") == "v"
        await store.delete("k")
        assert await store.get("k") is None

    asyncio.run(scenario())


def test_save_then_load_roundtrip():
    async def scenario():
        store = InMemoryStore()
        manager = _manager(store)
        session = manager.new_session()
        manager.record_turn(session, role="user", text="bonjour", intent="clarify")
        await manager.save(session)
        loaded = await manager.load(session.session_id)
        assert loaded.session_id == session.session_id
        assert [t.text for t in loaded.turns] == ["bonjour"]

    asyncio.run(scenario())


def test_sessions_are_tenant_scoped():
    async def scenario():
        store = InMemoryStore()  # shared backing store, different tenants
        company_a, company_b = uuid.uuid4(), uuid.uuid4()
        manager_a = _manager(store, company_a)
        manager_b = _manager(store, company_b)
        session = manager_a.new_session()
        await manager_a.save(session)
        # Same id, other tenant → not found (keys are namespaced by company).
        with pytest.raises(SessionNotFoundError):
            await manager_b.load(session.session_id)

    asyncio.run(scenario())


def test_load_missing_required_raises():
    async def scenario():
        with pytest.raises(SessionNotFoundError):
            await _manager(InMemoryStore()).load("does-not-exist", required=True)

    asyncio.run(scenario())


def test_load_missing_optional_returns_fresh():
    async def scenario():
        manager = _manager(InMemoryStore())
        session = await manager.load("ghost", required=False)
        assert session.session_id == "ghost"
        assert session.turns == []

    asyncio.run(scenario())


def test_turns_are_append_only():
    store = InMemoryStore()
    manager = _manager(store)
    session = manager.new_session()
    manager.record_turn(session, role="user", text="a")
    manager.record_turn(session, role="assistant", text="b")
    assert [t.role for t in session.turns] == ["user", "assistant"]


def test_older_turns_fold_into_summary_without_loss():
    manager = _manager(InMemoryStore(), max_turns=4)
    session = manager.new_session()
    for i in range(10):
        manager.record_turn(session, role="user", text=f"message {i}")
    # Kept to the recent half; the rest is summarized, not dropped silently.
    assert len(session.turns) <= 4
    assert session.summary  # older context preserved as a summary
    assert "message 0" in session.summary
