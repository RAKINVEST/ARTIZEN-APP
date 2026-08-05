"""Offline unit tests for the Intervention core (Bibliothèque Métier, V2).

No DB, no network. They pin the domain invariants the whole platform vision
rests on: the intervention is the unit (not the line), expansion proposes
editable drafts without inventing or computing anything, and an intervention may
legitimately be empty.
"""

from decimal import Decimal
from uuid import uuid4

from app.interventions.composer import (
    InterventionLineDraft,
    expand,
    referenced_catalog_item_ids,
)
from app.interventions.schemas import (
    ComponentKind,
    Intervention,
    InterventionComponent,
)


def _pac_install() -> tuple[Intervention, list]:
    item_a = uuid4()
    item_b = uuid4()
    intervention = Intervention(
        name="Installation PAC",
        action="installer",
        equipment="PAC",
        trade_slug="chauffage",
        components=[
            InterventionComponent(
                kind=ComponentKind.labor,
                order=2,
                label="Main-d'œuvre",
                default_quantity=Decimal("6"),
                unit="h",
            ),
            InterventionComponent(
                kind=ComponentKind.article,
                order=0,
                catalog_item_id=item_a,
                label="Unité extérieure",
                default_quantity=Decimal("1"),
                unit="u",
            ),
            InterventionComponent(
                kind=ComponentKind.consumable,
                order=1,
                catalog_item_id=item_b,
                label="Liaison frigorifique",
                default_quantity=Decimal("4"),
                unit="m",
            ),
            InterventionComponent(
                kind=ComponentKind.guarantee,
                order=3,
                text="Garantie 2 ans pièces et main-d'œuvre.",
            ),
        ],
    )
    return intervention, [item_a, item_b]


def test_expand_orders_by_component_order() -> None:
    intervention, _ = _pac_install()
    drafts = expand(intervention)
    kinds = [d.kind for d in drafts]
    assert kinds == [
        ComponentKind.article,
        ComponentKind.consumable,
        ComponentKind.labor,
        ComponentKind.guarantee,
    ]
    assert [d.order for d in drafts] == [0, 1, 2, 3]


def test_expand_carries_values_verbatim_and_computes_no_total() -> None:
    intervention, _ = _pac_install()
    drafts = expand(intervention)
    article = drafts[0]
    assert isinstance(article, InterventionLineDraft)
    assert article.quantity == Decimal("1")
    assert article.unit == "u"
    assert article.catalog_item_id is not None
    # A draft never carries a computed total — amounts belong to QuoteCalculator.
    assert not hasattr(article, "total_ht")
    # Text kinds carry their wording, no catalogue id.
    guarantee = drafts[3]
    assert guarantee.text.startswith("Garantie")
    assert guarantee.catalog_item_id is None


def test_expand_never_invents_a_quantity() -> None:
    intervention = Intervention(
        name="Divers",
        components=[InterventionComponent(kind=ComponentKind.phrase, text="Merci.")],
    )
    (draft,) = expand(intervention)
    assert draft.quantity is None  # not defaulted to 1 — nothing is invented


def test_an_intervention_can_be_empty() -> None:
    assert expand(Intervention(name="Intervention vierge")) == []


def test_referenced_catalog_items_are_ordered_and_deduped() -> None:
    intervention, [item_a, item_b] = _pac_install()
    # add a duplicate reference to item_a to prove de-duplication
    intervention.components.append(
        InterventionComponent(
            kind=ComponentKind.article, order=4, catalog_item_id=item_a
        )
    )
    assert referenced_catalog_item_ids(intervention) == [item_a, item_b]


def test_model_is_generic_no_trade_specific_branching() -> None:
    # Arbitrary action/equipment strings are pure data — the engine never
    # branches on "PAC" vs "chauffe-eau"; both are accepted identically.
    for equipment in ("PAC", "chauffe-eau", "tableau électrique", "n'importe quoi"):
        iv = Intervention(name=f"Test {equipment}", equipment=equipment)
        assert iv.equipment == equipment
        assert expand(iv) == []
