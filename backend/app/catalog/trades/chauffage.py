"""Activité « Chauffage » — production et émetteurs.

Activée séparément de la plomberie : la plupart des artisans français sont
plombiers-chauffagistes et cochent les deux, mais un plombier qui ne pose
jamais de chaudière ne doit pas traîner trente articles de chauffage dans son
catalogue. C'est la règle d'or appliquée au catalogue lui-même.

TVA : 5,5 % sur les équipements d'amélioration énergétique posés par un RGE
(chaudière à condensation, PAC, plancher chauffant), 10 % sinon.
"""

from decimal import Decimal

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

_ENERGIE = Decimal("5.50")

CHAUFFAGE = Activity(
    slug="chauffage",
    label="Chauffage",
    description="Chaudières, pompes à chaleur, radiateurs, plancher chauffant.",
    packs=(
        CatalogPack(
            name="Chauffage — production",
            items=(
                _p("Chaudière gaz à condensation murale", "unité", "1800.00", _ENERGIE),
                _p("Chaudière gaz à condensation au sol", "unité", "2800.00", _ENERGIE),
                _p("Pompe à chaleur air/eau split 8 kW", "unité", "5500.00", _ENERGIE),
                _p("Pompe à chaleur air/eau monobloc 8 kW", "unité", "5000.00", _ENERGIE),
                _p("Ballon tampon 100 L", "unité", "450.00", _ENERGIE),
                _p("Kit hydraulique de raccordement", "unité", "240.00", _ENERGIE),
                _p("Circulateur de chauffage", "unité", "180.00"),
                _p("Vase d'expansion chauffage 18 L", "unité", "55.00"),
                _p("Désemboueur magnétique", "unité", "130.00"),
                _p("Soupape de sécurité chauffage", "unité", "20.00"),
                _p("Thermostat d'ambiance", "unité", "60.00"),
                _p("Thermostat connecté", "unité", "180.00"),
                _p("Sonde extérieure", "unité", "55.00"),
                _s("Pose d'une chaudière murale", "900.00", 480),
                _s("Pose d'une pompe à chaleur air/eau", "1600.00", 960),
                _s("Dépose de l'ancienne chaudière", "220.00", 180),
                _s("Désembouage du réseau", "450.00", 300),
                _s("Mise en service et réglage de la production", "150.00", 90),
                _s("Dépannage de chaudière", "150.00", 90),
            ),
        ),
        CatalogPack(
            name="Chauffage — émetteurs et réseau",
            items=(
                _p("Radiateur acier type 11 — 400x400 (270 W)", "unité", "46.00"),
                _p("Radiateur acier type 22 — 400x800 (996 W)", "unité", "115.00"),
                _p("Radiateur acier type 22 — 600x1000 (1732 W)", "unité", "305.00"),
                _p("Radiateur fonte (rénovation)", "unité", "280.00"),
                _p("Sèche-serviettes eau chaude", "unité", "110.00"),
                _p("Sèche-serviettes mixte", "unité", "180.00"),
                _p("Robinet thermostatique", "unité", "26.00"),
                _p("Tête thermostatique", "unité", "18.00"),
                _p("Té de réglage", "unité", "12.00"),
                _p("Coude de raccordement radiateur", "unité", "8.00"),
                _p("Purgeur manuel", "unité", "2.00"),
                _p("Purgeur automatique", "unité", "9.00"),
                _p("Plancher chauffant hydraulique", "m²", "45.00", _ENERGIE),
                _p("Collecteur plancher chauffant 6 départs", "unité", "180.00", _ENERGIE),
                _p("Tube PER-BAO Ø16 (plancher chauffant)", "m", "0.90", _ENERGIE),
                _s("Pose d'un radiateur", "250.00", 180),
                _s("Dépose d'un radiateur", "90.00", 60),
                _s("Pose d'un plancher chauffant", "55.00", 60, unit="m²"),
                _s("Purge et équilibrage du réseau", "120.00", 90),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(_s("Main-d'œuvre chauffage", "60.00", 60, unit="heure"),),
        ),
    ),
)
