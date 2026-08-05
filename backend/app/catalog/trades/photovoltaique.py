"""Activité « Photovoltaïque ».

Production d'électricité solaire : modules, onduleurs, stockage, structure de
pose, raccordement. Installable par un électricien ; la **certification QualiPV**
n'est pas une réservation légale de travaux mais une qualification de *mention*
qui ouvre les aides au client — elle sera modélisée comme mention (comme le
n° RGE), pas comme un pack réservé.

Prix : estimations de marché HT (option A). TVA 10 % par défaut ; le petit
photovoltaïque d'autoconsommation peut relever de taux réduits — à ajuster par
l'artisan selon le cas.

Versionnage prévu dès la V1 : ``version=1``.
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

PHOTOVOLTAIQUE = Activity(
    slug="photovoltaique",
    label="Photovoltaïque",
    version=1,
    description="Panneaux, onduleurs, stockage, structure et raccordement solaire.",
    packs=(
        CatalogPack(
            name="Modules et onduleurs",
            items=(
                _p("Panneau photovoltaïque 400 Wc", "unité", "180.00"),
                _p("Panneau photovoltaïque 500 Wc", "unité", "230.00"),
                _p("Micro-onduleur", "unité", "130.00"),
                _p("Onduleur string 3 kW", "unité", "700.00"),
                _p("Onduleur hybride 6 kW", "unité", "1500.00"),
                _p("Optimiseur de puissance", "unité", "70.00"),
                _p("Batterie de stockage 5 kWh", "unité", "3500.00"),
            ),
        ),
        CatalogPack(
            name="Structure et raccordement",
            items=(
                _p("Rail de fixation", "m", "12.00"),
                _p("Crochet de fixation sur tuile", "unité", "8.00"),
                _p("Kit d'intégration ou surimposition", "unité", "200.00"),
                _p("Câble solaire", "m", "2.00"),
                _p("Connecteur MC4 (paire)", "unité", "6.00"),
                _p("Coffret de protection DC/AC", "unité", "150.00"),
                _p("Passe-toiture étanche", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre photovoltaïque", "55.00", 60, unit="heure"),
                _s("Étude et dimensionnement", "250.00", 120),
                _s("Pose d'un champ photovoltaïque 3 kWc", "1200.00", 480),
                _s("Raccordement et mise en service", "400.00", 240),
                _s("Démarches Enedis et Consuel", "350.00", 180),
                _s("Pose d'un système de supervision", "150.00", 90),
            ),
        ),
    ),
)
