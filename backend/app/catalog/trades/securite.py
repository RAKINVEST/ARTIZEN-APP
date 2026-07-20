"""Activités de sécurité électronique — trois catalogues distincts, comme sur le
terrain : « Alarme intrusion », « Vidéosurveillance », « Contrôle d'accès ».

Prix estimations de marché HT (option A), versionnés v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

ALARME_INTRUSION = Activity(
    slug="alarme-intrusion",
    label="Alarme intrusion",
    version=1,
    description="Centrale, détection, sirènes et transmission.",
    packs=(
        CatalogPack(
            name="Centrale et détection",
            items=(
                _p("Centrale d'alarme", "unité", "180.00"),
                _p("Clavier de commande", "unité", "70.00"),
                _p("Détecteur de mouvement", "unité", "35.00"),
                _p("Détecteur d'ouverture", "unité", "25.00"),
                _p("Détecteur de bris de vitre", "unité", "40.00"),
                _p("Sirène intérieure", "unité", "45.00"),
                _p("Sirène extérieure flash", "unité", "80.00"),
                _p("Transmetteur GSM", "unité", "120.00"),
                _p("Badge / télécommande", "unité", "20.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre alarme", "50.00", 60, unit="heure"),
                _s("Installation d'une centrale", "180.00", 120),
                _s("Pose d'un détecteur", "45.00", 30),
                _s("Mise en service et paramétrage", "120.00", 90),
            ),
        ),
    ),
)

VIDEOSURVEILLANCE = Activity(
    slug="videosurveillance",
    label="Vidéosurveillance",
    version=1,
    description="Caméras, enregistrement et accès distant.",
    packs=(
        CatalogPack(
            name="Caméras et enregistrement",
            items=(
                _p("Caméra IP fixe", "unité", "90.00"),
                _p("Caméra dôme", "unité", "110.00"),
                _p("Caméra motorisée PTZ", "unité", "250.00"),
                _p("Enregistreur NVR 8 voies", "unité", "200.00"),
                _p("Disque dur de surveillance 2 To", "unité", "90.00"),
                _p("Écran de contrôle", "unité", "130.00"),
                _p("Alimentation PoE", "unité", "60.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre vidéosurveillance", "50.00", 60, unit="heure"),
                _s("Pose d'une caméra", "80.00", 60),
                _s("Installation de l'enregistreur", "150.00", 90),
                _s("Configuration de l'accès distant", "90.00", 60),
                _s("Réglage et mise en service", "90.00", 60),
            ),
        ),
    ),
)

CONTROLE_ACCES = Activity(
    slug="controle-acces",
    label="Contrôle d'accès",
    version=1,
    description="Lecteurs, badges, gâches et gestion des accès.",
    packs=(
        CatalogPack(
            name="Contrôle d'accès",
            items=(
                _p("Lecteur de badge", "unité", "80.00"),
                _p("Badge d'accès", "unité", "5.00"),
                _p("Digicode", "unité", "60.00"),
                _p("Gâche électrique", "unité", "35.00"),
                _p("Ventouse magnétique", "unité", "60.00"),
                _p("Serrure connectée", "unité", "180.00"),
                _p("Contrôleur d'accès", "unité", "150.00"),
                _p("Bouton de sortie", "unité", "20.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre contrôle d'accès", "50.00", 60, unit="heure"),
                _s("Pose d'un lecteur", "70.00", 60),
                _s("Installation gâche ou ventouse", "80.00", 60),
                _s("Programmation des badges", "60.00", 45),
                _s("Mise en service", "90.00", 60),
            ),
        ),
    ),
)
