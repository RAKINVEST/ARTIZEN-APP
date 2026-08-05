"""Activité « Clôtures ».

Panneaux, poteaux, scellement. Structure homogène :
matériel → accessoires → consommables → prestations.
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

CLOTURE = Activity(
    slug="cloture",
    label="Clôtures",
    version=1,
    description="Clôtures rigides, souples, bois et composite ; brise-vue et gabions.",
    packs=(
        CatalogPack(
            name="Clôtures et panneaux",
            items=(
                _p("Panneau rigide", "ml", "35.00"),
                _p("Grillage souple", "ml", "12.00"),
                _p("Clôture bois", "ml", "45.00"),
                _p("Clôture composite", "ml", "70.00"),
                _p("Brise-vue", "ml", "18.00"),
                _p("Gabion", "unité", "60.00"),
                _p("Palissade", "ml", "55.00"),
            ),
        ),
        CatalogPack(
            name="Poteaux et accessoires",
            items=(
                _p("Poteau de clôture", "unité", "18.00"),
                _p("Platine de poteau", "unité", "6.00"),
                _p("Jambe de force", "unité", "12.00"),
                _p("Plaque de soubassement", "unité", "22.00"),
                _p("Kit de fixation", "unité", "8.00"),
                _p("Fil de tension (rouleau)", "unité", "15.00"),
            ),
        ),
        CatalogPack(
            name="Scellement",
            items=(
                _p("Ciment (sac)", "unité", "9.00"),
                _p("Gravier (sac)", "unité", "6.00"),
                _p("Cheville chimique", "unité", "5.00"),
                _p("Scellement rapide (sac)", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre clôture", "42.00", 60, unit="heure"),
                _s("Pose de poteaux scellés", "35.00", 30, unit="unité"),
                _s("Pose de panneaux rigides", "25.00", 25, unit="ml"),
                _s("Pose d'un grillage souple", "18.00", 20, unit="ml"),
                _s("Pose d'un brise-vue", "12.00", 12, unit="ml"),
                _s("Terrassement de la ligne de clôture", "15.00", 15, unit="ml"),
            ),
        ),
    ),
)
