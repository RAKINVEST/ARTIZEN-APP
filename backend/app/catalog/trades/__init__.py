"""Registry of the trades an artisan can load into his catalog.

Only trades that actually carry a catalog are registered. Listing the ten
trades of the roadmap here with empty ``categories`` would let an artisan tick
"Électricien" and receive an empty toolbox — the exact opposite of the promise,
and worse than not offering it yet. A trade appears the day its catalog exists.
"""

from app.catalog.trades.commun import CHANTIER
from app.catalog.trades.definitions import Trade, TradeCategory, TradeItem
from app.catalog.trades.plombier import PLOMBIER

#: Registered trades, keyed by the slug persisted on the company.
TRADES: dict[str, Trade] = {trade.slug: trade for trade in (PLOMBIER,)}


def list_trades() -> list[Trade]:
    """Every selectable trade, alphabetically by label — the order the artisan
    sees when ticking his trades."""
    return sorted(TRADES.values(), key=lambda trade: trade.label)


def get_trade(slug: str) -> Trade | None:
    return TRADES.get(slug)


def categories_for(trade: Trade, *, include_optional: bool = False) -> list[TradeCategory]:
    """The folders to actually create for ``trade``.

    Its own folders plus :data:`~app.catalog.trades.commun.CHANTIER`, which
    every trade needs and no trade owns. Optional folders (gas, reserved to
    PG-certified professionals) stay out unless explicitly asked for: a quote
    line the artisan is not allowed to carry out is worse than a missing one.
    """
    categories = [
        category
        for category in trade.categories
        if include_optional or not category.optional
    ]
    categories.append(CHANTIER)
    return categories


__all__ = [
    "CHANTIER",
    "TRADES",
    "Trade",
    "TradeCategory",
    "TradeItem",
    "categories_for",
    "get_trade",
    "list_trades",
]
