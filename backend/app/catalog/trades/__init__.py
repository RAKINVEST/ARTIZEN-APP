"""Registry of activities and qualifications, and how they compose a catalog.

Only activities that actually carry packs are registered. Listing the ten
trades of the roadmap with empty packs would let an artisan tick "Électricien"
and receive an empty toolbox — the exact opposite of the promise, and worse
than not offering it yet. An activity appears the day its packs exist.
"""

from app.catalog.trades.agencement import AGENCEMENT
from app.catalog.trades.arrosage import ARROSAGE
from app.catalog.trades.ascenseur import ASCENSEUR
from app.catalog.trades.assainissement import ASSAINISSEMENT
from app.catalog.trades.automatismes_portails import AUTOMATISMES_PORTAILS
from app.catalog.trades.bardage import BARDAGE
from app.catalog.trades.carrelage import CARRELAGE
from app.catalog.trades.charpente import CHARPENTE
from app.catalog.trades.chauffage import CHAUFFAGE
from app.catalog.trades.climatisation import CLIMATISATION, FLUIDES_FRIGORIGENES
from app.catalog.trades.cloture import CLOTURE
from app.catalog.trades.commun import CHANTIER
from app.catalog.trades.couverture import COUVERTURE
from app.catalog.trades.cuisine import CUISINE
from app.catalog.trades.definitions import (
    Activity,
    CatalogPack,
    PackItem,
    Qualification,
    VersionNotes,
    merge_packs,
    notes_since,
    prestation,
    produit,
)
from app.catalog.trades.demolition import DEMOLITION
from app.catalog.trades.desamiantage import CERTIFICATION_AMIANTE, DESAMIANTAGE
from app.catalog.trades.diagnostic import DIAGNOSTIC
from app.catalog.trades.domotique import DOMOTIQUE
from app.catalog.trades.electricite import ELECTRICITE_GENERALE, IRVE
from app.catalog.trades.enrobes import ENROBES
from app.catalog.trades.etancheite import ETANCHEITE
from app.catalog.trades.facade import FACADE
from app.catalog.trades.ferronnerie import FERRONNERIE
from app.catalog.trades.forage import FORAGE
from app.catalog.trades.gaz import PG
from app.catalog.trades.hygiene_nuisibles import HYGIENE_NUISIBLES
from app.catalog.trades.interphonie import INTERPHONIE
from app.catalog.trades.isolation import ISOLATION
from app.catalog.trades.isolation_exterieure import ISOLATION_EXTERIEURE
from app.catalog.trades.maconnerie import MACONNERIE
from app.catalog.trades.menuiserie_exterieure import MENUISERIE_EXTERIEURE
from app.catalog.trades.menuiserie_interieure import MENUISERIE_INTERIEURE
from app.catalog.trades.nettoyage import NETTOYAGE
from app.catalog.trades.parquet import PARQUET
from app.catalog.trades.paysagisme import PAYSAGISME
from app.catalog.trades.peinture import PEINTURE
from app.catalog.trades.photovoltaique import PHOTOVOLTAIQUE
from app.catalog.trades.piscine import PISCINE
from app.catalog.trades.platrerie import PLATRERIE
from app.catalog.trades.plomberie import PLOMBERIE
from app.catalog.trades.ramonage import RAMONAGE
from app.catalog.trades.reseaux_vdi import RESEAUX_VDI
from app.catalog.trades.revetements_sol import REVETEMENTS_SOL
from app.catalog.trades.securite import (
    ALARME_INTRUSION,
    CONTROLE_ACCES,
    VIDEOSURVEILLANCE,
)
from app.catalog.trades.serrurerie_metallerie import SERRURERIE_METALLERIE
from app.catalog.trades.stores_pergolas import STORES_PERGOLAS
from app.catalog.trades.taxonomy import (
    COMPANY_CERTIFICATIONS,
    FAMILIES,
    Family,
    TaxonomyEntry,
    TradeStatus,
    all_company_certifications,
    all_slugs,
    family_of,
)
from app.catalog.trades.taxonomy import (
    all_activities as taxonomy_activities,
)
from app.catalog.trades.taxonomy import (
    all_exercise_qualifications as taxonomy_exercise_qualifications,
)
from app.catalog.trades.terrasse_bois import TERRASSE_BOIS
from app.catalog.trades.terrassement import TERRASSEMENT
from app.catalog.trades.traitement_charpente import TRAITEMENT_CHARPENTE
from app.catalog.trades.traitement_eau import TRAITEMENT_EAU
from app.catalog.trades.ventilation import VENTILATION
from app.catalog.trades.vitrerie import VITRERIE
from app.catalog.trades.vrd import VRD
from app.catalog.trades.zinguerie import ZINGUERIE

