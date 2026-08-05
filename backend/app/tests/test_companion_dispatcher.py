"""Pure unit tests for the Companion Tool Dispatcher's proposal logic (no DB).

``propose`` only compares provided slots against each tool's required parameters
— it touches no engine — so it is fully unit-testable. Execution (which calls the
owning engines) is covered by the API tests. Run with ``pytest --noconftest``.
"""

import uuid

from app.ai_companion.dispatcher import ToolDispatcher
from app.ai_companion.intents import CompanionIntent, resolve_intent


def _dispatcher():
    # Services are unused by propose()/is_executable(); pass None.
    return ToolDispatcher(
        orchestration=None, planning=None, notification=None, quotes=None,
        company_id=uuid.uuid4(), actor="tester",
    )


def test_plan_intervention_missing_customer():
    action = _dispatcher().propose(resolve_intent("planifie une intervention"), {})
    assert action.tool == "plan_intervention"
    assert action.engine == "orchestration"
    assert action.missing == ["customer_id"]
    assert action.ready is False


def test_plan_intervention_ready_with_customer():
    action = _dispatcher().propose(
        resolve_intent("planifie une intervention"), {"customer_id": "abc", "title": "X"}
    )
    assert action.ready is True
    assert action.missing == []


def test_schedule_requires_start_and_duration():
    action = _dispatcher().propose(resolve_intent("réserve un créneau"), {"artisan": "alice"})
    assert set(action.missing) == {"start_at", "duration_minutes"}


def test_notification_requires_recipient():
    action = _dispatcher().propose(resolve_intent("préviens le client"), {})
    assert action.missing == ["recipient"]


def test_create_quote_requires_client_and_lines():
    action = _dispatcher().propose(resolve_intent("fais un devis"), {"client_id": "c"})
    assert action.missing == ["lines"]


def test_quote_is_not_executable_by_the_ai():
    # Invariant #1 — the Companion never creates a quote itself.
    assert ToolDispatcher.is_executable(CompanionIntent.CREATE_QUOTE.value) is False
    assert ToolDispatcher.is_executable(CompanionIntent.PLAN_INTERVENTION.value) is True
    assert ToolDispatcher.is_executable(CompanionIntent.SCHEDULE.value) is True
    assert ToolDispatcher.is_executable(CompanionIntent.SEND_NOTIFICATION.value) is True
