"""Release process — the official lifecycle of a piece of knowledge.

Brouillon → Relecture → Validation → Publication → Archivage. Append-only: each
transition **adds** a history row, never rewrites the past. Publication is gated —
a card with any blocking issue (Phase 3) cannot be published. Pure text
transform: it returns the new Markdown, it does not write files.
"""

import re
from dataclasses import dataclass

from app.knowledge_factory.quality import Issue, blocking_issues

# Editorial stages, in order.
STAGES: tuple[str, ...] = ("brouillon", "relecture", "validation", "publication", "archivage")

# Forward-only transitions (append-only lifecycle; nothing ever returns to draft).
_ALLOWED: dict[str, tuple[str, ...]] = {
    "brouillon": ("relecture",),
    "relecture": ("validation", "brouillon"),  # a review can send back for rework
    "validation": ("publication", "relecture"),
    "publication": ("archivage",),
    "archivage": (),
}

# Stage → the corpus's 3-value Statut field.
_STATUT_BY_STAGE: dict[str, str] = {
    "brouillon": "Brouillon", "relecture": "Brouillon", "validation": "Brouillon",
    "publication": "Validé", "archivage": "Archivé",
}

_STATUT_ROW_RE = re.compile(r"^(\|\s*Statut\s*\|\s*).*?(\s*\|)\s*$", re.MULTILINE)


class ReleaseError(Exception):
    """Illegal transition or a publication blocked by the quality gate."""


@dataclass(frozen=True)
class Transition:
    from_stage: str
    to_stage: str
    actor: str
    date: str


def can_transition(from_stage: str, to_stage: str) -> bool:
    return to_stage in _ALLOWED.get(from_stage, ())


def transition(
    text: str, *, from_stage: str, to_stage: str, actor: str, date: str,
    issues: list[Issue] | None = None,
) -> str:
    """Return the card text after a validated transition. Raises on an illegal
    move or a gate-blocked publication. Never mutates in place."""
    if from_stage not in STAGES or to_stage not in STAGES:
        raise ReleaseError(f"Étape inconnue : {from_stage!r} → {to_stage!r}.")
    if not can_transition(from_stage, to_stage):
        raise ReleaseError(f"Transition interdite : {from_stage} → {to_stage}.")
    if to_stage == "publication":
        blockers = blocking_issues(issues or [])
        if blockers:
            raise ReleaseError(
                f"Publication refusée — {len(blockers)} problème(s) bloquant(s) à corriger."
            )

    updated = _STATUT_ROW_RE.sub(rf"\1{_STATUT_BY_STAGE[to_stage]}\2", text)
    return _append_history(updated, to_stage=to_stage, actor=actor, date=date)


def _append_history(text: str, *, to_stage: str, actor: str, date: str) -> str:
    """Append one row to the ``## Historique`` table (append-only)."""
    row = f"| — | {date} | {actor} | {actor if to_stage == 'publication' else '⟦—⟧'} | passage → {to_stage} |"
    lines = text.rstrip("\n").splitlines()
    # Find the last markdown table row (the history table sits at the end).
    insert_at = len(lines)
    for i in range(len(lines) - 1, -1, -1):
        if lines[i].lstrip().startswith("|"):
            insert_at = i + 1
            break
    lines.insert(insert_at, row)
    return "\n".join(lines) + "\n"


__all__ = ["STAGES", "ReleaseError", "Transition", "can_transition", "transition"]
