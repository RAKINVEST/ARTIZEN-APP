"""Quality checks + the Phase-3 publication gate.

Each check is a pure function returning ``Issue``s. Only ``error``-severity issues
block publication (the gate). The gate refuses a card that is, per the mission:
without source, without taxonomy, without relations, without confidence, a
duplicate, with broken links, or missing a required field/section.
"""

import re
from collections import Counter
from dataclasses import dataclass
from pathlib import Path

from app.catalog.trades.taxonomy import all_slugs
from app.knowledge_factory.corpus import (
    CorpusIndex,
    FactoryCard,
    load_factory_corpus,
    load_single_card,
)
from app.knowledge_factory.spec import (
    PLACEHOLDER_RE,
    REQUIRED_META,
    REQUIRED_SECTIONS,
    SEVERITY_ERROR,
    SEVERITY_INFO,
    SEVERITY_WARNING,
    VALID_CONFIDENCE,
    VALID_STATUSES,
    VALID_TYPES,
)


@dataclass(frozen=True)
class Issue:
    card: str  # rel_path
    code: str
    severity: str
    message: str


def _official_metiers() -> set[str]:
    return {slug for slug in all_slugs()}


def _norm_title(title: str) -> str:
    return re.sub(r"\s+", " ", title.strip().lower())


def check_card(card: FactoryCard, index: CorpusIndex, slug_counts: Counter) -> list[Issue]:
    """All per-card checks. ``slug_counts`` counts each slug across the corpus."""
    issues: list[Issue] = []
    item = card.item

    def add(code: str, severity: str, message: str) -> None:
        issues.append(Issue(card=card.rel_path, code=code, severity=severity, message=message))

    # 1) Required metadata fields present.
    for meta in REQUIRED_META:
        if not card.has_meta(meta):
            add("champ_obligatoire_manquant", SEVERITY_ERROR, f"Champ obligatoire manquant : {meta}.")

    # 2) Required sections (cards carry the full geste; lighter types are exempt).
    if item.type == "card":
        for section in REQUIRED_SECTIONS:
            if not card.has_section(section):
                add("section_obligatoire_manquante", SEVERITY_ERROR, f"Section obligatoire absente : {section}.")

    # 3) Taxonomy: a métier is mandatory; an off-taxonomy métier is a warning.
    if not item.profession:
        add("taxonomie_absente", SEVERITY_ERROR, "Aucune taxonomie métier (tag metier:…).")
    elif item.profession not in _official_metiers():
        add("metier_hors_taxonomie", SEVERITY_WARNING, f"Métier hors taxonomie officielle : {item.profession}.")

    # 4) Confidence present and valid.
    if not item.confidence:
        add("confiance_absente", SEVERITY_ERROR, "Indice de confiance absent (A/B/C/D).")
    elif item.confidence not in VALID_CONFIDENCE:
        add("confiance_invalide", SEVERITY_ERROR, f"Indice de confiance invalide : {item.confidence}.")

    # 5) At least one source.
    if not item.sources:
        add("source_absente", SEVERITY_ERROR, "Aucune source (DTU/NF…).")

    # 6) At least one relation.
    if not item.relations:
        add("relations_absentes", SEVERITY_ERROR, "Aucune relation vers une autre connaissance.")

    # 7) Broken links.
    for raw, resolved in card.link_targets:
        if resolved not in index.existing_paths and not resolved.exists():
            add("lien_casse", SEVERITY_ERROR, f"Lien cassé : {raw}.")

    # 8) Valid enums.
    if item.type not in VALID_TYPES:
        add("type_invalide", SEVERITY_ERROR, f"Type inconnu : {item.type or '∅'}.")
    if item.status not in VALID_STATUSES:
        add("statut_invalide", SEVERITY_ERROR, f"Statut invalide : {item.status}.")

    # 9) Duplicate slug (same identifier used by more than one file).
    if slug_counts.get(item.slug, 0) > 1:
        add("doublon_slug", SEVERITY_ERROR, f"Doublon d'identifiant : {item.slug}.")

    # 10) Editorial placeholders left in the body (fine for a draft; flagged).
    placeholders = PLACEHOLDER_RE.findall(card.text)
    if placeholders:
        add("champ_incomplet", SEVERITY_WARNING, f"{len(placeholders)} champ(s) à compléter (⟦…⟧).")

    return issues


def detect_duplicate_titles(cards: list[FactoryCard]) -> list[Issue]:
    """Near-duplicate detection across distinct slugs (same normalized title)."""
    by_title: dict[str, list[FactoryCard]] = {}
    for card in cards:
        by_title.setdefault(_norm_title(card.item.title), []).append(card)
    issues: list[Issue] = []
    for group in by_title.values():
        if len(group) > 1:
            slugs = ", ".join(sorted(c.item.slug for c in group))
            for card in group:
                issues.append(
                    Issue(card.rel_path, "doublon_titre", SEVERITY_WARNING,
                          f"Titre en doublon possible avec : {slugs}.")
                )
    return issues


def validate_corpus(cards: list[FactoryCard]) -> list[Issue]:
    """Every check over the whole corpus."""
    index = CorpusIndex(cards=cards)
    slug_counts = Counter(c.item.slug for c in cards)
    issues: list[Issue] = []
    for card in cards:
        issues.extend(check_card(card, index, slug_counts))
    issues.extend(detect_duplicate_titles(cards))
    return issues


def validate_single(path: Path) -> list[Issue]:
    """Validate one card file directly (used by the release/publication gate).
    Neighbours in the same folder are loaded only so duplicate/link checks are
    meaningful; the target is always checked even if it sits outside the tree."""
    card = load_single_card(path)
    resolved = path.resolve()
    neighbours = [c for c in load_factory_corpus(path.parent) if c.abs_path.resolve() != resolved]
    all_cards = [*neighbours, card]
    index = CorpusIndex(cards=all_cards)
    return check_card(card, index, Counter(c.item.slug for c in all_cards))


def blocking_issues(issues: list[Issue]) -> list[Issue]:
    """The subset that blocks publication (the Phase-3 gate)."""
    return [i for i in issues if i.severity == SEVERITY_ERROR]


def passes_gate(card_issues: list[Issue]) -> bool:
    return not blocking_issues(card_issues)


__all__ = [
    "SEVERITY_ERROR", "SEVERITY_INFO", "SEVERITY_WARNING",
    "Issue", "blocking_issues", "check_card", "detect_duplicate_titles",
    "passes_gate", "validate_corpus", "validate_single",
]
