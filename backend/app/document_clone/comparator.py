"""The fidelity comparator — Brique 3.5.

Takes two PDFs (the artisan's **original** and the one ARTIZEN **generated**)
and measures how alike they are — objectively, deterministically, no AI. It
reads both with PyMuPDF and compares what actually landed on the page:

* text content — is every label / value present?
* **position** — did each land where the original had it?
* colours — text and fills.
* shapes / fills — the coloured bands and frames.
* images — the logo and pictos.
* pagination — same number of pages?

It returns a single fidelity score (e.g. ``99.8 %``) plus a per-aspect
breakdown. This is the project's **quality oracle**: at every change to the
engine you see immediately whether the render improved or regressed — the guard
rail that lets the clone engine march toward "indistinguishable" with numbers,
not vibes.
"""

import logging
import re
from dataclasses import dataclass

import fitz  # PyMuPDF

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class FidelityReport:
    overall: float          # 0..100
    text_recall: float      # % of the original's texts found in the candidate
    position_score: float   # % positional closeness of the matched texts
    color_score: float      # % of the original's colours present
    shape_score: float      # % of the original's coloured fills present
    image_score: float      # image-count closeness
    page_score: float       # same page count?
    reference_texts: int
    matched_texts: int


_WS = re.compile(r"\s+")


def _norm(text: str) -> str:
    return _WS.sub(" ", text).strip().lower()


def _quant(rgb: tuple[float, float, float]) -> tuple[int, int, int]:
    """Quantise a colour to a 16-step-per-channel bucket so near-identical
    colours (a #140E55 that reads back as #130E54 through the PDF pipeline)
    still match."""
    return tuple(min(255, round(v * 255 / 16) * 16) for v in rgb)  # type: ignore[return-value]


def _int_to_rgb(color: int) -> tuple[float, float, float]:
    return ((color >> 16 & 255) / 255, (color >> 8 & 255) / 255, (color & 255) / 255)


def _read(content: bytes) -> dict:
    doc = fitz.open(stream=content, filetype="pdf")
    try:
        pages = doc.page_count or 1
        page = doc[0]
        w, h = page.rect.width, page.rect.height
        diag = (w * w + h * h) ** 0.5 or 1.0

        texts = []  # (normalized_text, center_x, center_y, quant_color)
        text_colors = set()
        for b in page.get_text("dict")["blocks"]:
            for line in b.get("lines", []):
                for s in line["spans"]:
                    t = _norm(s["text"])
                    if not t:
                        continue
                    bb = s["bbox"]
                    q = _quant(_int_to_rgb(s["color"]))
                    texts.append((t, (bb[0] + bb[2]) / 2, (bb[1] + bb[3]) / 2, q))
                    text_colors.add(q)

        fills = set()  # quantised fill colours
        for d in page.get_drawings():
            if d.get("fill"):
                fills.add(_quant(tuple(d["fill"])))

        images = len(page.get_images(full=True))
        return {
            "pages": pages, "diag": diag, "texts": texts,
            "text_colors": text_colors, "fills": fills, "images": images,
        }
    finally:
        doc.close()


def compare_pdfs(reference: bytes, candidate: bytes) -> FidelityReport:
    ref = _read(reference)
    cand = _read(candidate)

    # --- text recall + position: match each reference text to the nearest
    # candidate text with the same content, unmatched candidates can't be reused.
    cand_texts = list(cand["texts"])
    used = [False] * len(cand_texts)
    matched = 0
    position_sum = 0.0
    for t, cx, cy, _ in ref["texts"]:
        best_i, best_d = -1, None
        for i, (t2, cx2, cy2, _) in enumerate(cand_texts):
            if used[i] or t2 != t:
                continue
            d = ((cx - cx2) ** 2 + (cy - cy2) ** 2) ** 0.5
            if best_d is None or d < best_d:
                best_i, best_d = i, d
        if best_i >= 0:
            used[best_i] = True
            matched += 1
            position_sum += max(0.0, 1.0 - best_d / ref["diag"])

    n_ref_text = len(ref["texts"])
    text_recall = matched / n_ref_text if n_ref_text else 1.0
    position_score = position_sum / matched if matched else (1.0 if not n_ref_text else 0.0)

    color_score = _overlap(ref["text_colors"], cand["text_colors"])
    shape_score = _overlap(ref["fills"], cand["fills"])
    image_score = 1.0 - abs(ref["images"] - cand["images"]) / max(1, ref["images"])
    image_score = max(0.0, image_score)
    page_score = 1.0 if ref["pages"] == cand["pages"] else max(
        0.0, 1.0 - abs(ref["pages"] - cand["pages"]) / max(1, ref["pages"])
    )

    overall = (
        0.30 * text_recall
        + 0.30 * position_score
        + 0.15 * color_score
        + 0.15 * shape_score
        + 0.05 * image_score
        + 0.05 * page_score
    ) * 100

    return FidelityReport(
        overall=round(overall, 2),
        text_recall=round(text_recall * 100, 1),
        position_score=round(position_score * 100, 1),
        color_score=round(color_score * 100, 1),
        shape_score=round(shape_score * 100, 1),
        image_score=round(image_score * 100, 1),
        page_score=round(page_score * 100, 1),
        reference_texts=n_ref_text,
        matched_texts=matched,
    )


def _overlap(reference: set, candidate: set) -> float:
    if not reference:
        return 1.0
    return len(reference & candidate) / len(reference)
