"""Activité « Traitement de l'eau » — adoucisseurs et filtration.

Courante en rénovation et en dépannage, elle a son propre rayon chez les
distributeurs pros. Séparée parce qu'un plombier peut très bien ne jamais en
poser.

TVA 20 % sur l'équipement de confort (adoucisseur, osmoseur) : il n'entre pas
dans les travaux d'amélioration à taux réduit.
"""

from decimal import Decimal

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

_NEUF = Decimal("20.00")

TRAITEMENT_EAU = Activity(
    slug="traitement-eau",
    label="Traitement de l'eau",
    description="Adoucisseurs, filtration, osmose, anti-tartre.",
    packs=(
        CatalogPack(
            name="Adoucisseurs",
            items=(
                _p("Adoucisseur 16 L", "unité", "650.00", _NEUF),
                _p("Adoucisseur 22 L", "unité", "850.00", _NEUF),
                _p("By-pass d'adoucisseur", "unité", "45.00", _NEUF),
                _p("Sel en pastilles (sac 25 kg)", "unité", "12.00", _NEUF),
                _p("Anti-tartre magnétique", "unité", "90.00", _NEUF),
                _s("Pose d'un adoucisseur", "350.00", 240),
                _s("Mise en service d'un adoucisseur", "120.00", 90),
                _s("Analyse de la dureté de l'eau", "35.00", 30),
                _s("Entretien annuel d'un adoucisseur", "130.00", 90),
            ),
        ),
        CatalogPack(
            name="Filtration",
            items=(
                _p("Filtre à tamis lavable", "unité", "65.00"),
                _p("Filtre à cartouche avec cartouche", "unité", "40.00"),
                _p("Cartouche de rechange", "unité", "18.00"),
                _p("Osmoseur sous évier", "unité", "220.00", _NEUF),
                _p("Disconnecteur", "unité", "75.00"),
                _s("Pose d'un filtre ou d'un osmoseur", "180.00", 120),
                _s("Remplacement des cartouches", "70.00", 45),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(_s("Main-d'œuvre traitement de l'eau", "55.00", 60, unit="heure"),),
        ),
    ),
)
