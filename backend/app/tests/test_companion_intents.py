"""Pure unit tests for the Companion intent resolver (no DB, no HTTP).

Deterministic classification of a message into a Companion intent + owning
engine, and the read/write split that drives whether a human validation is
required. Run with ``pytest --noconftest``.
"""

import pytest

from app.ai_companion.intents import (
    WRITE_INTENTS,
    CompanionIntent,
    resolve_intent,
)


@pytest.mark.parametrize(
    ("message", "expected"),
    [
        ("Je voudrais un devis pour ce client", CompanionIntent.CREATE_QUOTE),
        ("Planifie une intervention demain", CompanionIntent.PLAN_INTERVENTION),
        ("Réserve un créneau au planning", CompanionIntent.SCHEDULE),
        ("Préviens le client par email", CompanionIntent.SEND_NOTIFICATION),
        ("Résume la situation", CompanionIntent.SUMMARIZE),
        ("Pourquoi cette proposition ?", CompanionIntent.EXPLAIN),
        ("Comment remplacer un chauffe-eau ?", CompanionIntent.SEARCH_KNOWLEDGE),
    ],
)
def test_resolves_expected_intent(message, expected):
    assert resolve_intent(message).intent == expected


def test_known_verb_without_keyword_is_knowledge():
    # "je remplace un mitigeur" — an intervention verb, no command keyword.
    resolved = resolve_intent("je remplace un mitigeur")
    assert resolved.intent == CompanionIntent.SEARCH_KNOWLEDGE
    assert resolved.verb == "remplacer"
    assert "mitigeur" in resolved.target


def test_unrecognized_message_asks_rather_than_guesses():
    resolved = resolve_intent("bonjour")
    assert resolved.intent == CompanionIntent.CLARIFY
    assert resolved.confidence == 0.0
    assert resolved.is_write is False


def test_write_intents_are_flagged_write():
    for message in ("fais un devis", "planifie une intervention", "notifie le client"):
        assert resolve_intent(message).is_write is True


def test_read_intents_are_not_write():
    for message in ("comment faire", "résume", "pourquoi"):
        assert resolve_intent(message).is_write is False


def test_engine_routing_matches_intent():
    assert resolve_intent("fais un devis").engine == "quotes"
    assert resolve_intent("planifie une intervention").engine == "orchestration"
    assert resolve_intent("préviens le client").engine == "notification"
    assert resolve_intent("comment faire").engine == "knowledge"


def test_accent_insensitive():
    assert resolve_intent("resume").intent == CompanionIntent.SUMMARIZE
    assert resolve_intent("Résumé de la journée").intent == CompanionIntent.SUMMARIZE


def test_deterministic():
    a = resolve_intent("planifie une intervention")
    b = resolve_intent("planifie une intervention")
    assert (a.intent, a.engine, a.is_write) == (b.intent, b.engine, b.is_write)


def test_all_write_intents_declared():
    assert CompanionIntent.CREATE_QUOTE in WRITE_INTENTS
    assert CompanionIntent.SEARCH_KNOWLEDGE not in WRITE_INTENTS
