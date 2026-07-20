"""Shape of a trade's reference catalog — the "toolbox" an artisan loads.

A trade is **seed data, not a live parent** of the artisan's catalog. When a
trade is imported, its categories and items are *copied* into the company's
own ``catalog_categories`` / ``catalog_items`` rows, and Artizen never looks
at the reference again. Two reasons that is the right model here:

- Prices belong to the artisan. The product's promise is that each artisan
  builds their own price book (a plumber's hourly rate is not another's), so
  the copy must be his to edit the moment it lands. A shared parent would
  need an override table for every price he changes — which is every price.
- It cannot break a past quote. Reference data that kept evolving under an
  artisan's feet would silently change what his catalog says months later.

So these values are a *starting point*, deliberately ordinary market prices
the artisan is expected to correct — not a price recommendation.
"""

from dataclasses import dataclass, field
from decimal import Decimal

from app.catalog.models import ItemType


@dataclass(frozen=True)
class TradeItem:
    """One line of a trade's reference catalog.

    Mirrors ``CatalogItem``'s writable fields so seeding is a straight copy
    with a ``company_id`` and ``category_id`` bolted on — no mapping layer to
    keep in sync when the model gains a column.
    """

    designation: str
    unit: str
    unit_price_ht: Decimal
    vat_rate: Decimal
    item_type: ItemType = ItemType.PRODUCT
    description: str | None = None
    #: Labour only: how long the job typically takes. Lets the app total a
    #: quote's on-site time, and is what makes "main-d'œuvre in minutes /
    #: hours / days" possible without a second unit system.
    estimated_duration_minutes: int | None = None


@dataclass(frozen=True)
class TradeCategory:
    """A folder in the artisan's catalog (``CatalogCategory``)."""

    name: str
    items: tuple[TradeItem, ...]
    description: str | None = None


@dataclass(frozen=True)
class Trade:
    """One toolbox. ``slug`` is the stable id stored on the company; ``label``
    is what the artisan reads when ticking his trades at signup."""

    slug: str
    label: str
    categories: tuple[TradeCategory, ...] = field(default_factory=tuple)

    @property
    def item_count(self) -> int:
        return sum(len(category.items) for category in self.categories)
