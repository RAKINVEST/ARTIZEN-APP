"""The official Artizen trade taxonomy — the single reference for the whole app.

Families → activities → **exercise qualifications**, plus a cross-cutting list of
**company certifications**. Everything downstream (catalogs, search, filters,
statistics, marketplace, AI, public API) names these by their **slugs**, which
are **frozen** — chosen once, never renamed.

Two distinct concepts, deliberately not mixed (this was a real design decision):

- **Qualification d'exercice** — a *right to perform* reserved work (PG, IRVE,
  fluides frigorigènes, certification amiante). It **influences the engine**: it
  unlocks a reserved pack. Modelled as :class:`Qualification` with packs, held
  in the ``QUALIFICATIONS`` registry, and attached to its trade **family**.

- **Certification d'entreprise** — an administrative mention (RGE, QualiPV,
  QualiPAC, QualiBois, QualiSol, Éco Artisan, QUALIFELEC). It changes **nothing**
  in the catalog: it justifies an aid, shows a logo, appears on quotes. It is
  **cross-cutting** (an artisan holds a set of them, whatever his trades), so it
  lives in a single top-level list, not under a family. Reserved here as a
  concept; the ``CompanyCertification`` mechanism (type, numéro, organisme,
  dates, statut) is planned, not yet built — see docs/TAXONOMIE-METIERS.md.

Renewable energy is not a family: a photovoltaïque install is electrical, a
solaire-thermique / géothermie one is a heat source (fluides). The "green /
aided" dimension is a company **certification** — exactly this second concept.
"""

from dataclasses import dataclass
from enum import Enum


class TradeStatus(str, Enum):
    """Official life-cycle status of a taxonomy entry — the state the whole app
    reads (API filtering, back-office, tests, docs)."""

    IMPLEMENTED = "implemented"  # activité/qualif + packs, importable aujourd'hui
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
    #: Rights to perform reserved work in this family — influence the catalog.
    exercise_qualifications: tuple[TaxonomyEntry, ...] = ()


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
        exercise_qualifications=(
            _e("pg", "Professionnel Gaz (PG)", _IMPL),
            _e("fluides-frigorigenes", "Fluides frigorigènes", _IMPL),
        ),
    ),
    Family(
        slug="electricite",
        label="Électricité & courants faibles",
        activities=(
            _e("electricite-generale", "Électricité générale", _IMPL),
            _e("domotique", "Domotique / Smart Home", _IMPL),
            _e("photovoltaique", "Photovoltaïque", _IMPL),
            _e("reseaux-vdi", "Réseaux VDI / fibre", _IMPL),
            _e("alarme-intrusion", "Alarme intrusion", _IMPL),
            _e("videosurveillance", "Vidéosurveillance", _IMPL),
            _e("controle-acces", "Contrôle d'accès", _IMPL),
            _e("interphonie", "Interphonie / Visiophonie", _IMPL),
        ),
        exercise_qualifications=(_e("irve", "IRVE — bornes de recharge", _IMPL),),
    ),
    Family(
        slug="finition",
        label="Finition intérieure (second œuvre)",
        activities=(
            _e("platrerie", "Plâtrerie / Plaquiste", _IMPL),
            _e("peinture", "Peinture", _IMPL),
            _e("carrelage", "Carrelage", _IMPL),
            _e("revetements-sol", "Revêtements de sol", _IMPL),
            _e("parquet", "Parquet", _IMPL),
            _e("menuiserie-interieure", "Menuiserie intérieure", _IMPL),
            _e("cuisine", "Cuisine", _IMPL),
            _e("agencement", "Agencement", _IMPL),
        ),
    ),
    Family(
        slug="enveloppe",
        label="Enveloppe du bâtiment",
        activities=(
            _e("charpente", "Charpente", _IMPL),
            _e("couverture", "Couverture", _IMPL),
            _e("zinguerie", "Zinguerie", _IMPL),
            _e("menuiserie-exterieure", "Menuiserie extérieure / Fermetures", _IMPL),
            _e("stores-pergolas", "Stores & pergolas", _IMPL),
            _e("facade", "Façade / Ravalement", _IMPL),
            _e("isolation", "Isolation (ITI / combles)", _IMPL),
            _e("isolation-exterieure", "Isolation extérieure (ITE)", _IMPL),
            _e("bardage", "Bardage", _IMPL),
            _e("etancheite", "Étanchéité", _IMPL),
        ),
    ),
    Family(
        slug="gros-oeuvre",
        label="Gros œuvre & travaux publics",
        activities=(
            _e("maconnerie", "Maçonnerie", _IMPL),
            _e("terrassement", "Terrassement", _IMPL),
            _e("demolition", "Démolition / Curage", _IMPL),
            _e("vrd", "VRD (voirie & réseaux divers)", _IMPL),
            _e("assainissement", "Assainissement", _IMPL),
            _e("forage", "Forage / Puits", _IMPL),
            _e("enrobes", "Enrobés / Voirie", _IMPL),
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
        exercise_qualifications=(_e("certification-amiante", "Certification amiante (SS4)"),),
    ),
)


#: Company certifications — administrative mentions, **no catalog impact**,
#: cross-cutting (a company holds a set of them regardless of its trades). All
#: PLANNED: the CompanyCertification mechanism is reserved, not yet built.
COMPANY_CERTIFICATIONS: tuple[TaxonomyEntry, ...] = (
    _e("rge", "RGE (Reconnu Garant de l'Environnement)"),
    _e("eco-artisan", "RGE Éco Artisan"),
    _e("qualipac", "QualiPAC"),
    _e("qualipv", "QualiPV"),
    _e("qualibois", "QualiBois"),
    _e("qualisol", "QualiSol"),
    _e("qualifelec", "QUALIFELEC"),
)


def all_activities() -> list[TaxonomyEntry]:
    return [entry for family in FAMILIES for entry in family.activities]


def all_exercise_qualifications() -> list[TaxonomyEntry]:
    return [entry for family in FAMILIES for entry in family.exercise_qualifications]


def all_company_certifications() -> list[TaxonomyEntry]:
    return list(COMPANY_CERTIFICATIONS)


def family_of(slug: str) -> Family | None:
    """The family an activity or exercise qualification belongs to. Company
    certifications are cross-cutting and belong to no family (returns None)."""
    for family in FAMILIES:
        if any(e.slug == slug for e in (*family.activities, *family.exercise_qualifications)):
            return family
    return None


def all_slugs() -> list[str]:
    """Every slug — families, activities, exercise qualifications and company
    certifications — for the global-uniqueness check."""
    slugs: list[str] = []
    for family in FAMILIES:
        slugs.append(family.slug)
        slugs.extend(e.slug for e in family.activities)
        slugs.extend(e.slug for e in family.exercise_qualifications)
    slugs.extend(e.slug for e in COMPANY_CERTIFICATIONS)
    return slugs
