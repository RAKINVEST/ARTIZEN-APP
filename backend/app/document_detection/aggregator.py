"""Orchestrates all nine detectors and computes the aggregate result.

The PDF bytes are loaded once by the caller (``DocumentDetectionService``)
and passed here only for the two visual detectors; the seven text
detectors reuse the already-extracted text mutualized from
``document_analysis`` — nothing here re-fetches or re-parses the PDF
more than once per detector category.
"""

import logging
import time
from collections.abc import Awaitable, Callable
from typing import TypeVar

from app.document_detection.color_detector import ColorDetector
from app.document_detection.contact_detector import ContactDetector
from app.document_detection.footer_detector import FooterDetector
from app.document_detection.header_detector import HeaderDetector
from app.document_detection.interfaces import DetectorResult
from app.document_detection.legal_notice_detector import LegalNoticeDetector
from app.document_detection.logo_detector import LogoDetector
from app.document_detection.siret_detector import SiretDetector
from app.document_detection.table_detector import TableDetector
from app.document_detection.vat_detector import VatDetector

logger = logging.getLogger(__name__)

T = TypeVar("T")


class DetectionAggregator:
    def __init__(
        self,
        logo_detector: LogoDetector,
        color_detector: ColorDetector,
        header_detector: HeaderDetector,
        footer_detector: FooterDetector,
        contact_detector: ContactDetector,
        siret_detector: SiretDetector,
        vat_detector: VatDetector,
        legal_notice_detector: LegalNoticeDetector,
        table_detector: TableDetector,
    ) -> None:
        self._logo_detector = logo_detector
        self._color_detector = color_detector
        self._header_detector = header_detector
        self._footer_detector = footer_detector
        self._contact_detector = contact_detector
        self._siret_detector = siret_detector
        self._vat_detector = vat_detector
        self._legal_notice_detector = legal_notice_detector
        self._table_detector = table_detector

    async def aggregate(self, *, text: str, content: bytes) -> dict[str, object]:
        logo = await self._run("logo", self._logo_detector.detect, content)
        color = await self._run("color", self._color_detector.detect, content)
        header = await self._run("header", self._header_detector.detect, text)
        footer = await self._run("footer", self._footer_detector.detect, text)
        contact = await self._run("contact", self._contact_detector.detect, text)
        siret = await self._run("siret", self._siret_detector.detect, text)
        vat = await self._run("vat", self._vat_detector.detect, text)
        legal_notice = await self._run(
            "legal_notice", self._legal_notice_detector.detect, text
        )
        table = await self._run("table", self._table_detector.detect, text)

        results = {
            "logo": logo,
            "color": color,
            "header": header,
            "footer": footer,
            "contact": contact,
            "siret": siret,
            "vat": vat,
            "legal_notice": legal_notice,
            "table": table,
        }
        confidence_score = round(
            sum(result.confidence for result in results.values()) / len(results), 2
        )

        return {
            "logo_detected": logo.detected,
            "logo_position": logo.data.get("position"),
            "dominant_colors": color.data.get("colors", []),
            "header_detected": header.detected,
            "footer_detected": footer.detected,
            "table_detected": table.detected,
            "company_name": contact.data.get("company_name"),
            "address": contact.data.get("address"),
            "phone": contact.data.get("phone"),
            "email": contact.data.get("email"),
            "website": contact.data.get("website"),
            "siret": siret.data.get("siret"),
            "vat_number": vat.data.get("vat_number"),
            "legal_notice_detected": legal_notice.detected,
            "confidence_score": confidence_score,
            "detection_details": {
                name: {"detected": result.detected, "confidence": result.confidence, **result.data}
                for name, result in results.items()
            },
        }

    @staticmethod
    async def _run(
        name: str, func: Callable[[T], Awaitable[DetectorResult]], arg: T
    ) -> DetectorResult:
        started_at = time.perf_counter()
        logger.info("detector.start name=%s", name)
        try:
            result = await func(arg)
        except Exception:
            duration_ms = int((time.perf_counter() - started_at) * 1000)
            logger.exception("detector.failed name=%s duration_ms=%d", name, duration_ms)
            return DetectorResult(detected=False, confidence=0.0, data={})
        duration_ms = int((time.perf_counter() - started_at) * 1000)
        logger.info(
            "detector.completed name=%s duration_ms=%d detected=%s confidence=%.2f",
            name,
            duration_ms,
            result.detected,
            result.confidence,
        )
        return result
