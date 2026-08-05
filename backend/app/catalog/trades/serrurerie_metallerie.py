"""Activité « Serrurerie / Métallerie ».

Serrures, ouvrages métalliques, profilés. Structure homogène :
matériel → ouvrages → consommables → prestations.
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

SERRURERIE_METALLERIE = Activity(
    slug="serrurerie-metallerie",
    label="Serrurerie / Métallerie",
    version=1,
    description="Serrures, blindage, ouvrages métalliques et dépannage.",
    packs=(
        CatalogPack(
            name="Serrures et cylindres",
            items=(
                _p("Serrure en applique", "unité", "60.00"),
                _p("Serrure à encastrer", "unité", "70.00"),
                _p("Cylindre européen", "unité", "35.00"),
                _p("Verrou de sûreté", "unité", "45.00"),
                _p("Serrure multipoints", "unité", "220.00"),
                _p("Béquille / poignée", "unité", "30.00"),
                _p("Gâche électrique", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Ouvrages métalliques",
            items=(
                _p("Grille de défense", "m²", "180.00"),
                _p("Barreaudage", "ml", "90.00"),
                _p("Portail métallique", "unité", "1200.00"),
                _p("Garde-corps métallique", "ml", "150.00"),
                _p("Rideau métallique", "m²", "220.00"),
                _p("Porte métallique", "unité", "600.00"),
            ),
        ),
        CatalogPack(
            name="Profilés et consommables",
            items=(
                _p("Tube acier", "ml", "8.00"),
                _p("Cornière", "ml", "6.00"),
                _p("Platine de fixation", "unité", "5.00"),
                _p("Électrode de soudure (paquet)", "unité", "18.00"),
                _p("Peinture antirouille (bidon)", "unité", "35.00"),
                _p("Cheville de scellement (boîte)", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre serrurerie", "48.00", 60, unit="heure"),
                _s("Ouverture de porte (dépannage)", "120.00", 45),
                _s("Remplacement d'un cylindre", "90.00", 45),
                _s("Pose d'une serrure multipoints", "220.00", 120),
                _s("Fabrication d'un ouvrage sur mesure", "55.00", 60, unit="heure"),
                _s("Pose d'un garde-corps", "80.00", 60, unit="ml"),
                _s("Blindage d'une porte", "800.00", 240),
            ),
        ),
    ),
)
