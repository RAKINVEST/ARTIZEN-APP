"""Document-detection HTTP endpoint.

Mounted under the same ``/document-analysis`` URL prefix as
``document_analysis``'s own router (not ``/document-detection``): the
resource this exposes — "the detection result of this analysis" — is
naturally addressed as a sub-resource of an analysis. Two routers can
share a URL prefix without conflict as long as their paths don't
literally collide, which they don't here
(``/document-analysis/{id}/process`` vs. ``/document-analysis/{id}/detection``).
"""

import uuid

from fastapi import APIRouter

from app.document_detection.deps import DocumentDetectionServiceDep
from app.document_detection.schemas import DocumentDetectionResultRead
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/document-analysis", tags=["document-detection"])


@router.get("/{analysis_id}/detection", response_model=DocumentDetectionResultRead)
async def get_detection(
    service: DocumentDetectionServiceDep, current_user: CurrentUserDep, analysis_id: uuid.UUID
) -> DocumentDetectionResultRead:
    result = await service.get_or_run(analysis_id, company_id=current_user.company_id)
    return DocumentDetectionResultRead.model_validate(result)
