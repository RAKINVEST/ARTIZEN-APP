"""Composition model of a company's catalog: packs, activities, qualifications.

The unit of composition is the **pack**, not the trade. An activity or a
qualification does not carry folders directly — it activates packs, and the
selected packs are merged into the artisan's own catalog.

Why packs rather than trades: it removes the combinatorial explosion. Without
them, a catalog needs a "plombier", "plombier-chauffagiste",
"plombier-chauffagiste-PG"… variant for every real-world combination. With
them, a plumber-heating-engineer ticks two activities and gets the union, and
the same model serves the electrician, the carpenter or the painter without
reinventing how a catalog is organised.

A pack is **self-contained**: it carries the products *and* the services that
go with them ("Pose d'un chauffe-eau" belongs to the Chauffe-eau pack, next to
the water heater). The artisan opens one folder and ticks everything the job
needs, instead of hopping between a products folder and a labour folder.

Three levels, and only three:

1. **Pack-specific service** — inside the product pack ("Pose d'un chauffe-eau").
2. **"Prestations" pack** — cross-cutting for an activity (hourly rate, day rate).
3. **"Chantier" pack** — common to every trade (travel, removal, waste, testing).

Two packs sharing a name **merge** into a single folder: activating Plomberie
and Chauffage yields one "Prestations" folder, not two. The artisan sees one
catalog.

Packs are **seed data copied** into the company's own rows, never a live parent
— see `docs/DECISIONS.md`, décision 1. Prices are ordinary market figures the
artisan is expected to correct, not a recommendation.
"""

from dataclasses import dataclass, field
from decimal import Decimal

from app.catalog.models import ItemType


@dataclass(frozen=True)
class PackItem:
    """One line of a pack.

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
    #: Services only: how long the job usually takes. Lets the app total a
    #: quote's on-site time, and is what makes "main-d'œuvre in minutes /
    #: hours / days" possible without a second unit system.
    estimated_duration_minutes: int | None = None


@dataclass(frozen=True)
class CatalogPack:
    """A folder of the artisan's catalog, and the unit activities compose with.

    ``name`` is also the merge key: two packs called "Prestations" become one
    folder holding both their items.
    """

    name: str
    items: tuple[PackItem, ...]
    description: str | None = None


@dataclass(frozen=True)
class Activity:
    """What the company *does* — plomberie, chauffage, électricité…

    Drives which packs make up its catalog. An artisan ticks his activities
    once, in his company settings; the quote flow never asks again
    (`docs/DECISIONS.md`, décision 2).

    ``version`` is what makes "mise à jour disponible" reliable. Bump it —
    deliberately, like publishing an app update — whenever this activity's
    packs gain or change articles. A company remembers the version it imported;
    a newer version here is what surfaces the update, and nothing else does.
    Detecting updates by diffing articles instead would flag every article the
    artisan deleted as "missing" forever. See `docs/DECISIONS.md`, décision 7.
    """

    slug: str
    label: str
    version: int = 1
    packs: tuple[CatalogPack, ...] = field(default_factory=tuple)
    description: str | None = None


@dataclass(frozen=True)
class Qualification:
    """What the company is *allowed or certified* to do — PG, RGE, QualiPAC…

    Enriches the catalog with packs that are legally reserved. Never loaded by
    default: putting a gas article in the catalog of an artisan who is not
    PG-certified would let him quote work he has no right to carry out.

    A qualification is also a **legal mention on the quote** (an RGE number is
    what lets the customer claim MaPrimeRénov' or CEE), so the same setting
    feeds both the catalog and the PDF — see `docs/DECISIONS.md`, décision 7.
    """

    slug: str
    label: str
    version: int = 1
    packs: tuple[CatalogPack, ...] = field(default_factory=tuple)
    description: str | None = None


_TVA_RENOVATION = Decimal("10.00")


def produit(designation: str, unit: str, price: str, vat: Decimal = _TVA_RENOVATION) -> PackItem:
    """Une fourniture. TVA rénovation par défaut (le cas courant)."""
    return PackItem(designation, unit, Decimal(price), vat)


def prestation(
    designation: str,
    price: str,
    minutes: int,
    *,
    unit: str = "forfait",
    note: str | None = None,
) -> PackItem:
    """Une prestation facturable — main-d'œuvre, pose, dépose, mise en service,
    diagnostic, nettoyage… — avec le temps qu'elle prend habituellement."""
    return PackItem(
        designation,
        unit,
        Decimal(price),
        _TVA_RENOVATION,
        ItemType.SERVICE,
        description=note,
        estimated_duration_minutes=minutes,
    )


def merge_packs(packs: list[CatalogPack]) -> list[CatalogPack]:
    """Fold packs sharing a name into one, preserving item order.

    This is what turns "Plomberie brings Prestations, Chauffage brings
    Prestations" into the single Prestations folder the artisan expects.
    """
    merged: dict[str, CatalogPack] = {}
    for pack in packs:
        existing = merged.get(pack.name)
        if existing is None:
            merged[pack.name] = pack
        else:
            merged[pack.name] = CatalogPack(
                name=existing.name,
                items=existing.items + pack.items,
                description=existing.description or pack.description,
            )
    return list(merged.values())
