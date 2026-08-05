"""The official Knowledge Card model, as machine-checkable constants.

Derived from the frozen editorial model (``knowledge_corpus/cards/CARD_TEMPLATE.md``)
and the read-side schema (``app.knowledge.schemas``). Nothing here invents rules —
it encodes the ones the corpus already documents.
"""

import re

from app.knowledge.schemas import KNOWLEDGE_TYPES

VALID_TYPES: tuple[str, ...] = KNOWLEDGE_TYPES  # card|kit|diagnostic|checklist|procedure|phrase
VALID_STATUSES: tuple[str, ...] = ("brouillon", "valide", "archive")
VALID_CONFIDENCE: tuple[str, ...] = ("A", "B", "C", "D")

# Metadata rows marked obligatory (*) in the template.
REQUIRED_META: tuple[str, ...] = (
    "identifiant", "titre", "profession", "version", "auteur", "statut",
)
# Section headers marked obligatory (*) in the template.
REQUIRED_SECTIONS: tuple[str, ...] = (
    "objectif", "résumé", "étapes", "points critiques", "sécurité",
)

# Editorial placeholder marker: ⟦…⟧ means "to be completed/validated". Legitimate
# in a Brouillon; a blocker only at publication (see release.py).
PLACEHOLDER_RE = re.compile(r"⟦[^⟧]*⟧")

# Severities. Only ERROR blocks publication (the Phase-3 quality gate).
SEVERITY_ERROR = "error"
SEVERITY_WARNING = "warning"
SEVERITY_INFO = "info"

# Freshness horizon: a card whose last history entry is older than this is
# flagged as potentially obsolete (Phase 5 — freshness/obsolescence).
OBSOLESCENCE_DAYS = 365
