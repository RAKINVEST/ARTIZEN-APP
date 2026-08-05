"""Built-in workflow definitions — the business processes the engine owns.

Definitions are process *scaffolding* declared in code (states + transitions),
not business data: they say how a process moves, never what a card/quote says.
A transition may require an explicit human validation (Loi 7/18) and may carry a
simple context condition. Pure and DB-free.
"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Transition:
    event: str
    source: str
    target: str
    #: The transition needs an explicit human action (the artisan decides).
    requires_validation: bool = False
    #: Optional context key that must be truthy for the transition to apply.
    condition: str = ""


@dataclass(frozen=True)
class WorkflowDefinition:
    slug: str
    name: str
    initial_state: str
    states: tuple[str, ...]
    transitions: tuple[Transition, ...]
    terminal_states: tuple[str, ...]


# Intervention lifecycle — the process a validated decision instantiates.
_INTERVENTION = WorkflowDefinition(
    slug="intervention",
    name="Intervention",
    initial_state="proposee",
    states=("proposee", "planifiee", "en_cours", "controle", "cloturee", "annulee"),
    transitions=(
        Transition("planifier", "proposee", "planifiee", requires_validation=True),
        Transition("demarrer", "planifiee", "en_cours"),
        Transition("controler", "en_cours", "controle"),
        Transition("cloturer", "controle", "cloturee", requires_validation=True),
        Transition("annuler", "proposee", "annulee"),
        Transition("annuler", "planifiee", "annulee"),
        Transition("annuler", "en_cours", "annulee"),
        Transition("annuler", "controle", "annulee"),
    ),
    terminal_states=("cloturee", "annulee"),
)

# Quote preparation lifecycle (distinct from the Quote object's own status
# machine — this is the *process* around it, not the quote's persisted status).
_DEVIS = WorkflowDefinition(
    slug="devis",
    name="Préparation de devis",
    initial_state="brouillon",
    states=("brouillon", "prepare", "valide", "envoye", "annule"),
    transitions=(
        Transition("preparer", "brouillon", "prepare"),
        Transition("valider", "prepare", "valide", requires_validation=True),
        Transition("envoyer", "valide", "envoye", requires_validation=True),
        Transition("annuler", "brouillon", "annule"),
        Transition("annuler", "prepare", "annule"),
        Transition("annuler", "valide", "annule"),
    ),
    terminal_states=("envoye", "annule"),
)

_DEFINITIONS: dict[str, WorkflowDefinition] = {
    d.slug: d for d in (_INTERVENTION, _DEVIS)
}


def get_definition(slug: str) -> WorkflowDefinition | None:
    return _DEFINITIONS.get(slug)


def all_definitions() -> list[WorkflowDefinition]:
    return list(_DEFINITIONS.values())
