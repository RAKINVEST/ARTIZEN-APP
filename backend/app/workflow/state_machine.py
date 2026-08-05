"""State machine, transition engine and condition evaluator — pure, DB-free.

The deterministic heart of the Workflow Engine: given a definition, a current
state and an event, decide the next state. It enforces valid transitions and
simple context conditions. It performs no IO and is fully unit-testable.
"""

from app.workflow.definitions import Transition, WorkflowDefinition
from app.workflow.exceptions import InvalidTransitionError


def find_transition(
    definition: WorkflowDefinition, state: str, event: str
) -> Transition | None:
    for transition in definition.transitions:
        if transition.source == state and transition.event == event:
            return transition
    return None


def available_events(definition: WorkflowDefinition, state: str) -> list[str]:
    return [t.event for t in definition.transitions if t.source == state]


def is_terminal(definition: WorkflowDefinition, state: str) -> bool:
    return state in definition.terminal_states


class ConditionEvaluator:
    """Evaluates a transition's optional context condition (V1: a truthy key)."""

    @staticmethod
    def is_satisfied(transition: Transition, context: dict) -> bool:
        if not transition.condition:
            return True
        return bool(context.get(transition.condition))


def apply_transition(
    definition: WorkflowDefinition, state: str, event: str, context: dict
) -> str:
    """Return the next state, or raise :class:`InvalidTransitionError`.

    Deterministic: same (definition, state, event, context) -> same result."""
    if is_terminal(definition, state):
        raise InvalidTransitionError(
            f"Workflow is in terminal state '{state}'; no transition '{event}' is possible."
        )
    transition = find_transition(definition, state, event)
    if transition is None:
        raise InvalidTransitionError(
            f"Transition '{event}' is not allowed from state '{state}'."
        )
    if not ConditionEvaluator.is_satisfied(transition, context):
        raise InvalidTransitionError(
            f"Condition '{transition.condition}' for '{event}' is not satisfied."
        )
    return transition.target
