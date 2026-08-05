"""Activité « Électricité générale » (+ qualification « IRVE » bornes de recharge).

Le cœur de la famille Électricité : câblage, protection, appareillage, éclairage,
mise aux normes. Les bornes de recharge de véhicule électrique sont réservées
aux installateurs qualifiés IRVE (au-dessus de 3,7 kW) : elles vivent donc dans
la qualification, pas dans l'activité — même patron que le Gaz sous PG.

Prix : estimations de marché HT (option A), point de départ que l'artisan
corrige. TVA 10 % par défaut (rénovation, logement de plus de 2 ans).

Versionnage prévu dès la V1 : ``version=1``.
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

ELECTRICITE_GENERALE = Activity(
    slug="electricite-generale",
    label="Électricité générale",
    version=1,
    description="Câblage, tableau et protection, appareillage, éclairage, mise aux normes.",
    packs=(
        CatalogPack(
            name="Câbles et conducteurs",
            items=(
                _p("Fil H07V-U 1,5 mm²", "m", "0.40"),
                _p("Fil H07V-U 2,5 mm²", "m", "0.60"),
                _p("Fil H07V-U 6 mm²", "m", "1.20"),
                _p("Câble U1000 R2V 3G1,5", "m", "1.20"),
                _p("Câble U1000 R2V 3G2,5", "m", "1.80"),
                _p("Câble U1000 R2V 5G6", "m", "5.50"),
                _p("Câble de terre cuivre nu 25 mm²", "m", "3.50"),
            ),
        ),
        CatalogPack(
            name="Gaines et conduits",
            items=(
                _p("Gaine ICTA Ø16", "m", "0.30"),
                _p("Gaine ICTA Ø20", "m", "0.35"),
                _p("Gaine ICTA Ø25", "m", "0.50"),
                _p("Moulure de finition", "m", "4.00"),
                _p("Goulotte", "m", "6.00"),
                _p("Boîte d'encastrement simple", "unité", "1.20"),
                _p("Boîte d'encastrement double", "unité", "2.00"),
                _p("Boîte de dérivation", "unité", "3.00"),
            ),
        ),
        CatalogPack(
            name="Appareillage",
            items=(
                _p("Interrupteur simple", "unité", "8.00"),
                _p("Interrupteur va-et-vient", "unité", "9.00"),
                _p("Double interrupteur", "unité", "12.00"),
                _p("Bouton poussoir", "unité", "10.00"),
                _p("Variateur de lumière", "unité", "30.00"),
                _p("Prise 2P+T 16 A", "unité", "8.00"),
                _p("Prise double 2P+T", "unité", "14.00"),
                _p("Prise réseau RJ45", "unité", "12.00"),
                _p("Prise TV", "unité", "10.00"),
                _p("Détecteur de mouvement", "unité", "35.00"),
                _p("Plaque de finition", "unité", "5.00"),
            ),
        ),
        CatalogPack(
            name="Protection et tableau",
            items=(
                _p("Tableau nu 3 rangées", "unité", "45.00"),
                _p("Coffret équipé 13 modules", "unité", "120.00"),
                _p("Disjoncteur 10 A", "unité", "8.00"),
                _p("Disjoncteur 16 A", "unité", "8.00"),
                _p("Disjoncteur 20 A", "unité", "9.00"),
                _p("Disjoncteur 32 A", "unité", "11.00"),
                _p("Interrupteur différentiel 40 A 30 mA type AC", "unité", "35.00"),
                _p("Interrupteur différentiel 63 A 30 mA type A", "unité", "55.00"),
                _p("Parafoudre", "unité", "90.00"),
                _p("Contacteur jour/nuit", "unité", "40.00"),
                _p("Télérupteur", "unité", "25.00"),
                _p("Peigne d'alimentation", "unité", "12.00"),
                _p("Barrette de terre", "unité", "8.00"),
            ),
        ),
        CatalogPack(
            name="Éclairage",
            items=(
                _p("Spot LED encastré", "unité", "12.00"),
                _p("Downlight LED", "unité", "30.00"),
                _p("Réglette LED", "unité", "25.00"),
                _p("Applique murale", "unité", "40.00"),
                _p("Hublot extérieur", "unité", "35.00"),
                _p("Ruban LED", "m", "8.00"),
                _p("Driver / transformateur LED", "unité", "20.00"),
                _p("Détecteur crépusculaire", "unité", "30.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre électricité", "45.00", 60, unit="heure"),
                _s("Pose d'un point lumineux", "55.00", 45),
                _s("Pose d'une prise ou d'un interrupteur", "45.00", 30),
                _s("Création d'un circuit spécialisé", "120.00", 90),
                _s("Tirage de câble", "6.00", 10, unit="m"),
                _s("Saignée et encastrement", "25.00", 20, unit="m"),
                _s("Pose et raccordement d'un tableau électrique", "350.00", 240),
                _s("Mise aux normes d'un tableau", "600.00", 480),
                _s("Mise à la terre", "180.00", 120),
                _s("Attestation Consuel", "180.00", 60),
                _s("Recherche de panne électrique", "90.00", 60),
                _s("Dépannage électrique", "120.00", 90),
            ),
        ),
    ),
)

IRVE = Qualification(
    slug="irve",
    label="IRVE — bornes de recharge",
    version=1,
    description="Qualification obligatoire pour installer une borne de recharge de plus de 3,7 kW.",
    packs=(
        CatalogPack(
            name="Bornes de recharge (IRVE)",
            items=(
                _p("Prise renforcée (type Green'Up)", "unité", "90.00"),
                _p("Borne de recharge 7,4 kW", "unité", "700.00"),
                _p("Borne de recharge 22 kW", "unité", "1300.00"),
                _p("Câble de recharge type 2", "unité", "200.00"),
                _p("Protection dédiée (disjoncteur + différentiel type B)", "unité", "180.00"),
                _s("Pose et raccordement d'une borne", "400.00", 240),
                _s("Configuration et mise en service", "150.00", 90),
                _s("Déclaration de conformité IRVE", "120.00", 60),
            ),
        ),
    ),
)
