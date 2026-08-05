"""Activité « Nettoyage / après-chantier ».

Produits d'entretien, matériel. Structure homogène :
matériel → consommables → prestations.
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

NETTOYAGE = Activity(
    slug="nettoyage",
    label="Nettoyage / après-chantier",
    version=1,
    description="Nettoyage de fin de chantier, remise en état, vitres et sols.",
    packs=(
        CatalogPack(
            name="Produits d'entretien",
            items=(
                _p("Nettoyant multi-usage (5 L)", "unité", "15.00"),
                _p("Dégraissant industriel (bidon)", "unité", "18.00"),
                _p("Décapant (bidon)", "unité", "22.00"),
                _p("Détartrant (bidon)", "unité", "16.00"),
                _p("Nettoyant vitres (bidon)", "unité", "12.00"),
                _p("Sac poubelle (rouleau)", "unité", "9.00"),
                _p("Nettoyant sol (bidon)", "unité", "14.00"),
            ),
        ),
        CatalogPack(
            name="Matériel et consommables",
            items=(
                _p("Chiffon microfibre (lot)", "unité", "12.00"),
                _p("Serpillière (lot)", "unité", "9.00"),
                _p("Éponge (lot)", "unité", "6.00"),
                _p("Balai", "unité", "12.00"),
                _p("Raclette à vitre", "unité", "15.00"),
                _p("Seau", "unité", "8.00"),
                _p("Essuie-tout (lot)", "unité", "10.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre nettoyage", "35.00", 60, unit="heure"),
                _s("Nettoyage de fin de chantier", "6.00", 10, unit="m²"),
                _s("Nettoyage après travaux", "8.00", 12, unit="m²"),
                _s("Nettoyage de vitres", "5.00", 8, unit="m²"),
                _s("Décapage et remise en état de sols", "10.00", 15, unit="m²"),
                _s("Débarras / enlèvement d'encombrants", "40.00", 30, unit="m³"),
                _s("Nettoyage haute pression", "8.00", 10, unit="m²"),
            ),
        ),
    ),
)
