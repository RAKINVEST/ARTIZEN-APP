"""Re-validates every item Claude proposes against the real catalog —
even though the prompt already restricted Claude to the company's own
active items, an AI response is never trusted blindly.

For each proposed item, checks:
  - it isn't a duplicate of an item already accepted in this same response;
  - it exists;
  - it belongs to the requesting company;
  - it is still active.

An item failing any check is dropped rather than aborting the whole
suggestion: a partially-good AI answer should still surface the parts
that check out, exactly like ``DetectionAggregator`` (Étape 4) lets
eight detectors succeed even if a ninth fails. Every rejection is kept
(with its reason) rather than silently discarded, so the service can
log *why* a decision was made and ``SuggestionScorer`` can factor
duplicates into the final confidence — see "gestion des réponses
ambiguës" (Étape 9): the same catalog item proposed twice in one
response is itself a sign the AI's answer was less clean than a single,
confident match would have been.
"""

import uuid
from dataclasses import dataclass, field
from decimal import Decimal
from typing import Literal

from app.catalog.models import CatalogItem
from app.catalog.repository import CatalogItemRepository
from app.quote_assistant.schemas import RawSuggestionItem

RejectionReason = Literal["duplicate", "not_found", "wrong_company", "inactive"]


@dataclass
class ValidatedItem:
    item: CatalogItem
    quantity: Decimal
    reason: str


@dataclass
class RejectedItem:
    catalog_item_id: uuid.UUID
    reason: RejectionReason


@dataclass
class ValidationResult:
    valid_items: list[ValidatedItem] = field(default_factory=list)
    rejected_items: list[RejectedItem] = field(default_factory=list)
    total_count: int = 0
    valid_count: int = 0
    duplicate_count: int = 0


class MatchValidator:
    def __init__(self, catalog_items: CatalogItemRepository) -> None:
        self._catalog_items = catalog_items

    async def validate(
        self, raw_items: list[RawSuggestionItem], *, company_id: uuid.UUID
    ) -> ValidationResult:
        valid_items: list[ValidatedItem] = []
        rejected_items: list[RejectedItem] = []
        seen_ids: set[uuid.UUID] = set()
        duplicate_count = 0

        for raw in raw_items:
            if raw.catalog_item_id in seen_ids:
                duplicate_count += 1
                rejected_items.append(RejectedItem(raw.catalog_item_id, "duplicate"))
                continue
            # Marked seen now, regardless of whether it goes on to validate
            # successfully: a repeated id is "the same proposal twice" from
            # the AI's point of view even if that proposal turns out invalid.
            seen_ids.add(raw.catalog_item_id)

            item = await self._catalog_items.get(raw.catalog_item_id)
            if item is None:
                rejected_items.append(RejectedItem(raw.catalog_item_id, "not_found"))
                continue
            if item.company_id != company_id:
                rejected_items.append(RejectedItem(raw.catalog_item_id, "wrong_company"))
                continue
            if not item.active:
                rejected_items.append(RejectedItem(raw.catalog_item_id, "inactive"))
                continue

            valid_items.append(ValidatedItem(item=item, quantity=raw.quantity, reason=raw.reason))

        return ValidationResult(
            valid_items=valid_items,
            rejected_items=rejected_items,
            total_count=len(raw_items),
            valid_count=len(valid_items),
            duplicate_count=duplicate_count,
        )
