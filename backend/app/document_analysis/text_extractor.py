"""Third pipeline stage: extracts raw text from a PDF's pages.

Uses plain PDF text extraction (no OCR, no vision, no LLM) — this only
works for text-based PDFs, not scanned images. A future OCR-based
implementation can replace this class without changing its signature.

Re-parses the PDF independently from ``PDFRenderer`` rather than reusing
its internal reader object: each pipeline stage only exchanges plain
data (bytes, str, dict) with the others, never a stage's internal
library objects, so any stage can be swapped without the others needing
to know about the change.
"""

from io import BytesIO

from pypdf import PdfReader

from app.document_analysis.exceptions import InvalidDocumentError


class TextExtractor:
    async def extract(self, content: bytes) -> str:
        try:
            reader = PdfReader(BytesIO(content))
            pages_text = [page.extract_text() or "" for page in reader.pages]
        except Exception as exc:
            raise InvalidDocumentError(f"Unable to extract text: {exc}") from exc
        return "\n".join(pages_text).strip()
