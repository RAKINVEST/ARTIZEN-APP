"""Activité « VRD (voirie & réseaux divers) ».

Réseaux, canalisations, matériaux de voirie. Structure homogène :
matériel → voirie → prestations.
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

VRD = Activity(
    slug="vrd",
    label="VRD (voirie & réseaux divers)",
    version=1,
    description="Tranchées, réseaux enterrés, bordures et réfection de voirie.",
    packs=(
        CatalogPack(
            name="Réseaux et canalisations",
            items=(
                _p("Tuyau PVC assainissement Ø100", "ml", "9.00"),
                _p("Tuyau PVC Ø200", "ml", "18.00"),
                _p("Gaine TPC", "ml", "3.50"),
                _p("Regard de visite", "unité", "60.00"),
                _p("Grille avaloir", "unité", "45.00"),
                _p("Caniveau", "ml", "22.00"),
            ),
        ),
        CatalogPack(
            name="Matériaux de voirie",
            items=(
                _p("Grave concassée", "tonne", "25.00"),
                _p("Sable de pose", "tonne", "30.00"),
                _p("Géotextile (rouleau)", "unité", "60.00"),
                _p("Grillage avertisseur (rouleau)", "unité", "18.00"),
                _p("Bordure de trottoir T2", "ml", "12.00"),
                _p("Dalle podotactile", "unité", "35.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre VRD", "45.00", 60, unit="heure"),
                _s("Ouverture de tranchée", "22.00", 20, unit="ml"),
                _s("Pose de canalisation", "28.00", 25, unit="ml"),
                _s("Pose de bordures", "25.00", 25, unit="ml"),
                _s("Réalisation d'un regard", "180.00", 120),
                _s("Réfection de voirie", "35.00", 35, unit="m²"),
            ),
        ),
    ),
)
