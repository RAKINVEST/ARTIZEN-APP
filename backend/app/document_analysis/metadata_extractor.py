"""Fourth pipeline stage: assembles the structured metadata snapshot
stored in ``DocumentAnalysis.extracted_metadata``.

Pure data shaping — no parsing of its own. Page count, filename,
mime type and file size are already known (from ``PDFRenderer`` and the
upload itself); this stage's only responsibility is to record them as a
consistent, stable JSON snapshot at the moment the document was analyzed.
"""

from datetime import datetime


class MetadataExtractor:
    async def extract(
        self,
        *,
        filename: str,
        mime_type: str,
        file_size: int,
        page_count: int,
        imported_at: datetime,
    ) -> dict[str, object]:
        return {
            "filename": filename,
            "mime_type": mime_type,
            "file_size": file_size,
            "page_count": page_count,
            "imported_at": imported_at.isoformat(),
        }
