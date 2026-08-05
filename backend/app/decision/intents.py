"""Intent interpretation — pure, deterministic, DB-free (unit-testable).

Maps a free-text intention onto the frozen intervention verbs
(backend/knowledge_corpus/taxonomy/INTERVENTION_TYPES.md) plus a free-text target. This
is real rule-based logic, not a placeholder mock: an AI provider may later
enrich it behind the same ``Intent`` contract (provider-abstraction), but the
deterministic path is always available and is what the tests pin down.
"""

from app.decision.schemas import Intent

#: Frozen intervention verbs (subset used by V1) — kebab-case slugs.
INTENT_VERBS: tuple[str, ...] = (
    "installer",
    "remplacer",
    "reparer",
    "depanner",
    "diagnostiquer",
    "controler",
    "verifier",
    "entretenir",
    "nettoyer",
    "regler",
    "modifier",
    "renover",
    "creer",
    "raccorder",
)

#: French surface forms → normalized verb. Order matters only for readability;
#: matching is longest-keyword-first to avoid "change" shadowing "changer de".
_VERB_KEYWORDS: dict[str, str] = {
    "installer": "installer",
    "pose": "installer",
    "poser": "installer",
    "remplace": "remplacer",
    "remplacer": "remplacer",
    "changer": "remplacer",
    "change": "remplacer",
    "repare": "reparer",
    "reparer": "reparer",
    "depanne": "depanner",
    "depanner": "depanner",
    "diagnostic": "diagnostiquer",
    "diagnostiquer": "diagnostiquer",
    "controle": "controler",
    "controler": "controler",
    "verifie": "verifier",
    "verifier": "verifier",
    "entretien": "entretenir",
    "entretenir": "entretenir",
    "nettoie": "nettoyer",
    "nettoyer": "nettoyer",
    "regle": "regler",
    "regler": "regler",
    "modifie": "modifier",
    "modifier": "modifier",
    "renove": "renover",
    "renover": "renover",
    "cree": "creer",
    "creer": "creer",
    "raccorde": "raccorder",
    "raccorder": "raccorder",
}

# Small French stop-list so the extracted target is the meaningful noun phrase.
_STOP_WORDS = frozenset(
    {"je", "j", "un", "une", "le", "la", "les", "des", "du", "de", "d", "mon",
     "ma", "mes", "l", "au", "aux", "the", "a"}
)


def _normalize(text: str) -> list[str]:
    cleaned = []
    for raw in text.lower().split():
        token = "".join(ch for ch in raw if ch.isalnum())
        if token:
            cleaned.append(token)
    return cleaned


def interpret_intent(text: str) -> Intent:
    """Return the understood :class:`Intent`. ``verb`` is empty when no known
    action is recognized — the caller then asks instead of guessing (the engine
    never invents)."""
    tokens = _normalize(text)
    verb = ""
    verb_index = -1
    for i, token in enumerate(tokens):
        mapped = _VERB_KEYWORDS.get(token)
        if mapped is not None:
            verb = mapped
            verb_index = i
            break

    # The target is what follows the verb (or the whole phrase if no verb),
    # minus stop-words — never invented, just extracted.
    tail = tokens[verb_index + 1:] if verb_index >= 0 else tokens
    target = " ".join(t for t in tail if t not in _STOP_WORDS).strip()

    return Intent(verb=verb, target=target, raw=text.strip())
