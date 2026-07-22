"""Branding HTTP endpoints.

Every route only declares the request shape and delegates to
``BrandingService`` — no business logic lives here. Every route now
also requires ``CurrentUserDep`` and passes ``current_user.company_id``
to the service: the caller's own authenticated tenant, never a
client-suppliable value (see ``users.deps`` and the root README's
"Authentification (Étape 10)" section).
"""

from typing import Literal

from fastapi import APIRouter, File, Response, UploadFile, status

from app.branding.deps import BrandingServiceDep
from app.branding.models import TemplateType
from app.branding.schemas import (
    BrandingProfileRead,
    BrandProfileRead,
    BrandProfileUpdate,
    CompanyRead,
    CompanyUpdate,
    StoredFileInfo,
    TemplateUploadResult,
)
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/branding", tags=["branding"])


@router.post("/logo", response_model=StoredFileInfo, status_code=status.HTTP_201_CREATED)
async def upload_logo(
    service: BrandingServiceDep, current_user: CurrentUserDep, file: UploadFile = File(...)
) -> StoredFileInfo:
    return await service.upload_logo(current_user.company_id, file)


@router.delete("/logo", status_code=status.HTTP_204_NO_CONTENT)
async def delete_logo(service: BrandingServiceDep, current_user: CurrentUserDep) -> None:
    """Remove the company logo — so an account that has none (or a wrongly
    imported one) falls back to its name in the document header."""
    await service.delete_asset(current_user.company_id, "logo")


@router.post("/signature", response_model=StoredFileInfo, status_code=status.HTTP_201_CREATED)
async def upload_signature(
    service: BrandingServiceDep, current_user: CurrentUserDep, file: UploadFile = File(...)
) -> StoredFileInfo:
    """The artisan's own signature, drawn on the quotes they issue."""
    return await service.upload_signature(current_user.company_id, file)


@router.delete("/signature", status_code=status.HTTP_204_NO_CONTENT)
async def delete_signature(service: BrandingServiceDep, current_user: CurrentUserDep) -> None:
    await service.delete_asset(current_user.company_id, "signature")


@router.post("/stamp", response_model=StoredFileInfo, status_code=status.HTTP_201_CREATED)
async def upload_stamp(
    service: BrandingServiceDep, current_user: CurrentUserDep, file: UploadFile = File(...)
) -> StoredFileInfo:
    """The company stamp (optional), drawn next to the signature."""
    return await service.upload_stamp(current_user.company_id, file)


@router.delete("/stamp", status_code=status.HTTP_204_NO_CONTENT)
async def delete_stamp(service: BrandingServiceDep, current_user: CurrentUserDep) -> None:
    await service.delete_asset(current_user.company_id, "stamp")


@router.get(
    "/asset/{kind}",
    response_class=Response,
    responses={200: {"content": {"image/*": {}}}, 404: {"description": "No such asset configured."}},
)
async def get_asset(
    service: BrandingServiceDep,
    current_user: CurrentUserDep,
    kind: Literal["logo", "signature", "stamp"],
) -> Response:
    """Serve a stored brand asset so the app can preview it. Tenant-scoped: the
    key is resolved from the caller's own company, never taken from the URL."""
    content, content_type = await service.load_asset(current_user.company_id, kind)
    return Response(content=content, media_type=content_type)


@router.post(
    "/template/quote", response_model=TemplateUploadResult, status_code=status.HTTP_201_CREATED
)
async def upload_quote_template(
    service: BrandingServiceDep, current_user: CurrentUserDep, file: UploadFile = File(...)
) -> TemplateUploadResult:
    return await service.upload_template(current_user.company_id, TemplateType.QUOTE, file)


@router.post(
    "/template/invoice", response_model=TemplateUploadResult, status_code=status.HTTP_201_CREATED
)
async def upload_invoice_template(
    service: BrandingServiceDep, current_user: CurrentUserDep, file: UploadFile = File(...)
) -> TemplateUploadResult:
    return await service.upload_template(current_user.company_id, TemplateType.INVOICE, file)


@router.get("/profile", response_model=BrandingProfileRead)
async def get_profile(
    service: BrandingServiceDep, current_user: CurrentUserDep
) -> BrandingProfileRead:
    return await service.get_profile(current_user.company_id)


@router.put("/company", response_model=CompanyRead)
async def update_company(
    service: BrandingServiceDep, current_user: CurrentUserDep, payload: CompanyUpdate
) -> CompanyRead:
    return await service.update_company(current_user.company_id, payload)


@router.put("/brand", response_model=BrandProfileRead)
async def update_brand_profile(
    service: BrandingServiceDep, current_user: CurrentUserDep, payload: BrandProfileUpdate
) -> BrandProfileRead:
    return await service.update_profile(current_user.company_id, payload)
