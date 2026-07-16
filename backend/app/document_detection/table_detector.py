"""Detects a probable table by counting text lines that look like
tabular rows: several whitespace-separated columns with wide gaps
(typical of a "Désignation   Qté   Prix" row as extracted from a PDF).
"""

import re

from app.document_detection.interfaces import DetectorResult, TextDetector

_ROW_PATTERN = re.compile(r"\S+(?:\s{2,}\S+){2,}")
_MIN_ROWS_FOR_TABLE = 3


class TableDetector(TextDetector):
    async def detect(self, text: str) -> DetectorResult:
        matching_lines = [line for line in text.splitlines() if _ROW_PATTERN.search(line)]
        detected = len(matching_lines) >= _MIN_ROWS_FOR_TABLE
        confidence = (
            min(1.0, len(matching_lines) / (_MIN_ROWS_FOR_TABLE * 2)) if detected else 0.0
        )
        return DetectorResult(
            detected=detected, confidence=confidence, data={"row_count": len(matching_lines)}
        )
