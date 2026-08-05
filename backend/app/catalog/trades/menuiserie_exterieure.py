"""Activité « Menuiserie extérieure / Fermetures ».

Fenêtres, portes, volets, accessoires. Structure homogène :
matériel → fermetures → accessoires → prestations.
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

MENUISERIE_EXTERIEURE = Activity(
    slug="menuiserie-exterieure",
    label="Menuiserie extérieure / Fermetures",
    version=1,
    description="Fenêtres, portes, baies, volets et fermetures.",
    packs=(
        CatalogPack(
            name="Fenêtres et portes",
            items=(
                _p("Fenêtre PVC double vitrage", "unité", "320.00"),
                _p("Fenêtre aluminium", "unité", "480.00"),
                _p("Fenêtre bois", "unité", "450.00"),
                _p("Porte-fenêtre", "unité", "550.00"),
                _p("Porte d'entrée", "unité", "900.00"),
                _p("Baie coulissante", "unité", "1100.00"),
                _p("Fenêtre de toit", "unité", "400.00"),
            ),
        ),
        CatalogPack(
            name="Fermetures et volets",
            items=(
                _p("Volet roulant", "unité", "350.00"),
                _p("Volet battant", "unité", "220.00"),
                _p("Porte de garage sectionnelle", "unité", "1200.00"),
                _p("Persienne", "unité", "180.00"),
                _p("Moustiquaire", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Accessoires et étanchéité",
            items=(
                _p("Appui de fenêtre", "unité", "35.00"),
                _p("Bavette aluminium", "ml", "12.00"),
                _p("Mousse expansive (bombe)", "unité", "8.00"),
                _p("Joint compribande (rouleau)", "unité", "15.00"),
                _p("Vis de fixation (boîte)", "unité", "10.00"),
                _p("Patte de scellement", "unité", "1.50"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre menuiserie extérieure", "48.00", 60, unit="heure"),
                _s("Pose d'une fenêtre", "150.00", 120),
                _s("Pose d'une porte d'entrée", "250.00", 180),
                _s("Pose d'une baie coulissante", "300.00", 240),
                _s("Pose d'un volet roulant", "120.00", 90),
                _s("Pose d'une porte de garage", "350.00", 240),
                _s("Dépose d'une menuiserie", "60.00", 45),
            ),
        ),
    ),
)
