"""Qualification « PG » (Professionnel Gaz) — pack Gaz.

Jamais chargé par défaut. Toute installation, modification ou entretien d'une
installation gaz domestique est légalement réservé à un professionnel certifié
PG : mettre ces articles dans le catalogue d'un artisan non certifié lui
ferait chiffrer une prestation qu'il n'a pas le droit d'exécuter.

La qualification est aussi une **mention du devis** — voir `docs/DECISIONS.md`,
décision 7 : la même case cochée alimente le catalogue et le PDF.
"""

from app.catalog.trades.definitions import (
    CatalogPack,
    Qualification,
)
from app.catalog.trades.definitions import (
    prestation as _s,
)
from app.catalog.trades.definitions import (
    produit as _p,
)

PG = Qualification(
    slug="pg",
    label="PG — Professionnel Gaz",
    description="Certification obligatoire pour toute intervention sur une installation gaz.",
    packs=(
        CatalogPack(
            name="Gaz",
            items=(
                _p("Tube cuivre gaz Ø14", "m", "7.00"),
                _p("Tube PLT gaz", "m", "12.00"),
                _p("Robinet gaz ROAI", "unité", "25.00"),
                _p("Détendeur propane ou butane", "unité", "30.00"),
                _p("Flexible gaz NF à embouts mécaniques", "unité", "20.00"),
                _p("Coffret gaz extérieur", "unité", "90.00"),
                _p("Ventouse concentrique", "unité", "110.00"),
                _p("Conduit de raccordement", "unité", "45.00"),
                _s("Création d'une alimentation gaz", "70.00", 60, unit="m"),
                _s("Essai d'étanchéité du réseau gaz", "150.00", 90),
                _s("Certificat de conformité gaz", "180.00", 90),
                _s(
                    "Entretien annuel de chaudière gaz",
                    "130.00",
                    60,
                    note="Entretien annuel obligatoire, donne lieu à une attestation.",
                ),
            ),
        ),
    ),
)
