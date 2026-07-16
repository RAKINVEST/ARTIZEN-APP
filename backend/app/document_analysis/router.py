"""Document-analysis HTTP endpoints.

Every route only declares the request shape and delegates to
``DocumentAnalysisService`` — no business logic lives here.

Every route now requires ``CurrentUserDep`` (Étape 10): the analysis is
always created under ``current_user.company_id`` — ``upload`` no
longer even declares a ``company_id`` form field (an extra one sent by
an un-updated caller is simply ignored, not rejected). By-id routes
verify ownership via ``ensure_same_company`` before returning or (for
``process``) mutating the resource.
"""

import uuid

from fastapi import APIRouter, File, Form, UploadFile, status

from app.core.authorization import ensure_same_company
from app.document_analysis.deps import DocumentAnalysisServiceDep
from app.document_analysis.models import DocumentType
from app.document_analysis.schemas import DocumentAnalysisRead
from app.users.deps import CurrentUserDep

router = APIRouter(prefix="/document-analysis", tags=["document-analysis"])


@router.post("/upload", response_model=DocumentAnalysisRead, status_code=status.HTTP_201_CREATED)
async def upload_document(
    service: DocumentAnalysisServiceDep,
    current_user: CurrentUserDep,
    document_type: DocumentType = Form(...),
    document_template_id: uuid.UUID | None = Form(None),
    file: UploadFile = File(...),
) -> DocumentAnalysisRead:
    analysis = await service.upload(
        company_id=current_user.company_id,
        document_type=document_type,
        document_template_id=document_template_id,
        upload=file,
    )
    return DocumentAnalysisRead.model_validate(analysis)


@router.get("", response_model=list[DocumentAnalysisRead])
async def list_analyses(
    service: DocumentAnalysisServiceDep,
    current_user: CurrentUserDep,
    offset: int = 0,
    limit: int = 100,
) -> list[DocumentAnalysisRead]:
    analyses = await service.list(
        company_id=current_user.company_id, offset=offset, limit=limit
    )
    return [DocumentAnalysisRead.model_validate(analysis) for analysis in analyses]


@router.get("/{analysis_id}", response_model=DocumentAnalysisRead)
async def get_analysis(
    service: DocumentAnalysisServiceDep, current_user: CurrentUserDep, analysis_id: uuid.UUID
) -> DocumentAnalysisRead:
    analysis = await service.get(analysis_id)
    ensure_same_company(analysis.company_id, analysis_id, current_user.company_id)
    return DocumentAnalysisRead.model_validate(analysis)


@router.post("/{analysis_id}/process", response_model=DocumentAnalysisRead)
async def process_analysis(
    service: DocumentAnalysisServiceDep, current_user: CurrentUserDep, analysis_id: uuid.UUID
) -> DocumentAnalysisRead:
    existing = await service.get(analysis_id)
    ensure_same_company(existing.company_id, analysis_id, current_user.company_id)
    analysis = await service.process(analysis_id)
    return DocumentAnalysisRead.model_validate(analysis)
