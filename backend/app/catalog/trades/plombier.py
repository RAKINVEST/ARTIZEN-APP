"""Reference catalog for the "plombier" trade — in France, plombier-chauffagiste.

Scope follows the real job, not the sanitary half of it: the CAPEB groups both
under a single union (UNA Couverture-Plomberie-Chauffage), and a catalog that
stops at sinks and pipes misses roughly half of what the artisan invoices.
Hence heating (production and emitters), gas, ventilation, water treatment and
breakdown work alongside the sanitary folders.

Prices are ordinary **public** French market prices HT (2025-2026), taken from
Plomberie-Pro, Comptoir des Pros, Bricoman, Leroy Merlin, Castorama, Brico
Dépôt, and from quote guides (Travaux.com, Habitatpresto, MesDépanneurs,
AlloTravaux, TarifArtisan). Two consequences worth knowing:

- They are **selling** prices for supplies, not an artisan's buying price. A
  plumber with a trade account at Cedeo or Point.P typically gets 20-40 % off;
  pro tariffs are behind a login and could not be read.
- They are a **starting point to be corrected**, never a recommendation. The
  product's promise is that each artisan ends up with his own price book.

VAT defaults: 10 % renovation in a dwelling over two years old (art. 279-0
bis), the plumber's ordinary case; 5,5 % on equipment improving energy
performance fitted by an RGE professional (art. 278-0 bis A); 20 % for new
build and for comfort equipment that does not qualify.
"""

from decimal import Decimal

from app.catalog.models import ItemType
from app.catalog.trades.definitions import Trade, TradeCategory, TradeItem

_RENO = Decimal("10.00")  # rénovation, logement de plus de 2 ans
_ENERGIE = Decimal("5.50")  # amélioration de la performance énergétique (RGE)
_NEUF = Decimal("20.00")  # neuf, logement de moins de 2 ans, confort

_PRODUIT = ItemType.PRODUCT
_SERVICE = ItemType.SERVICE


def _mo(
    designation: str, price: str, minutes: int, *, unit: str = "forfait", note: str | None = None
) -> TradeItem:
    """Labour line: a service, priced HT, with the time it usually takes."""
    return TradeItem(
        designation,
        unit,
        Decimal(price),
        _RENO,
        _SERVICE,
        description=note,
        estimated_duration_minutes=minutes,
    )


