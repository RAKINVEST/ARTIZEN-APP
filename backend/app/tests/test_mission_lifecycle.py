"""Pure unit tests for the Mission Engine core (no DB, no HTTP).

Pin the lifecycle, progress, timeline and attachments — runnable locally
(``pytest --noconftest app/tests/test_mission_lifecycle.py``).
"""

import pytest

from app.mission.attachments import AttachmentManager
from app.mission.exceptions import InvalidMissionTransitionError, MissionError
from app.mission.lifecycle import (
    ProgressCalculator,
    can_transition,
    ensure_transition,
    is_terminal,
)
from app.mission.timeline import TimelineManager


def test_valid_and_invalid_transitions() -> None:
    assert can_transition("nouvelle", "ouverte")
    assert can_transition("en_cours", "cloturee")
    assert not can_transition("nouvelle", "cloturee")  # can't skip
    assert not can_transition("cloturee", "annulee")  # terminal
    ensure_transition("ouverte", "en_cours")  # no raise
    with pytest.raises(InvalidMissionTransitionError):
        ensure_transition("nouvelle", "cloturee")
    with pytest.raises(InvalidMissionTransitionError):
        ensure_transition("cloturee", "ouverte")


def test_is_terminal() -> None:
    assert is_terminal("cloturee")
    assert is_terminal("annulee")
    assert not is_terminal("en_cours")


def test_progress_calculator_full_lifecycle() -> None:
    assert ProgressCalculator.progress("nouvelle") == 0
    assert ProgressCalculator.progress("ouverte") == 25
    assert ProgressCalculator.progress("en_cours") == 60
    assert ProgressCalculator.progress("cloturee") == 100
    assert ProgressCalculator.progress("annulee") == 0


def test_timeline_records_events() -> None:
    timeline: list[dict] = []
    entry = TimelineManager.record(timeline, event="created", actor="a", detail="d")
    assert timeline == [entry]
    assert entry["event"] == "created"
    assert entry["actor"] == "a"
    assert entry["at"]  # timestamped


def test_attachment_manager_builds_and_validates() -> None:
    photo = AttachmentManager.build("photo", label="Avant", reference="storage://k")
    assert photo["kind"] == "photo"
    note = AttachmentManager.build("note", text="RAS")
    assert note["kind"] == "note"

    with pytest.raises(MissionError):
        AttachmentManager.build("gadget")  # unknown kind
    with pytest.raises(MissionError):
        AttachmentManager.build("note", text="   ")  # note needs text
    with pytest.raises(MissionError):
        AttachmentManager.build("document")  # document needs a reference


def test_attachment_add_appends() -> None:
    attachments: list[dict] = []
    entry = AttachmentManager.build("note", text="ok")
    AttachmentManager.add(attachments, entry)
    assert attachments == [entry]
