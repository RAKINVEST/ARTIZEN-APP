"""Activité « Terrassement ».

Matériaux d'apport, drainage. Structure homogène :
matériel → drainage → prestations.
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

TERRASSEMENT = Activity(
    slug="terrassement",
    label="Terrassement",
    version=1,
    description="Fouilles, remblais, plateformes, drainage et évacuation.",
    packs=(
        CatalogPack(
            name="Matériaux d'apport",
            items=(
                _p("Tout-venant", "tonne", "22.00"),
                _p("Grave 0/31.5", "tonne", "25.00"),
                _p("Sable de remblai", "m³", "35.00"),
                _p("Concassé", "tonne", "24.00"),
                _p("Terre végétale", "m³", "40.00"),
                _p("Géotextile (rouleau)", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Drainage et protection",
            items=(
                _p("Drain agricole", "ml", "3.50"),
                _p("Regard de collecte", "unité", "45.00"),
                _p("Nappe drainante (rouleau)", "unité", "90.00"),
                _p("Grillage avertisseur (rouleau)", "unité", "18.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre terrassement", "45.00", 60, unit="heure"),
                _s("Décapage de terre végétale", "5.00", 8, unit="m²"),
                _s("Fouille en pleine masse", "18.00", 15, unit="m³"),
                _s("Fouille en tranchée", "22.00", 20, unit="ml"),
                _s("Remblaiement et compactage", "20.00", 18, unit="m³"),
                _s("Évacuation des déblais", "25.00", 20, unit="m³"),
                _s("Location d'engin avec chauffeur", "550.00", 480, unit="jour"),
            ),
        ),
    ),
)
