"""FastAPI dependencies for the template-import module.

Composes three already-wired services/repositories (``branding``,
``document_analysis``, ``document_detection``) rather than re-deriving
any of their own dependency graphs (storage provider, detectors, ...).
"""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.branding.deps import BrandingServiceDep
from app.document_analysis.repository import DocumentAnalysisRepository
from app.document_detection.deps import DocumentDetectionServiceDep
from app.template_import.service import TemplateImportService


def get_template_import_service(
    session: SessionDep,
    branding: BrandingServiceDep,
    detection: DocumentDetectionServiceDep,
) -> TemplateImportService:
    return TemplateImportService(
        analyses=DocumentAnalysisRepository(session), detection=detection, branding=branding
    )


TemplateImportServiceDep = Annotated[
    TemplateImportService, Depends(get_template_import_service)
]
