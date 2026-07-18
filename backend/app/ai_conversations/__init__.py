"""Persistence of Voice-to-Quote conversations (V3.3 — persistence lot).

This module is the *only* place a voice conversation touches the database, and
it does so **exclusively by consuming the orchestrator's normalized events**
through ``PersistingEventSink`` (see ``sink.py``). The orchestrator
(``app.voice_quote``) never imports anything here — the dependency runs one
way, ``ai_conversations -> voice_quote``, so the engine stays database-ignorant
(proven by ``test_voice_orchestrator``'s static boundary check).

The ``ai_*`` tables hold **records only, no business logic**: no prices, no
totals, no quote creation, no computed columns, no triggers. They are an
append-only projection of what the engine decided, kept for explainability and
future statistics — the authoritative quote still lives in ``quotes`` and is
only ever created by the explicit ``POST /quotes``.
"""
