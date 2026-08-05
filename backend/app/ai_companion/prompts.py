"""Prompt Orchestrator — assembles the LLM prompt from engine-sourced context.

Wired to the ``AIProvider`` abstraction so a real LLM can phrase the Companion's
replies later with no caller change. In V1 the responses are composed
deterministically from engine outputs (offline, testable) — the same
"deterministic path always available, AI enriches later behind the same
contract" pattern as the Decision Engine. The prompt never carries an
instruction to invent facts or amounts: the substance always comes from engines.
"""

from app.ai.schemas import AIMessage
from app.ai_companion.context import CompanionContext
from app.ai_companion.intents import ResolvedIntent
from app.ai_companion.reasoning import ReasoningResult

_SYSTEM = (
    "Tu es Artizen, l'assistant de l'artisan du bâtiment. Tu ne décides jamais "
    "seul : tu t'appuies uniquement sur les moteurs de l'application (savoir-faire, "
    "décision, planning, interventions, notifications, devis). Tu proposes, "
    "l'artisan décide. Toute action ayant un impact (planifier, notifier, créer un "
    "devis) demande une validation explicite. Tu n'inventes ni prix, ni montant, ni "
    "information : si tu ne sais pas, tu demandes. Réponds en français, avec des mots "
    "simples, sans jargon technique."
)


class PromptOrchestrator:
    @staticmethod
    def system_prompt() -> str:
        return _SYSTEM

    @staticmethod
    def build_messages(
        context: CompanionContext, resolved: ResolvedIntent, reasoning: ReasoningResult
    ) -> list[AIMessage]:
        found = ", ".join(e["title"] for e in reasoning.elements) or "aucun"
        user = (
            f"Demande de l'artisan : {resolved.raw}\n"
            f"Intention comprise : {resolved.intent.value}\n"
            f"Contexte : {context.brief()}\n"
            f"Éléments issus des moteurs : {found}"
        )
        return [
            AIMessage(role="system", content=_SYSTEM),
            AIMessage(role="user", content=user),
        ]
