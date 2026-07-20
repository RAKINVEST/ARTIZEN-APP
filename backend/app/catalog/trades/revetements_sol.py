"""Activité « Revêtements de sol » (solier / moquettiste).

Sols souples, préparation du support, accessoires. Structure homogène :
matériel → préparation → accessoires → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

REVETEMENTS_SOL = Activity(
    slug="revetements-sol",
    label="Revêtements de sol",
    version=1,
    description="Sols souples (PVC, lino, moquette), préparation et pose.",
    packs=(
        CatalogPack(
            name="Revêtements souples",
            items=(
                _p("Sol PVC en lame", "m²", "22.00"),
                _p("Sol PVC en rouleau", "m²", "15.00"),
                _p("Sol vinyle clipsable", "m²", "28.00"),
                _p("Linoléum", "m²", "24.00"),
                _p("Moquette", "m²", "18.00"),
                _p("Dalle plombante", "m²", "20.00"),
            ),
        ),
        CatalogPack(
            name="Préparation du support",
            items=(
                _p("Ragréage autolissant (sac 25 kg)", "unité", "20.00"),
                _p("Primaire d'accrochage (5 L)", "unité", "25.00"),
                _p("Sous-couche isolante", "m²", "3.00"),
            ),
        ),
        CatalogPack(
            name="Accessoires",
            items=(
                _p("Plinthe", "m", "4.00"),
                _p("Barre de seuil", "unité", "9.00"),
                _p("Colle pour sol souple (pot)", "unité", "30.00"),
                _p("Bande de jonction / soudure", "m", "2.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre revêtements de sol", "42.00", 60, unit="heure"),
                _s("Ragréage du support", "18.00", 20, unit="m²"),
                _s("Pose d'un sol souple collé", "20.00", 20, unit="m²"),
                _s("Pose d'un sol clipsable", "18.00", 18, unit="m²"),
                _s("Pose de moquette", "16.00", 18, unit="m²"),
                _s("Dépose d'un ancien sol", "12.00", 15, unit="m²"),
            ),
        ),
    ),
)
