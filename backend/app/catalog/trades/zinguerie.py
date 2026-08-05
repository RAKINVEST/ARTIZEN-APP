"""Activité « Zinguerie ».

Gouttières, descentes, façonnés, solins. Structure homogène :
matériel → façonnés → consommables → prestations.
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

ZINGUERIE = Activity(
    slug="zinguerie",
    label="Zinguerie",
    version=1,
    description="Évacuation des eaux pluviales, solins et façonnés zinc.",
    packs=(
        CatalogPack(
            name="Gouttières et descentes",
            items=(
                _p("Gouttière zinc", "ml", "22.00"),
                _p("Gouttière aluminium", "ml", "16.00"),
                _p("Descente d'eau pluviale", "ml", "14.00"),
                _p("Naissance de gouttière", "unité", "12.00"),
                _p("Coude de descente", "unité", "8.00"),
                _p("Dauphin fonte", "unité", "35.00"),
                _p("Crochet de gouttière", "unité", "3.00"),
            ),
        ),
        CatalogPack(
            name="Façonnés et solins",
            items=(
                _p("Solin zinc", "ml", "14.00"),
                _p("Noue zinc", "ml", "20.00"),
                _p("Bande de rive", "ml", "9.00"),
                _p("Faîtière zinc", "ml", "16.00"),
                _p("Habillage de cheminée", "unité", "120.00"),
            ),
        ),
        CatalogPack(
            name="Consommables",
            items=(
                _p("Soudure à l'étain (barre)", "unité", "8.00"),
                _p("Patte à souder", "unité", "1.50"),
                _p("Mastic de zinguerie (cartouche)", "unité", "6.00"),
                _p("Rivets (boîte)", "unité", "9.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre zinguerie", "48.00", 60, unit="heure"),
                _s("Pose de gouttière", "22.00", 25, unit="ml"),
                _s("Pose d'une descente EP", "18.00", 20, unit="ml"),
                _s("Pose d'un solin", "20.00", 25, unit="ml"),
                _s("Réalisation d'une noue", "35.00", 40, unit="ml"),
                _s("Dépose de zinguerie", "12.00", 15, unit="ml"),
            ),
        ),
    ),
)
