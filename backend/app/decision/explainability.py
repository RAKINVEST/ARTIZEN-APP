"""Explanation assembly — pure, deterministic, DB-free (unit-testable).

Every proposed element gets a traceable "why" (Loi 6): no black box. Since the
Knowledge integration, the explanation is built from the Knowledge Engine's own
match reason + confidence + sources — the Decision Engine adds no knowledge of
its own (docs/.../DECISION_EXPLAINABILITY.md).
"""

from app.decision.schemas import Explanation, ExplanationItem, Intent, ProposalElement


def explain(intent: Intent, elements: list[ProposalElement]) -> Explanation:
    items: list[ExplanationItem] = []
    for element in elements:
        basis_parts: list[str] = []
        if element.sources:
            basis_parts.append("sources : " + ", ".join(element.sources))
        if element.relations:
            basis_parts.append("relations : " + ", ".join(element.relations))
        basis_parts.append(f"type {element.type}")
        items.append(
            ExplanationItem(
                subject=element.title,
                why=element.reason,
                basis=" ; ".join(basis_parts),
                confidence=element.confidence or "—",
            )
        )
    return Explanation(items=items)


def uncertainty_questions(intent: Intent, has_results: bool) -> list[str]:
    """What to ask when the engine cannot conclude — it asks, never invents."""
    questions: list[str] = []
    if not intent.verb:
        questions.append(
            "Quelle action souhaitez-vous (installer, remplacer, réparer, entretenir…) ?"
        )
    if not intent.target:
        questions.append("Sur quel équipement ou élément porte l'intervention ?")
    if intent.verb and intent.target and not has_results:
        questions.append(
            f"Aucune connaissance ne correspond à « {intent.target} » pour le moment. "
            "Pouvez-vous préciser ?"
        )
    return questions
