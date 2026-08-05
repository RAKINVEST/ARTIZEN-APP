"""Activité « Façade / Ravalement ».

Enduits, peintures, armatures, traitements. Structure homogène :
matériel → traitements → accessoires → prestations.
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

FACADE = Activity(
    slug="facade",
    label="Façade / Ravalement",
    version=1,
    description="Ravalement, enduits, peinture et traitement des façades.",
    packs=(
        CatalogPack(
            name="Enduits et mortiers",
            items=(
                _p("Enduit monocouche (sac 25 kg)", "unité", "16.00"),
                _p("Enduit de façade taloché (sac)", "unité", "18.00"),
                _p("Mortier de réparation (sac)", "unité", "20.00"),
                _p("Sous-enduit d'accrochage (sac)", "unité", "15.00"),
                _p("Crépi projeté (sac)", "unité", "14.00"),
            ),
        ),
        CatalogPack(
            name="Peintures et traitements",
            items=(
                _p("Peinture de façade (15 L)", "unité", "80.00"),
                _p("Hydrofuge de surface (bidon 20 L)", "unité", "60.00"),
                _p("Fixateur de façade (5 L)", "unité", "30.00"),
                _p("Traitement anti-mousse (5 L)", "unité", "25.00"),
                _p("Imperméabilisant de classe I4 (15 L)", "unité", "90.00"),
            ),
        ),
        CatalogPack(
            name="Armatures et accessoires",
            items=(
                _p("Treillis d'armature (rouleau)", "unité", "35.00"),
                _p("Profilé d'angle", "ml", "3.00"),
                _p("Baguette d'arrêt", "ml", "2.50"),
                _p("Cheville de façade (boîte)", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre ravalement", "45.00", 60, unit="heure"),
                _s("Nettoyage haute pression", "8.00", 10, unit="m²"),
                _s("Réparation de fissures", "18.00", 20, unit="ml"),
                _s("Application d'un enduit monocouche", "35.00", 40, unit="m²"),
                _s("Mise en peinture de façade", "22.00", 25, unit="m²"),
                _s("Installation d'échafaudage", "800.00", 480),
            ),
        ),
    ),
)
