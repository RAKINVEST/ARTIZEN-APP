"""Activité « Ramonage / Fumisterie ».

Conduits, consommables. Structure homogène :
matériel → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

RAMONAGE = Activity(
    slug="ramonage",
    label="Ramonage / Fumisterie",
    version=1,
    description="Ramonage, tubage et fumisterie : conduits, chapeaux, attestations.",
    packs=(
        CatalogPack(
            name="Conduits et fumisterie",
            items=(
                _p("Conduit inox double paroi", "ml", "60.00"),
                _p("Tubage flexible inox", "ml", "35.00"),
                _p("Té de raccordement", "unité", "45.00"),
                _p("Chapeau de cheminée", "unité", "80.00"),
                _p("Plaque d'étanchéité", "unité", "25.00"),
                _p("Coude inox", "unité", "30.00"),
                _p("Solin d'étanchéité", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Consommables et accessoires",
            items=(
                _p("Bûche de ramonage", "unité", "9.00"),
                _p("Hérisson de ramonage", "unité", "18.00"),
                _p("Brosse métallique", "unité", "8.00"),
                _p("Mastic réfractaire (cartouche)", "unité", "12.00"),
                _p("Tampon de visite", "unité", "22.00"),
                _p("Grille anti-oiseaux", "unité", "10.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre fumisterie", "45.00", 60, unit="heure"),
                _s("Ramonage d'un conduit", "70.00", 45),
                _s("Débistrage mécanique", "250.00", 180),
                _s("Tubage d'un conduit", "45.00", 40, unit="ml"),
                _s("Pose d'un conduit de fumée", "70.00", 60, unit="ml"),
                _s("Test d'étanchéité et attestation", "120.00", 60),
                _s("Installation d'un chapeau de cheminée", "90.00", 60),
            ),
        ),
    ),
)
