"""Activité « Isolation (ITI / combles) ».

Isolants, membranes, accessoires. Structure homogène :
matériel → membranes → prestations.
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

ISOLATION = Activity(
    slug="isolation",
    label="Isolation (ITI / combles)",
    version=1,
    description="Isolation thermique intérieure : murs, combles, rampants.",
    packs=(
        CatalogPack(
            name="Isolants",
            items=(
                _p("Laine de verre", "m²", "6.00"),
                _p("Laine de roche", "m²", "8.50"),
                _p("Ouate de cellulose (sac)", "unité", "12.00"),
                _p("Polystyrène expansé", "m²", "7.00"),
                _p("Polyuréthane", "m²", "12.00"),
                _p("Fibre de bois", "m²", "14.00"),
                _p("Laine à souffler (sac)", "unité", "15.00"),
            ),
        ),
        CatalogPack(
            name="Membranes et accessoires",
            items=(
                _p("Frein-vapeur (rouleau)", "unité", "60.00"),
                _p("Pare-vapeur (rouleau)", "unité", "45.00"),
                _p("Adhésif d'étanchéité (rouleau)", "unité", "18.00"),
                _p("Suspente d'isolation", "unité", "0.80"),
                _p("Fourrure métallique", "ml", "1.50"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre isolation", "42.00", 60, unit="heure"),
                _s("Isolation des combles perdus", "18.00", 20, unit="m²"),
                _s("Isolation par soufflage", "15.00", 15, unit="m²"),
                _s("Isolation des murs par l'intérieur", "35.00", 40, unit="m²"),
                _s("Isolation de rampants", "40.00", 45, unit="m²"),
                _s("Pose d'un frein-vapeur", "8.00", 10, unit="m²"),
            ),
        ),
    ),
)
