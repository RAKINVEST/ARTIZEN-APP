"""Catalog business logic: categories and items. Routes never touch the
repositories directly — everything goes through this service.

Category and item management are grouped in a single service (rather
than two), mirroring ``BrandingService`` in step 2: both concern "the
catalog" as one cohesive resource, and splitting them would only add
indirection without a real separation of concerns.
"""

import uuid
from datetime import datetime, timezone

from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.branding.models import Company
from app.branding.repository import CompanyRepository
from app.catalog import trades
from app.catalog.models import CatalogCategory, CatalogItem, ItemType
from app.catalog.repository import CatalogCategoryRepository, CatalogItemRepository
from app.catalog.schemas import (
    ActivityRead,
    CatalogCategoryCreate,
    CatalogCategoryUpdate,
    CatalogImportResult,
    CatalogItemCreate,
    CatalogItemUpdate,
    CatalogPackSummary,
    QualificationRead,
)
from app.core.authorization import ensure_same_company
from app.core.exceptions import ConflictError, NotFoundError


class CatalogService:
    def __init__(self, session: AsyncSession) -> None:
        self._session = session
        self._categories = CatalogCategoryRepository(session)
        self._items = CatalogItemRepository(session)
        # The activities and qualifications a company has ticked live on the
        # company row. Same one-way dependency users -> branding already has.
        self._companies = CompanyRepository(session)

    # --- Activités et qualifications : composition du catalogue ---

    async def _company(self, company_id: uuid.UUID) -> Company:
        company = await self._companies.get(company_id)
        if company is None:
            raise NotFoundError(f"Company {company_id} not found.")
        return company

    async def _describe(self, schema, company_id: uuid.UUID, source, imported: dict):  # type: ignore[no-untyped-def]
        """Build one settings card: what the source adds, and its state.

        Three states, app-store style. Not in ``imported`` -> available. Same
        version -> up to date. A newer version in code than the one imported ->
        update available, and only then do we count the articles it would add
        (a per-source query, so it stays off the common path).
        """
        entry = imported.get(source.slug)
        imported_version = entry.get("version") if entry else None
        imported_at = entry.get("imported_at") if entry else None

        if entry is None:
            status = "available"
            update_item_count = None
            update_notes = None
        elif source.version > imported_version:
            status = "update_available"
            update_item_count = await self._count_new_items(company_id, source)
            update_notes = trades.notes_since(source.changelog, imported_version)
        else:
            status = "imported"
            update_item_count = None
            update_notes = None

        items = [item for pack in source.packs for item in pack.items]
        return schema(
            slug=source.slug,
            label=source.label,
            description=source.description,
            packs=[
                CatalogPackSummary(name=pack.name, item_count=len(pack.items))
                for pack in source.packs
            ],
            item_count=len(items),
            product_count=sum(1 for item in items if item.item_type == ItemType.PRODUCT),
            prestation_count=sum(1 for item in items if item.item_type == ItemType.SERVICE),
            status=status,
            version=source.version,
            imported_version=imported_version,
            imported_at=imported_at,
            update_item_count=update_item_count,
            update_notes=update_notes,
        )

    async def _count_new_items(self, company_id: uuid.UUID, source) -> int:  # type: ignore[no-untyped-def]
        """How many articles importing ``source`` right now would add.

        A dry run of the additive seed: an article is "new" only if its folder
        doesn't already hold that designation. Deleted-then-republished
        articles do count — the update re-adds them, which is non-destructive.
        """
        count = 0
        for pack in trades.merge_packs([*source.packs]):
            category = await self._categories.get_by_name(company_id, pack.name)
            existing = (
                await self._items.designations_in_category(category.id)
                if category is not None
                else set()
            )
            count += sum(1 for item in pack.items if item.designation not in existing)
        return count

    async def list_activities(self, company_id: uuid.UUID) -> list[ActivityRead]:
        imported = (await self._company(company_id)).activities
        return [
            await self._describe(ActivityRead, company_id, activity, imported)
            for activity in trades.list_activities()
        ]

    async def list_qualifications(self, company_id: uuid.UUID) -> list[QualificationRead]:
        imported = (await self._company(company_id)).qualifications
        return [
            await self._describe(QualificationRead, company_id, qualification, imported)
            for qualification in trades.list_qualifications()
        ]

    async def import_activity(self, company_id: uuid.UUID, slug: str) -> CatalogImportResult:
        """Import *or update* — the same additive seed serves both.

        The "Importer" and "Mettre à jour" buttons hit this one route: adding
        the new articles of a newer version is exactly importing while skipping
        everything already there. On success the imported version is recorded,
        which is what clears the "mise à jour disponible" badge.
        """
        activity = trades.get_activity(slug)
        if activity is None:
            raise NotFoundError(f"Activity '{slug}' not found.")
        company = await self._company(company_id)
        result = await self._seed(company_id, activity)
        company.activities = {**company.activities, slug: self._stamp(activity.version)}
        return result

    async def import_qualification(
        self, company_id: uuid.UUID, slug: str
    ) -> CatalogImportResult:
        qualification = trades.get_qualification(slug)
        if qualification is None:
            raise NotFoundError(f"Qualification '{slug}' not found.")
        company = await self._company(company_id)
        result = await self._seed(company_id, qualification)
        company.qualifications = {
            **company.qualifications,
            slug: self._stamp(qualification.version),
        }
        return result

    @staticmethod
    def _stamp(version: int) -> dict:
        """The stored record of an import: which version, and when."""
        return {"version": version, "imported_at": datetime.now(timezone.utc).isoformat()}

    async def _seed(self, company_id: uuid.UUID, source: object) -> CatalogImportResult:
        """Copie les packs dans le catalogue de l'entreprise.

        **Purement additif.** Un dossier déjà présent est réutilisé (jamais
        dupliqué, jamais renommé) et un article déjà présent est laissé
        intact : son prix et son libellé appartiennent à l'artisan
        (`docs/DECISIONS.md`, décision 1). Réimporter est donc sans risque,
        et c'est ce qui rend l'opération idempotente.

        C'est aussi ce qui fait la fusion : importer Chauffage après Plomberie
        retrouve le dossier « Prestations » existant et y ajoute ses lignes,
        au lieu d'en créer un second.
        """
        categories_created = items_created = items_skipped = 0
        # Le pack Chantier accompagne tout import : déplacement, dépose,
        # déchets et essais appartiennent à tous les métiers et à aucun. Le
        # rajouter à chaque fois est sans effet dès la deuxième import — c'est
        # précisément ce que garantit l'idempotence ci-dessous.
        packs = trades.merge_packs([*source.packs, trades.CHANTIER])  # type: ignore[attr-defined]
        for pack in packs:
            category = await self._categories.get_by_name(company_id, pack.name)
            if category is None:
                category = await self._categories.create(
                    CatalogCategory(
                        company_id=company_id, name=pack.name, description=pack.description
                    )
                )
                categories_created += 1
                existing: set[str] = set()
            else:
                existing = await self._items.designations_in_category(category.id)

            for item in pack.items:
                if item.designation in existing:
                    items_skipped += 1
                    continue
                await self._items.create(
                    CatalogItem(
                        company_id=company_id,
                        category_id=category.id,
                        designation=item.designation,
                        description=item.description,
                        item_type=item.item_type,
                        unit=item.unit,
                        unit_price_ht=item.unit_price_ht,
                        vat_rate=item.vat_rate,
                        estimated_duration_minutes=item.estimated_duration_minutes,
                    )
                )
                existing.add(item.designation)
                items_created += 1

        await self._session.flush()
        return CatalogImportResult(
            slug=source.slug,  # type: ignore[attr-defined]
            label=source.label,  # type: ignore[attr-defined]
            categories_created=categories_created,
            items_created=items_created,
            items_skipped=items_skipped,
        )

    async def remove_activity(self, company_id: uuid.UUID, slug: str) -> None:
        """Désactive une activité — **le catalogue n'est pas touché**.

        Supprimer les articles serait détruire le travail de l'artisan : il a
        pu corriger des prix, réécrire des libellés, en ajouter. Le catalogue
        lui appartient (décision 1) ; Artizen n'efface pas ses données. Retirer
        l'activité l'empêche seulement d'être réimportée, et il supprime
        lui-même les articles dont il ne veut plus.
        """
        company = await self._company(company_id)
        company.activities = {s: v for s, v in company.activities.items() if s != slug}
        await self._session.flush()

    async def remove_qualification(self, company_id: uuid.UUID, slug: str) -> None:
        """Retire une qualification. Même principe : le catalogue est intact."""
        company = await self._company(company_id)
        company.qualifications = {
            s: v for s, v in company.qualifications.items() if s != slug
        }
        await self._session.flush()

    # --- Categories ---

    async def create_category(self, data: CatalogCategoryCreate) -> CatalogCategory:
        return await self._categories.create(CatalogCategory(**data.model_dump()))

    async def get_category(self, category_id: uuid.UUID) -> CatalogCategory:
        category = await self._categories.get(category_id)
        if category is None:
            raise NotFoundError(f"Catalog category {category_id} not found.")
        return category

    async def list_categories(
        self, *, company_id: uuid.UUID | None = None, offset: int = 0, limit: int = 100
    ) -> list[CatalogCategory]:
        if company_id is not None:
            return await self._categories.list_by_company(company_id, offset=offset, limit=limit)
        return await self._categories.list(offset=offset, limit=limit)

    async def update_category(
        self, category_id: uuid.UUID, data: CatalogCategoryUpdate
    ) -> CatalogCategory:
        category = await self.get_category(category_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(category, field, value)
        await self._session.flush()
        await self._session.refresh(category)
        return category

    async def delete_category(self, category_id: uuid.UUID) -> None:
        category = await self.get_category(category_id)
        try:
            await self._categories.delete(category)
        except IntegrityError as exc:
            await self._session.rollback()
            raise ConflictError(
                f"Catalog category {category_id} still has items and cannot be deleted."
            ) from exc

    # --- Items ---

    async def _ensure_category_belongs_to(
        self, category_id: uuid.UUID, company_id: uuid.UUID
    ) -> None:
        """The category is the one field on an item that points at another
        row, and it arrives straight from the client. The foreign key only
        proves the row exists — not that it is *this* company's.

        Without this, an item could be attached to another company's
        category, which then pins that company: CatalogItem.category_id is
        RESTRICT, so the victim could never delete their own category
        again (a permanent 409 they cannot explain or fix). Exploiting it
        needs a category UUID no route ever discloses, which is why this
        is a hole rather than a breach — but the contract says company_id
        never comes from the client, and until now that only held for the
        row itself, not for what it referenced.
        """
        category = await self._categories.get(category_id)
        if category is None:
            raise NotFoundError(f"Catalog category {category_id} not found.")
        ensure_same_company(category.company_id, category_id, company_id)

    async def create_item(self, data: CatalogItemCreate) -> CatalogItem:
        if data.company_id is not None:
            await self._ensure_category_belongs_to(data.category_id, data.company_id)
        return await self._items.create(CatalogItem(**data.model_dump()))

    async def get_item(self, item_id: uuid.UUID) -> CatalogItem:
        item = await self._items.get(item_id)
        if item is None:
            raise NotFoundError(f"Catalog item {item_id} not found.")
        return item

    async def list_items(
        self,
        *,
        company_id: uuid.UUID | None = None,
        active_only: bool = False,
        query: str | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[CatalogItem]:
        if company_id is not None:
            return await self._items.list_by_company(
                company_id, active_only=active_only, search=query, offset=offset, limit=limit
            )
        return await self._items.list(offset=offset, limit=limit)

    async def update_item(self, item_id: uuid.UUID, data: CatalogItemUpdate) -> CatalogItem:
        item = await self.get_item(item_id)
        # Same check as create_item, and needed for the same reason: the
        # router has already confirmed the *item* is this company's, but
        # category_id can still be repointed at anyone's category.
        # item.company_id is the trustworthy side here — the router derived
        # it from the JWT before letting the update through.
        if data.category_id is not None and data.category_id != item.category_id:
            await self._ensure_category_belongs_to(data.category_id, item.company_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(item, field, value)
        await self._session.flush()
        await self._session.refresh(item)
        return item

    async def deactivate_item(self, item_id: uuid.UUID) -> CatalogItem:
        """Soft-delete: sets ``active=False`` rather than removing the row,
        since a past quote may already reference this item."""
        item = await self.get_item(item_id)
        item.active = False
        await self._session.flush()
        await self._session.refresh(item)
        return item
