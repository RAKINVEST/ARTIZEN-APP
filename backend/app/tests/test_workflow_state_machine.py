"""Pure unit tests for the Workflow Engine state machine (no DB, no HTTP).

Pin the deterministic core — definitions, transitions, conditions, terminal
states — runnable locally
(``pytest --noconftest app/tests/test_workflow_state_machine.py``).
"""

import pytest

from app.workflow.definitions import (
    Transition,
    WorkflowDefinition,
    all_definitions,
    get_definition,
)
from app.workflow.exceptions import InvalidTransitionError
from app.workflow.state_machine import (
    ConditionEvaluator,
    apply_transition,
    available_events,
    is_terminal,
)


def test_builtin_definitions_registered() -> None:
    assert get_definition("intervention") is not None
    assert get_definition("devis") is not None
    assert get_definition("nope") is None
    assert len(all_definitions()) >= 2


def test_valid_transition_advances_state() -> None:
    intervention = get_definition("intervention")
    assert apply_transition(intervention, "proposee", "planifier", {}) == "planifiee"


def test_invalid_transition_raises() -> None:
    intervention = get_definition("intervention")
    with pytest.raises(InvalidTransitionError):
        apply_transition(intervention, "proposee", "demarrer", {})


def test_terminal_state_blocks_transitions() -> None:
    intervention = get_definition("intervention")
    assert is_terminal(intervention, "cloturee")
    with pytest.raises(InvalidTransitionError):
        apply_transition(intervention, "cloturee", "annuler", {})


def test_available_events() -> None:
    intervention = get_definition("intervention")
    assert set(available_events(intervention, "proposee")) == {"planifier", "annuler"}
    assert available_events(intervention, "cloturee") == []


def test_condition_evaluator_guards_transition() -> None:
    definition = WorkflowDefinition(
        slug="t", name="T", initial_state="a", states=("a", "b"),
        transitions=(Transition("go", "a", "b", condition="ready"),),
        terminal_states=("b",),
    )
    assert ConditionEvaluator.is_satisfied(definition.transitions[0], {"ready": True})
    assert apply_transition(definition, "a", "go", {"ready": True}) == "b"
    with pytest.raises(InvalidTransitionError):
        apply_transition(definition, "a", "go", {})  # condition not met


def test_full_happy_path_is_deterministic() -> None:
    intervention = get_definition("intervention")
    state = intervention.initial_state
    for event in ("planifier", "demarrer", "controler", "cloturer"):
        state = apply_transition(intervention, state, event, {})
    assert state == "cloturee"
    assert is_terminal(intervention, state)
    # Determinism: replay yields the same terminal state.
    replay = "proposee"
    for event in ("planifier", "demarrer", "controler", "cloturer"):
        replay = apply_transition(intervention, replay, event, {})
    assert replay == state
