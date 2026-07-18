"""Mandatory-information-driven questioning (Blueprint §5.3, adjustment #2).

There is no fixed cap on questions. The engine asks as long as a *mandatory*
slot of a recognized prestation is still missing, and stops the moment none
remain. Which slots are mandatory for which prestation type is DATA, not code
(``required_slots``), so a new trade is a new mapping, not a new branch.

This module is pure: given the current prestations, it returns the next
question to ask (the most blocking missing slot) or ``None`` (nothing left to
ask). Applying an answer, counting questions, and the anti-loop breaker are the
orchestrator's job — this only decides *what* to ask next.
"""

from app.voice_quote.schemas import ClarificationQuestion, ServiceRequest

# MVP scope: residential air conditioning (adjustment #3). Only the slots
# without which a line cannot be trusted are here — comfort/variant choices are
# optional and never trigger a question (they are proposed on screen).
_MVP_REQUIRED_SLOTS: dict[str, list[str]] = {
    "ac_install": ["unit_type", "outdoor_unit"],
}

# How each slot is asked, and (optionally) its allowed answers. Kept beside the
# slot list so adding a slot means adding one entry, not editing the engine.
_SLOT_PROMPTS: dict[str, tuple[str, list[str]]] = {
    "unit_type": ("Quel type d'unité : mono-split ou multi-split ?", ["mono-split", "multi-split"]),
    "outdoor_unit": ("Faut-il installer l'unité extérieure ?", ["oui", "non"]),
}


class MandatoryInfoQuestionStrategy:
    def __init__(self, required_slots: dict[str, list[str]] | None = None) -> None:
        self._required_slots = required_slots if required_slots is not None else _MVP_REQUIRED_SLOTS

    def _missing_slots(self, service: ServiceRequest) -> list[str]:
        required = self._required_slots.get(service.service_type, [])
        return [slot for slot in required if not service.attributes.get(slot)]

    def next_question(self, services: list[ServiceRequest]) -> ClarificationQuestion | None:
        """The most blocking unresolved mandatory slot across all prestations,
        as a question — or ``None`` when every mandatory slot is filled.

        "Most blocking" = first missing slot of the first prestation that has
        one, in order: a stable, explainable choice, and one question at a time
        (Blueprint §7)."""
        for index, service in enumerate(services):
            for slot in self._missing_slots(service):
                prompt, options = _SLOT_PROMPTS.get(
                    slot, (f"Pouvez-vous préciser : {slot} ?", [])
                )
                return ClarificationQuestion(
                    type="slot",
                    prompt_text=prompt,
                    target_service_index=index,
                    slot=slot,
                    options=options,
                )
        return None

    def has_unresolved(self, services: list[ServiceRequest]) -> bool:
        return self.next_question(services) is not None
