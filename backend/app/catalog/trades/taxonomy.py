"""The official Artizen trade taxonomy — the single reference for the whole app.

Families → activities → qualifications, each with its implementation status.
This is the backbone: catalogs, search, filters, statistics, the future
marketplace, the AI and the public API all name trades by the **slugs** defined
here. The slugs are **frozen** — chosen once, never renamed — because everything
downstream keys on them.

Distinct from the *registry* (``ACTIVITIES`` / ``QUALIFICATIONS`` in this
package): the registry holds only the **implemented** activities, with their
packs, ready to import today. The taxonomy is the full perimeter — implemented,
planned, and deferred to V2. ``test_taxonomy.py`` keeps the two in sync: every
entry marked implemented here has a real Activity/Qualification, and every
registered activity/qualification appears here as implemented.

Design note — **renewable energy is not a family**: a photovoltaïque install is
electrical, a solaire-thermique / géothermie one is a heat source (fluides). The
"green / aided" dimension is a *qualification* (RGE, QualiPAC, QualiPV,
QualiBois, QualiSol), not a trade — which is exactly what the
Activity/Qualification split is for (docs/DECISIONS.md, décision 7).
"""

from dataclasses import dataclass
from enum import Enum


class TradeStatus(str, Enum):
    """Official life-cycle status of a taxonomy entry — the state the whole app
    reads (API filtering, back-office, tests, docs)."""

    IMPLEMENTED = "implemented"  # activité + packs, importable aujourd'hui
    PLANNED = "planned"          # au périmètre V1, contenu à développer
    DEFERRED = "deferred_v2"     # au périmètre mais repoussé en V2
    DEPRECATED = "deprecated"    # était disponible, en retrait — ne plus proposer


@dataclass(frozen=True)
class TaxonomyEntry:
    slug: str
    label: str
    status: TradeStatus


@dataclass(frozen=True)
class Family:
    slug: str
    label: str
    activities: tuple[TaxonomyEntry, ...]
    qualifications: tuple[TaxonomyEntry, ...] = ()


_IMPL = TradeStatus.IMPLEMENTED
_V2 = TradeStatus.DEFERRED


def _e(slug: str, label: str, status: TradeStatus = TradeStatus.PLANNED) -> TaxonomyEntry:
    return TaxonomyEntry(slug=slug, label=label, status=status)


