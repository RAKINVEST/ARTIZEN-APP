"""Quote-extraction HTTP endpoints (V2 import).

Two thin routes on top of the existing ``/document-analysis`` upload+process:
``extract`` returns the full editable quote read from the PDF, and
``preview-pdf`` returns a faithful reproduction with the artisan's identity
applied. Every route is tenant-scoped via ``current_user.company_id``; the
analysis id in the URL is verified to belong to the caller before anything runs.
"""

import uuid

from fastapi import APIRouter, Response

from app.quote_extraction.deps import QuoteExtractionServiceDep
from app.quote_extraction.schemas import ExtractedQuote
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/quote-extraction", tags=["quote-extraction"])


@router.post("/{analysis_id}/extract", response_model=ExtractedQuote)
async def extract_quote(
    service: QuoteExtractionServiceDep,
    current_user: CurrentUserDep,
    analysis_id: uuid.UUID,
) -> ExtractedQuote:
    """Reconstruct the full, editable quote from an imported (already analysed)
    PDF. Absent fields come back empty — never invented."""
    return await service.extract(analysis_id, company_id=current_user.company_id)


@router.post(
    "/{analysis_id}/preview-pdf",
    response_class=Response,
    responses={
        200: {
            "content": {"application/pdf": {}},
            "description": "The imported devis reproduced with the artisan's identity.",
        }
    },
)
async def preview_reproduction(
    service: QuoteExtractionServiceDep,
    current_user: CurrentUserDep,
    analysis_id: uuid.UUID,
) -> Response:
    filename, pdf = await service.render_reproduction_pdf(
        analysis_id, company_id=current_user.company_id
    )
    return Response(
        content=pdf,
        media_type="application/pdf",
        headers={"Content-Disposition": f'inline; filename="{filename}"'},
    )
