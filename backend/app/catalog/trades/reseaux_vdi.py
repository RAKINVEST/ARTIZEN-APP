"""Activité « Réseaux VDI / fibre ».

Voix-données-images : câblage cuivre et optique, brassage, connectivité.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

RESEAUX_VDI = Activity(
    slug="reseaux-vdi",
    label="Réseaux VDI / fibre",
    version=1,
    description="Câblage cuivre et fibre, brassage, coffret de communication, WiFi.",
    packs=(
        CatalogPack(
            name="Câblage et brassage",
            items=(
                _p("Câble RJ45 catégorie 6", "m", "0.90"),
                _p("Câble fibre optique", "m", "1.50"),
                _p("Prise RJ45", "unité", "12.00"),
                _p("Panneau de brassage 24 ports", "unité", "60.00"),
                _p("Coffret de communication (DTI)", "unité", "90.00"),
                _p("Cordon de brassage", "unité", "5.00"),
                _p("Goulotte de câblage", "m", "6.00"),
            ),
        ),
        CatalogPack(
            name="Réseau et connectivité",
            items=(
                _p("Switch réseau 8 ports", "unité", "60.00"),
                _p("Switch PoE 8 ports", "unité", "120.00"),
                _p("Routeur", "unité", "90.00"),
                _p("Borne WiFi", "unité", "110.00"),
                _p("Répéteur WiFi", "unité", "45.00"),
                _p("Injecteur PoE", "unité", "25.00"),
                _p("Module fibre (ONT)", "unité", "70.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre réseau", "50.00", 60, unit="heure"),
                _s("Tirage et raccordement d'une prise RJ45", "45.00", 40),
                _s("Installation d'un coffret de communication", "180.00", 120),
                _s("Certification d'un lien", "25.00", 20),
                _s("Configuration réseau", "120.00", 90),
                _s("Raccordement fibre", "150.00", 90),
            ),
        ),
    ),
)
