"""FastAPI dependencies for the document-analysis module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.document_analysis.blueprint_builder import BlueprintBuilder
from app.document_analysis.layout_analyzer import LayoutAnalyzer
from app.document_analysis.loader import DocumentLoader
from app.document_analysis.metadata_extractor import MetadataExtractor
from app.document_analysis.pdf_renderer import PDFRenderer
from app.document_analysis.pipeline import DocumentPipeline
from app.document_analysis.service import DocumentAnalysisService
from app.document_analysis.text_extractor import TextExtractor
from app.storage import StorageProvider, get_storage_provider

StorageDep = Annotated[StorageProvider, Depends(get_storage_provider)]


def get_document_analysis_service(
    session: SessionDep, storage: StorageDep
) -> DocumentAnalysisService:
    pipeline = DocumentPipeline(
        loader=DocumentLoader(storage),
        pdf_renderer=PDFRenderer(),
        text_extractor=TextExtractor(),
        metadata_extractor=MetadataExtractor(),
        layout_analyzer=LayoutAnalyzer(),
        blueprint_builder=BlueprintBuilder(),
    )
    return DocumentAnalysisService(session=session, storage=storage, pipeline=pipeline)


DocumentAnalysisServiceDep = Annotated[
    DocumentAnalysisService, Depends(get_document_analysis_service)
]
