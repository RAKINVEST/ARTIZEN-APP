"""Mission lifecycle & progress — pure, deterministic, DB-free (unit-testable).

The Mission aggregate owns its status machine and its progress. Business data
is never destroyed (Loi 5): a mission is cancelled/closed, never deleted.
"""

from typing import ClassVar

from app.mission.exceptions import InvalidMissionTransitionError

MISSION_NOUVELLE = "nouvelle"
MISSION_OUVERTE = "ouverte"
MISSION_EN_COURS = "en_cours"
MISSION_CLOTUREE = "cloturee"
MISSION_ANNULEE = "annulee"

MISSION_STATUSES: tuple[str, ...] = (
    MISSION_NOUVELLE, MISSION_OUVERTE, MISSION_EN_COURS, MISSION_CLOTUREE, MISSION_ANNULEE,
)

_TERMINAL = frozenset({MISSION_CLOTUREE, MISSION_ANNULEE})

# Forward-only lifecycle; any non-terminal state can be cancelled. Never back.
_ALLOWED: dict[str, frozenset[str]] = {
    MISSION_NOUVELLE: frozenset({MISSION_OUVERTE, MISSION_ANNULEE}),
    MISSION_OUVERTE: frozenset({MISSION_EN_COURS, MISSION_ANNULEE}),
    MISSION_EN_COURS: frozenset({MISSION_CLOTUREE, MISSION_ANNULEE}),
}


def is_terminal(status: str) -> bool:
    return status in _TERMINAL


def can_transition(current: str, target: str) -> bool:
    return target in _ALLOWED.get(current, frozenset())


def ensure_transition(current: str, target: str) -> None:
    if target not in MISSION_STATUSES:
        raise InvalidMissionTransitionError(f"Unknown mission status '{target}'.")
    if not can_transition(current, target):
        raise InvalidMissionTransitionError(
            f"Transition '{current}' -> '{target}' is not allowed."
        )


class ProgressCalculator:
    """Maps a mission status to a 0–100 progress. Deterministic."""

    _PROGRESS: ClassVar[dict[str, int]] = {
        MISSION_NOUVELLE: 0,
        MISSION_OUVERTE: 25,
        MISSION_EN_COURS: 60,
        MISSION_CLOTUREE: 100,
        MISSION_ANNULEE: 0,
    }

    @classmethod
    def progress(cls, status: str) -> int:
        return cls._PROGRESS.get(status, 0)
