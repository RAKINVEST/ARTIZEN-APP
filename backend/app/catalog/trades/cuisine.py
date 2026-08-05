"""Activité « Cuisine » (cuisiniste).

Meubles, électroménager, éviers et accessoires. Structure homogène :
matériels du domaine → accessoires → prestations.
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

CUISINE = Activity(
    slug="cuisine",
    label="Cuisine",
    version=1,
    description="Meubles, plans de travail, électroménager et pose de cuisine.",
    packs=(
        CatalogPack(
            name="Meubles de cuisine",
            items=(
                _p("Caisson bas", "unité", "120.00"),
                _p("Caisson haut", "unité", "90.00"),
                _p("Colonne", "unité", "200.00"),
                _p("Façade de meuble", "unité", "60.00"),
                _p("Meuble sous-évier", "unité", "140.00"),
                _p("Plan de travail stratifié", "ml", "80.00"),
                _p("Plan de travail bois massif", "ml", "150.00"),
            ),
        ),
        CatalogPack(
            name="Électroménager",
            items=(
                _p("Four encastrable", "unité", "350.00"),
                _p("Plaque de cuisson induction", "unité", "300.00"),
                _p("Hotte aspirante", "unité", "200.00"),
                _p("Lave-vaisselle encastrable", "unité", "400.00"),
                _p("Réfrigérateur encastrable", "unité", "500.00"),
                _p("Micro-ondes encastrable", "unité", "180.00"),
            ),
        ),
        CatalogPack(
            name="Éviers et accessoires",
            items=(
                _p("Évier inox", "unité", "160.00"),
                _p("Mitigeur de cuisine", "unité", "90.00"),
                _p("Crédence", "ml", "60.00"),
                _p("Éclairage LED sous meuble", "unité", "35.00"),
                _p("Poignée de meuble", "unité", "8.00"),
                _p("Tiroir coulissant", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre cuisine", "48.00", 60, unit="heure"),
                _s("Conception et plan 3D", "200.00", 120),
                _s("Pose complète d'une cuisine", "800.00", 600),
                _s("Pose d'un plan de travail", "150.00", 120),
                _s("Raccordements (eau, électricité)", "180.00", 120),
                _s("Dépose d'une ancienne cuisine", "200.00", 120),
            ),
        ),
    ),
)
