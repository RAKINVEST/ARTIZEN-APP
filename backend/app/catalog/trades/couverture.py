"""Activité « Couverture ».

Tuiles, ardoises, écran et support, fixations. Structure homogène :
matériel → support → consommables → prestations.
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

COUVERTURE = Activity(
    slug="couverture",
    label="Couverture",
    version=1,
    description="Toitures tuiles et ardoises : pose, réfection, faîtage.",
    packs=(
        CatalogPack(
            name="Tuiles et ardoises",
            items=(
                _p("Tuile terre cuite", "m²", "18.00"),
                _p("Tuile béton", "m²", "12.00"),
                _p("Ardoise naturelle", "m²", "45.00"),
                _p("Tuile de rive", "unité", "4.50"),
                _p("Tuile faîtière", "ml", "9.00"),
                _p("Closoir ventilé", "ml", "8.00"),
                _p("Chatière de ventilation", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Écran et support",
            items=(
                _p("Écran sous-toiture HPV (rouleau)", "unité", "90.00"),
                _p("Liteau", "ml", "1.20"),
                _p("Contre-latte", "ml", "1.00"),
                _p("Volige", "m²", "9.00"),
            ),
        ),
        CatalogPack(
            name="Fixations et consommables",
            items=(
                _p("Crochet à ardoise (boîte)", "unité", "18.00"),
                _p("Pointe inox (boîte)", "unité", "12.00"),
                _p("Vis de couverture (boîte)", "unité", "15.00"),
                _p("Mortier de scellement (sac)", "unité", "10.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre couverture", "48.00", 60, unit="heure"),
                _s("Pose de tuiles", "45.00", 45, unit="m²"),
                _s("Pose d'ardoises", "70.00", 60, unit="m²"),
                _s("Pose d'un écran sous-toiture", "12.00", 12, unit="m²"),
                _s("Réfection de faîtage", "40.00", 40, unit="ml"),
                _s("Dépose d'une couverture", "20.00", 25, unit="m²"),
            ),
        ),
    ),
)
