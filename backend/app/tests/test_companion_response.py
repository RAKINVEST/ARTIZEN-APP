"""Pure unit tests for the Companion Response Composer (no DB, no HTTP).

Every reply is explainable by construction and deterministic. These pin the
message + explanation for each branch (read answer, missing params, ready action,
clarify, executed, quote handoff). Run with ``pytest --noconftest``.
"""

from app.ai_companion.intents import CompanionIntent, resolve_intent
from app.ai_companion.reasoning import ReasoningResult
from app.ai_companion.response_builder import ResponseComposer
from app.ai_companion.schemas import ProposedAction, SourceRef


def _reasoning(**kw):
    return ReasoningResult(engine=kw.pop("engine", "knowledge"), **kw)


def test_answer_lists_knowledge_and_marks_no_persistence():
    reasoning = _reasoning(
        elements=[{"slug": "s1", "type": "card", "title": "Purge", "reason": "r"}],
        sources=[SourceRef(kind="knowledge", ref="s1", title="Purge")],
        confidence=0.8,
    )
    resp = ResponseComposer.compose(
        session_id="s", resolved=resolve_intent("comment purger"), reasoning=reasoning
    )
    assert resp.needs_confirmation is False
    assert "Purge" in resp.message
    assert resp.explanation.confidence == 0.8
    assert resp.explanation.knowledge_used == []  # supplied via reasoning only when set
    assert resp.sources[0].ref == "s1"


def test_ready_action_requests_confirmation():
    action = ProposedAction(tool="plan_intervention", engine="orchestration",
                            description="planifier une intervention", params={"customer_id": "c"})
    resp = ResponseComposer.compose(
        session_id="s", resolved=resolve_intent("planifie une intervention"),
        reasoning=_reasoning(), proposed_action=action,
    )
    assert resp.needs_confirmation is True
    assert resp.explanation.needs_confirmation is True
    assert "Confirmez" in resp.message


def test_missing_params_asks_and_does_not_confirm():
    action = ProposedAction(tool="plan_intervention", engine="orchestration",
                            description="planifier une intervention", missing=["customer_id"])
    resp = ResponseComposer.compose(
        session_id="s", resolved=resolve_intent("planifie une intervention"),
        reasoning=_reasoning(), proposed_action=action,
    )
    assert resp.needs_confirmation is False
    assert resp.questions
    assert "client" in resp.message


def test_clarify_asks():
    resp = ResponseComposer.compose(
        session_id="s", resolved=resolve_intent("bonjour"), reasoning=_reasoning(),
    )
    assert resp.intent == CompanionIntent.CLARIFY.value
    assert resp.questions


def test_after_execution_reports_done():
    action = ProposedAction(tool="plan_intervention", engine="orchestration", description="x")
    resp = ResponseComposer.after_execution(
        session_id="s", action=action, executed=True, result={"status": "reussi"}
    )
    assert resp.executed is True
    assert "fait" in resp.message.lower()


def test_after_execution_quote_is_handoff_not_created():
    action = ProposedAction(tool="create_quote", engine="quotes", description="préparer un devis")
    resp = ResponseComposer.after_execution(
        session_id="s", action=action, executed=False,
        result={"handoff": "POST /api/quotes"},
    )
    # The AI never created it — the message hands it back to the artisan.
    assert resp.executed is False
    assert "Devis" in resp.message
    assert "valider" in resp.message.lower() or "validez" in resp.message.lower()
