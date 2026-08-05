"""Activité « Forage / Puits ».

Équipements de forage, pompage. Structure homogène :
matériel → pompage → prestations.
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

FORAGE = Activity(
    slug="forage",
    label="Forage / Puits",
    version=1,
    description="Forage d'eau, puits, équipement de pompage et mise en service.",
    packs=(
        CatalogPack(
            name="Équipements de forage",
            items=(
                _p("Tube de forage PVC", "ml", "18.00"),
                _p("Crépine", "ml", "35.00"),
                _p("Massif filtrant / gravier (sac)", "unité", "12.00"),
                _p("Tête de puits", "unité", "120.00"),
                _p("Bentonite (sac)", "unité", "25.00"),
                _p("Ciment d'annulaire (sac)", "unité", "10.00"),
            ),
        ),
        CatalogPack(
            name="Pompage",
            items=(
                _p("Pompe immergée", "unité", "550.00"),
                _p("Coffret de commande", "unité", "180.00"),
                _p("Câble immergé", "ml", "6.00"),
                _p("Ballon surpresseur", "unité", "220.00"),
                _p("Clapet anti-retour", "unité", "35.00"),
                _p("Sonde de niveau", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre forage", "50.00", 60, unit="heure"),
                _s("Forage", "90.00", 60, unit="ml"),
                _s("Équipement et tubage du forage", "35.00", 40, unit="ml"),
                _s("Pose d'une pompe immergée", "400.00", 240),
                _s("Développement / nettoyage du forage", "350.00", 240),
                _s("Essai de pompage", "300.00", 240),
                _s("Analyse d'eau", "120.00", 30),
            ),
        ),
    ),
)
