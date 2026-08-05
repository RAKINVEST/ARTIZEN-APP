"""Knowledge Production Factory — the editorial toolchain for the corpus.

Tooling only: it **reads** the corpus (``backend/knowledge_corpus/``) to validate,
measure, import (as drafts) and report on it. It never modifies existing content,
never publishes automatically, and is not part of any runtime engine — the
Knowledge Engine (``app/knowledge``) stays the read-side runtime source of truth.
Everything here is deterministic and offline (no DB, no network).
"""
