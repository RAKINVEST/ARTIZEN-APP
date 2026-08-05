"""Read a corpus into rich, checkable ``FactoryCard`` objects.

Wraps the read-side loader (``app.knowledge.loader.parse_item``) with the extra
raw-text views the editorial checks need: the metadata table, the presence of
required sections, the outgoing links (with their resolved targets) and the
history dates. Read-only — it opens files, never writes them.
"""

import re
from dataclasses import dataclass, field
from functools import cached_property
from pathlib import Path

from app.knowledge.loader import parse_item
from app.knowledge.schemas import KnowledgeItem

_TYPE_SEGMENTS = ("cards", "kits", "diagnostics", "checklists", "procedures", "phrases")
_META_ROW_RE = re.compile(r"^\|\s*([^|]+?)\s*\|\s*(.*?)\s*\|\s*$", re.MULTILINE)
_LINK_RE = re.compile(r"\]\(([^)]+\.md)[^)]*\)")
_DATE_RE = re.compile(r"\b(\d{4}-\d{2}-\d{2})\b")
_EXCLUDED = {"README.md", "CARD_TEMPLATE.md"}


def _clean(value: str) -> str:
    return value.strip().strip("`").strip("*").strip()


@dataclass
class FactoryCard:
    rel_path: str
    abs_path: Path
    text: str
    item: KnowledgeItem

    @cached_property
    def metadata(self) -> dict[str, str]:
        """The ``## Métadonnées`` table as ``{field(lowercased): value}``. Scoped
        to that section only — otherwise the Historique table header (which also
        starts with ``| Version |``) would overwrite the real metadata."""
        result: dict[str, str] = {}
        for field_name, value in _META_ROW_RE.findall(self._metadata_section):
            key = _clean(field_name).lower()
            if key in ("champ", "---", "") or key.startswith("---"):
                continue
            result[key] = _clean(value)
        return result

    @cached_property
    def _metadata_section(self) -> str:
        """The text between the ``## Métadonnées`` header and the next ``##``."""
        match = re.search(r"^##\s+M[ée]tadonn[ée]es\s*$", self.text, re.MULTILINE)
        if not match:
            return self.text  # no explicit section — fall back to the whole file
        rest = self.text[match.end():]
        next_header = re.search(r"^##\s", rest, re.MULTILINE)
        return rest[: next_header.start()] if next_header else rest

    @cached_property
    def link_targets(self) -> list[tuple[str, Path]]:
        """Outgoing ``.md`` links as ``(raw_target, resolved_absolute_path)``."""
        targets: list[tuple[str, Path]] = []
        for raw in _LINK_RE.findall(self.text):
            resolved = (self.abs_path.parent / raw).resolve()
            targets.append((raw, resolved))
        return targets

    @cached_property
    def history_dates(self) -> list[str]:
        return sorted(set(_DATE_RE.findall(self.text)))

    @property
    def last_updated(self) -> str:
        return self.history_dates[-1] if self.history_dates else ""

    def has_section(self, name: str) -> bool:
        """A required field/section is present when its bold label appears
        (``**Objectif**``) or a header of that name exists."""
        low = self.text.lower()
        target = name.lower()
        return f"**{target}**" in low or f"# {target}" in low

    def has_meta(self, field_name: str) -> bool:
        value = self.metadata.get(field_name.lower(), "")
        # Present = non-empty and not a bare placeholder.
        return bool(value) and "⟦" not in value


def _type_from_path(rel_path: str) -> str:
    parts = Path(rel_path).as_posix().split("/")
    mapping = {
        "cards": "card", "kits": "kit", "diagnostics": "diagnostic",
        "checklists": "checklist", "procedures": "procedure", "phrases": "phrase",
    }
    for segment, type_name in mapping.items():
        if segment in parts:
            return type_name
    return ""


def load_single_card(path: Path, *, default_type: str = "card") -> FactoryCard:
    """Build a ``FactoryCard`` from one file regardless of its location. When the
    type can't be inferred from the path (a draft outside the corpus tree), fall
    back to ``card`` so the strictest checks apply — the release gate must never
    pass a card it couldn't actually verify."""
    text = path.read_text(encoding="utf-8")
    rel = path.name
    item = parse_item(rel, text)
    if not item.type:
        item = item.model_copy(update={"type": default_type})
    return FactoryCard(rel_path=rel, abs_path=path, text=text, item=item)


def load_factory_corpus(root: Path) -> list[FactoryCard]:
    """Load every content file under ``root`` as a ``FactoryCard`` (read-only)."""
    cards: list[FactoryCard] = []
    if not root.is_dir():
        return cards
    for md in sorted(root.rglob("*.md")):
        if md.name in _EXCLUDED or md.name.startswith("_"):
            continue
        rel = md.relative_to(root).as_posix()
        if not _type_from_path(rel):
            continue  # governance/taxonomy/book docs are not content items
        text = md.read_text(encoding="utf-8")
        cards.append(
            FactoryCard(rel_path=rel, abs_path=md, text=text, item=parse_item(rel, text))
        )
    return cards


@dataclass
class CorpusIndex:
    """Fast lookups shared by the checks (slug set, path set)."""

    cards: list[FactoryCard] = field(default_factory=list)

    @cached_property
    def slugs(self) -> set[str]:
        return {c.item.slug for c in self.cards}

    @cached_property
    def existing_paths(self) -> set[Path]:
        return {c.abs_path.resolve() for c in self.cards}
