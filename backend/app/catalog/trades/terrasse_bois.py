"""Activité « Terrasse bois ».

Lames, structure, fixations. Structure homogène :
matériel → structure → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

TERRASSE_BOIS = Activity(
    slug="terrasse-bois",
    label="Terrasse bois",
    version=1,
    description="Terrasses en bois et composite : structure, platelage, finition.",
    packs=(
        CatalogPack(
            name="Lames et platelage",
            items=(
                _p("Lame bois exotique", "m²", "55.00"),
                _p("Lame pin traité", "m²", "25.00"),
                _p("Lame composite", "m²", "45.00"),
                _p("Lambourde", "ml", "4.00"),
                _p("Solive", "ml", "6.00"),
            ),
        ),
        CatalogPack(
            name="Structure et supports",
            items=(
                _p("Plot réglable", "unité", "3.50"),
                _p("Plot béton", "unité", "5.00"),
                _p("Vérin / support", "unité", "6.00"),
                _p("Feutre bitumé (rouleau)", "unité", "35.00"),
                _p("Bande d'étanchéité lambourde (rouleau)", "unité", "18.00"),
            ),
        ),
        CatalogPack(
            name="Fixations et finitions",
            items=(
                _p("Vis inox terrasse (boîte)", "unité", "22.00"),
                _p("Clip de fixation (boîte)", "unité", "18.00"),
                _p("Profilé de finition", "ml", "6.00"),
                _p("Huile / saturateur bois (bidon)", "unité", "45.00"),
                _p("Cale de terrasse (sachet)", "unité", "5.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre terrasse bois", "45.00", 60, unit="heure"),
                _s("Préparation et réglage du sol", "12.00", 15, unit="m²"),
                _s("Pose de la structure", "20.00", 20, unit="m²"),
                _s("Pose du platelage", "30.00", 30, unit="m²"),
                _s("Application d'un saturateur", "8.00", 10, unit="m²"),
                _s("Réalisation d'un habillage / plinthe", "15.00", 15, unit="ml"),
            ),
        ),
    ),
)
