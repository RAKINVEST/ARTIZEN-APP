"""Activité « Ventilation » — VMC simple et double flux.

Dans le périmètre habituel du chauffagiste, mais activable seule : un artisan
qui ne pose que de la VMC existe, et un plombier qui n'en pose jamais ne doit
pas la voir.
"""

from decimal import Decimal

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

_ENERGIE = Decimal("5.50")

VENTILATION = Activity(
    slug="ventilation",
    label="Ventilation (VMC)",
    description="VMC simple flux, hygroréglable et double flux.",
    packs=(
        CatalogPack(
            name="Ventilation (VMC)",
            items=(
                _p("Caisson VMC simple flux autoréglable", "unité", "120.00"),
                _p("VMC hygroréglable type A", "unité", "250.00", _ENERGIE),
                _p("VMC hygroréglable type B", "unité", "380.00", _ENERGIE),
                _p("VMC double flux", "unité", "1200.00", _ENERGIE),
                _p("Bouche d'extraction cuisine", "unité", "25.00"),
                _p("Bouche d'extraction salle de bain ou WC", "unité", "15.00"),
                _p("Bouche hygroréglable", "unité", "35.00"),
                _p("Entrée d'air de menuiserie", "unité", "8.00"),
                _p("Gaine souple isolée Ø125", "m", "6.00"),
                _p("Manchon de raccordement", "unité", "5.00"),
                _p("Sortie de toiture", "unité", "60.00"),
                _p("Grille de façade", "unité", "20.00"),
                _p("Plots antivibratiles", "unité", "9.00"),
                _s("Pose d'une VMC simple flux", "450.00", 300),
                _s("Pose d'une VMC double flux", "1200.00", 720),
                _s("Dépose de l'ancienne VMC", "90.00", 60),
                _s("Nettoyage et remplacement des bouches", "110.00", 90),
                _s("Mesure de débit et réglage", "90.00", 60),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(_s("Main-d'œuvre ventilation", "55.00", 60, unit="heure"),),
        ),
    ),
)
