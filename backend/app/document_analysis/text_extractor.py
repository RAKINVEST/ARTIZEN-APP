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

import asyncio
from io import BytesIO

from pypdf import PdfReader

from app.document_analysis.exceptions import InvalidDocumentError


def _extract_all_text(content: bytes) -> str:
    reader = PdfReader(BytesIO(content))
    pages_text = [page.extract_text() or "" for page in reader.pages]
    return "\n".join(pages_text).strip()


class TextExtractor:
    async def extract(self, content: bytes) -> str:
        """Text extraction is synchronous and CPU-bound (pypdf), and is the
        heaviest stage of the pipeline — over a second on a 10 000-page
        file. Run on a thread so it doesn't hold the event loop, and with
        it every other request in the process."""
        try:
            return await asyncio.to_thread(_extract_all_text, content)
        except Exception as exc:
            raise InvalidDocumentError(f"Unable to extract text: {exc}") from exc
