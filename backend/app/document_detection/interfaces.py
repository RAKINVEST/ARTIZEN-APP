"""Detection interfaces.

Every detector implements one of these two contracts depending on
whether it needs the raw PDF bytes (``VisualDetector``) or only the
already-extracted text (``TextDetector``, reusing
``DocumentAnalysis.extracted_text`` produced by the ``document_analysis``
pipeline — no PDF re-parsing needed for these). Both return a
``DetectorResult``: a ``detected`` flag, a ``confidence`` in [0, 1], and
a ``data`` dict holding whatever fields that specific detector
contributes to ``DocumentDetectionResult``.

None of these are AI-backed today (pure regex/heuristics), but a future
Vision-model-based ``LogoDetector`` or ``ColorDetector`` only needs to
implement ``VisualDetector``, and a future NER/LLM-based
``ContactDetector`` only needs to implement ``TextDetector`` —
``DetectionAggregator`` doesn't change either way.
"""

from abc import ABC, abstractmethod
from dataclasses import dataclass, field


@dataclass
class DetectorResult:
    detected: bool
    confidence: float
    data: dict[str, object] = field(default_factory=dict)


class TextDetector(ABC):
    @abstractmethod
    async def detect(self, text: str) -> DetectorResult:
        raise NotImplementedError


class VisualDetector(ABC):
    @abstractmethod
    async def detect(self, content: bytes) -> DetectorResult:
        raise NotImplementedError
