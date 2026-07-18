"""Centralized error handling for pipeline steps.

Every step runs through one wrapper (see ``orchestrator._run_step``). When a
step raises, its exception is classified here into a ``StepFailure`` — a normal
value, not an exception — carrying a stable ``error_code``, a human message,
and whether it is worth retrying. The orchestrator then makes ONE decision:
move to ``FAILED``, keep the draft built so far, emit ``STEP_FAILED``. No step
invents its own failure handling, and a failure never tears down the
conversation (Blueprint §9: each step can fail without losing the previous
ones).

``recoverable`` distinguishes "the upstream vendor blinked, try again"
(provider unavailable, timeout) from "this input/logic can't succeed as-is"
(everything else) — which the UI turns into *retry* vs *switch to manual*.
"""

from dataclasses import dataclass

from app.ai.exceptions import AIProviderUnavailableError


@dataclass(frozen=True)
class StepFailure:
    step: str
    error_code: str
    message: str
    recoverable: bool


def classify(step: str, exc: BaseException) -> StepFailure:
    """Map a raised exception to a normalized, provider-agnostic failure.

    Only exception *types* are inspected, never their text, so this stays
    stable across provider SDKs — the ``ai/`` layer already collapses every
    vendor error into ``AIProviderUnavailableError`` upstream of here."""
    if isinstance(exc, AIProviderUnavailableError):
        return StepFailure(
            step=step,
            error_code="provider_unavailable",
            message="Le service IA est momentanément indisponible. Réessayez.",
            recoverable=True,
        )
    if isinstance(exc, TimeoutError):
        return StepFailure(
            step=step,
            error_code="timeout",
            message="Le traitement a expiré. Réessayez.",
            recoverable=True,
        )
    return StepFailure(
        step=step,
        error_code="step_error",
        message="Une erreur est survenue pendant le traitement vocal.",
        recoverable=False,
    )
