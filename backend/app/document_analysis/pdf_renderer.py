"""Second pipeline stage: opens the PDF and determines its page count.

Named "renderer" because a future implementation will render each page
to an image for Vision/OCR-based analysis — that capability doesn't
exist yet (no AI in this phase), so today this class only validates the
file is a well-formed PDF and counts its pages. Swapping in a real
page-rendering implementation later only means changing this file.
"""

from io import BytesIO

from pypdf import PdfReader

from app.document_analysis.exceptions import InvalidDocumentError


class PDFRenderer:
    async def render(self, content: bytes) -> int:
        """Return the page count. Raises ``InvalidDocumentError`` if
        ``content`` isn't a parseable PDF."""
        try:
            reader = PdfReader(BytesIO(content))
            return len(reader.pages)
        except Exception as exc:
            raise InvalidDocumentError(f"Unable to parse PDF: {exc}") from exc
