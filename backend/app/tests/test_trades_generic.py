"""The genericity proof: every registered trade works through the same generic
pipeline the wizard uses — no engine code knows about any trade.

Parametrised over *all* activities and qualifications, so a métier added later
is covered automatically. If a future trade ever needs a special case here,
that is the signal of an architecture defect, exactly as agreed.
"""

import pytest
from httpx import AsyncClient

from app.catalog import trades

ACTIVITY_SLUGS = [activity.slug for activity in trades.list_activities()]
QUALIFICATION_SLUGS = [qualification.slug for qualification in trades.list_qualifications()]


@pytest.mark.parametrize("slug", ACTIVITY_SLUGS)
def test_every_activity_offers_a_prestations_folder(slug: str) -> None:
    """Homogénéité de structure : quel que soit le métier, l'artisan retrouve
    toujours un dossier « Prestations » (main-d'œuvre et poses). C'est le socle
    commun qui rend l'expérience cohérente d'un métier à l'autre et sur lequel
    les futures fonctionnalités peuvent s'appuyer. Le pack « Chantier » partagé
    est ajouté séparément à l'import ; celui-ci vérifie l'ossature du métier."""
    activity = trades.get_activity(slug)
    assert activity is not None
    pack_names = [pack.name for pack in activity.packs]
    assert "Prestations" in pack_names, f"{slug} n'a pas de dossier « Prestations »"


@pytest.mark.parametrize("slug", ACTIVITY_SLUGS)
async def test_every_activity_composes_a_real_catalog(client: AsyncClient, slug: str) -> None:
    """Importing any activity fills the artisan's catalog, and the exact
    endpoint the wizard's Dossier step reads then returns real folders."""
    result = (await client.post(f"/api/catalog/activities/{slug}")).json()
    assert result["categories_created"] > 0, f"{slug} created no folder"
    assert result["items_created"] > 0, f"{slug} created no article"

    # The wizard's Dossier step consumes this — and nothing else trade-specific.
    overview = (await client.get("/api/catalog/categories/overview")).json()
    assert len(overview) > 0
    assert any(folder["item_count"] > 0 for folder in overview)
    assert all("sample_designations" in folder for folder in overview)


@pytest.mark.parametrize("slug", QUALIFICATION_SLUGS)
async def test_every_qualification_imports_its_reserved_pack(
    client: AsyncClient, slug: str
) -> None:
    result = (await client.post(f"/api/catalog/qualifications/{slug}")).json()
    assert result["items_created"] > 0, f"{slug} created no article"


async def test_all_activities_and_qualifications_compose_together(client: AsyncClient) -> None:
    """A multi-trade company (every activity + qualification at once) still
    composes one coherent catalog — the merge holds at full breadth."""
    for slug in ACTIVITY_SLUGS:
        await client.post(f"/api/catalog/activities/{slug}")
    for slug in QUALIFICATION_SLUGS:
        await client.post(f"/api/catalog/qualifications/{slug}")

    overview = (await client.get("/api/catalog/categories/overview")).json()
    # Folders merged, none duplicated (same-named packs fold into one folder).
    names = [folder["name"] for folder in overview]
    assert len(names) == len(set(names)), "a folder name was duplicated"
    assert sum(folder["item_count"] for folder in overview) > 0
