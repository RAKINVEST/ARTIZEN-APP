"""Activité « Hygiène / dératisation (3D) ».

Produits 3D, dispositifs, matériel. Structure homogène :
matériel → dispositifs → matériel → prestations.
Prix estimations de marché HT (option A), versionné v1. TVA 10 % par défaut.
"""

from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
)
from app.catalog.trades.definitions import (
    prestation as _s,
)
from app.catalog.trades.definitions import (
    produit as _p,
)

HYGIENE_NUISIBLES = Activity(
    slug="hygiene-nuisibles",
    label="Hygiène / dératisation (3D)",
    version=1,
    description="Dératisation, désinsectisation, désinfection : produits, pièges, traitements.",
    packs=(
        CatalogPack(
            name="Produits 3D",
            items=(
                _p("Raticide / rodenticide (seau)", "unité", "35.00"),
                _p("Insecticide professionnel (bidon)", "unité", "40.00"),
                _p("Gel anti-cafards (seringue)", "unité", "18.00"),
                _p("Désinfectant virucide (bidon)", "unité", "30.00"),
                _p("Larvicide (bidon)", "unité", "35.00"),
                _p("Fumigène insecticide", "unité", "12.00"),
            ),
        ),
        CatalogPack(
            name="Dispositifs et pièges",
            items=(
                _p("Poste d'appâtage sécurisé", "unité", "12.00"),
                _p("Piège à glu (lot)", "unité", "9.00"),
                _p("Piège mécanique", "unité", "6.00"),
                _p("Tapette (lot)", "unité", "5.00"),
                _p("Répulsif à ultrasons", "unité", "25.00"),
                _p("Grille anti-nuisibles", "ml", "8.00"),
            ),
        ),
        CatalogPack(
            name="Matériel et protection",
            items=(
                _p("Pulvérisateur", "unité", "60.00"),
                _p("Nébulisateur", "unité", "180.00"),
                _p("Combinaison de protection", "unité", "12.00"),
                _p("Masque respiratoire", "unité", "35.00"),
                _p("Gants nitrile (boîte)", "unité", "9.00"),
                _p("Applicateur de gel", "unité", "15.00"),
            ),
        ),
        CatalogPack(
            name="Prestations",
            items=(
                _s("Main-d'œuvre hygiène", "45.00", 60, unit="heure"),
                _s("Diagnostic et inspection", "120.00", 60),
                _s("Dératisation", "150.00", 90),
                _s("Désinsectisation", "150.00", 90),
                _s("Désinfection", "12.00", 12, unit="m²"),
                _s("Traitement anti-punaises de lit", "300.00", 180),
                _s("Pose de postes d'appâtage", "18.00", 20, unit="unité"),
                _s("Passage de contrat de suivi", "90.00", 45, unit="passage"),
            ),
        ),
    ),
)
