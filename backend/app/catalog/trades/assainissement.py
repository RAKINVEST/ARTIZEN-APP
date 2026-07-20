"""Activité « Assainissement ».

Canalisations, regards, filière de traitement. Structure homogène :
matériel → filière → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ASSAINISSEMENT = Activity(
    slug="assainissement",
    label="Assainissement",
    version=1,
    description="Assainissement individuel et collectif : fosses, micro-stations, épandage.",
    packs=(
        CatalogPack(
            name="Canalisations et regards",
            items=(
                _p("Tuyau PVC Ø100", "ml", "9.00"),
                _p("Tuyau PVC Ø125", "ml", "12.00"),
                _p("Regard de visite", "unité", "60.00"),
                _p("Boîte de branchement", "unité", "45.00"),
                _p("Culotte / raccord", "unité", "8.00"),
                _p("Tabouret de branchement", "unité", "70.00"),
            ),
        ),
        CatalogPack(
            name="Filière et traitement",
            items=(
                _p("Fosse toutes eaux (cuve)", "unité", "1200.00"),
                _p("Micro-station d'épuration", "unité", "4500.00"),
                _p("Bac dégraisseur", "unité", "350.00"),
                _p("Tuyau d'épandage drainé", "ml", "6.00"),
                _p("Filtre à sable (kit)", "unité", "600.00"),
                _p("Ventilation primaire", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre assainissement", "45.00", 60, unit="heure"),
                _s("Pose d'une fosse toutes eaux", "900.00", 480),
                _s("Installation d'une micro-station", "1500.00", 600),
                _s("Réalisation d'un épandage", "35.00", 40, unit="ml"),
                _s("Raccordement au tout-à-l'égout", "1200.00", 600),
                _s("Ouverture de tranchée", "22.00", 20, unit="ml"),
                _s("Contrôle et mise en service", "180.00", 120),
            ),
        ),
    ),
)
