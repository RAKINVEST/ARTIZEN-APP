"""Tests du chargement des catalogues métiers.

L'artisan coche ses activités, Artizen copie les packs correspondants dans
**son** catalogue. Ce qui est verrouillé ici : l'import est additif, idempotent,
et ne touche jamais un article que l'artisan a déjà — son prix lui appartient
(`docs/DECISIONS.md`, décisions 1 et 2).
"""

from decimal import Decimal

import pytest
from httpx import AsyncClient


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


async def _categories(client: AsyncClient) -> list[str]:
    response = await client.get("/api/catalog/categories")
    return [category["name"] for category in response.json()]


async def test_activities_are_listed_with_what_they_would_add(
    client: AsyncClient, company_id: str
) -> None:
    response = await client.get("/api/catalog/activities")

    assert response.status_code == 200
    activities = {activity["slug"]: activity for activity in response.json()}
    assert "plomberie" in activities
    plomberie = activities["plomberie"]
    assert plomberie["status"] == "available"  # rien n'est chargé par défaut
    assert plomberie["imported_version"] is None
    assert plomberie["item_count"] > 100
    assert any(pack["name"] == "Sanitaires" for pack in plomberie["packs"])


async def test_importing_an_activity_fills_the_catalog(
    client: AsyncClient, company_id: str
) -> None:
    response = await client.post("/api/catalog/activities/plomberie")

    assert response.status_code == 200
    result = response.json()
    assert result["categories_created"] > 0
    assert result["items_created"] > 100
    assert result["items_skipped"] == 0

    names = await _categories(client)
    assert "Sanitaires" in names
    assert "Chantier et prestations communes" in names  # le pack commun suit toujours


async def test_activity_is_marked_imported_after_import(
    client: AsyncClient, company_id: str
) -> None:
    await client.post("/api/catalog/activities/plomberie")

    activities = {a["slug"]: a for a in (await client.get("/api/catalog/activities")).json()}
    plomberie = activities["plomberie"]
    assert plomberie["status"] == "imported"
    assert plomberie["imported_version"] == plomberie["version"]
    assert plomberie["imported_at"] is not None
    assert activities["chauffage"]["status"] == "available"


async def test_importing_twice_creates_nothing_new(
    client: AsyncClient, company_id: str
) -> None:
    """Idempotence : réimporter est sans risque et sans effet."""
    first = (await client.post("/api/catalog/activities/plomberie")).json()
    second = (await client.post("/api/catalog/activities/plomberie")).json()

    assert second["items_created"] == 0
    assert second["categories_created"] == 0
    assert second["items_skipped"] == first["items_created"]


async def test_import_never_overwrites_a_price_the_artisan_changed(
    client: AsyncClient, company_id: str
) -> None:
    """Le test qui compte. Le catalogue appartient à l'artisan : un
    réimport ne doit jamais lui reprendre son prix."""
    await client.post("/api/catalog/activities/plomberie")
    items = (await client.get("/api/catalog/items", params={"search": "Mitigeur de lavabo"})).json()
    item = items[0]

    await client.put(
        f"/api/catalog/items/{item['id']}",
        json={"unit_price_ht": "49.90", "designation": "Mitigeur de lavabo (mon tarif)"},
    )
    await client.post("/api/catalog/activities/plomberie")  # réimport

    after = (await client.get(f"/api/catalog/items/{item['id']}")).json()
    assert Decimal(after["unit_price_ht"]) == Decimal("49.90")
    assert after["designation"] == "Mitigeur de lavabo (mon tarif)"


async def test_two_activities_merge_into_one_prestations_folder(
    client: AsyncClient, company_id: str
) -> None:
    """Un plombier-chauffagiste voit UN catalogue, pas deux."""
    await client.post("/api/catalog/activities/plomberie")
    await client.post("/api/catalog/activities/chauffage")

    names = await _categories(client)
    assert names.count("Prestations") == 1
    prestations = (await client.get("/api/catalog/items", params={"search": "Main-d'œuvre"})).json()
    designations = {item["designation"] for item in prestations}
    assert "Main-d'œuvre plomberie" in designations
    assert "Main-d'œuvre chauffage" in designations


