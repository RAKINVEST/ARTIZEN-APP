"""Pydantic v2 schemas for the knowledge module (read-side).

The Knowledge Engine is exclusively read-side (docs/blueprint/engines/knowledge/):
it loads and serves the knowledge corpus, it **never creates or modifies** a
card. These schemas are read-models projected from the corpus files
(``backend/knowledge_corpus/``) — nothing here is persisted and nothing is invented: a
field the corpus does not carry is left empty rather than guessed.
"""

from pydantic import BaseModel, Field

#: Corpus content types the engine understands (folder-derived).
KNOWLEDGE_TYPES: tuple[str, ...] = (
    "card",
    "kit",
    "diagnostic",
    "checklist",
    "procedure",
    "phrase",
)


class KnowledgeItem(BaseModel):
    """A single corpus entry, projected read-only from its Markdown file."""

    slug: str
    type: str
    title: str
    profession: str = ""
    tags: list[str] = Field(default_factory=list)
    status: str = "brouillon"  # brouillon | valide | archive
    confidence: str = ""  # A | B | C | D (empty when the corpus states none)
    relations: list[str] = Field(default_factory=list)
    sources: list[str] = Field(default_factory=list)
    summary: str = ""
    path: str = ""  # repo-relative path (traceability)


class KnowledgeMatch(BaseModel):
    item: KnowledgeItem
    score: float = Field(ge=0, le=1)
    why: str  # explainability — never a black box (Loi 6)


class KnowledgeSearchResult(BaseModel):
    total: int
    # True when drafts were included (the corpus is currently all-draft, so a
    # validated-only query is legitimately empty — surfaced, not hidden).
    include_drafts: bool
    matches: list[KnowledgeMatch] = Field(default_factory=list)


class KnowledgeDetail(BaseModel):
    item: KnowledgeItem
    related: list[KnowledgeItem] = Field(default_factory=list)
