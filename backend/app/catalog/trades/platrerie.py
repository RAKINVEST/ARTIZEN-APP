"""Activité « Plâtrerie / Plaquiste ».

Cloisons sèches, doublages, plafonds, isolation. Structure homogène :
matériel → ossature → isolation → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

PLATRERIE = Activity(
    slug="platrerie",
    label="Plâtrerie / Plaquiste",
    version=1,
    description="Cloisons, doublages, plafonds, plâtrerie et isolation intérieure.",
    packs=(
        CatalogPack(
            name="Plaques et carreaux",
            items=(
                _p("Plaque de plâtre BA13 standard", "m²", "3.50"),
                _p("Plaque hydrofuge BA13", "m²", "6.00"),
                _p("Plaque phonique BA13", "m²", "8.00"),
                _p("Plaque haute dureté", "m²", "9.00"),
                _p("Carreau de plâtre", "m²", "12.00"),
                _p("Plaque de sol", "m²", "14.00"),
            ),
        ),
        CatalogPack(
            name="Ossature et rails",
            items=(
                _p("Rail R48", "m", "1.60"),
                _p("Montant M48", "m", "1.80"),
                _p("Fourrure F530", "m", "1.50"),
                _p("Suspente", "unité", "0.80"),
                _p("Cornière de plafond", "m", "1.20"),
                _p("Bande résiliente", "m", "0.60"),
            ),
        ),
        CatalogPack(
            name="Isolation",
            items=(
                _p("Laine de verre GR32", "m²", "6.00"),
                _p("Laine de roche", "m²", "8.50"),
                _p("Panneau polystyrène", "m²", "7.00"),
                _p("Membrane frein-vapeur", "m²", "1.50"),
            ),
        ),
        CatalogPack(
            name="Consommables",
            items=(
                _p("Vis TTPC 25 mm (boîte)", "unité", "8.00"),
                _p("Vis TTPC 35 mm (boîte)", "unité", "9.00"),
                _p("Bande à joint (rouleau)", "unité", "3.00"),
                _p("Enduit à joint (sac 25 kg)", "unité", "18.00"),
                _p("Bande armée d'angle", "m", "0.90"),
                _p("Cheville pour plaque (boîte)", "unité", "6.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre plâtrerie", "45.00", 60, unit="heure"),
                _s("Pose d'une cloison", "35.00", 30, unit="m²"),
                _s("Pose d'un doublage", "30.00", 25, unit="m²"),
                _s("Pose d'un plafond", "40.00", 35, unit="m²"),
                _s("Pose d'un faux-plafond suspendu", "45.00", 40, unit="m²"),
                _s("Bandes et enduit (finition)", "12.00", 15, unit="m²"),
                _s("Dépose d'une cloison", "18.00", 20, unit="m²"),
            ),
        ),
    ),
)
