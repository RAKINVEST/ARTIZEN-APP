"""Activité « Désamiantage » et qualification d'exercice « Certification amiante (SS4) ».

L'activité couvre le retrait de matériaux amiantés (EPI, confinement, déchets).
La qualification d'exercice SS4 réserve un pack dédié aux interventions
réglementées sur matériaux amiantés — importable seulement si l'entreprise
est certifiée, comme PG / IRVE / fluides frigorigènes (voir Qualification).

Structure d'activité homogène : matériel → traitement → matériel de chantier →
prestations. Prix estimations de marché HT (option A), versionné v1. TVA 10 %.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    Qualification,
)
from app.catalog.trades.definitions import (
    prestation as _s,
)
from app.catalog.trades.definitions import (
    produit as _p,
)

DESAMIANTAGE = Activity(
    slug="desamiantage",
    label="Désamiantage",
    version=1,
    description="Retrait de matériaux amiantés : confinement, décontamination, déchets.",
    packs=(
        CatalogPack(
            name="EPI et confinement",
            items=(
                _p("Combinaison jetable type 5", "unité", "12.00"),
                _p("Masque FFP3 (boîte)", "unité", "35.00"),
                _p("Demi-masque à cartouche", "unité", "45.00"),
                _p("Film de confinement (rouleau)", "unité", "40.00"),
                _p("Sas de décontamination (kit)", "unité", "600.00"),
                _p("Ruban adhésif (rouleau)", "unité", "6.00"),
            ),
        ),
        CatalogPack(
            name="Traitement et déchets",
            items=(
                _p("Sac amiante double (lot)", "unité", "18.00"),
                _p("Big-bag amianté", "unité", "9.00"),
                _p("Surfactant / imprégnant (bidon)", "unité", "35.00"),
                _p("Film polyane (rouleau)", "unité", "30.00"),
                _p("Étiquette réglementaire amiante (lot)", "unité", "8.00"),
                _p("Fût de déchets", "unité", "22.00"),
            ),
        ),
        CatalogPack(
            name="Matériel de chantier",
            items=(
                _p("Aspirateur THE à filtre absolu", "unité", "900.00"),
                _p("Extracteur d'air à filtration", "unité", "700.00"),
                _p("Douche de décontamination", "unité", "500.00"),
                _p("Pulvérisateur", "unité", "60.00"),
                _p("Unité de filtration d'eau", "unité", "450.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre désamiantage", "55.00", 60, unit="heure"),
                _s("Confinement de la zone", "40.00", 40, unit="m²"),
                _s("Retrait de matériaux amiantés", "60.00", 50, unit="m²"),
                _s("Décontamination", "600.00", 240),
                _s("Conditionnement et évacuation des déchets", "180.00", 90, unit="m³"),
                _s("Analyse libératoire", "350.00", 60),
                _s("Établissement du plan de retrait", "800.00", 300),
            ),
        ),
    ),
)

#: Qualification d'exercice SS4 — droit d'intervenir sur matériaux amiantés
#: (sans retrait de grande ampleur : maintenance, perçage, dépose ponctuelle).
#: Réserve un pack dédié, jamais chargé par défaut.
CERTIFICATION_AMIANTE = Qualification(
    slug="certification-amiante",
    label="Certification amiante (SS4)",
    version=1,
    description="Interventions réglementées sur matériaux amiantés (sous-section 4).",
    packs=(
        CatalogPack(
            name="Amiante SS4 (interventions réglementées)",
            items=(
                _p("Kit EPI amiante SS4", "unité", "45.00"),
                _p("Sac à déchets amiante réglementaire (lot)", "unité", "18.00"),
                _p("Film de protection de zone (rouleau)", "unité", "35.00"),
                _p("Aspirateur THE (filtre absolu)", "unité", "900.00"),
                _s("Intervention SS4 sur matériau amianté", "80.00", 60, unit="m²"),
                _s("Rédaction du mode opératoire SS4", "300.00", 180),
                _s("Analyse d'empoussièrement", "250.00", 60),
                _s("Évacuation des déchets amiante (SS4)", "180.00", 90, unit="m³"),
            ),
        ),
    ),
)
