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
class Gap:
    """One concrete discrepancy between the original and the generated PDF —
    what the extraction still has to fix. The detailed report the artisan (and
    the extraction dev loop) reads, beyond the single score."""

    aspect: str    # texte_manquant | position | couleur | forme | image | pagination
    detail: str    # the text / colour / value concerned
    delta: float = 0.0  # magnitude (e.g. points of displacement)


#: Weighted categories (they sum to 1). "Tableaux" gets its own weight once
#: table detection lands (extraction) — for now its share sits in Structure /
#: Mise en page, which already cover the table's texts and positions.
_WEIGHTS: dict[str, float] = {
    "Structure": 0.33,      # is every label / value present?
    "Mise en page": 0.27,   # did each land at the right place?
    "Typographie": 0.16,    # same fonts / sizes?
    "Couleurs": 0.11,       # text + fill colours
    "Images": 0.06,
    "Pagination": 0.07,
}

#: Fidelity → certification badge ("Compatible Batappli : Or").
_CERT = ((99.5, "Platine"), (98.0, "Or"), (95.0, "Argent"), (90.0, "Bronze"))


def certification(overall: float) -> str:
    for threshold, label in _CERT:
        if overall >= threshold:
            return label
    return "Non certifié"


@dataclass(frozen=True)
class FidelityReport:
    overall: float          # 0..100, the weighted-category score
    certification: str      # Platine | Or | Argent | Bronze | Non certifié
    categories: dict[str, float]  # French category -> %, the weighted breakdown
    text_recall: float      # % of the original's texts found in the candidate
    position_score: float   # % positional closeness of the matched texts
    typography_score: float # % of the original's (font, size) pairs present
    color_score: float      # % of the original's text colours present
    shape_score: float      # % of the original's coloured fills present
    image_score: float      # image-count closeness
    page_score: float       # same page count?
    reference_texts: int
    matched_texts: int
    gaps: tuple[Gap, ...] = ()   # the detailed list of discrepancies


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
        typography = set()  # (font, rounded size) pairs actually used
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
                    typography.add((s["font"], round(s["size"])))

        fills = set()  # quantised fill colours
        for d in page.get_drawings():
            if d.get("fill"):
                fills.add(_quant(tuple(d["fill"])))

        images = len(page.get_images(full=True))
        return {
            "pages": pages, "diag": diag, "texts": texts,
            "text_colors": text_colors, "fills": fills, "images": images,
            "typography": typography,
        }
    finally:
        doc.close()


def compare_pdfs(reference: bytes, candidate: bytes) -> FidelityReport:
    ref = _read(reference)
    cand = _read(candidate)

    gaps: list[Gap] = []

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
            if best_d is not None and best_d > 3.0:  # noticeably displaced
                gaps.append(Gap("position", t[:40], round(best_d, 1)))
        else:
            gaps.append(Gap("texte_manquant", t[:40]))

    n_ref_text = len(ref["texts"])
    text_recall = matched / n_ref_text if n_ref_text else 1.0
    position_score = position_sum / matched if matched else (1.0 if not n_ref_text else 0.0)

    typo_score = _overlap(ref["typography"], cand["typography"])
    color_score = _overlap(ref["text_colors"], cand["text_colors"])
    shape_score = _overlap(ref["fills"], cand["fills"])
    image_score = 1.0 - abs(ref["images"] - cand["images"]) / max(1, ref["images"])
    image_score = max(0.0, image_score)
    page_score = 1.0 if ref["pages"] == cand["pages"] else max(
        0.0, 1.0 - abs(ref["pages"] - cand["pages"]) / max(1, ref["pages"])
    )

    for font, size in ref["typography"] - cand["typography"]:
        gaps.append(Gap("typographie", f"{font} {size}pt"))
    for col in ref["text_colors"] - cand["text_colors"]:
        gaps.append(Gap("couleur", "#%02x%02x%02x" % col))
    for col in ref["fills"] - cand["fills"]:
        gaps.append(Gap("forme", "#%02x%02x%02x" % col))
    if ref["pages"] != cand["pages"]:
        gaps.append(Gap("pagination", f"{ref['pages']} → {cand['pages']} pages"))
    if ref["images"] != cand["images"]:
        gaps.append(Gap("image", f"{ref['images']} → {cand['images']} images"))

    # Worst displacements first, then a total order (aspect, detail) so the fix
    # list is byte-identical across processes — a prerequisite for replayable
    # benchmarks (set iteration order must never leak into the output).
    gaps.sort(key=lambda g: (-g.delta, g.aspect, g.detail))

    categories = {
        "Structure": text_recall,
        "Mise en page": position_score,
        "Typographie": typo_score,
        "Couleurs": (color_score + shape_score) / 2,
        "Images": image_score,
        "Pagination": page_score,
    }
    overall = sum(_WEIGHTS[k] * categories[k] for k in _WEIGHTS) * 100

    return FidelityReport(
        overall=round(overall, 2),
        certification=certification(overall),
        categories={k: round(v * 100, 1) for k, v in categories.items()},
        text_recall=round(text_recall * 100, 1),
        position_score=round(position_score * 100, 1),
        typography_score=round(typo_score * 100, 1),
        color_score=round(color_score * 100, 1),
        shape_score=round(shape_score * 100, 1),
        image_score=round(image_score * 100, 1),
        page_score=round(page_score * 100, 1),
        reference_texts=n_ref_text,
        matched_texts=matched,
        gaps=tuple(gaps),
    )


def _overlap(reference: set, candidate: set) -> float:
    if not reference:
        return 1.0
    return len(reference & candidate) / len(reference)
