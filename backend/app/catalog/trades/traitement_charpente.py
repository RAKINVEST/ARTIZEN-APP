"""Activité « Traitement de charpente / anti-nuisibles ».

Produits de traitement, matériel d'application. Structure homogène :
matériel → matériel d'application → prestations.
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

TRAITEMENT_CHARPENTE = Activity(
    slug="traitement-charpente",
    label="Traitement de charpente / anti-nuisibles",
    version=1,
    description="Traitement curatif et préventif des bois : insectes, champignons, termites.",
    packs=(
        CatalogPack(
            name="Produits de traitement",
            items=(
                _p("Insecticide / fongicide charpente (5 L)", "unité", "45.00"),
                _p("Xylophène (bidon)", "unité", "40.00"),
                _p("Traitement curatif par injection (kit)", "unité", "90.00"),
                _p("Produit anti-termites (bidon)", "unité", "60.00"),
                _p("Badigeon fongicide (pot)", "unité", "25.00"),
                _p("Bouchon d'injection (boîte)", "unité", "18.00"),
            ),
        ),
        CatalogPack(
            name="Matériel d'application",
            items=(
                _p("Pulvérisateur", "unité", "60.00"),
                _p("Pistolet d'injection", "unité", "120.00"),
                _p("Mèche à bois", "unité", "9.00"),
                _p("Buse d'injection (lot)", "unité", "15.00"),
                _p("Combinaison de protection", "unité", "12.00"),
                _p("Masque respiratoire", "unité", "35.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre traitement", "45.00", 60, unit="heure"),
                _s("Diagnostic parasitaire", "150.00", 90),
                _s("Traitement de charpente par pulvérisation", "18.00", 20, unit="m²"),
                _s("Traitement curatif par injection", "22.00", 25, unit="ml"),
                _s("Bûchage des bois attaqués", "50.00", 60, unit="heure"),
                _s("Traitement anti-termites", "25.00", 25, unit="m²"),
                _s("Attestation de traitement", "90.00", 45),
            ),
        ),
    ),
)
