"""The conversation state machine (Blueprint §4).

Explicit, like ``QUOTE_TRANSITIONS`` in ``quotes/models.py``: the set of
states a conversation can be in, and the *only* moves allowed between them.
Any move not in ``VOICE_TRANSITIONS`` raises ``InvalidTransition`` — an
orchestration bug, caught loudly, never a silent wrong turn.

The shape mirrors the quote lifecycle deliberately: a ``dict`` of allowed
targets, an empty set meaning "terminal". The invariants that matter:

- ``CREATED`` is terminal and reachable ONLY through ``CONFIRMING`` — there is
  no ``DRAFTING -> CREATED`` edge, so a draft can never turn into a created
  quote without the explicit confirm step (CLAUDE.md: no quote without an
  explicit gesture).
- ``FAILED`` never loses work: it is reachable from the processing states and
  leads back to ``LISTENING`` (retry) or ``MANUAL_FALLBACK`` — the draft built
  so far is kept either way.
- ``CLARIFYING -> LISTENING`` is the dialogue loop (ask a question, listen for
  the answer); ``REVIEWING -> LISTENING`` is conversational revision
  (Blueprint §7.1, adjustment #4).
"""

import enum


class ConversationState(str, enum.Enum):
    IDLE = "idle"
    LISTENING = "listening"
    TRANSCRIBING = "transcribing"
    UNDERSTANDING = "understanding"
    CLARIFYING = "clarifying"
    DRAFTING = "drafting"
    REVIEWING = "reviewing"
    CONFIRMING = "confirming"
    CREATED = "created"
    FAILED = "failed"
    MANUAL_FALLBACK = "manual_fallback"
    ABANDONED = "abandoned"


_S = ConversationState

#: Allowed target states from each state. Absent/empty frozenset = terminal.
VOICE_TRANSITIONS: dict[ConversationState, frozenset[ConversationState]] = {
    _S.IDLE: frozenset({_S.LISTENING}),
    _S.LISTENING: frozenset({_S.TRANSCRIBING, _S.ABANDONED}),
    _S.TRANSCRIBING: frozenset({_S.UNDERSTANDING, _S.FAILED}),
    _S.UNDERSTANDING: frozenset({_S.CLARIFYING, _S.DRAFTING, _S.FAILED}),
    _S.CLARIFYING: frozenset({_S.LISTENING, _S.DRAFTING, _S.FAILED}),
    _S.DRAFTING: frozenset({_S.REVIEWING, _S.FAILED}),
    _S.REVIEWING: frozenset({_S.LISTENING, _S.CONFIRMING, _S.ABANDONED}),
    _S.CONFIRMING: frozenset({_S.CREATED, _S.REVIEWING}),
    _S.FAILED: frozenset({_S.LISTENING, _S.MANUAL_FALLBACK, _S.ABANDONED}),
    _S.CREATED: frozenset(),
    _S.ABANDONED: frozenset(),
    _S.MANUAL_FALLBACK: frozenset(),
}

#: States from which nothing more happens — the conversation is over.
TERMINAL_STATES: frozenset[ConversationState] = frozenset(
    state for state, targets in VOICE_TRANSITIONS.items() if not targets
)


class InvalidTransition(Exception):
    """Raised on an attempt to move between two states no edge connects."""

    def __init__(self, source: ConversationState, target: ConversationState) -> None:
        super().__init__(f"Illegal conversation transition: {source.value} -> {target.value}")
        self.source = source
        self.target = target


def can_transition(source: ConversationState, target: ConversationState) -> bool:
    return target in VOICE_TRANSITIONS.get(source, frozenset())
