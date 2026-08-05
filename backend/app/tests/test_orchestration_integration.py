"""Pure unit tests for Orchestration → Planning + Notification wiring (no DB).

Exercise the two integration steps of the intervention plan and their executor
branches with fake engine services, so the coordination logic (schedule when a
slot is given, best-effort notify, transactional-vs-best-effort semantics,
compensation) is pinned locally. Run with ``pytest --noconftest``.
"""

import asyncio
import uuid
from types import SimpleNamespace

import pytest

from app.orchestration.exceptions import StepExecutionError
from app.orchestration.executors import EngineExecutors
from app.orchestration.plan import ExecutionStep, build_plan
from app.planning.exceptions import PlanningConflictError

_COMPANY = uuid.uuid4()
_MISSION_ID = str(uuid.uuid4())
_ENTRY_ID = uuid.uuid4()


class _FakePlanning:
    def __init__(self, *, conflict: bool = False) -> None:
        self.created: list = []
        self.cancelled: list = []
        self._conflict = conflict

    async def create(self, *, company_id, actor, data):
        if self._conflict:
            raise PlanningConflictError("artisan indisponible")
        self.created.append(data)
        return SimpleNamespace(id=_ENTRY_ID)

    async def cancel(self, *, entry_id, actor):
        self.cancelled.append(entry_id)
        return SimpleNamespace(id=entry_id)


class _FakeNotifications:
    def __init__(self, *, status: str = "sent") -> None:
        self.sent: list = []
        self._status = status

    async def notify(self, *, company_id, actor, channel, recipient, template_key="",
                     context=None, related_type="", related_id="", subject="", body=""):
        self.sent.append(
            {"recipient": recipient, "template_key": template_key, "related_id": related_id}
        )
        return SimpleNamespace(id=uuid.uuid4(), status=self._status)


def _executors(planning, notifications) -> EngineExecutors:
    return EngineExecutors(
        None, None, planning, notifications, company_id=_COMPANY, actor="tester"
    )


def _step(action: str) -> ExecutionStep:
    return ExecutionStep(id=action, engine="x", action=action)


def _results_with_mission() -> dict:
    return {"create_mission": {"mission_id": _MISSION_ID}}


# --- plan shape -------------------------------------------------------------

def test_intervention_plan_now_coordinates_four_engines() -> None:
    steps = build_plan("intervention").steps
    assert [s.id for s in steps] == [
        "create_mission", "start_workflow", "associate_workflow",
        "schedule_mission", "notify_customer",
    ]
    engines = {s.id: s.engine for s in steps}
    assert engines["schedule_mission"] == "planning"
    assert engines["notify_customer"] == "notification"


# --- schedule_mission -------------------------------------------------------

def test_schedule_mission_creates_entry_when_slot_given() -> None:
    planning = _FakePlanning()
    context = {"start_at": "2026-06-15T09:00:00+00:00", "duration_minutes": 120, "artisan": "alice"}
    out = asyncio.run(
        _executors(planning, _FakeNotifications()).execute(
            _step("schedule_mission"), context, _results_with_mission()
        )
    )
    assert out["scheduled"] is True
    assert out["planning_entry_id"] == str(_ENTRY_ID)
    assert len(planning.created) == 1


def test_schedule_mission_is_noop_without_slot() -> None:
    planning = _FakePlanning()
    out = asyncio.run(
        _executors(planning, _FakeNotifications()).execute(
            _step("schedule_mission"), {}, _results_with_mission()
        )
    )
    assert out == {"scheduled": False, "reason": "no_schedule_requested"}
    assert planning.created == []  # engine untouched


def test_schedule_conflict_is_non_retryable_failure() -> None:
    planning = _FakePlanning(conflict=True)
    context = {"start_at": "2026-06-15T09:00:00+00:00", "duration_minutes": 120}
    with pytest.raises(StepExecutionError) as excinfo:
        asyncio.run(
            _executors(planning, _FakeNotifications()).execute(
                _step("schedule_mission"), context, _results_with_mission()
            )
        )
    assert excinfo.value.retryable is False  # a real conflict rolls the saga back


def test_compensate_schedule_cancels_entry_never_deletes() -> None:
    planning = _FakePlanning()
    results = {"schedule_mission": {"scheduled": True, "planning_entry_id": str(_ENTRY_ID)}}
    asyncio.run(
        _executors(planning, _FakeNotifications()).compensate(
            _step("schedule_mission"), {}, results
        )
    )
    assert planning.cancelled == [_ENTRY_ID]  # Loi 5: cancel, not delete


# --- notify_customer --------------------------------------------------------

def test_notify_customer_sends_when_recipient_given() -> None:
    notifications = _FakeNotifications()
    context = {"recipient": "client@example.com", "title": "Chaudière", "start_at": "12/03"}
    out = asyncio.run(
        _executors(_FakePlanning(), notifications).execute(
            _step("notify_customer"), context, _results_with_mission()
        )
    )
    assert out["notified"] is True
    assert out["status"] == "sent"
    assert notifications.sent[0]["template_key"] == "mission_scheduled"
    assert notifications.sent[0]["related_id"] == _MISSION_ID


def test_notify_customer_is_noop_without_recipient() -> None:
    notifications = _FakeNotifications()
    out = asyncio.run(
        _executors(_FakePlanning(), notifications).execute(
            _step("notify_customer"), {}, _results_with_mission()
        )
    )
    assert out == {"notified": False, "reason": "no_recipient"}
    assert notifications.sent == []


def test_notify_customer_failed_send_does_not_raise() -> None:
    # A failed dispatch is recorded (status=failed), never fails the saga.
    notifications = _FakeNotifications(status="failed")
    context = {"recipient": "client@example.com"}
    out = asyncio.run(
        _executors(_FakePlanning(), notifications).execute(
            _step("notify_customer"), context, _results_with_mission()
        )
    )
    assert out["notified"] is True
    assert out["status"] == "failed"
