"""Conversational intent resolution — pure, deterministic, DB-free.

Maps an artisan's free-text message onto a Companion intent and routes it to the
owning engine. Rule-based and fully offline (works with the mock AI provider); a
real LLM may enrich it later behind the same ``ResolvedIntent`` contract, exactly
as the Decision Engine's ``interpret_intent`` does. It reuses that verb/target
extractor rather than duplicating it (single source of truth for verbs).
"""

import unicodedata
from dataclasses import dataclass
from enum import Enum

from app.decision.intents import interpret_intent


class CompanionIntent(str, Enum):
    # Read-side — answered immediately, no business impact, no confirmation.
    SEARCH_KNOWLEDGE = "search_knowledge"
    EXPLAIN = "explain"
    SUMMARIZE = "summarize"
    # Write-side — proposed only, executed after explicit human validation.
    PLAN_INTERVENTION = "plan_intervention"
    SCHEDULE = "schedule"
    SEND_NOTIFICATION = "send_notification"
    CREATE_QUOTE = "create_quote"
    # Fallback — the Companion asks instead of guessing.
    CLARIFY = "clarify"


WRITE_INTENTS: frozenset[CompanionIntent] = frozenset(
    {
        CompanionIntent.PLAN_INTERVENTION,
        CompanionIntent.SCHEDULE,
        CompanionIntent.SEND_NOTIFICATION,
        CompanionIntent.CREATE_QUOTE,
    }
)

#: Which engine owns each intent (for explainability + dispatch).
INTENT_ENGINE: dict[CompanionIntent, str] = {
    CompanionIntent.SEARCH_KNOWLEDGE: "knowledge",
    CompanionIntent.EXPLAIN: "decision",
    CompanionIntent.SUMMARIZE: "companion",
    CompanionIntent.PLAN_INTERVENTION: "orchestration",
    CompanionIntent.SCHEDULE: "planning",
    CompanionIntent.SEND_NOTIFICATION: "notification",
    CompanionIntent.CREATE_QUOTE: "quotes",
    CompanionIntent.CLARIFY: "companion",
}

# Keyword triggers, checked in priority order (first match wins). Accents are
# stripped before matching, so "résume" and "resume" both hit "resume".
_TRIGGERS: tuple[tuple[CompanionIntent, tuple[str, ...]], ...] = (
    (CompanionIntent.CREATE_QUOTE, ("devis", "chiffrer", "chiffrage", "cotation", "quote")),
    (CompanionIntent.PLAN_INTERVENTION, ("intervention", "orchestr", "organise", "prepare l")),
    (CompanionIntent.SCHEDULE, ("planifie", "planning", "rendez-vous", "rdv", "creneau",
                                "programmer", "agenda", "cale ")),
    (CompanionIntent.SEND_NOTIFICATION, ("notifie", "notification", "previens", "prevenir",
                                         "avertis", "envoie", "rappel")),
    (CompanionIntent.SUMMARIZE, ("resume", "recapitule", "recap", "synthese", "ou en est")),
    (CompanionIntent.EXPLAIN, ("pourquoi", "explique", "explication", "justifie")),
    (CompanionIntent.SEARCH_KNOWLEDGE, ("comment", "procedure", "methode", "diagnostic",
                                        "que faire", "cherche", "recherche", "sais-tu",
                                        "connais")),
)


@dataclass(frozen=True)
class ResolvedIntent:
    intent: CompanionIntent
    engine: str
    is_write: bool
    verb: str  # normalized intervention verb (may be empty)
    target: str  # free-text object of the intent (may be empty)
    raw: str
    confidence: float


def _strip_accents(text: str) -> str:
    return "".join(
        c for c in unicodedata.normalize("NFD", text) if unicodedata.category(c) != "Mn"
    )


def resolve_intent(message: str) -> ResolvedIntent:
    """Classify a message into a Companion intent. Deterministic: the same
    message always resolves the same way. Never invents — an unrecognized
    message resolves to ``CLARIFY`` so the Companion asks."""
    normalized = _strip_accents(message.lower())
    parsed = interpret_intent(message)  # reuse verb/target extraction

    for intent, keywords in _TRIGGERS:
        if any(keyword in normalized for keyword in keywords):
            return _build(intent, parsed, confidence=0.9)

    # No trigger keyword, but a known intervention verb ("je remplace un
    # mitigeur") → treat as a knowledge lookup rather than a guess.
    if parsed.verb:
        return _build(CompanionIntent.SEARCH_KNOWLEDGE, parsed, confidence=0.6)

    return _build(CompanionIntent.CLARIFY, parsed, confidence=0.0)


def _build(intent: CompanionIntent, parsed, confidence: float) -> ResolvedIntent:
    return ResolvedIntent(
        intent=intent,
        engine=INTENT_ENGINE[intent],
        is_write=intent in WRITE_INTENTS,
        verb=parsed.verb,
        target=parsed.target,
        raw=parsed.raw,
        confidence=confidence,
    )
