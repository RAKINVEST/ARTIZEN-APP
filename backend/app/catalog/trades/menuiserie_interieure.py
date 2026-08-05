"""Activité « Menuiserie intérieure ».

Portes, placards, escaliers, quincaillerie. Structure homogène :
matériels du domaine → quincaillerie → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
)
from app.catalog.trades.definitions import (
    prestation as _s,
)
from app.catalog.trades.definitions import (
    produit as _p,
)

MENUISERIE_INTERIEURE = Activity(
    slug="menuiserie-interieure",
    label="Menuiserie intérieure",
    version=1,
    description="Portes, placards, escaliers, agencements bois intérieurs.",
    packs=(
        CatalogPack(
            name="Portes et blocs-portes",
            items=(
                _p("Bloc-porte intérieur", "unité", "150.00"),
                _p("Bloc-porte isophonique", "unité", "280.00"),
                _p("Porte coulissante", "unité", "220.00"),
                _p("Châssis de galandage", "unité", "180.00"),
                _p("Huisserie / bâti", "unité", "60.00"),
                _p("Porte de service", "unité", "200.00"),
            ),
        ),
        CatalogPack(
            name="Placards et rangements",
            items=(
                _p("Porte de placard coulissante", "unité", "120.00"),
                _p("Aménagement de dressing", "ml", "180.00"),
                _p("Étagère", "unité", "35.00"),
                _p("Séparation de placard", "unité", "80.00"),
            ),
        ),
        CatalogPack(
            name="Escaliers",
            items=(
                _p("Escalier bois droit", "unité", "1200.00"),
                _p("Escalier bois quart tournant", "unité", "1800.00"),
                _p("Garde-corps", "m", "120.00"),
                _p("Main courante", "m", "40.00"),
            ),
        ),
        CatalogPack(
            name="Quincaillerie",
            items=(
                _p("Poignée de porte", "unité", "20.00"),
                _p("Serrure", "unité", "35.00"),
                _p("Paire de charnières", "unité", "8.00"),
                _p("Rail de porte coulissante", "unité", "45.00"),
                _p("Butée de porte", "unité", "5.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre menuiserie", "48.00", 60, unit="heure"),
                _s("Pose d'un bloc-porte", "120.00", 90),
                _s("Pose d'une porte coulissante", "180.00", 120),
                _s("Pose d'un placard ou dressing", "250.00", 180),
                _s("Pose d'un escalier", "600.00", 480),
                _s("Dépose d'une menuiserie", "60.00", 45),
            ),
        ),
    ),
)
