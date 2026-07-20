"""Activité « Isolation extérieure (ITE) ».

Panneaux isolants, systèmes d'enduit, consommables. Structure homogène :
matériel → systèmes → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ISOLATION_EXTERIEURE = Activity(
    slug="isolation-exterieure",
    label="Isolation extérieure (ITE)",
    version=1,
    description="Isolation thermique par l'extérieur : panneaux, enduit, finition.",
    packs=(
        CatalogPack(
            name="Panneaux isolants",
            items=(
                _p("Panneau PSE ITE", "m²", "12.00"),
                _p("Panneau laine de roche ITE", "m²", "18.00"),
                _p("Panneau fibre de bois ITE", "m²", "22.00"),
                _p("Panneau PSE graphité", "m²", "15.00"),
            ),
        ),
        CatalogPack(
            name="Systèmes d'enduit",
            items=(
                _p("Sous-enduit d'accrochage (sac)", "unité", "18.00"),
                _p("Enduit de finition ITE (sac)", "unité", "22.00"),
                _p("Trame d'armature (rouleau)", "unité", "40.00"),
                _p("Profilé de départ", "ml", "6.00"),
                _p("Baguette d'angle", "ml", "3.50"),
                _p("Cheville à rosace (boîte)", "unité", "18.00"),
            ),
        ),
        CatalogPack(
            name="Consommables",
            items=(
                _p("Colle-mortier ITE (sac 25 kg)", "unité", "16.00"),
                _p("Rail de départ", "ml", "5.00"),
                _p("Profilé goutte d'eau", "ml", "4.00"),
                _p("Mousse de calfeutrement (bombe)", "unité", "8.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre ITE", "45.00", 60, unit="heure"),
                _s("Pose de l'isolant (collé/chevillé)", "40.00", 45, unit="m²"),
                _s("Application sous-enduit + trame", "25.00", 30, unit="m²"),
                _s("Enduit de finition", "22.00", 25, unit="m²"),
                _s("Traitement des points singuliers", "18.00", 20, unit="ml"),
                _s("Installation d'échafaudage", "800.00", 480),
            ),
        ),
    ),
)
