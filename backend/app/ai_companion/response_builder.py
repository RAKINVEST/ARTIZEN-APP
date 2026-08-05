"""Response Composer — turns engine outputs into an explainable reply.

Deterministic: the message and its explanation are built from the resolved
intent, the reasoning result and the proposed action — never from a free-form
model guess. Every reply carries *why*, *which engine*, *which knowledge*,
*what confidence*, and whether a human validation is required (no black box).
"""

from app.ai_companion.intents import INTENT_ENGINE, CompanionIntent, ResolvedIntent
from app.ai_companion.reasoning import ReasoningResult
from app.ai_companion.schemas import ChatResponse, Explanation, ProposedAction

_MISSING_LABELS = {
    "customer_id": "le client",
    "client_id": "le client",
    "lines": "les lignes (articles du catalogue)",
    "start_at": "la date et l'heure",
    "duration_minutes": "la durée",
    "recipient": "le destinataire",
}


class ResponseComposer:
    @staticmethod
    def compose(
        *,
        session_id: str,
        resolved: ResolvedIntent,
        reasoning: ReasoningResult,
        proposed_action: ProposedAction | None = None,
        executed: bool = False,
        result: dict | None = None,
    ) -> ChatResponse:
        questions: list[str] = []
        needs_confirmation = False
        message = ""

        if executed:
            message = ResponseComposer._executed_message(resolved, result)
        elif proposed_action is not None:
            if proposed_action.missing:
                needs = ", ".join(
                    _MISSING_LABELS.get(m, m) for m in proposed_action.missing
                )
                message = (
                    f"Pour {proposed_action.description}, il me manque : {needs}. "
                    "Rien ne sera fait sans votre validation."
                )
                questions = [f"Pouvez-vous préciser {needs} ?"]
            else:
                needs_confirmation = True
                message = (
                    f"Je peux {proposed_action.description}. "
                    "Confirmez et je m'en occupe — sinon rien n'est fait."
                )
        elif resolved.intent == CompanionIntent.CLARIFY:
            questions = reasoning.questions or [
                "Que souhaitez-vous faire ? (rechercher un savoir-faire, planifier, préparer un devis…)"
            ]
            message = "Je ne suis pas sûr de comprendre — pouvez-vous préciser ?"
        elif reasoning.elements:
            titles = ", ".join(e["title"] for e in reasoning.elements[:5])
            message = (
                f"Voici ce que je trouve dans le savoir-faire : {titles}. "
                "Rien n'est enregistré — à vous de décider."
            )
        else:
            questions = reasoning.questions
            message = (
                "Je n'ai pas trouvé de savoir-faire correspondant. "
                "Pouvez-vous reformuler ou préciser ?"
            )

        explanation = Explanation(
            why=ResponseComposer._why(resolved, reasoning, proposed_action, executed),
            engine=reasoning.engine if reasoning.engine != "companion" else resolved.engine,
            knowledge_used=reasoning.knowledge_slugs,
            confidence=reasoning.confidence,
            needs_confirmation=needs_confirmation,
        )
        return ChatResponse(
            session_id=session_id,
            intent=resolved.intent.value,
            message=message,
            explanation=explanation,
            sources=reasoning.sources,
            proposed_action=proposed_action,
            needs_confirmation=needs_confirmation,
            questions=questions,
            executed=executed,
            result=result,
        )

    @staticmethod
    def after_execution(
        *, session_id: str, action: ProposedAction, executed: bool, result: dict | None
    ) -> ChatResponse:
        """Response for a confirmed action. For a quote, ``executed`` is False —
        the payload was handed back for the artisan's own POST /quotes."""
        intent = CompanionIntent(action.tool)
        resolved_like = ResolvedIntent(
            intent=intent, engine=action.engine, is_write=True,
            verb="", target="", raw="", confidence=1.0,
        )
        return ChatResponse(
            session_id=session_id,
            intent=action.tool,
            message=ResponseComposer._executed_message(resolved_like, result),
            explanation=Explanation(
                why=(
                    f"Action « {action.tool} » traitée via le moteur {action.engine} "
                    "après votre validation."
                ),
                engine=INTENT_ENGINE.get(intent, action.engine),
                confidence=1.0,
                needs_confirmation=False,
            ),
            proposed_action=None,
            needs_confirmation=False,
            executed=executed,
            result=result,
        )

    @staticmethod
    def _executed_message(resolved: ResolvedIntent, result: dict | None) -> str:
        result = result or {}
        if resolved.intent == CompanionIntent.CREATE_QUOTE:
            return (
                "Votre devis est prêt. Il n'est pas encore enregistré : validez-le sur "
                "l'écran Devis pour le créer (c'est votre geste, pas le mien)."
            )
        if resolved.intent == CompanionIntent.PLAN_INTERVENTION:
            return f"C'est fait — intervention coordonnée (statut : {result.get('status', 'ok')})."
        if resolved.intent == CompanionIntent.SCHEDULE:
            return "C'est fait — le créneau est réservé au planning."
        if resolved.intent == CompanionIntent.SEND_NOTIFICATION:
            return f"C'est fait — notification {result.get('status', 'envoyée')}."
        return "C'est fait."

    @staticmethod
    def _why(
        resolved: ResolvedIntent,
        reasoning: ReasoningResult,
        proposed_action: ProposedAction | None,
        executed: bool,
    ) -> str:
        if executed:
            return f"Action « {resolved.intent.value} » exécutée via le moteur {resolved.engine} après votre validation."
        if proposed_action is not None:
            return (
                f"Intention « {resolved.intent.value} » routée vers le moteur {resolved.engine}. "
                "Action proposée, en attente de votre validation."
            )
        if reasoning.elements:
            return (
                f"Réponse construite à partir de {len(reasoning.elements)} élément(s) du moteur "
                f"{reasoning.engine}."
            )
        return "Aucune connaissance suffisante — demande de précision plutôt qu'une invention."
