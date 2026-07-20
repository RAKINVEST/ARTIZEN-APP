"""Site-work articles every trade quotes, whatever the trade.

Travel, removal of old equipment, waste, protection, cleaning, testing: these
weigh 8 to 15 % of a job and are the lines artisans forget most often, which
is exactly why they belong in the box from day one rather than being typed by
hand each time.

This folder lives outside any single trade on purpose. It is the CLAUDE.md
"second consumer means infrastructure" rule applied literally: the moment a
second trade exists, "Chantier" stops being plumbing and becomes shared.

Not here on purpose: **remise commerciale** and **acompte**. A negative-priced
catalog line would change what ``QuoteCalculator`` means — it rounds per line
and sums, so a discount modelled as a line silently redefines the total. Those
two belong to the quote, not to the catalog.

Prices are ordinary market forfaits (sources: devis réels commentés chez
MesDépanneurs / Batisigne, guides Travaux.com et Habitatpresto). Surcharges are
modelled as forfaits rather than percentages because a ``CatalogItem`` carries
a price, not a rate — the artisan adjusts, and the usual market practice is
+25 to +50 % evening, +50 to +100 % night, Sunday and public holidays.
"""

from decimal import Decimal

from app.catalog.models import ItemType
from app.catalog.trades.definitions import TradeCategory, TradeItem

_RENO = Decimal("10.00")
_SERVICE = ItemType.SERVICE

CHANTIER = TradeCategory(
    name="Chantier et prestations communes",
    description="Déplacement, dépose, déchets, protection, essais — les lignes qu'on oublie.",
    items=(
        # --- Déplacement ---
        TradeItem(
            "Déplacement zone 1 (0 à 20 km)",
            "forfait",
            Decimal("35.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=30,
        ),
        TradeItem(
            "Déplacement zone 2 (20 à 50 km)",
            "forfait",
            Decimal("55.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=60,
        ),
        TradeItem(
            "Déplacement et diagnostic",
            "forfait",
            Decimal("60.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=45,
        ),
        TradeItem(
            "Frais de stationnement ou de péage", "forfait", Decimal("15.00"), _RENO, _SERVICE
        ),
        # --- Majorations horaires ---
        TradeItem(
            "Majoration intervention en soirée (après 19 h)",
            "forfait",
            Decimal("60.00"),
            _RENO,
            _SERVICE,
            description="Usage courant : +25 à +50 % du montant de l'intervention.",
        ),
        TradeItem(
            "Majoration nuit, dimanche ou jour férié",
            "forfait",
            Decimal("120.00"),
            _RENO,
            _SERVICE,
            description="Usage courant : +50 à +100 % du montant de l'intervention.",
        ),
        TradeItem(
            "Majoration intervention urgente (sous 2 h)",
            "forfait",
            Decimal("80.00"),
            _RENO,
            _SERVICE,
        ),
        # --- Préparation et dépose ---
        TradeItem(
            "Installation et repli de chantier",
            "forfait",
            Decimal("90.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=60,
        ),
        TradeItem(
            "Protection des sols et du mobilier",
            "forfait",
            Decimal("45.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=30,
        ),
        TradeItem(
            "Dépose de l'ancien équipement",
            "forfait",
            Decimal("80.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=60,
        ),
        TradeItem(
            "Percement ou carottage",
            "unité",
            Decimal("45.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=30,
        ),
        TradeItem(
            "Saignée dans mur ou cloison",
            "m",
            Decimal("25.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=20,
        ),
        TradeItem(
            "Rebouchage et scellement",
            "forfait",
            Decimal("35.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=30,
        ),
        # --- Déchets (mention obligatoire sur devis, décret n° 2020-1817) ---
        TradeItem(
            "Évacuation des gravats et déchets",
            "forfait",
            Decimal("50.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=45,
            description="Le devis doit indiquer les installations de collecte (décret n° 2020-1817).",
        ),
        TradeItem(
            "Dépôt en déchetterie",
            "forfait",
            Decimal("45.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=45,
        ),
        TradeItem("Location de benne 8 m³", "forfait", Decimal("280.00"), _RENO, _SERVICE),
        TradeItem("Big-bag de chantier", "unité", Decimal("35.00"), _RENO),
        # --- Matériel ---
        TradeItem("Location d'échafaudage", "jour", Decimal("120.00"), _RENO, _SERVICE),
        TradeItem(
            "Montage et démontage d'échafaudage",
            "forfait",
            Decimal("180.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=120,
        ),
        TradeItem(
            "Location d'un nettoyeur haute pression", "jour", Decimal("60.00"), _RENO, _SERVICE
        ),
        TradeItem(
            "Location d'une caméra d'inspection", "jour", Decimal("90.00"), _RENO, _SERVICE
        ),
        # --- Finition et administratif ---
        TradeItem(
            "Nettoyage de fin de chantier",
            "forfait",
            Decimal("60.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=60,
        ),
        TradeItem(
            "Mise en service et essais",
            "forfait",
            Decimal("40.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=30,
        ),
        TradeItem(
            "Étude, visite technique et métré",
            "forfait",
            Decimal("90.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=60,
        ),
        TradeItem(
            "Montage du dossier d'aides (MaPrimeRénov', CEE)",
            "forfait",
            Decimal("150.00"),
            _RENO,
            _SERVICE,
            estimated_duration_minutes=90,
        ),
    ),
)
