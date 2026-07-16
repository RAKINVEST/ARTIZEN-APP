"""FastAPI dependencies for the document-detection module."""

from typing import Annotated

from fastapi import Depends

from app.api.deps import SessionDep
from app.document_detection.aggregator import DetectionAggregator
from app.document_detection.color_detector import ColorDetector
from app.document_detection.contact_detector import ContactDetector
from app.document_detection.footer_detector import FooterDetector
from app.document_detection.header_detector import HeaderDetector
from app.document_detection.legal_notice_detector import LegalNoticeDetector
from app.document_detection.logo_detector import LogoDetector
from app.document_detection.service import DocumentDetectionService
from app.document_detection.siret_detector import SiretDetector
from app.document_detection.table_detector import TableDetector
from app.document_detection.vat_detector import VatDetector
from app.storage import StorageProvider, get_storage_provider

StorageDep = Annotated[StorageProvider, Depends(get_storage_provider)]


def get_document_detection_service(
    session: SessionDep, storage: StorageDep
) -> DocumentDetectionService:
    aggregator = DetectionAggregator(
        logo_detector=LogoDetector(),
        color_detector=ColorDetector(),
        header_detector=HeaderDetector(),
        footer_detector=FooterDetector(),
        contact_detector=ContactDetector(),
        siret_detector=SiretDetector(),
        vat_detector=VatDetector(),
        legal_notice_detector=LegalNoticeDetector(),
        table_detector=TableDetector(),
    )
    return DocumentDetectionService(session=session, storage=storage, aggregator=aggregator)


DocumentDetectionServiceDep = Annotated[
    DocumentDetectionService, Depends(get_document_detection_service)
]
