"""Activité « Paysagisme / Jardinier ».

Végétaux, matériaux, consommables. Structure homogène :
matériel → aménagement → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

PAYSAGISME = Activity(
    slug="paysagisme",
    label="Paysagisme / Jardinier",
    version=1,
    description="Création et entretien d'espaces verts : plantations, gazon, massifs.",
    packs=(
        CatalogPack(
            name="Végétaux",
            items=(
                _p("Arbre", "unité", "120.00"),
                _p("Arbuste", "unité", "18.00"),
                _p("Haie", "ml", "15.00"),
                _p("Gazon en rouleau", "m²", "8.00"),
                _p("Semence de gazon (kg)", "unité", "12.00"),
                _p("Plante vivace", "unité", "6.00"),
                _p("Massif de fleurs", "m²", "25.00"),
            ),
        ),
        CatalogPack(
            name="Matériaux d'aménagement",
            items=(
                _p("Terre végétale", "m³", "40.00"),
                _p("Paillage / écorce (sac)", "unité", "8.00"),
                _p("Géotextile (rouleau)", "unité", "35.00"),
                _p("Bordure de jardin", "ml", "9.00"),
                _p("Gravier décoratif", "tonne", "60.00"),
                _p("Pas japonais", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Consommables et fournitures",
            items=(
                _p("Engrais (sac)", "unité", "18.00"),
                _p("Terreau (sac)", "unité", "9.00"),
                _p("Tuteur", "unité", "4.00"),
                _p("Attache-plante (lot)", "unité", "5.00"),
                _p("Amendement calcaire (sac)", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre paysagisme", "42.00", 60, unit="heure"),
                _s("Préparation du terrain", "6.00", 8, unit="m²"),
                _s("Engazonnement", "8.00", 10, unit="m²"),
                _s("Plantation d'arbres et arbustes", "35.00", 30, unit="unité"),
                _s("Création d'un massif", "30.00", 35, unit="m²"),
                _s("Taille et entretien", "40.00", 60, unit="heure"),
                _s("Élagage", "50.00", 60, unit="heure"),
            ),
        ),
    ),
)
