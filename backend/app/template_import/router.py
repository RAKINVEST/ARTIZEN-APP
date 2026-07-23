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

from fastapi import APIRouter, Response

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


@router.post(
    "/{analysis_id}/sample-preview",
    response_class=Response,
    responses={
        200: {
            "content": {"application/pdf": {}},
            "description": "A demo quote rendered with the proposed (not yet saved) identity.",
        }
    },
)
async def sample_preview_template_import(
    service: TemplateImportServiceDep,
    current_user: CurrentUserDep,
    analysis_id: uuid.UUID,
    payload: TemplateImportValidateRequest,
) -> Response:
    """The "aperçu du rendu": renders the detected/edited identity onto a demo
    quote without persisting anything, so the artisan sees their devis à leur
    image *before* confirming it with ``/validate``."""
    filename, pdf = await service.render_proposed_sample(
        analysis_id, payload, company_id=current_user.company_id
    )
    return Response(
        content=pdf,
        media_type="application/pdf",
        headers={"Content-Disposition": f'inline; filename="{filename}"'},
    )


@router.post("/{analysis_id}/validate", response_model=BrandingProfileRead)
async def validate_template_import(
    service: TemplateImportServiceDep,
    current_user: CurrentUserDep,
    analysis_id: uuid.UUID,
    payload: TemplateImportValidateRequest,
) -> BrandingProfileRead:
    return await service.validate(analysis_id, payload, company_id=current_user.company_id)
