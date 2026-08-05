"""Reasoning Coordinator — reuses the existing intelligence, never a parallel one.

All reasoning is delegated to the **Decision Engine** (which itself sources the
**Knowledge Engine**) or to Knowledge directly. The Companion builds no reasoning
of its own: it interprets the intent, asks the owning engines, and carries their
confidence, sources and clarification questions back verbatim (explainability,
Loi 6). Nothing here persists or computes an amount.
"""

from dataclasses import dataclass, field

from app.ai_companion.intents import CompanionIntent, ResolvedIntent
from app.ai_companion.schemas import SourceRef
from app.decision.service import DecisionService
from app.knowledge.service import KnowledgeService

_MAX = 5


@dataclass
class ReasoningResult:
    engine: str  # which engine produced the substance (decision | knowledge)
    knowledge_slugs: list[str] = field(default_factory=list)
    sources: list[SourceRef] = field(default_factory=list)
    elements: list[dict] = field(default_factory=list)  # title/type/reason
    confidence: float = 0.0
    needs_confirmation: bool = False
    questions: list[str] = field(default_factory=list)
    comment: str = ""


class ReasoningCoordinator:
    def __init__(self, *, decision: DecisionService, knowledge: KnowledgeService) -> None:
        self._decision = decision
        self._knowledge = knowledge

    def reason(self, resolved: ResolvedIntent) -> ReasoningResult:
        # "Explain / decide" → the Decision Engine's full explained proposal.
        if resolved.intent == CompanionIntent.EXPLAIN or resolved.is_write:
            return self._via_decision(resolved)
        # "Search / how-to / diagnose" → a direct Knowledge lookup.
        if resolved.intent == CompanionIntent.SEARCH_KNOWLEDGE:
            return self._via_knowledge(resolved)
        return ReasoningResult(engine="companion")

    def _via_decision(self, resolved: ResolvedIntent) -> ReasoningResult:
        decision = self._decision.decide(intent_text=resolved.raw)
        elements = [
            {"slug": e.slug, "type": e.type, "title": e.title, "reason": e.reason}
            for e in decision.proposal.elements
        ]
        return ReasoningResult(
            engine="decision",
            knowledge_slugs=[e.slug for e in decision.proposal.elements],
            sources=[
                SourceRef(kind="knowledge", ref=e.slug, title=e.title)
                for e in decision.proposal.elements
            ],
            elements=elements,
            confidence=decision.confidence,
            needs_confirmation=decision.needs_confirmation,
            questions=decision.questions,
            comment=decision.proposal.comment,
        )

    def _via_knowledge(self, resolved: ResolvedIntent) -> ReasoningResult:
        query = (f"{resolved.verb} {resolved.target}".strip()) or resolved.raw
        result = self._knowledge.search(q=query, include_drafts=True, limit=_MAX)
        elements = [
            {"slug": m.item.slug, "type": m.item.type, "title": m.item.title, "reason": m.why}
            for m in result.matches
        ]
        confidence = round(max((m.score for m in result.matches), default=0.0), 3)
        return ReasoningResult(
            engine="knowledge",
            knowledge_slugs=[m.item.slug for m in result.matches],
            sources=[
                SourceRef(kind="knowledge", ref=m.item.slug, title=m.item.title)
                for m in result.matches
            ],
            elements=elements,
            confidence=confidence,
            needs_confirmation=not result.matches,
            questions=(
                [] if result.matches else ["Pouvez-vous préciser votre besoin ?"]
            ),
        )
