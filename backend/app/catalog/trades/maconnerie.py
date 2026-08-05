"""Activité « Maçonnerie ».

Blocs, liants, ferraillage, coffrage. Structure homogène :
matériel → liants → ferraillage → prestations.
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

MACONNERIE = Activity(
    slug="maconnerie",
    label="Maçonnerie",
    version=1,
    description="Murs, dalles, fondations, chaînages : gros œuvre bâtiment.",
    packs=(
        CatalogPack(
            name="Blocs et briques",
            items=(
                _p("Parpaing (bloc béton)", "unité", "1.50"),
                _p("Brique creuse", "unité", "1.20"),
                _p("Brique de parement", "unité", "0.90"),
                _p("Bloc béton cellulaire", "unité", "3.50"),
                _p("Bloc à bancher", "unité", "4.00"),
                _p("Linteau béton", "ml", "12.00"),
                _p("Planelle", "unité", "2.50"),
            ),
        ),
        CatalogPack(
            name="Liants et granulats",
            items=(
                _p("Ciment (sac 35 kg)", "unité", "9.00"),
                _p("Chaux (sac 25 kg)", "unité", "12.00"),
                _p("Mortier prêt à l'emploi (sac)", "unité", "8.00"),
                _p("Sable", "m³", "45.00"),
                _p("Gravier", "m³", "50.00"),
                _p("Béton prêt à l'emploi", "m³", "130.00"),
            ),
        ),
        CatalogPack(
            name="Ferraillage et coffrage",
            items=(
                _p("Treillis soudé (panneau)", "unité", "18.00"),
                _p("Fer à béton (barre)", "unité", "9.00"),
                _p("Chaînage préfabriqué", "ml", "6.00"),
                _p("Coffrage / banche", "m²", "12.00"),
                _p("Cale d'enrobage (sachet)", "unité", "5.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre maçonnerie", "45.00", 60, unit="heure"),
                _s("Montage d'un mur en parpaings", "45.00", 45, unit="m²"),
                _s("Coulage d'une dalle béton", "40.00", 40, unit="m²"),
                _s("Réalisation d'un chaînage", "35.00", 40, unit="ml"),
                _s("Réalisation de fondations", "60.00", 60, unit="ml"),
                _s("Application d'un enduit de mortier", "30.00", 35, unit="m²"),
            ),
        ),
    ),
)
