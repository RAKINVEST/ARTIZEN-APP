"""Voice-to-Quote orchestration (V3.3 L4 — Voice Orchestrator).

This package is the *engine* that drives a voice-to-quote conversation through
its explicit state machine, calling each pipeline step behind an injected port,
emitting normalized events, timing every step, and handling failures in one
place. See docs/v3/07_VOICE_ORCHESTRATOR.md.

**It has no dependency on the business database.** It imports only the
provider abstractions (``app.ai``), configuration, and its own pure modules.
The steps that need the catalog or persistence (matching, saving a
conversation) are ``Protocol`` ports (``ports.py``) whose concrete, DB-backed
implementations are injected by an outer layer in a later lot — never imported
here. That boundary is what makes every step independently testable with a
fake, and it is enforced by ``test_voice_orchestrator_boundaries``.
"""
