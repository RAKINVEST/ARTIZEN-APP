"""Orchestrates the document analysis pipeline.

``DocumentPipeline`` only sequences the six stages and logs their
start/end/duration/errors — it holds no analysis logic of its own, and
knows nothing about ``DocumentAnalysis`` persistence or status
transitions (that's ``DocumentAnalysisService``'s job). Each stage is
injected through the constructor as a plain object, so any one of them
can be swapped for a different implementation (e.g. a Vision-based
``LayoutAnalyzer``) without touching this class or the others.
"""

import logging
import time
from collections.abc import Awaitable, Callable
from dataclasses import dataclass
from typing import TypeVar

from app.document_analysis.blueprint_builder import BlueprintBuilder
from app.document_analysis.layout_analyzer import LayoutAnalyzer
from app.document_analysis.loader import DocumentLoader
from app.document_analysis.metadata_extractor import MetadataExtractor
from app.document_analysis.models import DocumentAnalysis
from app.document_analysis.pdf_renderer import PDFRenderer
from app.document_analysis.text_extractor import TextExtractor

logger = logging.getLogger(__name__)

T = TypeVar("T")


@dataclass
class PipelineResult:
    page_count: int
    extracted_text: str
    extracted_metadata: dict[str, object]
    detected_layout: dict[str, object]
    blueprint: dict[str, object]


class DocumentPipeline:
    def __init__(
        self,
        loader: DocumentLoader,
        pdf_renderer: PDFRenderer,
        text_extractor: TextExtractor,
        metadata_extractor: MetadataExtractor,
        layout_analyzer: LayoutAnalyzer,
        blueprint_builder: BlueprintBuilder,
    ) -> None:
        self._loader = loader
        self._pdf_renderer = pdf_renderer
        self._text_extractor = text_extractor
        self._metadata_extractor = metadata_extractor
        self._layout_analyzer = layout_analyzer
        self._blueprint_builder = blueprint_builder

    async def run(self, analysis: DocumentAnalysis) -> PipelineResult:
        logger.info(
            "pipeline.start analysis_id=%s filename=%s", analysis.id, analysis.filename
        )
        content = await self._run_stage(
            "loader", analysis.id, self._loader.load, analysis.storage_key
        )
        page_count = await self._run_stage(
            "pdf_renderer", analysis.id, self._pdf_renderer.render, content
        )
        text = await self._run_stage(
            "text_extractor", analysis.id, self._text_extractor.extract, content
        )
        metadata = await self._run_stage(
            "metadata_extractor",
            analysis.id,
            self._metadata_extractor.extract,
            filename=analysis.filename,
            mime_type=analysis.mime_type,
            file_size=analysis.file_size,
            page_count=page_count,
            imported_at=analysis.created_at,
        )
        layout = await self._run_stage(
            "layout_analyzer", analysis.id, self._layout_analyzer.analyze, text, page_count
        )
        blueprint = await self._run_stage(
            "blueprint_builder",
            analysis.id,
            self._blueprint_builder.build,
            metadata=metadata,
            layout=layout,
        )
        logger.info("pipeline.completed analysis_id=%s", analysis.id)
        return PipelineResult(
            page_count=page_count,
            extracted_text=text,
            extracted_metadata=metadata,
            detected_layout=layout,
            blueprint=blueprint,
        )

    @staticmethod
    async def _run_stage(
        name: str,
        analysis_id: object,
        func: Callable[..., Awaitable[T]],
        *args: object,
        **kwargs: object,
    ) -> T:
        started_at = time.perf_counter()
        logger.info("pipeline.stage.start stage=%s analysis_id=%s", name, analysis_id)
        try:
            result = await func(*args, **kwargs)
        except Exception:
            duration_ms = int((time.perf_counter() - started_at) * 1000)
            logger.exception(
                "pipeline.stage.failed stage=%s analysis_id=%s duration_ms=%d",
                name,
                analysis_id,
                duration_ms,
            )
            raise
        duration_ms = int((time.perf_counter() - started_at) * 1000)
        logger.info(
            "pipeline.stage.completed stage=%s analysis_id=%s duration_ms=%d",
            name,
            analysis_id,
            duration_ms,
        )
        return result
