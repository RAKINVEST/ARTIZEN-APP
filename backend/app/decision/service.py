"""Decision service — orchestrates intention -> explained proposal.

Read-side only. Since the Knowledge integration, the Decision Engine sources
**exclusively** from the Knowledge Engine (dependency-inverted onto
``KnowledgeService``): it no longer reads the catalog, no longer ranks
candidates itself (that logic lives in the Knowledge query engine — no
duplication), and never accesses the corpus directly. It interprets the intent,
asks Knowledge, and shapes the ranked, confidence-carrying results into an
explained proposal. It **never persists, never creates a Quote, never computes
an amount** (ADR-023).
"""

import logging

from app.decision.explainability import explain, uncertainty_questions
from app.decision.intents import interpret_intent
from app.decision.schemas import DecisionResponse, Proposal, ProposalElement
from app.knowledge.service import KnowledgeService

logger = logging.getLogger(__name__)

# The corpus is currently all-draft (validation in progress). To be useful the
# Decision Engine proposes drafts too — but surfaces their confidence and leaves
# the decision to the artisan (nothing is asserted as certain).
_INCLUDE_DRAFTS = True
_MAX_ELEMENTS = 10


class DecisionService:
    def __init__(self, knowledge: KnowledgeService) -> None:
        self._knowledge = knowledge

    def decide(self, *, intent_text: str) -> DecisionResponse:
        intent = interpret_intent(intent_text)
        logger.info(
            "decision.start verb=%s target_len=%d", intent.verb or "?", len(intent.target)
        )

        elements: list[ProposalElement] = []
        if intent.target:
            query = f"{intent.verb} {intent.target}".strip()
            result = self._knowledge.search(
                q=query, include_drafts=_INCLUDE_DRAFTS, limit=_MAX_ELEMENTS
            )
            elements = [
                ProposalElement(
                    slug=match.item.slug,
                    type=match.item.type,
                    title=match.item.title,
                    reason=match.why,
                    score=match.score,
                    confidence=match.item.confidence,
                    sources=match.item.sources,
                    relations=match.item.relations,
                )
                for match in result.matches
            ]

        explanation = explain(intent, elements)
        questions = uncertainty_questions(intent, has_results=bool(elements))
        needs_confirmation = bool(questions)
        confidence = 0.0 if not elements else round(max(e.score for e in elements), 3)
        if needs_confirmation:
            confidence = round(confidence * 0.5, 3)

        comment = self._comment(intent, elements, needs_confirmation)
        logger.info(
            "decision.completed elements=%d confidence=%.2f needs_confirmation=%s",
            len(elements),
            confidence,
            needs_confirmation,
        )
        return DecisionResponse(
            intent=intent,
            proposal=Proposal(elements=elements, comment=comment),
            explanation=explanation,
            confidence=confidence,
            needs_confirmation=needs_confirmation,
            questions=questions,
        )

    @staticmethod
    def _comment(intent, elements: list[ProposalElement], needs_confirmation: bool) -> str:
        if needs_confirmation and not elements:
            return "J'ai besoin d'une précision avant de vous proposer quelque chose."
        if not elements:
            return "Aucune connaissance à proposer pour le moment."
        action = intent.verb or "votre demande"
        target = intent.target or "votre besoin"
        return (
            f"Voici ce que je trouve pour « {action} {target} », issu de la base de savoir. "
            "Vérifiez avant d'agir — rien n'est enregistré, et ces fiches restent à valider."
        )