PLOMBIER = Trade(
    slug="plombier",
    label="Plombier",
    categories=(
        # ------------------------------------------------------------------
        TradeCategory(
            name="Alimentation et tuyauterie",
            items=(
                TradeItem("Tube cuivre Ø12", "m", Decimal("6.20"), _RENO),
                TradeItem("Tube cuivre Ø14", "m", Decimal("6.90"), _RENO),
                TradeItem("Tube cuivre Ø16", "m", Decimal("8.00"), _RENO),
                TradeItem("Tube cuivre Ø18", "m", Decimal("9.50"), _RENO),
                TradeItem("Tube cuivre Ø22", "m", Decimal("12.00"), _RENO),
                TradeItem("Tube PER Ø12", "m", Decimal("0.50"), _RENO),
                TradeItem("Tube PER Ø16 gainé", "m", Decimal("0.62"), _RENO),
                TradeItem("Tube PER Ø20", "m", Decimal("0.95"), _RENO),
                TradeItem("Tube multicouche Ø16", "m", Decimal("1.10"), _RENO),
                TradeItem("Tube multicouche Ø20", "m", Decimal("1.60"), _RENO),
                TradeItem("Tube multicouche Ø26", "m", Decimal("2.40"), _RENO),
                TradeItem("Gaine ICTA Ø20", "m", Decimal("0.30"), _RENO),
                TradeItem("Nourrice 4 départs", "unité", Decimal("55.00"), _RENO),
                TradeItem("Nourrice 8 départs", "unité", Decimal("95.00"), _RENO),
                TradeItem("Coffret de nourrice", "unité", Decimal("70.00"), _RENO),
                TradeItem("Raccord PER à sertir Ø16", "unité", Decimal("3.20"), _RENO),
                TradeItem("Raccord multicouche à glissement", "unité", Decimal("4.50"), _RENO),
                TradeItem('Raccord laiton 15x21 (1/2")', "unité", Decimal("1.90"), _RENO),
                TradeItem("Coude cuivre à souder Ø14-16", "unité", Decimal("0.95"), _RENO),
                TradeItem("Té cuivre à souder Ø14-16", "unité", Decimal("1.10"), _RENO),
                TradeItem("Vanne d'arrêt à sphère 15x21", "unité", Decimal("9.00"), _RENO),
                TradeItem("Collier de fixation Ø16", "unité", Decimal("0.28"), _RENO),
                TradeItem("Isolant tubulaire polyéthylène", "m", Decimal("0.85"), _RENO),
                TradeItem(
                    "Isolant tubulaire caoutchouc",
                    "m",
                    Decimal("3.50"),
                    _RENO,
                    description="Prix à confirmer : aucune source fiable trouvée (ordre de grandeur).",
                ),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Chauffage — émetteurs et réseau",
            items=(
                TradeItem("Radiateur acier type 11 — 400x400 (270 W)", "unité", Decimal("46.00"), _RENO),
                TradeItem("Radiateur acier type 22 — 400x800 (996 W)", "unité", Decimal("115.00"), _RENO),
                TradeItem("Radiateur acier type 22 — 600x1000 (1732 W)", "unité", Decimal("305.00"), _RENO),
                TradeItem("Radiateur fonte (rénovation)", "unité", Decimal("280.00"), _RENO),
                TradeItem("Sèche-serviettes eau chaude", "unité", Decimal("110.00"), _RENO),
                TradeItem("Sèche-serviettes mixte", "unité", Decimal("180.00"), _RENO),
                TradeItem("Robinet thermostatique", "unité", Decimal("26.00"), _RENO),
                TradeItem("Tête thermostatique", "unité", Decimal("18.00"), _RENO),
                TradeItem("Té de réglage", "unité", Decimal("12.00"), _RENO),
                TradeItem("Coude de raccordement radiateur", "unité", Decimal("8.00"), _RENO),
                TradeItem("Purgeur manuel", "unité", Decimal("2.00"), _RENO),
                TradeItem("Purgeur automatique", "unité", Decimal("9.00"), _RENO),
                TradeItem("Plancher chauffant hydraulique", "m²", Decimal("45.00"), _ENERGIE),
                TradeItem("Collecteur plancher chauffant 6 départs", "unité", Decimal("180.00"), _ENERGIE),
                TradeItem("Tube PER-BAO Ø16 (plancher chauffant)", "m", Decimal("0.90"), _ENERGIE),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Chauffage — production",
            items=(
                TradeItem("Chaudière gaz à condensation murale", "unité", Decimal("1800.00"), _ENERGIE),
                TradeItem("Chaudière gaz à condensation au sol", "unité", Decimal("2800.00"), _ENERGIE),
                TradeItem("Pompe à chaleur air/eau split 8 kW", "unité", Decimal("5500.00"), _ENERGIE),
                TradeItem("Pompe à chaleur air/eau monobloc 8 kW", "unité", Decimal("5000.00"), _ENERGIE),
                TradeItem("Ballon tampon 100 L", "unité", Decimal("450.00"), _ENERGIE),
                TradeItem("Kit hydraulique de raccordement", "unité", Decimal("240.00"), _ENERGIE),
                TradeItem("Circulateur de chauffage", "unité", Decimal("180.00"), _RENO),
                TradeItem("Vase d'expansion chauffage 18 L", "unité", Decimal("55.00"), _RENO),
                TradeItem("Désemboueur magnétique", "unité", Decimal("130.00"), _RENO),
                TradeItem("Soupape de sécurité chauffage", "unité", Decimal("20.00"), _RENO),
                TradeItem("Thermostat d'ambiance", "unité", Decimal("60.00"), _RENO),
                TradeItem("Thermostat connecté", "unité", Decimal("180.00"), _RENO),
                TradeItem("Sonde extérieure", "unité", Decimal("55.00"), _RENO),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Consommables et fixations",
            items=(
                TradeItem("Ruban téflon", "unité", Decimal("1.20"), _RENO),
                TradeItem("Filasse et pâte à joint", "unité", Decimal("8.00"), _RENO),
                TradeItem("Silicone sanitaire", "unité", Decimal("6.00"), _RENO),
                TradeItem("Mousse expansive", "unité", Decimal("8.00"), _RENO),
                TradeItem("Colle PVC et décapant", "unité", Decimal("9.00"), _RENO),
                TradeItem("Brasure tendre", "unité", Decimal("15.00"), _RENO),
                TradeItem("Sachet de joints fibre et caoutchouc", "unité", Decimal("4.00"), _RENO),
                TradeItem("Rosace de finition", "unité", Decimal("2.00"), _RENO),
                TradeItem("Boîte de chevilles et vis", "unité", Decimal("12.00"), _RENO),
                TradeItem("Collier Atlas", "unité", Decimal("1.50"), _RENO),
                TradeItem(
                    "Petites fournitures",
                    "forfait",
                    Decimal("25.00"),
                    _RENO,
                    description="Consommables non détaillés du chantier.",
                ),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Dépannage et diagnostic",
            description="Interventions ponctuelles, recherche de panne et débouchage.",
            items=(
                _mo("Forfait minimum d'intervention", "110.00", 60,
                    note="Usage courant : 80 à 150 € HT hors fournitures."),
                _mo("Débouchage à la ventouse ou au furet manuel", "120.00", 60),
                _mo("Débouchage au furet électrique", "220.00", 120),
                _mo("Débouchage haute pression", "350.00", 180),
                _mo("Inspection vidéo de canalisation", "300.00", 120),
                _mo("Recherche de fuite électroacoustique", "180.00", 120),
                _mo("Recherche de fuite par thermographie", "250.00", 120),
                _mo("Recherche de fuite au gaz traceur", "280.00", 150),
                _mo("Recherche de fuite sur canalisation enterrée", "450.00", 240),
                _mo("Réparation de fuite sur cuivre ou PER", "130.00", 90),
                _mo("Remplacement d'un joint", "70.00", 30),
                _mo("Détartrage d'un chauffe-eau", "180.00", 120),
                _mo("Dépannage de chaudière", "150.00", 90),
                _mo("Remise en eau et purge du réseau", "90.00", 60),
                _mo("Mise hors gel de l'installation", "120.00", 90),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Eau chaude sanitaire",
            items=(
                TradeItem("Chauffe-eau électrique 50 L", "unité", Decimal("180.00"), _RENO),
                TradeItem("Chauffe-eau électrique 100 L", "unité", Decimal("250.00"), _RENO),
                TradeItem("Chauffe-eau électrique 150 L", "unité", Decimal("300.00"), _RENO),
                TradeItem("Chauffe-eau électrique 200 L (stéatite)", "unité", Decimal("380.00"), _RENO),
                TradeItem("Chauffe-eau électrique 300 L", "unité", Decimal("620.00"), _RENO),
                TradeItem(
                    "Chauffe-eau thermodynamique 200 L",
                    "unité",
                    Decimal("1600.00"),
                    _ENERGIE,
                    description="TVA 5,5 % et aides sous condition de pose par un professionnel RGE.",
                ),
                TradeItem("Chauffe-eau thermodynamique 270 L", "unité", Decimal("1950.00"), _ENERGIE),
                TradeItem("Chauffe-bain gaz instantané", "unité", Decimal("330.00"), _RENO),
                TradeItem("Ballon ECS à échangeur", "unité", Decimal("700.00"), _RENO),
                TradeItem("Groupe de sécurité", "unité", Decimal("14.00"), _RENO),
                TradeItem("Kit de fixation trépied", "unité", Decimal("38.00"), _RENO),
                TradeItem("Siphon de sécurité", "unité", Decimal("5.50"), _RENO),
                TradeItem("Vase d'expansion sanitaire 8 L", "unité", Decimal("38.00"), _RENO),
                TradeItem("Résistance de chauffe-eau", "unité", Decimal("45.00"), _RENO),
                TradeItem("Anode de protection", "unité", Decimal("30.00"), _RENO),
                TradeItem("Thermostat de chauffe-eau", "unité", Decimal("35.00"), _RENO),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Évacuation et assainissement",
            items=(
                TradeItem("Tube PVC Ø32", "m", Decimal("2.51"), _RENO),
                TradeItem("Tube PVC Ø40", "m", Decimal("2.71"), _RENO),
                TradeItem("Tube PVC Ø50", "m", Decimal("3.00"), _RENO),
                TradeItem("Tube PVC Ø100", "m", Decimal("3.50"), _RENO),
                TradeItem("Coude PVC Ø40", "unité", Decimal("1.20"), _RENO),
                TradeItem("Coude PVC Ø100", "unité", Decimal("3.92"), _RENO),
                TradeItem("Culotte PVC Ø100", "unité", Decimal("13.68"), _RENO),
                TradeItem("Pipe de WC souple", "unité", Decimal("11.92"), _RENO),
                TradeItem("Siphon de lavabo", "unité", Decimal("6.25"), _RENO),
                TradeItem("Siphon d'évier", "unité", Decimal("12.00"), _RENO),
                TradeItem("Bonde de douche Ø90", "unité", Decimal("17.49"), _RENO),
                TradeItem("Bonde de douche extra-plate", "unité", Decimal("33.00"), _RENO),
                TradeItem("Clapet anti-retour Ø40", "unité", Decimal("32.00"), _RENO),
                TradeItem("Clapet anti-retour Ø100", "unité", Decimal("60.00"), _RENO),
                TradeItem("Aérateur à membrane", "unité", Decimal("18.00"), _RENO),
                TradeItem("Tampon de visite", "unité", Decimal("22.00"), _RENO),
                TradeItem("Pompe de relevage eaux grises", "unité", Decimal("150.00"), _RENO),
                TradeItem("Station de relevage sanitaire", "unité", Decimal("400.00"), _RENO),
                TradeItem("Broyeur sanitaire", "unité", Decimal("320.00"), _RENO),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Gaz",
            description="Réservé aux professionnels certifiés PG (PGN/PGP).",
            optional=True,
            items=(
                TradeItem("Tube cuivre gaz Ø14", "m", Decimal("7.00"), _RENO),
                TradeItem("Tube PLT gaz", "m", Decimal("12.00"), _RENO),
                TradeItem("Robinet gaz ROAI", "unité", Decimal("25.00"), _RENO),
                TradeItem("Détendeur propane ou butane", "unité", Decimal("30.00"), _RENO),
                TradeItem("Flexible gaz NF à embouts mécaniques", "unité", Decimal("20.00"), _RENO),
                TradeItem("Coffret gaz extérieur", "unité", Decimal("90.00"), _RENO),
                TradeItem("Ventouse concentrique", "unité", Decimal("110.00"), _RENO),
                TradeItem("Conduit de raccordement", "unité", Decimal("45.00"), _RENO),
                _mo("Essai d'étanchéité du réseau gaz", "150.00", 90),
                _mo("Certificat de conformité gaz", "180.00", 90),
                _mo("Entretien annuel de chaudière gaz", "130.00", 60,
                    note="Entretien annuel obligatoire, donne lieu à une attestation."),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Main-d'œuvre et poses",
            description="Temps passé et forfaits de pose.",
            items=(
                _mo("Main-d'œuvre plomberie", "55.00", 60, unit="heure"),
                _mo("Main-d'œuvre chauffage", "60.00", 60, unit="heure"),
                _mo("Main-d'œuvre aide ou apprenti", "35.00", 60, unit="heure"),
                _mo("Demi-journée d'intervention", "230.00", 240,
                    note="Extrapolé (~55-60 % du tarif journée) : aucune source de marché chiffrée."),
                _mo("Journée d'intervention", "420.00", 480, unit="jour"),
                _mo("Pose d'un chauffe-eau électrique", "280.00", 240),
                _mo("Pose d'un chauffe-eau thermodynamique", "700.00", 420),
                _mo("Remplacement de robinetterie", "180.00", 90),
                _mo("Pose d'un WC à poser", "180.00", 120),
                _mo("Pose d'un WC suspendu (alimentation existante)", "300.00", 240),
                _mo("Pose d'un WC suspendu avec création du bâti", "650.00", 480),
                _mo("Pose d'un lavabo ou d'une vasque", "180.00", 120),
                _mo("Pose d'une douche (receveur et paroi)", "400.00", 300),
                _mo("Pose d'une baignoire", "450.00", 300),
                _mo("Pose d'un radiateur", "250.00", 180),
                _mo("Pose d'une chaudière murale", "900.00", 480),
                _mo("Pose d'une VMC", "450.00", 300),
                _mo("Création d'une alimentation d'eau", "40.00", 45, unit="m"),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Robinetterie",
            items=(
                TradeItem("Mitigeur de lavabo", "unité", Decimal("35.00"), _RENO),
                TradeItem("Mitigeur d'évier avec douchette", "unité", Decimal("80.00"), _RENO),
                TradeItem("Mitigeur bain-douche", "unité", Decimal("62.00"), _RENO),
                TradeItem("Mitigeur thermostatique de douche", "unité", Decimal("110.00"), _RENO),
                TradeItem("Colonne de douche", "unité", Decimal("180.00"), _RENO),
                TradeItem('Robinet d\'arrêt 1/2"', "unité", Decimal("7.00"), _RENO),
                TradeItem("Robinet équerre", "unité", Decimal("6.00"), _RENO),
                TradeItem("Robinet de machine à laver", "unité", Decimal("11.00"), _RENO),
                TradeItem("Robinet auto-perceur", "unité", Decimal("7.00"), _RENO),
                TradeItem("Flexible inox 50 cm", "unité", Decimal("5.00"), _RENO),
                TradeItem("Douchette et flexible", "unité", Decimal("28.00"), _RENO),
                TradeItem("Barre de douche", "unité", Decimal("35.00"), _RENO),
                TradeItem("Réducteur de pression", "unité", Decimal("25.00"), _RENO),
                TradeItem("Mécanisme de chasse", "unité", Decimal("22.00"), _RENO),
                TradeItem("Robinet flotteur", "unité", Decimal("14.00"), _RENO),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Sanitaires",
            items=(
                TradeItem("WC suspendu avec bâti-support", "unité", Decimal("350.00"), _RENO),
                TradeItem("WC à poser (pack complet)", "unité", Decimal("125.00"), _RENO),
                TradeItem("Abattant de WC", "unité", Decimal("29.00"), _RENO),
                TradeItem("Lavabo céramique", "unité", Decimal("125.00"), _RENO),
                TradeItem("Vasque à poser", "unité", Decimal("95.00"), _RENO),
                TradeItem("Lave-mains", "unité", Decimal("55.00"), _RENO),
                TradeItem("Meuble vasque 60 cm", "unité", Decimal("240.00"), _RENO),
                TradeItem("Meuble vasque 80 cm", "unité", Decimal("333.00"), _RENO),
                TradeItem("Meuble vasque 120 cm double", "unité", Decimal("560.00"), _RENO),
                TradeItem("Receveur de douche 90x90", "unité", Decimal("150.00"), _RENO),
                TradeItem("Receveur de douche 120x90 extra-plat", "unité", Decimal("220.00"), _RENO),
                TradeItem("Paroi de douche fixe", "unité", Decimal("250.00"), _RENO),
                TradeItem("Porte de douche", "unité", Decimal("320.00"), _RENO),
                TradeItem("Baignoire acrylique 170 cm", "unité", Decimal("275.00"), _RENO),
                TradeItem("Tablier de baignoire", "unité", Decimal("95.00"), _RENO),
                TradeItem("Évier inox 1 bac", "unité", Decimal("90.00"), _RENO),
                TradeItem("Évier inox 2 bacs", "unité", Decimal("140.00"), _RENO),
                TradeItem("Barre d'appui PMR", "unité", Decimal("45.00"), _RENO),
                TradeItem("Siège de douche PMR", "unité", Decimal("120.00"), _RENO),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Traitement de l'eau",
            items=(
                TradeItem("Adoucisseur 16 L", "unité", Decimal("650.00"), _NEUF),
                TradeItem("Adoucisseur 22 L", "unité", Decimal("850.00"), _NEUF),
                TradeItem("By-pass d'adoucisseur", "unité", Decimal("45.00"), _NEUF),
                TradeItem("Sel en pastilles (sac 25 kg)", "unité", Decimal("12.00"), _NEUF),
                TradeItem("Filtre à tamis lavable", "unité", Decimal("65.00"), _RENO),
                TradeItem("Filtre à cartouche avec cartouche", "unité", Decimal("40.00"), _RENO),
                TradeItem("Anti-tartre magnétique", "unité", Decimal("90.00"), _NEUF),
                TradeItem("Osmoseur sous évier", "unité", Decimal("220.00"), _NEUF),
                TradeItem("Disconnecteur", "unité", Decimal("75.00"), _RENO),
                _mo("Analyse de la dureté de l'eau", "35.00", 30),
                _mo("Mise en service d'un adoucisseur", "120.00", 90),
            ),
        ),
        # ------------------------------------------------------------------
        TradeCategory(
            name="Ventilation (VMC)",
            items=(
                TradeItem("Caisson VMC simple flux autoréglable", "unité", Decimal("120.00"), _RENO),
                TradeItem("VMC hygroréglable type A", "unité", Decimal("250.00"), _ENERGIE),
                TradeItem("VMC hygroréglable type B", "unité", Decimal("380.00"), _ENERGIE),
                TradeItem("VMC double flux", "unité", Decimal("1200.00"), _ENERGIE),
                TradeItem("Bouche d'extraction cuisine", "unité", Decimal("25.00"), _RENO),
                TradeItem("Bouche d'extraction salle de bain ou WC", "unité", Decimal("15.00"), _RENO),
                TradeItem("Bouche hygroréglable", "unité", Decimal("35.00"), _RENO),
                TradeItem("Entrée d'air de menuiserie", "unité", Decimal("8.00"), _RENO),
                TradeItem("Gaine souple isolée Ø125", "m", Decimal("6.00"), _RENO),
                TradeItem("Manchon de raccordement", "unité", Decimal("5.00"), _RENO),
                TradeItem("Sortie de toiture", "unité", Decimal("60.00"), _RENO),
                TradeItem("Grille de façade", "unité", Decimal("20.00"), _RENO),
                TradeItem("Plots antivibratiles", "unité", Decimal("9.00"), _RENO),
            ),
        ),
    ),
)
