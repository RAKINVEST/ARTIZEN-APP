"""Activité « Parquet ».

Parquets, accessoires, finitions. Structure homogène :
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

PARQUET = Activity(
    slug="parquet",
    label="Parquet",
    version=1,
    description="Parquets massif, contrecollé, stratifié : pose, ponçage, finition.",
    packs=(
        CatalogPack(
            name="Parquets",
            items=(
                _p("Parquet massif", "m²", "45.00"),
                _p("Parquet contrecollé", "m²", "35.00"),
                _p("Parquet stratifié", "m²", "18.00"),
                _p("Parquet extérieur (bois exotique)", "m²", "55.00"),
                _p("Sous-couche parquet", "m²", "3.00"),
            ),
        ),
        CatalogPack(
            name="Accessoires et finitions",
            items=(
                _p("Plinthe assortie", "m", "5.00"),
                _p("Barre de seuil", "unité", "9.00"),
                _p("Profilé de finition", "m", "6.00"),
                _p("Cales de dilatation (sachet)", "unité", "4.00"),
            ),
        ),
        CatalogPack(
            name="Consommables",
            items=(
                _p("Colle à parquet (pot)", "unité", "35.00"),
                _p("Vitrificateur (5 L)", "unité", "45.00"),
                _p("Huile pour parquet (2,5 L)", "unité", "40.00"),
                _p("Abrasif de ponçage (lot)", "unité", "15.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre parquet", "45.00", 60, unit="heure"),
                _s("Pose flottante", "20.00", 20, unit="m²"),
                _s("Pose collée", "28.00", 25, unit="m²"),
                _s("Pose clouée", "32.00", 30, unit="m²"),
                _s("Ponçage", "18.00", 20, unit="m²"),
                _s("Vitrification", "15.00", 15, unit="m²"),
                _s("Dépose d'un ancien parquet", "14.00", 18, unit="m²"),
            ),
        ),
    ),
)
