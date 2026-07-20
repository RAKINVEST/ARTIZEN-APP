"""Activité « Climatisation » (+ qualification « Fluides frigorigènes »).

Complète la famille Fluides (plomberie, chauffage, ventilation, traitement de
l'eau, gaz). La climatisation « confort » air-air : unités intérieures et
extérieures, réseau frigorifique, régulation, pose.

La manipulation des fluides frigorigènes est légalement réservée aux titulaires
de l'**attestation de capacité** : ces opérations (recharge, contrôle
d'étanchéité, récupération) vivent donc dans la qualification, pas dans
l'activité — même patron que le Gaz réservé au PG.

Prix : estimations de marché HT (option A), point de départ que l'artisan
corrige. TVA 10 % (fourni-posé en rénovation, logement de plus de 2 ans) ; la
clim air-air n'ouvre pas droit au taux réduit énergétique.

Versionnage prévu dès la V1 : ``version=1``. Toute évolution du contenu
incrémentera ce numéro et documentera ses nouveautés (changelog).
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    Qualification,
    prestation as _s,
    produit as _p,
)

CLIMATISATION = Activity(
    slug="climatisation",
    label="Climatisation",
    version=1,
    description="Climatisation air-air : splits, multisplits, gainables, régulation.",
    packs=(
        CatalogPack(
            name="Unités intérieures",
            items=(
                _p("Split mural 2,5 kW", "unité", "550.00"),
                _p("Split mural 3,5 kW", "unité", "700.00"),
                _p("Split mural 5 kW", "unité", "950.00"),
                _p("Console", "unité", "900.00"),
                _p("Cassette 4 voies 5 kW", "unité", "1400.00"),
                _p("Gainable 5 kW", "unité", "1600.00"),
                _p("Plafonnier", "unité", "1200.00"),
            ),
        ),
        CatalogPack(
            name="Unités extérieures",
            items=(
                _p("Groupe monosplit 3,5 kW", "unité", "800.00"),
                _p("Groupe bi-split", "unité", "1300.00"),
                _p("Groupe tri-split", "unité", "1800.00"),
                _p("Groupe quadri-split", "unité", "2400.00"),
                _p("Groupe pour gainable", "unité", "1900.00"),
            ),
        ),
        CatalogPack(
            name="Réseau et supports",
            items=(
                _p("Liaison frigorifique cuivre isolée (paire)", "m", "12.00"),
                _p("Goulotte de climatisation", "m", "9.00"),
                _p("Support mural de groupe", "unité", "35.00"),
                _p("Plots antivibratiles", "unité", "12.00"),
                _p("Pompe de relevage des condensats", "unité", "90.00"),
                _p("Tube d'évacuation des condensats", "m", "3.00"),
                _p("Câble de liaison 4G1,5", "m", "3.50"),
            ),
        ),
        CatalogPack(
            name="Régulation",
            items=(
                _p("Télécommande filaire", "unité", "60.00"),
                _p("Thermostat d'ambiance connecté", "unité", "130.00"),
                _p("Interface WiFi", "unité", "90.00"),
                _p("Centralisation multi-zones", "unité", "350.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre climatisation", "60.00", 60, unit="heure"),
                _s("Pose d'un split mural", "350.00", 240),
                _s("Pose d'une unité de multisplit", "300.00", 180),
                _s("Pose d'un gainable", "900.00", 600),
                _s("Mise en service et contrôle", "120.00", 90),
                _s("Entretien annuel de climatisation", "130.00", 60),
                _s("Dépannage de climatisation", "150.00", 90),
                _s("Dépose d'une climatisation", "150.00", 90),
            ),
        ),
    ),
)

FLUIDES_FRIGORIGENES = Qualification(
    slug="fluides-frigorigenes",
    label="Fluides frigorigènes",
    version=1,
    description="Attestation de capacité obligatoire pour manipuler les fluides frigorigènes.",
    packs=(
        CatalogPack(
            name="Fluides frigorigènes",
            items=(
                _p("Bouteille de fluide R32", "unité", "90.00"),
                _s("Recharge en fluide R32", "120.00", 60,
                   note="Réservé aux titulaires de l'attestation de capacité."),
                _s("Complément de charge", "80.00", 45),
                _s("Récupération et recyclage des fluides", "90.00", 60),
                _s("Contrôle d'étanchéité du circuit", "90.00", 60),
                _s("Tirage au vide et déshydratation", "70.00", 45),
            ),
        ),
    ),
)