#: The frozen backbone. Order = the reading order of the 6 families (lots).
FAMILIES: tuple[Family, ...] = (
    Family(
        slug="fluides",
        label="Fluides & génie climatique",
        activities=(
            _e("plomberie", "Plomberie", _IMPL),
            _e("chauffage", "Chauffage", _IMPL),
            _e("climatisation", "Climatisation", _IMPL),
            _e("ventilation", "Ventilation (VMC)", _IMPL),
            _e("traitement-eau", "Traitement de l'eau", _IMPL),
            _e("froid", "Froid commercial"),
            _e("solaire-thermique", "Solaire thermique"),
            _e("geothermie", "Géothermie"),
        ),
        qualifications=(
            _e("pg", "Professionnel Gaz (PG)", _IMPL),
            _e("fluides-frigorigenes", "Fluides frigorigènes", _IMPL),
            _e("qualipac", "QualiPAC"),
            _e("qualibois", "QualiBois"),
            _e("qualisol", "QualiSol"),
        ),
    ),
    Family(
        slug="electricite",
        label="Électricité & courants faibles",
        activities=(
            _e("electricite-generale", "Électricité générale", _IMPL),
            _e("domotique", "Domotique / Smart Home"),
            _e("photovoltaique", "Photovoltaïque", _IMPL),
            _e("reseaux-vdi", "Réseaux VDI / fibre"),
            _e("alarme-intrusion", "Alarme intrusion"),
            _e("videosurveillance", "Vidéosurveillance"),
            _e("controle-acces", "Contrôle d'accès"),
            _e("interphonie", "Interphonie / Visiophonie"),
        ),
        qualifications=(
            _e("irve", "IRVE — bornes de recharge", _IMPL),
            _e("qualipv", "QualiPV"),
        ),
    ),
    Family(
        slug="finition",
        label="Finition intérieure (second œuvre)",
        activities=(
            _e("platrerie", "Plâtrerie / Plaquiste"),
            _e("peinture", "Peinture"),
            _e("carrelage", "Carrelage"),
            _e("revetements-sol", "Revêtements de sol"),
            _e("parquet", "Parquet"),
            _e("menuiserie-interieure", "Menuiserie intérieure"),
            _e("cuisine", "Cuisine"),
            _e("agencement", "Agencement"),
        ),
    ),
    Family(
        slug="enveloppe",
        label="Enveloppe du bâtiment",
        activities=(
            _e("charpente", "Charpente"),
            _e("couverture", "Couverture"),
            _e("zinguerie", "Zinguerie"),
            _e("menuiserie-exterieure", "Menuiserie extérieure / Fermetures"),
            _e("stores-pergolas", "Stores & pergolas"),
            _e("facade", "Façade / Ravalement"),
            _e("isolation", "Isolation (ITI / combles)"),
            _e("isolation-exterieure", "Isolation extérieure (ITE)"),
            _e("bardage", "Bardage"),
            _e("etancheite", "Étanchéité"),
        ),
        qualifications=(_e("rge", "RGE (Reconnu Garant de l'Environnement)"),),
    ),
    Family(
        slug="gros-oeuvre",
        label="Gros œuvre & travaux publics",
        activities=(
            _e("maconnerie", "Maçonnerie"),
            _e("terrassement", "Terrassement"),
            _e("demolition", "Démolition / Curage"),
            _e("vrd", "VRD (voirie & réseaux divers)"),
            _e("assainissement", "Assainissement"),
            _e("forage", "Forage / Puits"),
            _e("enrobes", "Enrobés / Voirie"),
        ),
    ),
    Family(
        slug="specialises",
        label="Métiers spécialisés & services techniques",
        activities=(
            _e("piscine", "Piscine"),
            _e("serrurerie-metallerie", "Serrurerie / Métallerie"),
            _e("automatismes-portails", "Portails & automatismes"),
            _e("vitrerie", "Vitrerie / Miroiterie"),
            _e("ferronnerie", "Ferronnerie d'art"),
            _e("paysagisme", "Paysagisme / Jardinier"),
            _e("cloture", "Clôtures"),
            _e("arrosage", "Arrosage automatique"),
            _e("terrasse-bois", "Terrasse bois"),
            _e("ascenseur", "Ascenseur"),
            _e("ramonage", "Ramonage / Fumisterie"),
            _e("desamiantage", "Désamiantage"),
            _e("traitement-charpente", "Traitement de charpente / anti-nuisibles"),
            _e("hygiene-nuisibles", "Hygiène / dératisation (3D)"),
            _e("nettoyage", "Nettoyage / après-chantier"),
            _e("diagnostic", "Diagnostic immobilier"),
            _e("cordiste", "Travaux sur cordes", _V2),
            _e("cuvelage", "Cuvelage", _V2),
            _e("paratonnerre", "Paratonnerre", _V2),
            _e("antenniste", "Antenniste", _V2),
            _e("home-staging", "Home staging", _V2),
        ),
        qualifications=(_e("certification-amiante", "Certification amiante (SS4)"),),
    ),
)


def all_activities() -> list[TaxonomyEntry]:
    return [entry for family in FAMILIES for entry in family.activities]


def all_qualifications() -> list[TaxonomyEntry]:
    return [entry for family in FAMILIES for entry in family.qualifications]


def family_of(slug: str) -> Family | None:
    """The family a given activity or qualification slug belongs to."""
    for family in FAMILIES:
        if any(e.slug == slug for e in (*family.activities, *family.qualifications)):
            return family
    return None


def all_slugs() -> list[str]:
    """Every slug in the taxonomy — families, activities and qualifications —
    used to check global uniqueness (nothing downstream may be ambiguous)."""
    slugs: list[str] = []
    for family in FAMILIES:
        slugs.append(family.slug)
        slugs.extend(e.slug for e in family.activities)
        slugs.extend(e.slug for e in family.qualifications)
    return slugs
