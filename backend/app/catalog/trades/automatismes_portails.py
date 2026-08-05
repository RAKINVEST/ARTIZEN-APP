"""Activité « Portails & automatismes ».

Portails, motorisation, commande. Structure homogène :
matériel → motorisation → commande → prestations.
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

AUTOMATISMES_PORTAILS = Activity(
    slug="automatismes-portails",
    label="Portails & automatismes",
    version=1,
    description="Portails, portes de garage et automatismes d'ouverture.",
    packs=(
        CatalogPack(
            name="Portails et fermetures",
            items=(
                _p("Portail battant aluminium", "unité", "1400.00"),
                _p("Portail coulissant aluminium", "unité", "1800.00"),
                _p("Portillon", "unité", "600.00"),
                _p("Portail PVC", "unité", "900.00"),
                _p("Poteau de portail", "unité", "180.00"),
            ),
        ),
        CatalogPack(
            name="Motorisation et automatismes",
            items=(
                _p("Motorisation à bras (kit)", "unité", "450.00"),
                _p("Motorisation enterrée (kit)", "unité", "700.00"),
                _p("Motorisation coulissante (kit)", "unité", "550.00"),
                _p("Motorisation de garage (kit)", "unité", "350.00"),
                _p("Crémaillère", "ml", "18.00"),
                _p("Rail au sol", "ml", "25.00"),
            ),
        ),
        CatalogPack(
            name="Commande et sécurité",
            items=(
                _p("Télécommande", "unité", "45.00"),
                _p("Clavier à code", "unité", "80.00"),
                _p("Interphone de portail", "unité", "180.00"),
                _p("Cellule photoélectrique (paire)", "unité", "60.00"),
                _p("Feu clignotant", "unité", "35.00"),
                _p("Batterie de secours", "unité", "90.00"),
                _p("Récepteur radio", "unité", "50.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre automatismes", "48.00", 60, unit="heure"),
                _s("Pose d'un portail", "350.00", 240),
                _s("Motorisation d'un portail existant", "300.00", 180),
                _s("Pose d'une porte de garage motorisée", "400.00", 240),
                _s("Raccordement électrique", "150.00", 90),
                _s("Réglage et mise en service", "120.00", 90),
                _s("Dépannage d'un automatisme", "110.00", 60),
            ),
        ),
    ),
)
