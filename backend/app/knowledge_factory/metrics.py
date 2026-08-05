"""Knowledge metrics — computed over the corpus, **never** mutating it.

Coverage, completeness, freshness, quality, density, relations, validation and
duplication. Pure and deterministic: the freshness horizon takes an explicit
reference date so a test pins the same result every run.
"""

from collections import Counter
from dataclasses import dataclass, field
from datetime import date

from app.catalog.trades.taxonomy import all_slugs
from app.knowledge_factory.corpus import FactoryCard
from app.knowledge_factory.quality import Issue, blocking_issues
from app.knowledge_factory.spec import (
    OBSOLESCENCE_DAYS,
    REQUIRED_META,
    REQUIRED_SECTIONS,
)


@dataclass
class KnowledgeMetrics:
    total: int
    by_type: dict[str, int] = field(default_factory=dict)
    by_status: dict[str, int] = field(default_factory=dict)
    by_confidence: dict[str, int] = field(default_factory=dict)
    by_profession: dict[str, int] = field(default_factory=dict)
    coverage_metier: float = 0.0
    covered_metiers: list[str] = field(default_factory=list)
    missing_metiers: list[str] = field(default_factory=list)
    completeness: float = 0.0
    quality: float = 0.0  # fraction of cards with zero blocking issues
    density: float = 0.0  # average relations per card
    orphans: int = 0  # cards with no relation
    validation: dict[str, float] = field(default_factory=dict)
    duplication: int = 0  # identifiers used by more than one file
    fresh: int = 0
    stale: int = 0
    undated: int = 0


def _completeness(card: FactoryCard) -> float:
    required = list(REQUIRED_META) + (
        list(REQUIRED_SECTIONS) if card.item.type == "card" else []
    )
    if not required:
        return 1.0
    present = sum(card.has_meta(m) for m in REQUIRED_META)
    if card.item.type == "card":
        present += sum(card.has_section(s) for s in REQUIRED_SECTIONS)
    return round(present / len(required), 3)


def _freshness_bucket(card: FactoryCard, today: date) -> str:
    if not card.last_updated:
        return "undated"
    try:
        updated = date.fromisoformat(card.last_updated)
    except ValueError:
        return "undated"
    return "fresh" if (today - updated).days <= OBSOLESCENCE_DAYS else "stale"


def compute_metrics(
    cards: list[FactoryCard], issues: list[Issue], *, today: date
) -> KnowledgeMetrics:
    total = len(cards)
    metrics = KnowledgeMetrics(total=total)
    if total == 0:
        return metrics

    metrics.by_type = dict(Counter(c.item.type for c in cards))
    metrics.by_status = dict(Counter(c.item.status for c in cards))
    metrics.by_confidence = dict(Counter(c.item.confidence or "∅" for c in cards))
    metrics.by_profession = dict(Counter(c.item.profession or "∅" for c in cards))

    official = set(all_slugs())
    covered = {c.item.profession for c in cards if c.item.profession} & official
    metrics.covered_metiers = sorted(covered)
    metrics.missing_metiers = sorted(official - covered)
    metrics.coverage_metier = round(len(covered) / len(official), 3) if official else 0.0

    metrics.completeness = round(sum(_completeness(c) for c in cards) / total, 3)

    blocked_cards = {i.card for i in blocking_issues(issues)}
    metrics.quality = round((total - len(blocked_cards)) / total, 3)

    metrics.density = round(sum(len(c.item.relations) for c in cards) / total, 3)
    metrics.orphans = sum(1 for c in cards if not c.item.relations)

    status_counts = Counter(c.item.status for c in cards)
    metrics.validation = {
        status: round(count / total, 3) for status, count in status_counts.items()
    }

    slug_counts = Counter(c.item.slug for c in cards)
    metrics.duplication = sum(1 for count in slug_counts.values() if count > 1)

    freshness = Counter(_freshness_bucket(c, today) for c in cards)
    metrics.fresh = freshness.get("fresh", 0)
    metrics.stale = freshness.get("stale", 0)
    metrics.undated = freshness.get("undated", 0)
    return metrics
