"""Second pipeline stage: opens the PDF and determines its page count.

Named "renderer" because a future implementation will render each page
to an image for Vision/OCR-based analysis — that capability doesn't
exist yet (no AI in this phase), so today this class only validates the
file is a well-formed PDF and counts its pages. Swapping in a real
page-rendering implementation later only means changing this file.
"""

import asyncio
from io import BytesIO

from pypdf import PdfReader

from app.document_analysis.exceptions import InvalidDocumentError

# A PDF's page count is not bounded by its file size: ~10 000 pages fit in
# 1.2 MB, and the 15 MB the upload allows extrapolates to six figures.
# Nothing an artisan imports is anywhere near this; a file that is exists
# to be expensive.
MAX_PAGES = 2000


def _read_page_count(content: bytes) -> int:
    reader = PdfReader(BytesIO(content))
    return len(reader.pages)


class PDFRenderer:
    async def render(self, content: bytes) -> int:
        """Return the page count. Raises ``InvalidDocumentError`` if
        ``content`` isn't a parseable PDF, or has implausibly many pages.

        pypdf is synchronous and CPU-bound, so despite the ``async``
        signature this used to run *on* the event loop: parsing a
        10 000-page file blocked every other request in the process for
        the best part of a second. ``to_thread`` keeps the loop free.
        """
        try:
            page_count = await asyncio.to_thread(_read_page_count, content)
        except Exception as exc:
            raise InvalidDocumentError(f"Unable to parse PDF: {exc}") from exc
        if page_count > MAX_PAGES:
            raise InvalidDocumentError(
                f"PDF has {page_count} pages, more than the {MAX_PAGES} supported."
            )
        return page_count
