"""Pre-installed trade catalogs ("packs métier").

Each trade defines a ready-to-use category tree with common articles so an
artisan can start quoting immediately after picking their trade at first
launch, then personalize prices/references. Content here is deliberately
data (not code): adding a trade or an article is just editing this file.

Conventions:
  * Prices are left at 0 — the artisan fills in their own (see the brief:
    "il ajoute seulement ses prix"). Units and VAT are pre-set.
  * VAT defaults: 20 % for supplied goods (fournitures / PRODUCT), 10 % for
    labour (pose / prestations / SERVICE) — the common French renovation
    split. Both are freely editable per item afterwards.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from decimal import Decimal

from app.catalog.models import ItemType

_VAT_GOODS = Decimal("20.00")
_VAT_LABOUR = Decimal("10.00")


@dataclass(frozen=True)
class SeedItem:
    designation: str
    unit: str
    item_type: ItemType = ItemType.PRODUCT

    @property
    def vat_rate(self) -> Decimal:
        return _VAT_GOODS if self.item_type is ItemType.PRODUCT else _VAT_LABOUR


@dataclass(frozen=True)
class SeedCategory:
    name: str
    children: tuple["SeedCategory", ...] = ()
    items: tuple[SeedItem, ...] = ()


@dataclass(frozen=True)
class SeedTrade:
    slug: str
    name: str
    description: str
    categories: tuple[SeedCategory, ...] = field(default_factory=tuple)

    def category_count(self) -> int:
        def count(cats: tuple[SeedCategory, ...]) -> int:
            return sum(1 + count(c.children) for c in cats)

        return count(self.categories)

    def item_count(self) -> int:
        def count(cats: tuple[SeedCategory, ...]) -> int:
            return sum(len(c.items) + count(c.children) for c in cats)

        return count(self.categories)


def _goods(*names_units: tuple[str, str]) -> tuple[SeedItem, ...]:
    return tuple(SeedItem(n, u, ItemType.PRODUCT) for n, u in names_units)


def _labour(*names: str) -> tuple[SeedItem, ...]:
    return tuple(SeedItem(n, "h", ItemType.SERVICE) for n in names)


# --- Fully detailed trades (from the brief's examples) ---

_PLOMBERIE = SeedTrade(
    slug="plombier",
    name="Plombier",
    description="Tubes, chauffe-eau, robinetterie, évacuation et prestations.",
    categories=(
        SeedCategory(
            "Tubes",
            items=_goods(("Tube PER", "m"), ("Tube cuivre", "m"),
                        ("Tube PVC", "m"), ("Tube multicouche", "m")),
        ),
        SeedCategory(
            "Chauffe-eau",
            items=_goods(("Chauffe-eau électrique", "pièce"),
                        ("Chauffe-eau thermodynamique", "pièce"),
                        ("Ballon 200 L", "pièce"), ("Ballon 300 L", "pièce")),
        ),
        SeedCategory(
            "Robinetterie",
            items=_goods(("Mitigeur", "pièce"), ("Robinet d'arrêt", "pièce"),
                        ("Groupe de sécurité", "pièce")),
        ),
        SeedCategory(
            "Évacuation",
            items=_goods(("Siphon", "pièce"), ("Bonde", "pièce"), ("PVC Ø40", "m")),
        ),
        SeedCategory(
            "Prestations",
            items=_labour("Pose et raccordement", "Dépannage", "Mise en service"),
        ),
    ),
)

_CHAUFFAGE = SeedTrade(
    slug="chauffagiste",
    name="Chauffagiste",
    description="Chaudières, radiateurs, PAC, plancher chauffant et prestations.",
    categories=(
        SeedCategory("Chaudières", items=_goods(
            ("Chaudière gaz à condensation", "pièce"), ("Chaudière fioul", "pièce"))),
        SeedCategory("Radiateurs", items=_goods(
            ("Radiateur acier", "pièce"), ("Radiateur fonte", "pièce"),
            ("Sèche-serviettes", "pièce"))),
        SeedCategory("PAC", items=_goods(
            ("PAC air/eau", "pièce"), ("PAC air/air", "pièce"))),
        SeedCategory("Plancher chauffant", items=_goods(
            ("Kit plancher chauffant hydraulique", "m²"),
            ("Collecteur", "pièce"))),
        SeedCategory("Prestations", items=_labour(
            "Pose", "Entretien annuel", "Désembouage")),
    ),
)

_CLIMATISATION = SeedTrade(
    slug="climaticien",
    name="Climaticien",
    description="Split, gainable, multisplit, accessoires et prestations.",
    categories=(
        SeedCategory("Split mural", items=_goods(
            ("Mono-split mural", "pièce"))),
        SeedCategory("Gainable", items=_goods(
            ("Climatiseur gainable", "pièce"))),
        SeedCategory("Multisplit", items=_goods(
            ("Multi-split 2 sorties", "pièce"), ("Multi-split 3 sorties", "pièce"),
            ("Multi-split 4 sorties", "pièce"))),
        SeedCategory("Accessoires", items=_goods(
            ("Support mural", "pièce"), ("Goulotte", "m"),
            ("Liaison frigorifique", "m"))),
        SeedCategory("Prestations", items=_labour(
            "Pose et mise en service", "Recharge de gaz", "Entretien")),
    ),
)

# --- Starter trades (lighter packs, easy to extend) ---

_ELECTRICIEN = SeedTrade(
    slug="electricien",
    name="Électricien",
    description="Tableau, appareillage, éclairage, câbles et prestations.",
    categories=(
        SeedCategory("Tableau", items=_goods(
            ("Tableau électrique", "pièce"), ("Disjoncteur", "pièce"),
            ("Interrupteur différentiel", "pièce"))),
        SeedCategory("Appareillage", items=_goods(
            ("Prise 2P+T", "pièce"), ("Interrupteur", "pièce"), ("Va-et-vient", "pièce"))),
        SeedCategory("Éclairage", items=_goods(
            ("Spot LED encastré", "pièce"), ("Réglette LED", "pièce"))),
        SeedCategory("Câbles", items=_goods(
            ("Câble 1,5 mm²", "m"), ("Câble 2,5 mm²", "m"))),
        SeedCategory("Prestations", items=_labour(
            "Pose", "Mise aux normes", "Dépannage")),
    ),
)

_MENUISIER = SeedTrade(
    slug="menuisier",
    name="Menuisier",
    description="Fenêtres, portes, volets et prestations.",
    categories=(
        SeedCategory("Fenêtres", items=_goods(
            ("Fenêtre PVC double vitrage", "pièce"), ("Fenêtre alu", "pièce"))),
        SeedCategory("Portes", items=_goods(
            ("Porte d'entrée", "pièce"), ("Porte intérieure", "pièce"))),
        SeedCategory("Volets", items=_goods(
            ("Volet roulant", "pièce"), ("Volet battant", "pièce"))),
        SeedCategory("Prestations", items=_labour("Pose", "Dépose")),
    ),
)

_PEINTRE = SeedTrade(
    slug="peintre",
    name="Peintre",
    description="Peinture, préparation, revêtements et prestations.",
    categories=(
        SeedCategory("Peinture", items=_goods(
            ("Peinture murale (pot)", "pièce"), ("Sous-couche", "pièce"))),
        SeedCategory("Préparation", items=_goods(
            ("Enduit de lissage", "pièce"), ("Bande à joint", "m"))),
        SeedCategory("Revêtements", items=_goods(
            ("Papier peint", "rouleau"), ("Toile de verre", "m²"))),
        SeedCategory("Prestations", items=_labour(
            "Application peinture", "Préparation des supports")),
    ),
)

_MACON = SeedTrade(
    slug="macon",
    name="Maçon",
    description="Gros œuvre, matériaux et prestations.",
    categories=(
        SeedCategory("Matériaux", items=_goods(
            ("Parpaing", "pièce"), ("Ciment (sac)", "pièce"), ("Sable", "kg"))),
        SeedCategory("Gros œuvre", items=_goods(
            ("Dalle béton", "m²"), ("Mur parpaing", "m²"))),
        SeedCategory("Prestations", items=_labour(
            "Maçonnerie", "Coffrage", "Ferraillage")),
    ),
)


TRADES: tuple[SeedTrade, ...] = (
    _PLOMBERIE,
    _CHAUFFAGE,
    _CLIMATISATION,
    _ELECTRICIEN,
    _MENUISIER,
    _PEINTRE,
    _MACON,
)

TRADES_BY_SLUG: dict[str, SeedTrade] = {t.slug: t for t in TRADES}
