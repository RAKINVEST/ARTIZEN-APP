"""Activité « Diagnostic immobilier ».

Matériel de mesure, consommables. Structure homogène :
matériel → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

DIAGNOSTIC = Activity(
    slug="diagnostic",
    label="Diagnostic immobilier",
    version=1,
    description="Diagnostics réglementaires : DPE, amiante, plomb, gaz, électricité, Carrez.",
    packs=(
        CatalogPack(
            name="Matériel de mesure",
            items=(
                _p("Détecteur de plomb à fluorescence X", "unité", "3500.00"),
                _p("Humidimètre", "unité", "120.00"),
                _p("Détecteur de gaz / CO", "unité", "180.00"),
                _p("Testeur d'installation électrique", "unité", "250.00"),
                _p("Testeur d'installation gaz", "unité", "200.00"),
                _p("Caméra thermique", "unité", "600.00"),
            ),
        ),
        CatalogPack(
            name="Consommables et fournitures",
            items=(
                _p("Kit de prélèvement amiante (lot)", "unité", "18.00"),
                _p("Flacon de prélèvement (lot)", "unité", "12.00"),
                _p("Étiquette d'échantillon (lot)", "unité", "6.00"),
                _p("Sachet zip (boîte)", "unité", "8.00"),
                _p("Gants et EPI (boîte)", "unité", "15.00"),
                _p("Mètre / télémètre laser", "unité", "45.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre diagnostic", "50.00", 60, unit="heure"),
                _s("DPE (diagnostic de performance énergétique)", "120.00", 90),
                _s("Diagnostic amiante", "110.00", 90),
                _s("Constat de risque d'exposition au plomb (CREP)", "130.00", 90),
                _s("Diagnostic électrique", "110.00", 90),
                _s("Diagnostic gaz", "110.00", 90),
                _s("État parasitaire / termites", "120.00", 90),
                _s("Mesurage Loi Carrez", "90.00", 60),
            ),
        ),
    ),
)
