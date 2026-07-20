"""Activité « Carrelage ».

Carrelage et faïence, colles et mortiers, finitions. Structure homogène :
matériel → colles/mortiers → accessoires → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

CARRELAGE = Activity(
    slug="carrelage",
    label="Carrelage",
    version=1,
    description="Carrelage sol et mur, faïence, mosaïque, colles et finitions.",
    packs=(
        CatalogPack(
            name="Carrelage et faïence",
            items=(
                _p("Carrelage sol grès cérame", "m²", "25.00"),
                _p("Carrelage sol imitation bois", "m²", "30.00"),
                _p("Faïence murale", "m²", "20.00"),
                _p("Carrelage extérieur antidérapant", "m²", "28.00"),
                _p("Mosaïque", "m²", "45.00"),
                _p("Plinthe carrelée", "m", "6.00"),
                _p("Listel décoratif", "m", "12.00"),
            ),
        ),
        CatalogPack(
            name="Colles et mortiers",
            items=(
                _p("Colle à carrelage (sac 25 kg)", "unité", "18.00"),
                _p("Mortier-joint (sac 5 kg)", "unité", "12.00"),
                _p("Primaire d'accrochage (5 L)", "unité", "25.00"),
                _p("Mortier de ragréage (sac 25 kg)", "unité", "20.00"),
            ),
        ),
        CatalogPack(
            name="Accessoires et finitions",
            items=(
                _p("Croisillons (sachet)", "unité", "5.00"),
                _p("Profilé de finition", "m", "6.00"),
                _p("Nez de marche", "m", "12.00"),
                _p("Natte d'étanchéité", "m²", "15.00"),
                _p("Joint silicone sanitaire", "unité", "6.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre carrelage", "45.00", 60, unit="heure"),
                _s("Pose de carrelage au sol", "40.00", 40, unit="m²"),
                _s("Pose de faïence murale", "45.00", 45, unit="m²"),
                _s("Ragréage du support", "18.00", 20, unit="m²"),
                _s("Réalisation des joints", "10.00", 12, unit="m²"),
                _s("Réalisation d'une étanchéité (SPEC)", "25.00", 25, unit="m²"),
                _s("Dépose d'un ancien carrelage", "22.00", 25, unit="m²"),
            ),
        ),
    ),
)
