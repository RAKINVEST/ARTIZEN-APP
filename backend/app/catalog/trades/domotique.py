"""Activité « Domotique / Smart Home ».

Maison connectée : commande centralisée, scénarios, capteurs, confort piloté.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

DOMOTIQUE = Activity(
    slug="domotique",
    label="Domotique / Smart Home",
    version=1,
    description="Box domotique, scénarios, capteurs et confort connecté.",
    packs=(
        CatalogPack(
            name="Commande et scénarios",
            items=(
                _p("Box domotique", "unité", "250.00"),
                _p("Interrupteur connecté", "unité", "45.00"),
                _p("Micromodule éclairage", "unité", "40.00"),
                _p("Micromodule volet roulant", "unité", "45.00"),
                _p("Télécommande de scénarios", "unité", "35.00"),
                _p("Passerelle radio (Zigbee/Z-Wave)", "unité", "70.00"),
            ),
        ),
        CatalogPack(
            name="Capteurs et détecteurs",
            items=(
                _p("Détecteur de mouvement connecté", "unité", "35.00"),
                _p("Capteur d'ouverture", "unité", "25.00"),
                _p("Capteur de température et humidité", "unité", "30.00"),
                _p("Détecteur de fumée connecté", "unité", "45.00"),
                _p("Détecteur d'inondation", "unité", "30.00"),
                _p("Capteur de luminosité", "unité", "28.00"),
            ),
        ),
        CatalogPack(
            name="Confort connecté",
            items=(
                _p("Thermostat connecté", "unité", "130.00"),
                _p("Tête thermostatique connectée", "unité", "60.00"),
                _p("Prise connectée", "unité", "25.00"),
                _p("Station météo connectée", "unité", "120.00"),
                _p("Assistant vocal", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre domotique", "50.00", 60, unit="heure"),
                _s("Installation et configuration de la box", "180.00", 120),
                _s("Programmation de scénarios", "120.00", 90),
                _s("Paramétrage de l'application", "70.00", 45),
                _s("Formation à l'utilisation", "80.00", 60),
            ),
        ),
    ),
)
