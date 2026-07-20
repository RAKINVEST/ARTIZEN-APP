"""Activité « Ascenseur ».

Appareils élévateurs, composants, sécurité. Structure homogène :
matériel → composants → sécurité → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ASCENSEUR = Activity(
    slug="ascenseur",
    label="Ascenseur",
    version=1,
    description="Ascenseurs privatifs, plateformes PMR, monte-escaliers : pose et maintenance.",
    packs=(
        CatalogPack(
            name="Appareils élévateurs",
            items=(
                _p("Ascenseur privatif", "unité", "18000.00"),
                _p("Plateforme élévatrice PMR", "unité", "9000.00"),
                _p("Monte-escalier", "unité", "5000.00"),
                _p("Monte-charge", "unité", "8000.00"),
                _p("Élévateur à nacelle", "unité", "12000.00"),
            ),
        ),
        CatalogPack(
            name="Composants",
            items=(
                _p("Cabine", "unité", "4500.00"),
                _p("Motorisation / treuil", "unité", "3500.00"),
                _p("Guide de cabine", "ml", "45.00"),
                _p("Câble / sangle de levage", "ml", "18.00"),
                _p("Porte palière", "unité", "1200.00"),
                _p("Armoire de commande", "unité", "1800.00"),
            ),
        ),
        CatalogPack(
            name="Sécurité et accessoires",
            items=(
                _p("Parachute de sécurité", "unité", "600.00"),
                _p("Boîtier d'appel", "unité", "180.00"),
                _p("Éclairage de secours", "unité", "90.00"),
                _p("Téléalarme", "unité", "350.00"),
                _p("Amortisseur", "unité", "220.00"),
                _p("Fin de course", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre ascenseur", "55.00", 60, unit="heure"),
                _s("Étude et implantation", "800.00", 480),
                _s("Installation d'un ascenseur privatif", "6000.00", 2400),
                _s("Pose d'une plateforme PMR", "2500.00", 960),
                _s("Raccordement et mise en service", "900.00", 480),
                _s("Contrat de maintenance annuel", "600.00", 240, unit="an"),
                _s("Mise aux normes d'un appareil", "1500.00", 600),
            ),
        ),
    ),
)
