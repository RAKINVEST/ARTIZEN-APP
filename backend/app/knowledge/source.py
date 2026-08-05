"""Knowledge source — where the corpus comes from, behind one interface.

V1 reads the filesystem corpus (``backend/knowledge_corpus/``), the real source
of truth built in the earlier phases. It lives inside the backend so it ships
**inside the image** (the Docker build context is ``backend/``) — no manual step,
present in every standard deployment. It is loaded **once** and cached (the
corpus is static reference content). A future DB-backed source (the tenant-scoped
``Knowledge`` object) plugs in behind the same ``get_items`` contract without
touching callers — the provider-abstraction the project already applies to
AI/storage. Read-only throughout: nothing here writes.
"""

from functools import lru_cache
from pathlib import Path

from app.core.config import settings
from app.knowledge.loader import load_corpus
from app.knowledge.schemas import KnowledgeItem


def _default_root() -> Path:
    # backend/app/knowledge/source.py -> parents[2] is the backend/ root, where
    # the corpus is vendored so it ships inside the image (build context).
    return Path(__file__).resolve().parents[2] / "knowledge_corpus"


def corpus_root() -> Path:
    override = settings.KNOWLEDGE_CORPUS_ROOT
    return Path(override) if override else _default_root()


@lru_cache(maxsize=1)
def _load_cached() -> tuple[KnowledgeItem, ...]:
    return tuple(load_corpus(corpus_root()))


def get_items() -> list[KnowledgeItem]:
    """The cached corpus (loaded once). Read-only copy per call."""
    return list(_load_cached())


def clear_cache() -> None:
    """Drop the cache — used by tests that point at a temp corpus."""
    _load_cached.cache_clear()
