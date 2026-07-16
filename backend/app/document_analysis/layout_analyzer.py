"""Fifth pipeline stage: a deterministic, non-intelligent placeholder for
layout analysis.

This has no real understanding of visual structure — it counts non-empty
lines of already-extracted text as a coarse proxy for "text blocks" per
page. It exists purely to give ``BlueprintBuilder`` and the API response
a stable shape before a real Vision/OCR-based analyzer replaces this
class. No AI, no external calls: same input always produces the same
output.
"""


class LayoutAnalyzer:
    async def analyze(self, text: str, page_count: int) -> dict[str, object]:
        text_block_count = len([line for line in text.splitlines() if line.strip()])
        return {
            "page_count": page_count,
            "text_block_count": text_block_count,
            "pages": [{"page_number": page_number} for page_number in range(1, page_count + 1)],
        }
