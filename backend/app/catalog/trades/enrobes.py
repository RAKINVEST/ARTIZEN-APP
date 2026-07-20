"""Activité « Enrobés / Voirie ».

Enrobés, liants, structure de chaussée. Structure homogène :
matériel → structure → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ENROBES = Activity(
    slug="enrobes",
    label="Enrobés / Voirie",
    version=1,
    description="Enrobés, allées, accès et cours : chaussée et revêtements de sol extérieurs.",
    packs=(
        CatalogPack(
            name="Enrobés et liants",
            items=(
                _p("Enrobé à chaud", "tonne", "110.00"),
                _p("Enrobé à froid (sac 25 kg)", "unité", "12.00"),
                _p("Émulsion de bitume (bidon)", "unité", "35.00"),
                _p("Grave-bitume", "tonne", "90.00"),
                _p("Gravillonnage", "tonne", "45.00"),
                _p("Enrobé drainant", "tonne", "130.00"),
            ),
        ),
        CatalogPack(
            name="Structure de chaussée",
            items=(
                _p("Grave concassée 0/31.5", "tonne", "25.00"),
                _p("Géotextile (rouleau)", "unité", "60.00"),
                _p("Géogrille (rouleau)", "unité", "120.00"),
                _p("Bordure béton", "ml", "12.00"),
                _p("Caniveau", "ml", "22.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre enrobés", "45.00", 60, unit="heure"),
                _s("Décaissement / rabotage", "12.00", 12, unit="m²"),
                _s("Mise en œuvre d'une couche de forme", "18.00", 18, unit="m²"),
                _s("Application d'enrobé", "35.00", 30, unit="m²"),
                _s("Réalisation d'un accès / allée", "45.00", 40, unit="m²"),
                _s("Compactage", "8.00", 10, unit="m²"),
            ),
        ),
    ),
)
