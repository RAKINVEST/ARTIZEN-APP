"""Reference catalog for the "plombier" trade.

VAT defaults follow the plumber's ordinary case — renovation work in a
dwelling over two years old, taxed at 10 % (art. 279-0 bis du CGI) — with
5,5 % on equipment that improves energy performance (art. 278-0 bis A).
New-build work is 20 %, which the artisan switches per quote: these are
starting points, and the whole product is built around him correcting them.

Folders are what a plumber actually opens on site, and are stored in the
order below; the app sorts them alphabetically for display.
"""

from decimal import Decimal

from app.catalog.models import ItemType
from app.catalog.trades.definitions import Trade, TradeCategory, TradeItem

_RENO = Decimal("10.00")  # rénovation, logement de plus de 2 ans
_ENERGIE = Decimal("5.50")  # amélioration de la performance énergétique

_PRODUIT = ItemType.PRODUCT
_SERVICE = ItemType.SERVICE


PLOMBIER = Trade(
    slug="plombier",
    label="Plombier",
    categories=(
        TradeCategory(
            name="Chauffe-eau",
            items=(
                TradeItem("Chauffe-eau électrique 100 L", "unité", Decimal("260.00"), _RENO),
                TradeItem("Chauffe-eau électrique 150 L", "unité", Decimal("310.00"), _RENO),
                TradeItem("Chauffe-eau électrique 200 L", "unité", Decimal("360.00"), _RENO),
                TradeItem(
                    "Chauffe-eau thermodynamique 200 L",
                    "unité",
                    Decimal("1850.00"),
                    _ENERGIE,
                    description="Éligible aux aides à la rénovation énergétique.",
                ),
                TradeItem("Groupe de sécurité laiton", "unité", Decimal("28.00"), _RENO),
                TradeItem("Kit de fixation trépied", "unité", Decimal("45.00"), _RENO),
                TradeItem("Siphon de sécurité", "unité", Decimal("12.00"), _RENO),
                TradeItem("Vase d'expansion sanitaire 8 L", "unité", Decimal("42.00"), _RENO),
            ),
        ),
        TradeCategory(
            name="Évacuation",
            items=(
                TradeItem("Tube PVC Ø40", "m", Decimal("4.50"), _RENO),
                TradeItem("Tube PVC Ø100", "m", Decimal("8.00"), _RENO),
                TradeItem("Coude PVC Ø40", "unité", Decimal("3.00"), _RENO),
                TradeItem("Coude PVC Ø100", "unité", Decimal("5.50"), _RENO),
                TradeItem("Siphon de lavabo", "unité", Decimal("14.00"), _RENO),
                TradeItem("Bonde de douche Ø90", "unité", Decimal("32.00"), _RENO),
                TradeItem("Clapet anti-retour", "unité", Decimal("26.00"), _RENO),
                TradeItem("Manchon de raccordement WC", "unité", Decimal("11.00"), _RENO),
            ),
        ),
        TradeCategory(
            name="Main-d'œuvre",
            description="Temps passé et forfaits d'intervention.",
            items=(
                TradeItem(
                    "Main-d'œuvre plomberie",
                    "heure",
                    Decimal("55.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=60,
                ),
                TradeItem(
                    "Demi-journée d'intervention",
                    "forfait",
                    Decimal("210.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=240,
                ),
                TradeItem(
                    "Journée d'intervention",
                    "jour",
                    Decimal("400.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=480,
                ),
                TradeItem(
                    "Pose chauffe-eau",
                    "forfait",
                    Decimal("280.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=180,
                ),
                TradeItem(
                    "Remplacement de robinetterie",
                    "forfait",
                    Decimal("90.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=60,
                ),
                TradeItem(
                    "Recherche de fuite",
                    "forfait",
                    Decimal("120.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=90,
                ),
                TradeItem(
                    "Dépose et évacuation de l'ancien matériel",
                    "forfait",
                    Decimal("80.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=60,
                ),
                TradeItem(
                    "Mise en service et contrôle d'étanchéité",
                    "forfait",
                    Decimal("60.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=45,
                ),
                TradeItem(
                    "Déplacement (0 à 20 km)",
                    "forfait",
                    Decimal("35.00"),
                    _RENO,
                    _SERVICE,
                    estimated_duration_minutes=30,
                ),
            ),
        ),
        TradeCategory(
            name="Robinetterie",
            items=(
                TradeItem("Mitigeur de lavabo chromé", "unité", Decimal("75.00"), _RENO),
                TradeItem("Mitigeur d'évier avec douchette", "unité", Decimal("120.00"), _RENO),
                TradeItem("Mitigeur thermostatique de douche", "unité", Decimal("180.00"), _RENO),
                TradeItem("Robinet d'arrêt 1/2\"", "unité", Decimal("9.00"), _RENO),
                TradeItem("Flexible inox 50 cm", "unité", Decimal("8.00"), _RENO),
                TradeItem("Robinet de machine à laver", "unité", Decimal("12.00"), _RENO),
                TradeItem("Réducteur de pression", "unité", Decimal("48.00"), _RENO),
            ),
        ),
        TradeCategory(
            name="Sanitaires",
            items=(
                TradeItem("WC suspendu avec bâti-support", "unité", Decimal("420.00"), _RENO),
                TradeItem("WC à poser", "unité", Decimal("180.00"), _RENO),
                TradeItem("Lavabo céramique", "unité", Decimal("95.00"), _RENO),
                TradeItem("Meuble vasque 80 cm", "unité", Decimal("350.00"), _RENO),
                TradeItem("Receveur de douche 90 × 90", "unité", Decimal("190.00"), _RENO),
                TradeItem("Paroi de douche en verre", "unité", Decimal("320.00"), _RENO),
                TradeItem("Baignoire acrylique 170 cm", "unité", Decimal("290.00"), _RENO),
                TradeItem("Évier inox 2 bacs", "unité", Decimal("160.00"), _RENO),
            ),
        ),
        TradeCategory(
            name="Tuyauterie",
            items=(
                TradeItem("Tube cuivre Ø14", "m", Decimal("9.00"), _RENO),
                TradeItem("Tube cuivre Ø16", "m", Decimal("11.00"), _RENO),
                TradeItem("Tube PER Ø16", "m", Decimal("3.50"), _RENO),
                TradeItem("Gaine ICTA Ø25", "m", Decimal("1.80"), _RENO),
                TradeItem("Raccord PER à sertir", "unité", Decimal("7.00"), _RENO),
                TradeItem("Raccord laiton 1/2\"", "unité", Decimal("5.00"), _RENO),
                TradeItem("Vanne d'arrêt à sphère", "unité", Decimal("15.00"), _RENO),
                TradeItem("Collier de fixation", "unité", Decimal("1.50"), _RENO),
                TradeItem("Isolant pour tuyauterie", "m", Decimal("2.20"), _RENO),
            ),
        ),
    ),
)
