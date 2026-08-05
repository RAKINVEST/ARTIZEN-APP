"""Activité « Démolition / Curage ».

Consommables, protections, étaiement. Structure homogène :
matériel/consommables → prestations.
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

DEMOLITION = Activity(
    slug="demolition",
    label="Démolition / Curage",
    version=1,
    description="Démolition, curage, dépose et évacuation avant travaux.",
    packs=(
        CatalogPack(
            name="Consommables et protections",
            items=(
                _p("Big-bag", "unité", "4.00"),
                _p("Sac à gravats (lot)", "unité", "9.00"),
                _p("Bâche de protection", "unité", "8.00"),
                _p("Disque diamant", "unité", "35.00"),
                _p("Étai de soutènement", "unité", "18.00"),
                _p("Ruban de signalisation (rouleau)", "unité", "6.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre démolition", "42.00", 60, unit="heure"),
                _s("Démolition d'une cloison", "20.00", 25, unit="m²"),
                _s("Démolition d'un mur porteur", "80.00", 90, unit="m²"),
                _s("Curage complet d'un logement", "35.00", 40, unit="m²"),
                _s("Dépose d'une dalle", "28.00", 30, unit="m²"),
                _s("Évacuation des gravats", "40.00", 30, unit="m³"),
                _s("Location et rotation d'une benne", "350.00", 60),
            ),
        ),
    ),
)
