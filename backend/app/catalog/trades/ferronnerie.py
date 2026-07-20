"""Activité « Ferronnerie d'art ».

Ouvrages d'art, fers à forger, finitions. Structure homogène :
matériel → profilés → consommables → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    prestation as _s,
    produit as _p,
)

FERRONNERIE = Activity(
    slug="ferronnerie",
    label="Ferronnerie d'art",
    version=1,
    description="Ouvrages en fer forgé sur mesure : rampes, garde-corps, grilles, portails.",
    packs=(
        CatalogPack(
            name="Ouvrages d'art",
            items=(
                _p("Rampe d'escalier fer forgé", "ml", "350.00"),
                _p("Garde-corps fer forgé", "ml", "280.00"),
                _p("Grille décorative", "m²", "320.00"),
                _p("Portail fer forgé", "unité", "2200.00"),
                _p("Marquise", "unité", "1500.00"),
                _p("Verrière fer forgé", "m²", "450.00"),
            ),
        ),
        CatalogPack(
            name="Fers et profilés",
            items=(
                _p("Fer plat", "ml", "6.00"),
                _p("Rond à forger", "ml", "5.00"),
                _p("Carré à forger", "ml", "5.50"),
                _p("Volute décorative", "unité", "12.00"),
                _p("Pointe de lance", "unité", "8.00"),
                _p("Tôle décorative", "m²", "45.00"),
            ),
        ),
        CatalogPack(
            name="Finitions et consommables",
            items=(
                _p("Peinture fer forgé (bidon)", "unité", "40.00"),
                _p("Antirouille (bidon)", "unité", "35.00"),
                _p("Patine (pot)", "unité", "25.00"),
                _p("Électrode de soudure (paquet)", "unité", "18.00"),
                _p("Disque à tronçonner (lot)", "unité", "15.00"),
                _p("Brosse métallique", "unité", "8.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre ferronnerie", "55.00", 60, unit="heure"),
                _s("Fabrication sur mesure", "60.00", 60, unit="heure"),
                _s("Forge et façonnage", "60.00", 60, unit="heure"),
                _s("Pose d'un ouvrage", "70.00", 60, unit="ml"),
                _s("Restauration d'un ouvrage ancien", "60.00", 60, unit="heure"),
                _s("Traitement antirouille et finition", "25.00", 30, unit="m²"),
            ),
        ),
    ),
)
