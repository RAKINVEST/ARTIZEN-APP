"""Activité « Peinture ».

Peintures, préparation des supports, revêtements muraux. Structure homogène :
matériel → préparation → revêtements → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

PEINTURE = Activity(
    slug="peinture",
    label="Peinture",
    version=1,
    description="Peintures intérieures et extérieures, préparation, revêtements muraux.",
    packs=(
        CatalogPack(
            name="Peintures",
            items=(
                _p("Peinture murale mate (10 L)", "unité", "45.00"),
                _p("Peinture murale satinée (10 L)", "unité", "55.00"),
                _p("Peinture velours (10 L)", "unité", "60.00"),
                _p("Peinture laque (2,5 L)", "unité", "35.00"),
                _p("Peinture plafond (10 L)", "unité", "40.00"),
                _p("Sous-couche universelle (10 L)", "unité", "35.00"),
                _p("Peinture de façade (15 L)", "unité", "80.00"),
                _p("Peinture anti-humidité (2,5 L)", "unité", "40.00"),
            ),
        ),
        CatalogPack(
            name="Préparation des supports",
            items=(
                _p("Enduit de rebouchage (sac)", "unité", "12.00"),
                _p("Enduit de lissage (sac)", "unité", "18.00"),
                _p("Enduit de garnissage (pot)", "unité", "22.00"),
                _p("Fixateur / durcisseur (5 L)", "unité", "25.00"),
                _p("Bande à joint de fissure", "m", "0.80"),
            ),
        ),
        CatalogPack(
            name="Revêtements muraux",
            items=(
                _p("Papier peint (rouleau)", "unité", "20.00"),
                _p("Papier intissé (rouleau)", "unité", "25.00"),
                _p("Toile de verre (rouleau)", "unité", "35.00"),
                _p("Fibre de verre (rouleau)", "unité", "40.00"),
                _p("Colle à papier peint (paquet)", "unité", "8.00"),
            ),
        ),
        CatalogPack(
            name="Consommables",
            items=(
                _p("Rouleau", "unité", "6.00"),
                _p("Pinceau", "unité", "5.00"),
                _p("Bâche de protection", "unité", "8.00"),
                _p("Ruban de masquage", "unité", "4.00"),
                _p("Abrasif (lot)", "unité", "6.00"),
                _p("Bac à peinture", "unité", "4.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre peinture", "40.00", 60, unit="heure"),
                _s("Préparation des surfaces", "10.00", 15, unit="m²"),
                _s("Ratissage complet", "18.00", 20, unit="m²"),
                _s("Mise en peinture 2 couches", "15.00", 15, unit="m²"),
                _s("Peinture de plafond", "16.00", 15, unit="m²"),
                _s("Pose de toile de verre", "14.00", 15, unit="m²"),
                _s("Pose de papier peint", "14.00", 15, unit="m²"),
            ),
        ),
    ),
)
