"""Activité « Étanchéité ».

Membranes, isolation support, évacuations. Structure homogène :
matériel → support → accessoires → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ETANCHEITE = Activity(
    slug="etancheite",
    label="Étanchéité",
    version=1,
    description="Étanchéité des toitures-terrasses et ouvrages : membranes, SEL, relevés.",
    packs=(
        CatalogPack(
            name="Membranes et revêtements",
            items=(
                _p("Membrane bitumineuse (rouleau)", "unité", "70.00"),
                _p("Membrane EPDM", "m²", "18.00"),
                _p("Membrane PVC", "m²", "20.00"),
                _p("Résine d'étanchéité (bidon 20 kg)", "unité", "150.00"),
                _p("Système d'étanchéité liquide (kit)", "unité", "120.00"),
            ),
        ),
        CatalogPack(
            name="Isolation et supports",
            items=(
                _p("Panneau isolant toiture-terrasse", "m²", "18.00"),
                _p("Pare-vapeur (rouleau)", "unité", "45.00"),
                _p("Feutre de désolidarisation (rouleau)", "unité", "40.00"),
                _p("Plot de terrasse réglable", "unité", "3.50"),
            ),
        ),
        CatalogPack(
            name="Accessoires et évacuations",
            items=(
                _p("Naissance d'évacuation", "unité", "35.00"),
                _p("Platine d'évacuation EP", "unité", "40.00"),
                _p("Bande de solin", "ml", "9.00"),
                _p("Profilé de rive", "ml", "6.00"),
                _p("Primaire d'accrochage (bidon)", "unité", "30.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre étanchéité", "48.00", 60, unit="heure"),
                _s("Pose de membrane bitume soudée", "35.00", 40, unit="m²"),
                _s("Pose d'une membrane EPDM", "30.00", 35, unit="m²"),
                _s("Application d'un SEL", "40.00", 45, unit="m²"),
                _s("Réalisation d'un relevé d'étanchéité", "35.00", 40, unit="ml"),
                _s("Pose d'une évacuation EP", "90.00", 60),
            ),
        ),
    ),
)
