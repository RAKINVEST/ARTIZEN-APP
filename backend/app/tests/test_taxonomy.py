"""The taxonomy is the app's frozen backbone — these tests keep it honest.

They guarantee the two properties everything downstream (search, marketplace,
AI, API, stats) will rely on: **every slug is globally unique**, and the
taxonomy stays **in sync with the implemented registry** — no activity is
importable without being declared here, and nothing is declared "implemented"
without real packs behind it.
"""

from httpx import AsyncClient

from app.catalog import trades
from app.catalog.trades.taxonomy import TradeStatus


def test_deprecated_is_an_official_status() -> None:
    """The full life-cycle exists: planned -> implemented -> deprecated."""
    assert {s.value for s in TradeStatus} >= {"planned", "implemented", "deprecated"}


async def test_taxonomy_endpoint_filters_by_status(client: AsyncClient) -> None:
    everything = (await client.get("/api/catalog/taxonomy")).json()
    implemented = (await client.get("/api/catalog/taxonomy?status=implemented")).json()

    for family in implemented:
        for entry in family["activities"] + family["qualifications"]:
            assert entry["status"] == "implemented"

    def total(families: list) -> int:
        return sum(len(f["activities"]) + len(f["qualifications"]) for f in families)

    assert 0 < total(implemented) < total(everything)  # a real, narrowing filter


def test_all_slugs_are_globally_unique() -> None:
    """Families, activities and qualifications share one namespace: a slug must
    identify exactly one thing, forever."""
    slugs = trades.all_slugs()
    duplicates = {slug for slug in slugs if slugs.count(slug) > 1}
    assert not duplicates, f"slugs en double dans la taxonomie : {duplicates}"


def test_slugs_are_clean_kebab_case() -> None:
    for slug in trades.all_slugs():
        assert slug == slug.lower(), f"{slug} n'est pas en minuscules"
        assert " " not in slug and "_" not in slug, f"{slug} doit être en kebab-case"


def test_implemented_activities_match_the_registry_exactly() -> None:
    """Every activity marked implemented has a real Activity (with packs), and
    every registered Activity is declared implemented here — no drift."""
    taxonomy_impl = {
        entry.slug
        for entry in trades.taxonomy_activities()
        if entry.status == TradeStatus.IMPLEMENTED
    }
    registry = set(trades.ACTIVITIES.keys())
    assert taxonomy_impl == registry, (
        f"désync activités — taxonomie:{taxonomy_impl} vs registre:{registry}"
    )


def test_implemented_qualifications_match_the_registry_exactly() -> None:
    taxonomy_impl = {
        entry.slug
        for entry in trades.taxonomy_qualifications()
        if entry.status == TradeStatus.IMPLEMENTED
    }
    registry = set(trades.QUALIFICATIONS.keys())
    assert taxonomy_impl == registry


def test_registered_labels_match_the_taxonomy() -> None:
    """The label an artisan reads comes from one place. If a trade is renamed,
    it is renamed in the taxonomy and the activity together — this catches a
    half-done rename."""
    by_slug = {entry.slug: entry.label for entry in trades.taxonomy_activities()}
    for slug, activity in trades.ACTIVITIES.items():
        assert activity.label == by_slug[slug], f"label divergent pour {slug}"


def test_every_activity_and_qualification_has_a_family() -> None:
    for entry in (*trades.taxonomy_activities(), *trades.taxonomy_qualifications()):
        assert trades.family_of(entry.slug) is not None
