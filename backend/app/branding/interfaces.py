"""Ports for future AI-assisted branding features.

None of these are implemented in this phase — only the contracts are
fixed, so a concrete implementation (backed by ``app.ai``, a PDF parsing
library, a rendering engine, ...) can be plugged into ``BrandingService``
later without reshaping it. Method signatures intentionally stay
data-agnostic (``dict[str, object]``) since the real analysis output
shape isn't decided yet — inventing one now would be speculative.
"""

from abc import ABC, abstractmethod

from app.branding.schemas import DocumentTemplateRead, StoredFileInfo


class LogoExtractor(ABC):
    """Extracts a clean, usable logo image out of an arbitrary source document."""

    @abstractmethod
    async def extract(self, source: StoredFileInfo) -> StoredFileInfo:
        raise NotImplementedError


class PDFAnalyzer(ABC):
    """Parses an imported quote/invoice PDF to infer its structure and content."""

    @abstractmethod
    async def analyze(self, source: StoredFileInfo) -> dict[str, object]:
        raise NotImplementedError


class TemplateAnalyzer(ABC):
    """Turns an analyzed source document into a reusable template definition."""

    @abstractmethod
    async def analyze(self, source: StoredFileInfo) -> dict[str, object]:
        raise NotImplementedError


class DocumentRenderer(ABC):
    """Renders a final PDF (quote/invoice) from a template and business data."""

    @abstractmethod
    async def render(self, template: DocumentTemplateRead, data: dict[str, object]) -> bytes:
        raise NotImplementedError
