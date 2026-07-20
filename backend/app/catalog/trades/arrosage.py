"""Activité « Arrosage automatique ».

Réseau, arroseurs, programmation. Structure homogène :
matériel → diffusion → automatismes → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ARROSAGE = Activity(
    slug="arrosage",
    label="Arrosage automatique",
    version=1,
    description="Réseaux d'arrosage enterrés, goutte-à-goutte et programmation.",
    packs=(
        CatalogPack(
            name="Réseau et tuyaux",
            items=(
                _p("Tuyau PE Ø25", "ml", "1.50"),
                _p("Tuyau PE Ø32", "ml", "2.20"),
                _p("Goutte-à-goutte", "ml", "1.20"),
                _p("Raccord PE", "unité", "3.50"),
                _p("Collier de prise", "unité", "4.00"),
                _p("Vanne d'arrêt", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Arroseurs et diffuseurs",
            items=(
                _p("Tuyère escamotable", "unité", "9.00"),
                _p("Turbine escamotable", "unité", "18.00"),
                _p("Goutteur", "unité", "0.80"),
                _p("Micro-asperseur", "unité", "3.50"),
                _p("Buse", "unité", "2.50"),
                _p("Regard de vannes", "unité", "25.00"),
            ),
        ),
        CatalogPack(
            name="Programmation et automatismes",
            items=(
                _p("Programmateur d'arrosage", "unité", "90.00"),
                _p("Électrovanne", "unité", "25.00"),
                _p("Sonde de pluie", "unité", "35.00"),
                _p("Pompe de surface", "unité", "180.00"),
                _p("Récupérateur d'eau programmé", "unité", "220.00"),
                _p("Transformateur", "unité", "30.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre arrosage", "42.00", 60, unit="heure"),
                _s("Étude et plan d'arrosage", "150.00", 90),
                _s("Pose du réseau enterré", "12.00", 15, unit="ml"),
                _s("Pose des arroseurs", "18.00", 20, unit="unité"),
                _s("Installation du programmateur", "120.00", 90),
                _s("Mise en service et réglage", "90.00", 60),
                _s("Hivernage de l'installation", "80.00", 60),
            ),
        ),
    ),
)
