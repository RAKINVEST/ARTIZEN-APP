"""Pure unit + integration tests for the Decision Engine (no DB, no HTTP).

Since the Knowledge integration, the Decision Engine sources exclusively from
the Knowledge Engine. These build a real ``KnowledgeService`` from in-memory
items — no database — so the whole Decision→Knowledge slice is pinned locally
(``pytest --noconftest app/tests/test_decision_logic.py``).
"""

from app.decision.explainability import uncertainty_questions
from app.decision.intents import interpret_intent
from app.decision.schemas import DecisionResponse, Intent, ProposalElement
from app.decision.service import DecisionService
from app.knowledge.schemas import KnowledgeItem
from app.knowledge.service import KnowledgeService


def _card(slug, title, tags, *, confidence="C", status="valide", type_="card",
          sources=None, relations=None) -> KnowledgeItem:
    return KnowledgeItem(
        slug=slug, type=type_, title=title, tags=list(tags), confidence=confidence,
        status=status, sources=list(sources or []), relations=list(relations or []),
    )


def test_interpret_recognizes_verb_and_target() -> None:
    intent = interpret_intent("Je remplace un mitigeur")
    assert intent.verb == "remplacer"
    assert intent.target == "mitigeur"


def test_uncertainty_asks_instead_of_inventing() -> None:
    assert uncertainty_questions(Intent(verb="", target="x", raw="x"), True)
    assert uncertainty_questions(Intent(verb="reparer", target="", raw="r"), True)
    assert uncertainty_questions(Intent(verb="reparer", target="ovni", raw="r"), False)
    assert uncertainty_questions(Intent(verb="reparer", target="mitigeur", raw="r"), True) == []


def test_no_price_or_total_anywhere() -> None:
    for model in (ProposalElement, DecisionResponse):
        keys = " ".join(model.model_fields).lower()
        assert "price" not in keys and "prix" not in keys
        assert "total" not in keys and "montant" not in keys
        assert "quantity" not in keys and "quantite" not in keys


def test_decision_sources_exclusively_from_knowledge() -> None:
    knowledge = KnowledgeService([
        _card(
            "remplacer-mitigeur", "Remplacer un mitigeur",
            ["metier:plomberie", "equipement:mitigeur"],
            confidence="B", sources=["DTU 60.1"], relations=["kit-robinetterie"],
        ),
        _card("peindre-mur", "Peindre un mur", ["metier:peinture"]),
    ])
    response = DecisionService(knowledge=knowledge).decide(intent_text="Je remplace un mitigeur")

    slugs = [e.slug for e in response.proposal.elements]
    assert "remplacer-mitigeur" in slugs
    assert "peindre-mur" not in slugs  # irrelevant, filtered by Knowledge
    top = response.proposal.elements[0]
    assert top.confidence == "B"  # confidence exploited
    assert top.sources == ["DTU 60.1"]  # sources exploited
    assert top.relations == ["kit-robinetterie"]  # relations exploited
    # Explanation is traceable to the Knowledge item.
    assert response.explanation.items[0].confidence == "B"


def test_decision_is_deterministic() -> None:
    knowledge = KnowledgeService([
        _card("a", "Mitigeur cuisine", ["equipement:mitigeur"]),
        _card("b", "Mitigeur douche", ["equipement:mitigeur"]),
    ])
    service = DecisionService(knowledge=knowledge)
    first = service.decide(intent_text="remplacer mitigeur").model_dump()
    second = service.decide(intent_text="remplacer mitigeur").model_dump()
    assert first == second


def test_decision_never_invents_when_knowledge_is_empty() -> None:
    response = DecisionService(knowledge=KnowledgeService([])).decide(
        intent_text="remplacer mitigeur"
    )
    assert response.proposal.elements == []
    assert response.needs_confirmation is True  # asks, never fabricates
    assert response.questions
