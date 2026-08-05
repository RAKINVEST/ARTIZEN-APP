"""Corpus loader — parses ``backend/knowledge_corpus`` Markdown into read-models.

Pure and filesystem-based (no DB): reads the real corpus files and extracts the
metadata they actually carry. It is deliberately **defensive** — anything it
cannot parse is left empty, never invented (the project's cardinal rule).
"""

import re
from pathlib import Path

from app.knowledge.schemas import KnowledgeItem

# Folder segment -> content type.
_TYPE_BY_SEGMENT: dict[str, str] = {
    "cards": "card",
    "kits": "kit",
    "diagnostics": "diagnostic",
    "checklists": "checklist",
    "procedures": "procedure",
    "phrases": "phrase",
}

# Files that are structure, not content.
_EXCLUDED_NAMES = {"README.md", "CARD_TEMPLATE.md"}

_TAG_RE = re.compile(r"\b([a-z][a-z-]*):([a-z0-9][a-z0-9-]*)\b")
_LINK_RE = re.compile(r"\]\(([^)]+\.md)[^)]*\)")
_STATUS_RE = re.compile(r"Statut\s*\|\s*\*{0,2}(Brouillon|Validé|Valide|Archivé|Archive)", re.IGNORECASE)
_CONF_RE = re.compile(r"[Ii]ndice de confiance\s*\|\s*\*{0,2}([ABCD])\b")
_SOURCE_RE = re.compile(r"\b(DTU\s*[0-9][0-9.\s]*|NF\s*[CE]\s*[0-9-]+)")


def _type_from_path(path: str) -> str:
    parts = Path(path).as_posix().split("/")
    for segment, type_name in _TYPE_BY_SEGMENT.items():
        if segment in parts:
            return type_name
    return ""


def _normalize_status(raw: str) -> str:
    low = raw.lower()
    if low.startswith("archiv"):
        return "archive"
    if low.startswith("valid"):
        return "valide"
    return "brouillon"


def _first_title(text: str) -> str:
    for line in text.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return ""


def _summary(text: str) -> str:
    for line in text.splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith(("#", ">", "|", "-", "*", "```")):
            continue
        return stripped[:280]
    return ""


def parse_item(rel_path: str, text: str) -> KnowledgeItem:
    """Project one Markdown file into a :class:`KnowledgeItem` (pure)."""
    slug = Path(rel_path).stem

    status_match = _STATUS_RE.search(text)
    if status_match:
        status = _normalize_status(status_match.group(1))
    elif "Brouillon" in text:
        status = "brouillon"
    else:
        status = "brouillon"

    conf_match = _CONF_RE.search(text)
    confidence = conf_match.group(1) if conf_match else ""

    tags = sorted({f"{axis}:{value}" for axis, value in _TAG_RE.findall(text)})
    profession = ""
    for tag in tags:
        if tag.startswith("metier:"):
            profession = tag.split(":", 1)[1]
            break
    if not profession:
        parts = Path(rel_path).as_posix().split("/")
        if "professions" in parts:
            i = parts.index("professions")
            if i + 1 < len(parts):
                profession = parts[i + 1]

    relations = sorted(
        {Path(target).stem for target in _LINK_RE.findall(text)} - {slug, "README", "CARD_TEMPLATE"}
    )
    sources = sorted({s.strip() for s in _SOURCE_RE.findall(text)})

    return KnowledgeItem(
        slug=slug,
        type=_type_from_path(rel_path),
        title=_first_title(text) or slug,
        profession=profession,
        tags=tags,
        status=status,
        confidence=confidence,
        relations=relations,
        sources=sources,
        summary=_summary(text),
        path=Path(rel_path).as_posix(),
    )


def load_corpus(root: Path) -> list[KnowledgeItem]:
    """Load every content file under a knowledge corpus root (read-only)."""
    items: list[KnowledgeItem] = []
    if not root.is_dir():
        return items
    for md in sorted(root.rglob("*.md")):
        name = md.name
        if name in _EXCLUDED_NAMES or name.startswith("_"):
            continue
        rel = md.relative_to(root)
        type_name = _type_from_path(str(rel))
        if not type_name:
            continue  # governance/taxonomy/book docs are not content items
        text = md.read_text(encoding="utf-8")
        items.append(parse_item(str(rel), text))
    return items
