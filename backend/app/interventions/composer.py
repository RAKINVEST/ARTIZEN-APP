"""Pure expansion of an Intervention into editable draft lines.

The bridge from the artisan's unit of thought (an intervention) to the devis:
``expand`` turns a reusable Intervention into an ordered list of draft lines the
quote builder drops in as one block. It respects the two invariants that make
this safe to trust for ten years:

- **No amount is computed** — that is ``QuoteCalculator``'s single job. Drafts
  carry quantities and references, never totals.
- **Nothing is decided for the artisan** — a draft is a proposal; the artisan
  adds, removes, reorders, merges or splits it freely (Vol.2). The composer only
  *proposes*; it never persists and never mutates a devis.

Pure functions (no I/O, no DB), so the whole intervention→devis translation is
unit-tested without a database or a network.
"""

from __future__ import annotations

from decimal import Decimal
from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.interventions.schemas import ComponentKind, Intervention

_CATALOGUE_KINDS = (ComponentKind.article, ComponentKind.consumable)


class InterventionLineDraft(BaseModel):
    """One editable proposed line produced from an intervention component.

    A draft referencing a catalogue item (``catalog_item_id`` set) is consumable
    as-is by the quote-creation path; a text draft (phrase/guarantee/condition)
    carries its wording. No total: amounts belong to ``QuoteCalculator``.
    """

    model_config = ConfigDict(extra="ignore")

    kind: ComponentKind
    order: int
    catalog_item_id: UUID | None = None
    label: str | None = None
    quantity: Decimal | None = None
    unit: str | None = None
    text: str | None = None


def expand(intervention: Intervention) -> list[InterventionLineDraft]:
    """Ordered, editable draft lines for one intervention block. Empty in,
    empty out (an intervention may legitimately be empty — Vol.2)."""
    ordered = sorted(
        enumerate(intervention.components),
        key=lambda pair: (pair[1].order, pair[0]),
    )
    return [
        InterventionLineDraft(
            kind=component.kind,
            order=position,
            catalog_item_id=component.catalog_item_id,
            label=component.label,
            quantity=component.default_quantity,  # verbatim; never invented
            unit=component.unit,
            text=component.text,
        )
        for position, (_, component) in enumerate(ordered)
    ]


def referenced_catalog_item_ids(intervention: Intervention) -> list[UUID]:
    """The catalogue items an intervention draws on, in order — what the quote
    builder must resolve against the personal catalogue. De-duplicated,
    order-preserving."""
    seen: set[UUID] = set()
    result: list[UUID] = []
    for component in intervention.components:
        item_id = component.catalog_item_id
        if component.kind in _CATALOGUE_KINDS and item_id and item_id not in seen:
            seen.add(item_id)
            result.append(item_id)
    return result
