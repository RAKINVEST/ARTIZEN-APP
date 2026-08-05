"""Activité « Vitrerie / Miroiterie ».

Vitrages, verrières, accessoires. Structure homogène :
matériel → ouvrages verre → consommables → prestations.
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

VITRERIE = Activity(
    slug="vitrerie",
    label="Vitrerie / Miroiterie",
    version=1,
    description="Vitrages, doubles vitrages, verrières, miroirs et dépannage.",
    packs=(
        CatalogPack(
            name="Vitrages",
            items=(
                _p("Simple vitrage", "m²", "60.00"),
                _p("Double vitrage", "m²", "120.00"),
                _p("Verre feuilleté sécurit", "m²", "150.00"),
                _p("Verre trempé", "m²", "140.00"),
                _p("Verre dépoli", "m²", "110.00"),
                _p("Miroir", "m²", "80.00"),
                _p("Verre imprimé", "m²", "90.00"),
            ),
        ),
        CatalogPack(
            name="Ouvrages verriers",
            items=(
                _p("Verrière atelier", "m²", "450.00"),
                _p("Paroi de douche", "unité", "550.00"),
                _p("Garde-corps en verre", "ml", "350.00"),
                _p("Crédence en verre", "m²", "180.00"),
                _p("Store intégré", "unité", "300.00"),
            ),
        ),
        CatalogPack(
            name="Accessoires et consommables",
            items=(
                _p("Parclose", "ml", "3.00"),
                _p("Joint de vitrage", "ml", "2.50"),
                _p("Mastic de vitrier (cartouche)", "unité", "8.00"),
                _p("Cale de vitrage (sachet)", "unité", "5.00"),
                _p("Ventouse à verre", "unité", "25.00"),
                _p("Profilé de serrage", "ml", "6.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre vitrerie", "48.00", 60, unit="heure"),
                _s("Remplacement d'un vitrage", "90.00", 60),
                _s("Pose d'un double vitrage", "60.00", 45, unit="m²"),
                _s("Pose d'une verrière", "250.00", 180),
                _s("Pose d'une paroi de douche", "200.00", 150),
                _s("Pose d'un miroir", "80.00", 60),
                _s("Dépannage bris de glace", "150.00", 90),
            ),
        ),
    ),
)
