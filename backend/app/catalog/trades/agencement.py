"""Activité « Agencement ».

Mobilier sur mesure, panneaux, quincaillerie. Structure homogène :
matériels du domaine → quincaillerie → prestations.
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

AGENCEMENT = Activity(
    slug="agencement",
    label="Agencement",
    version=1,
    description="Mobilier sur mesure, dressings, banques d'accueil, aménagements.",
    packs=(
        CatalogPack(
            name="Mobilier sur mesure",
            items=(
                _p("Meuble sur mesure", "ml", "250.00"),
                _p("Bibliothèque sur mesure", "ml", "220.00"),
                _p("Banque d'accueil", "unité", "1200.00"),
                _p("Plan de travail sur mesure", "ml", "180.00"),
                _p("Tête de lit sur mesure", "unité", "350.00"),
            ),
        ),
        CatalogPack(
            name="Panneaux et matériaux",
            items=(
                _p("Panneau mélaminé", "m²", "25.00"),
                _p("Panneau MDF", "m²", "20.00"),
                _p("Panneau stratifié", "m²", "35.00"),
                _p("Plan compact", "m²", "90.00"),
                _p("Chant / bordure", "m", "2.00"),
            ),
        ),
        CatalogPack(
            name="Quincaillerie",
            items=(
                _p("Charnière", "unité", "6.00"),
                _p("Coulisse de tiroir", "unité", "18.00"),
                _p("Poignée", "unité", "10.00"),
                _p("Système coulissant", "unité", "60.00"),
                _p("Pied réglable", "unité", "5.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre agencement", "50.00", 60, unit="heure"),
                _s("Étude et conception", "250.00", 150),
                _s("Fabrication sur mesure", "60.00", 60, unit="heure"),
                _s("Pose de mobilier", "300.00", 240),
                _s("Dépose d'un agencement", "150.00", 120),
            ),
        ),
    ),
)
