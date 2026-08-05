"""Activité « Charpente ».

Bois de charpente, connecteurs, traitement. Structure homogène :
matériel → fixations → consommables → prestations.
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

CHARPENTE = Activity(
    slug="charpente",
    label="Charpente",
    version=1,
    description="Charpente traditionnelle et industrielle : bois, fermes, levage.",
    packs=(
        CatalogPack(
            name="Bois de charpente",
            items=(
                _p("Chevron", "ml", "4.50"),
                _p("Panne", "ml", "9.00"),
                _p("Poutre sapin", "ml", "14.00"),
                _p("Madrier", "ml", "8.00"),
                _p("Bastaing", "ml", "6.00"),
                _p("Liteau", "ml", "1.20"),
                _p("Ferme industrielle (fermette)", "unité", "85.00"),
                _p("Poutre lamellé-collé", "ml", "35.00"),
            ),
        ),
        CatalogPack(
            name="Connecteurs et fixations",
            items=(
                _p("Sabot de charpente", "unité", "6.00"),
                _p("Équerre de fixation", "unité", "2.50"),
                _p("Connecteur métallique (gousset)", "unité", "4.00"),
                _p("Étrier de suspente", "unité", "3.50"),
                _p("Tire-fond", "unité", "0.80"),
                _p("Boulon de charpente", "unité", "1.20"),
            ),
        ),
        CatalogPack(
            name="Traitement et protection",
            items=(
                _p("Traitement fongicide/insecticide (5 L)", "unité", "45.00"),
                _p("Lasure bois (5 L)", "unité", "40.00"),
                _p("Saturateur bois (5 L)", "unité", "48.00"),
                _p("Bande d'arase / feutre bitumé", "ml", "1.50"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre charpente", "48.00", 60, unit="heure"),
                _s("Pose d'une charpente traditionnelle", "70.00", 60, unit="m²"),
                _s("Pose de fermettes industrielles", "40.00", 40, unit="m²"),
                _s("Levage et manutention", "350.00", 240),
                _s("Traitement de charpente", "22.00", 20, unit="m²"),
                _s("Dépose d'une charpente", "35.00", 40, unit="m²"),
            ),
        ),
    ),
)
