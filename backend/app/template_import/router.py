"""Template-import HTTP endpoints.

Mounted under ``/template-import/{analysis_id}/...``: the analysis
itself is uploaded/processed through the existing
``/document-analysis`` endpoints (upload -> process); this module only
adds the two steps specific to "importer un ancien devis" —
preview the detected identity/branding, then validate it into the
company's active quote template.

Requires ``CurrentUserDep`` (Étape 10): both steps are scoped to
``current_user.company_id`` — ``TemplateImportService`` verifies the
target analysis actually belongs to that company before doing anything
with it.
"""

import uuid

from fastapi import APIRouter

from app.branding.schemas import BrandingProfileRead
from app.template_import.deps import TemplateImportServiceDep
from app.template_import.schemas import TemplateImportPreviewRead, TemplateImportValidateRequest
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/template-import", tags=["template-import"])


@router.get("/{analysis_id}/preview", response_model=TemplateImportPreviewRead)
async def preview_template_import(
    service: TemplateImportServiceDep, current_user: CurrentUserDep, analysis_id: uuid.UUID
) -> TemplateImportPreviewRead:
    return await service.preview(analysis_id, company_id=current_user.company_id)


@router.post("/{analysis_id}/validate", response_model=BrandingProfileRead)
async def validate_template_import(
    service: TemplateImportServiceDep,
    current_user: CurrentUserDep,
    analysis_id: uuid.UUID,
    payload: TemplateImportValidateRequest,
) -> BrandingProfileRead:
    return await service.validate(analysis_id, payload, company_id=current_user.company_id)