async def test_qualification_is_never_loaded_by_default(
    client: AsyncClient, company_id: str
) -> None:
    """Le gaz est réservé aux certifiés PG : l'importer doit être un geste."""
    await client.post("/api/catalog/activities/plomberie")
    assert "Gaz" not in await _categories(client)

    qualifications = (await client.get("/api/catalog/qualifications")).json()
    assert qualifications[0]["status"] == "available"

    result = (await client.post("/api/catalog/qualifications/pg")).json()
    assert result["items_created"] > 0
    assert "Gaz" in await _categories(client)


async def test_removing_an_activity_keeps_the_catalog(
    client: AsyncClient, company_id: str
) -> None:
    """Désactiver n'efface rien : Artizen ne supprime pas les données de l'artisan."""
    await client.post("/api/catalog/activities/plomberie")
    before = await _categories(client)

    response = await client.delete("/api/catalog/activities/plomberie")

    assert response.status_code == 204
    activities = {a["slug"]: a for a in (await client.get("/api/catalog/activities")).json()}
    assert activities["plomberie"]["status"] == "available"
    assert await _categories(client) == before  # le catalogue est intact


async def test_unknown_activity_is_not_found(client: AsyncClient, company_id: str) -> None:
    response = await client.post("/api/catalog/activities/souffleur-de-verre")

    assert response.status_code == 404


async def test_a_newer_version_surfaces_an_update_without_touching_prices(
    client: AsyncClient, company_id: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    """Le cœur du modèle « app store ». L'artisan importe la v1, puis Artizen
    publie une v2 avec un article de plus : l'activité passe en
    « mise à jour disponible » avec le bon décompte, la mise à jour ajoute
    seulement le nouvel article, et ne touche pas aux prix personnalisés."""
    from app.catalog import trades
    from app.catalog.trades.definitions import Activity, CatalogPack, PackItem, VersionNotes
    from decimal import Decimal

    v1 = trades.get_activity("plomberie")
    await client.post("/api/catalog/activities/plomberie")  # importe la v1

    # Artizen publie une v2 : même contenu + un article neuf dans un pack,
    # avec ses nouveautés.
    pack0 = v1.packs[0]
    v2_pack = CatalogPack(
        name=pack0.name,
        items=pack0.items + (PackItem("Article tout neuf v2", "unité", Decimal("10.00"), Decimal("10.00")),),
        description=pack0.description,
    )
    v2 = Activity(
        slug=v1.slug, label=v1.label, version=v1.version + 1,
        packs=(v2_pack, *v1.packs[1:]), description=v1.description,
        changelog=(VersionNotes(version=v1.version + 1, changes=("Ajout de l'article tout neuf",)),),
    )
    monkeypatch.setitem(trades.ACTIVITIES, "plomberie", v2)

    # L'activité signale la mise à jour, +1 article, avec ses nouveautés.
    activities = {a["slug"]: a for a in (await client.get("/api/catalog/activities")).json()}
    assert activities["plomberie"]["status"] == "update_available"
    assert activities["plomberie"]["update_item_count"] == 1
    assert activities["plomberie"]["update_notes"] == ["Ajout de l'article tout neuf"]

    # La mise à jour n'ajoute que le nouvel article.
    result = (await client.post("/api/catalog/activities/plomberie")).json()
    assert result["items_created"] == 1
    assert "Article tout neuf v2" in {
        i["designation"] for i in (await client.get("/api/catalog/items", params={"search": "tout neuf"})).json()
    }

    # Et l'activité repasse « à jour ».
    activities = {a["slug"]: a for a in (await client.get("/api/catalog/activities")).json()}
    assert activities["plomberie"]["status"] == "imported"
