"""Branding business logic: validates uploads, stores files, and
orchestrates persistence. Routes never touch repositories or the storage
provider directly — everything goes through this service.

Every method takes an explicit ``company_id`` — the caller's real,
authenticated tenant (see ``users.deps.CurrentUserDep``), resolved by
the router, never guessed here. Before Étape 10 this service instead
auto-created/reused a single implicit "first company" row, a
placeholder for a real multi-tenant boundary that didn't exist yet;
now that ``users.AuthService.register()`` creates a real ``Company``
per account, that singleton hack is gone — a company is only ever
missing here if the caller passed a bogus id, which is a genuine 404,
not something to paper over by creating one.
"""

import logging
import uuid

from fastapi import UploadFile
from sqlalchemy.ext.asyncio import AsyncSession

from app.branding.models import BrandProfile, Company, DocumentTemplate, TemplateType
from app.branding.repository import (
    BrandProfileRepository,
    CompanyRepository,
    DocumentTemplateRepository,
)
from app.branding.schemas import (
    BrandingProfileRead,
    BrandProfileRead,
    BrandProfileUpdate,
    CompanyRead,
    CompanyUpdate,
    DocumentTemplateRead,
    StoredFileInfo,
    TemplateUploadResult,
)
from app.core.exceptions import NotFoundError
from app.storage import StorageProvider
from app.utils.upload_validation import read_validated_upload

logger = logging.getLogger(__name__)

_LOGO_CONTENT_TYPES = {"image/png", "image/jpeg", "image/svg+xml"}
_LOGO_MAX_SIZE_BYTES = 5 * 1024 * 1024  # 5 MB

_PDF_CONTENT_TYPES = {"application/pdf"}
_PDF_MAX_SIZE_BYTES = 15 * 1024 * 1024  # 15 MB


