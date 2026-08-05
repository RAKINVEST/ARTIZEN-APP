"""Activité « Piscine ».

Structure, filtration, équipements. Structure homogène :
matériel → équipement → accessoires → prestations.
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

PISCINE = Activity(
    slug="piscine",
    label="Piscine",
    version=1,
    description="Construction et équipement de piscines : bassin, filtration, traitement.",
    packs=(
        CatalogPack(
            name="Structure et étanchéité",
            items=(
                _p("Kit piscine coque", "unité", "6500.00"),
                _p("Bloc à bancher piscine", "unité", "5.00"),
                _p("Liner", "m²", "22.00"),
                _p("Membrane armée PVC", "m²", "40.00"),
                _p("Margelle", "ml", "35.00"),
                _p("Escalier de piscine", "unité", "700.00"),
            ),
        ),
        CatalogPack(
            name="Filtration et traitement",
            items=(
                _p("Pompe de filtration", "unité", "350.00"),
                _p("Filtre à sable", "unité", "300.00"),
                _p("Skimmer", "unité", "45.00"),
                _p("Buse de refoulement", "unité", "18.00"),
                _p("Coffret électrique piscine", "unité", "220.00"),
                _p("Électrolyseur au sel", "unité", "600.00"),
                _p("Régulation pH automatique", "unité", "350.00"),
            ),
        ),
        CatalogPack(
            name="Équipements et accessoires",
            items=(
                _p("Projecteur LED", "unité", "120.00"),
                _p("Volet roulant de piscine", "unité", "3500.00"),
                _p("Pompe à chaleur piscine", "unité", "1800.00"),
                _p("Échelle inox", "unité", "180.00"),
                _p("Bâche à bulles", "m²", "9.00"),
                _p("Local technique préfabriqué", "unité", "450.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre piscine", "48.00", 60, unit="heure"),
                _s("Terrassement du bassin", "1500.00", 600),
                _s("Pose d'une piscine coque", "3000.00", 960),
                _s("Réalisation d'un bassin béton", "6000.00", 2400),
                _s("Pose du liner", "22.00", 25, unit="m²"),
                _s("Installation de la filtration", "800.00", 480),
                _s("Mise en service et équilibrage de l'eau", "300.00", 180),
            ),
        ),
    ),
)
