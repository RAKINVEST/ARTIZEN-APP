"""Activité « Interphonie / Visiophonie ».

Platines de rue, moniteurs intérieurs, bus et commande d'ouverture.
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

INTERPHONIE = Activity(
    slug="interphonie",
    label="Interphonie / Visiophonie",
    version=1,
    description="Platines de rue, moniteurs, bus 2 fils et commande d'accès.",
    packs=(
        CatalogPack(
            name="Interphonie / Visiophonie",
            items=(
                _p("Platine de rue audio", "unité", "120.00"),
                _p("Platine de rue vidéo", "unité", "220.00"),
                _p("Combiné intérieur audio", "unité", "70.00"),
                _p("Moniteur vidéo intérieur", "unité", "160.00"),
                _p("Alimentation", "unité", "45.00"),
                _p("Câble bus 2 fils", "m", "1.20"),
                _p("Gâche électrique", "unité", "35.00"),
                _p("Serrure électrique de portail", "unité", "90.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre interphonie", "50.00", 60, unit="heure"),
                _s("Pose d'une platine de rue", "120.00", 90),
                _s("Pose d'un moniteur intérieur", "80.00", 60),
                _s("Câblage du bus", "6.00", 15, unit="m"),
                _s("Mise en service et paramétrage", "90.00", 60),
            ),
        ),
    ),
)
