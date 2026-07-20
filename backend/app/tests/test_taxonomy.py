"""The taxonomy is the app's frozen backbone — these tests keep it honest.

They guarantee the properties everything downstream (search, marketplace, AI,
API, stats) relies on: every slug is globally unique, the taxonomy stays in
sync with the implemented registry, and the two concepts stay separate —
**exercise qualifications** (rights to perform reserved work, with packs) vs
**company certifications** (administrative mentions, no catalog impact).
"""

from httpx import AsyncClient

from app.catalog import trades
from app.catalog.trades.taxonomy import TradeStatus


def test_deprecated_is_an_official_status() -> None:
    """The full life-cycle exists: planned -> implemented -> deprecated."""
    assert {s.value for s in TradeStatus} >= {"planned", "implemented", "deprecated"}


def test_all_slugs_are_globally_unique() -> None:
    """Families, activities, exercise qualifications and company certifications
    share one namespace: a slug identifies exactly one thing, forever."""
    slugs = trades.all_slugs()
    duplicates = {slug for slug in slugs if slugs.count(slug) > 1}
    assert not duplicates, f"slugs en double : {duplicates}"


def test_slugs_are_clean_kebab_case() -> None:
    for slug in trades.all_slugs():
        assert slug == slug.lower()
        assert " " not in slug and "_" not in slug


def test_implemented_activities_match_the_registry_exactly() -> None:
    taxonomy_impl = {
        e.slug for e in trades.taxonomy_activities() if e.status == TradeStatus.IMPLEMENTED
    }
    assert taxonomy_impl == set(trades.ACTIVITIES.keys())


def test_implemented_exercise_qualifications_match_the_registry_exactly() -> None:
    """Only exercise qualifications have packs and live in the registry."""
    taxonomy_impl = {
        e.slug
        for e in trades.taxonomy_exercise_qualifications()
        if e.status == TradeStatus.IMPLEMENTED
    }
    assert taxonomy_impl == set(trades.QUALIFICATIONS.keys())


def test_company_certifications_never_reach_the_registry() -> None:
    """A certification is administrative — it must never be importable as a
    pack. Nothing in the registry may be a company certification."""
    cert_slugs = {e.slug for e in trades.all_company_certifications()}
    assert not (cert_slugs & set(trades.QUALIFICATIONS.keys()))


def test_registered_labels_match_the_taxonomy() -> None:
    by_slug = {e.slug: e.label for e in trades.taxonomy_activities()}
    for slug, activity in trades.ACTIVITIES.items():
        assert activity.label == by_slug[slug], f"label divergent pour {slug}"


def test_activities_and_exercise_qualifications_have_a_family() -> None:
    for entry in (*trades.taxonomy_activities(), *trades.taxonomy_exercise_qualifications()):
        assert trades.family_of(entry.slug) is not None


def test_company_certifications_are_cross_cutting() -> None:
    """A certification belongs to no single family (it spans trades)."""
    for entry in trades.all_company_certifications():
        assert trades.family_of(entry.slug) is None


async def test_taxonomy_endpoint_exposes_both_sections_and_filters(client: AsyncClient) -> None:
    everything = (await client.get("/api/catalog/taxonomy")).json()
    assert "families" in everything and "company_certifications" in everything
    assert any(c["slug"] == "rge" for c in everything["company_certifications"])

    implemented = (await client.get("/api/catalog/taxonomy?status=implemented")).json()
    for family in implemented["families"]:
        for entry in family["activities"] + family["exercise_qualifications"]:
            assert entry["status"] == "implemented"

    def total(payload: dict) -> int:
        n = sum(
            len(f["activities"]) + len(f["exercise_qualifications"])
            for f in payload["families"]
        )
        return n + len(payload["company_certifications"])

    assert 0 < total(implemented) < total(everything)  # a real, narrowing filter
