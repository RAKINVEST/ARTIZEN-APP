"""Activité « Stores & pergolas ».

Stores, bannes, pergolas, motorisation. Structure homogène :
matériel → équipement → accessoires → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

STORES_PERGOLAS = Activity(
    slug="stores-pergolas",
    label="Stores & pergolas",
    version=1,
    description="Protection solaire : stores, bannes, pergolas et motorisation.",
    packs=(
        CatalogPack(
            name="Stores et bannes",
            items=(
                _p("Store banne", "unité", "700.00"),
                _p("Store vertical extérieur", "unité", "350.00"),
                _p("Store screen", "unité", "450.00"),
                _p("Brise-soleil orientable", "unité", "550.00"),
                _p("Toile de rechange", "m²", "45.00"),
            ),
        ),
        CatalogPack(
            name="Pergolas",
            items=(
                _p("Pergola bioclimatique", "m²", "450.00"),
                _p("Pergola aluminium adossée", "m²", "300.00"),
                _p("Pergola autoportée", "m²", "350.00"),
                _p("Lame orientable", "ml", "60.00"),
                _p("Poteau aluminium", "unité", "120.00"),
            ),
        ),
        CatalogPack(
            name="Motorisation et accessoires",
            items=(
                _p("Motorisation de store", "unité", "180.00"),
                _p("Télécommande", "unité", "45.00"),
                _p("Capteur vent / soleil", "unité", "90.00"),
                _p("Éclairage LED intégré", "unité", "60.00"),
                _p("Kit de fixation", "unité", "35.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre pose", "45.00", 60, unit="heure"),
                _s("Pose d'un store banne", "250.00", 180),
                _s("Pose d'une pergola", "600.00", 480),
                _s("Motorisation et réglages", "150.00", 120),
                _s("Mise en service et réglage", "90.00", 60),
                _s("Dépose d'un équipement existant", "120.00", 90),
            ),
        ),
    ),
)
