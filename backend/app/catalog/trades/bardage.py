"""Activité « Bardage ».

Bardages, ossature, fixations, finitions. Structure homogène :
matériel → ossature → finitions → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

BARDAGE = Activity(
    slug="bardage",
    label="Bardage",
    version=1,
    description="Habillage de façade : bardage bois, composite, métal, fibre-ciment.",
    packs=(
        CatalogPack(
            name="Bardages",
            items=(
                _p("Bardage bois", "m²", "35.00"),
                _p("Bardage composite", "m²", "55.00"),
                _p("Bardage PVC", "m²", "25.00"),
                _p("Bardage métallique", "m²", "40.00"),
                _p("Bardage fibre-ciment", "m²", "45.00"),
                _p("Clin de bardage", "ml", "6.00"),
            ),
        ),
        CatalogPack(
            name="Ossature et fixations",
            items=(
                _p("Tasseau d'ossature", "ml", "2.50"),
                _p("Équerre de fixation", "unité", "2.00"),
                _p("Grille anti-rongeurs", "ml", "3.00"),
                _p("Vis inox de bardage (boîte)", "unité", "18.00"),
                _p("Clip de fixation (boîte)", "unité", "15.00"),
                _p("Pare-pluie (rouleau)", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Finitions",
            items=(
                _p("Profilé d'angle", "ml", "6.00"),
                _p("Bavette basse", "ml", "8.00"),
                _p("Cornière de finition", "ml", "5.00"),
                _p("Lasure / saturateur (5 L)", "unité", "45.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre bardage", "45.00", 60, unit="heure"),
                _s("Pose de l'ossature", "18.00", 20, unit="m²"),
                _s("Pose du pare-pluie", "6.00", 8, unit="m²"),
                _s("Pose du bardage", "35.00", 40, unit="m²"),
                _s("Traitement / finition du bardage", "12.00", 15, unit="m²"),
                _s("Dépose d'un bardage existant", "15.00", 18, unit="m²"),
            ),
        ),
    ),
)