#: What the company does. Keyed by the slug persisted on the company.
ACTIVITIES: dict[str, Activity] = {
    activity.slug: activity
    for activity in (
        PLOMBERIE,
        CHAUFFAGE,
        CLIMATISATION,
        VENTILATION,
        TRAITEMENT_EAU,
        ELECTRICITE_GENERALE,
        PHOTOVOLTAIQUE,
        DOMOTIQUE,
        RESEAUX_VDI,
        ALARME_INTRUSION,
        VIDEOSURVEILLANCE,
        CONTROLE_ACCES,
        INTERPHONIE,
        PLATRERIE,
        PEINTURE,
        CARRELAGE,
        REVETEMENTS_SOL,
        PARQUET,
        MENUISERIE_INTERIEURE,
        CUISINE,
        AGENCEMENT,
        CHARPENTE,
        COUVERTURE,
        ZINGUERIE,
        MENUISERIE_EXTERIEURE,
        STORES_PERGOLAS,
        FACADE,
        ISOLATION,
        ISOLATION_EXTERIEURE,
        BARDAGE,
        ETANCHEITE,
        MACONNERIE,
        TERRASSEMENT,
        DEMOLITION,
        VRD,
        ASSAINISSEMENT,
        FORAGE,
        ENROBES,
        PISCINE,
        SERRURERIE_METALLERIE,
        AUTOMATISMES_PORTAILS,
        VITRERIE,
        FERRONNERIE,
        PAYSAGISME,
        CLOTURE,
        ARROSAGE,
        TERRASSE_BOIS,
        ASCENSEUR,
        RAMONAGE,
        DESAMIANTAGE,
        TRAITEMENT_CHARPENTE,
        HYGIENE_NUISIBLES,
        NETTOYAGE,
        DIAGNOSTIC,
    )
}

#: What the company is certified to do. Never loaded by default. Only
#: qualifications that reserve a *pack* are registered here (PG, fluides,
#: IRVE) — mention-only ones (RGE, QualiPV, QualiPAC…) grant no articles and
#: are handled as PDF mentions, not imports.
QUALIFICATIONS: dict[str, Qualification] = {
    qualification.slug: qualification
    for qualification in (PG, FLUIDES_FRIGORIGENES, IRVE, CERTIFICATION_AMIANTE)
}


def list_activities() -> list[Activity]:
    """Alphabetically by label — the order the artisan sees when ticking."""
    return sorted(ACTIVITIES.values(), key=lambda activity: activity.label)


def list_qualifications() -> list[Qualification]:
    return sorted(QUALIFICATIONS.values(), key=lambda qualification: qualification.label)


def get_activity(slug: str) -> Activity | None:
    return ACTIVITIES.get(slug)


def get_qualification(slug: str) -> Qualification | None:
    return QUALIFICATIONS.get(slug)


def compose_catalog(
    *, activities: list[str], qualifications: list[str] | None = None
) -> list[CatalogPack]:
    """The folders to create for a company, from what it does and is certified for.

    Packs sharing a name are merged, so activating Plomberie and Chauffage
    yields **one** "Prestations" folder rather than two — the artisan sees a
    single catalog (`docs/DECISIONS.md`, décision 2).

    :data:`~app.catalog.trades.commun.CHANTIER` is always added: travel,
    removal, waste and testing belong to every trade and to none.

    Unknown slugs are ignored rather than raising. A company stores its slugs;
    if an activity is ever renamed or retired, its catalog must still compose
    instead of failing. Validating that a slug exists is the router's job, at
    the moment the artisan picks it.
    """
    packs: list[CatalogPack] = []
    for slug in activities:
        activity = ACTIVITIES.get(slug)
        if activity is not None:
            packs.extend(activity.packs)
    for slug in qualifications or []:
        qualification = QUALIFICATIONS.get(slug)
        if qualification is not None:
            packs.extend(qualification.packs)
    packs.append(CHANTIER)
    return merge_packs(packs)


__all__ = [
    "ACTIVITIES",
    "CHANTIER",
    "COMPANY_CERTIFICATIONS",
    "FAMILIES",
    "QUALIFICATIONS",
    "Activity",
    "CatalogPack",
    "Family",
    "PackItem",
    "Qualification",
    "TaxonomyEntry",
    "TradeStatus",
    "VersionNotes",
    "all_company_certifications",
    "all_slugs",
    "compose_catalog",
    "family_of",
    "get_activity",
    "get_qualification",
    "list_activities",
    "list_qualifications",
    "merge_packs",
    "notes_since",
    "prestation",
    "produit",
    "taxonomy_activities",
    "taxonomy_exercise_qualifications",
]