class BrandingService:
    def __init__(self, session: AsyncSession, storage: StorageProvider) -> None:
        self._session = session
        self._storage = storage
        self._companies = CompanyRepository(session)
        self._profiles = BrandProfileRepository(session)
        self._templates = DocumentTemplateRepository(session)

    async def upload_logo(self, company_id: uuid.UUID, upload: UploadFile) -> StoredFileInfo:
        content = await read_validated_upload(
            upload, allowed_content_types=_LOGO_CONTENT_TYPES, max_size_bytes=_LOGO_MAX_SIZE_BYTES
        )
        profile = await self._get_or_create_profile(company_id)
        return await self._store_logo(
            profile,
            company_id,
            content=content,
            content_type=upload.content_type or "application/octet-stream",
            filename=upload.filename or "logo",
        )

    async def set_logo_from_bytes(
        self,
        company_id: uuid.UUID,
        content: bytes,
        *,
        content_type: str = "image/png",
        filename: str = "logo.png",
    ) -> StoredFileInfo:
        """Persists already-in-hand image bytes as the company logo, without
        an ``UploadFile`` or MIME re-validation. Used by ``template_import``,
        which extracts the logo from an imported PDF and must store it the
        same way an explicit upload would — same replace-and-cleanup path, so
        a re-import never leaks the previous logo file."""
        profile = await self._get_or_create_profile(company_id)
        return await self._store_logo(
            profile, company_id, content=content, content_type=content_type, filename=filename
        )

    async def _store_logo(
        self,
        profile: BrandProfile,
        company_id: uuid.UUID,
        *,
        content: bytes,
        content_type: str,
        filename: str,
    ) -> StoredFileInfo:
        previous_logo_key = profile.logo_path
        stored = await self._storage.save(
            category="logos",
            filename=filename,
            content_type=content_type,
            content=content,
        )
        profile.logo_path = stored.key

        # Reassigning logo_path drops the only reference to the previous
        # file, so without this the old logo stays on disk forever: every
        # re-upload leaked up to _LOGO_MAX_SIZE_BYTES into a volume with no
        # purge path. Deleted after the new key is in place, and never at
        # the cost of the request: the artisan's new logo is saved either
        # way, an orphan file is a janitorial problem, not their problem.
        if previous_logo_key and previous_logo_key != stored.key:
            try:
                await self._storage.delete(previous_logo_key)
            except OSError:
                logger.warning(
                    "branding.previous_logo_delete_failed company_id=%s key=%s",
                    company_id,
                    previous_logo_key,
                    exc_info=True,
                )
        return StoredFileInfo(
            filename=stored.filename,
            content_type=stored.content_type,
            size_bytes=stored.size_bytes,
            path=stored.key,
        )

    async def upload_template(
        self, company_id: uuid.UUID, template_type: TemplateType, upload: UploadFile
    ) -> TemplateUploadResult:
        content = await read_validated_upload(
            upload, allowed_content_types=_PDF_CONTENT_TYPES, max_size_bytes=_PDF_MAX_SIZE_BYTES
        )
        stored = await self._storage.save(
            category=f"templates/{template_type.value}",
            filename=upload.filename or f"{template_type.value}.pdf",
            content_type=upload.content_type or "application/pdf",
            content=content,
        )

        template = await self._create_new_template_version(
            company_id,
            template_type,
            filename=upload.filename or f"{template_type.value}.pdf",
            storage_key=stored.key,
        )

        return TemplateUploadResult(
            template=DocumentTemplateRead.model_validate(template),
            file=StoredFileInfo(
                filename=stored.filename,
                content_type=stored.content_type,
                size_bytes=stored.size_bytes,
                path=stored.key,
            ),
        )

    async def create_template_from_existing_file(
        self, company_id: uuid.UUID, template_type: TemplateType, *, filename: str, storage_key: str
    ) -> DocumentTemplateRead:
        """Registers an already-stored file (no fresh upload/validation) as
        a new template version. Used by ``template_import``, which reuses
        the PDF a ``DocumentAnalysis`` already stored rather than asking
        the caller to upload the same bytes a second time."""
        template = await self._create_new_template_version(
            company_id, template_type, filename=filename, storage_key=storage_key
        )
        return DocumentTemplateRead.model_validate(template)

    async def _create_new_template_version(
        self, company_id: uuid.UUID, template_type: TemplateType, *, filename: str, storage_key: str
    ) -> DocumentTemplate:
        company = await self._get_company(company_id)

        previous_active = await self._templates.get_active(company.id, template_type)
        if previous_active is not None:
            previous_active.is_active = False

        next_version = await self._templates.get_latest_version(company.id, template_type) + 1
        return await self._templates.create(
            DocumentTemplate(
                company_id=company.id,
                type=template_type,
                name=filename,
                version=next_version,
                source_file_path=storage_key,
                is_active=True,
            )
        )

    async def update_company(self, company_id: uuid.UUID, data: CompanyUpdate) -> CompanyRead:
        company = await self._get_company(company_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(company, field, value)
        await self._session.flush()
        await self._session.refresh(company)
        return CompanyRead.model_validate(company)

    async def update_profile(
        self, company_id: uuid.UUID, data: BrandProfileUpdate
    ) -> BrandProfileRead:
        profile = await self._get_or_create_profile(company_id)
        for field, value in data.model_dump(exclude_unset=True).items():
            setattr(profile, field, value)
        await self._session.flush()
        await self._session.refresh(profile)
        return BrandProfileRead.model_validate(profile)

    async def get_company_name(self, company_id: uuid.UUID) -> str | None:
        """Lighter than `get_profile()`: callers that only need the
        company's display name (e.g. `quote_assistant`'s prompt context)
        shouldn't pay for fetching the brand profile and full template
        history too."""
        company = await self._get_company(company_id)
        return company.name or company.legal_name

    async def get_profile(self, company_id: uuid.UUID) -> BrandingProfileRead:
        company = await self._get_company(company_id)
        profile = await self._get_or_create_profile_for(company)
        templates = await self._templates.list_by_company(company.id)
        return BrandingProfileRead(
            company=CompanyRead.model_validate(company),
            brand=BrandProfileRead.model_validate(profile),
            templates=[DocumentTemplateRead.model_validate(t) for t in templates],
        )

    async def _get_company(self, company_id: uuid.UUID) -> Company:
        company = await self._companies.get(company_id)
        if company is None:
            raise NotFoundError(f"Company {company_id} not found.")
        return company

    async def _get_or_create_profile(self, company_id: uuid.UUID) -> BrandProfile:
        company = await self._get_company(company_id)
        return await self._get_or_create_profile_for(company)

    async def _get_or_create_profile_for(self, company: Company) -> BrandProfile:
        profile = await self._profiles.get_by_company_id(company.id)
        if profile is not None:
            return profile
        return await self._profiles.create(BrandProfile(company_id=company.id))
