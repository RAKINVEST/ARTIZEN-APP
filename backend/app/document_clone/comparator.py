"""The fidelity comparator — Brique 3.5, the project's quality **oracle**.

Takes two PDFs (the artisan's **original** and the one ARTIZEN **generated**)
and measures how alike they are — objectively, deterministically, no AI.

Two laws govern this module (Sprint 4):

> **It must never reward a visible difference, and never penalise an invisible
> one.** The oracle exists to converge toward the judgment of an artisan holding
> the two devis side by side — the benchmark reflects human perception, never the
> reverse.

Consequences, and what changed in Sprint 4:

* **Typography is judged on what actually renders, not on font names.** A
  metric-compatible substitute (*Liberation Sans* for Arial) draws the same
  glyphs at the same widths: it is invisible to the eye, so it must not be
  penalised. We therefore compare **size, weight, slant and the rendered advance
  width** of each matched text — the properties that determine the rendering —
  and ignore the internal font name entirely.
* **Every page counts.** Measuring page 1 only was not representative of a
  multi-page devis; texts are now matched page by page and the score aggregates
  the whole document.
* **Two indicators**, because they do not play the same role:
  **structurelle** (content in the right place: structure, layout, pagination)
  and **perceptuelle** (what a human actually sees: typography, colours, images).
  They should converge as the engine matures.
"""

import logging
import re
from dataclasses import dataclass, field

import fitz  # PyMuPDF

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class Gap:
    """One concrete discrepancy between the original and the generated PDF —
    what the extraction still has to fix. The detailed report the artisan (and
    the extraction dev loop) reads, beyond the single score."""

    aspect: str    # texte_manquant | position | typographie | couleur | forme | image | pagination
    detail: str    # the text / colour / value concerned
    delta: float = 0.0  # magnitude (e.g. points of displacement)


@dataclass(frozen=True)
class _Span:
    """A rendered text run, with the properties that determine how it *looks*."""

    text: str
    cx: float
    cy: float
    color: tuple[int, int, int]
    size: float
    width: float   # rendered advance width — the real "chasse" signal
    bold: bool
    italic: bool


#: Weighted categories (they sum to 1). "Tableaux" gets its own weight once
#: table detection lands (extraction) — for now its share sits in Structure /
#: Mise en page, which already cover the table's texts and positions.
_WEIGHTS: dict[str, float] = {
    "Structure": 0.33,      # is every label / value present?
    "Mise en page": 0.27,   # did each land at the right place?
    "Typographie": 0.16,    # does it *render* the same (metrics, not names)?
    "Couleurs": 0.11,       # text + fill colours
    "Images": 0.06,
    "Pagination": 0.07,
}

#: The two indicators. Structural = the content is in the right place;
#: perceptual = what a human actually sees. Same categories, two readings.
_STRUCTURAL = ("Structure", "Mise en page", "Pagination")
_PERCEPTUAL = ("Typographie", "Couleurs", "Images")

#: Fidelity → certification badge ("Compatible Batappli : Or").
_CERT = ((99.5, "Platine"), (98.0, "Or"), (95.0, "Argent"), (90.0, "Bronze"))

#: Rendering-equivalence tolerances. Size follows EXTRACTION_SPEC §4; the width
#: tolerance is what separates a metric-compatible substitute (invisible) from a
#: genuinely different typeface (visible).
_SIZE_TOL_PT = 0.25
_WIDTH_TOL_RATIO = 0.02
#: Beyond this, a matched text is visibly displaced and worth reporting.
_POSITION_GAP_PT = 3.0
#: A drawn image matches its counterpart when it lands close enough (fraction of
#: the page diagonal) and at the same size (fraction of each dimension).
_IMAGE_POSITION_TOL_RATIO = 0.04
_IMAGE_SIZE_TOL_RATIO = 0.05

# fitz span "flags" bit field.
_FLAG_ITALIC = 1 << 1
_FLAG_BOLD = 1 << 4


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
    typography_score: float # % of matched texts that *render* alike (metrics)
    color_score: float      # % of the original's text colours present
    shape_score: float      # % of the original's coloured fills present
    image_score: float      # image-count closeness (all pages)
    page_score: float       # same page count?
    reference_texts: int
    matched_texts: int
    gaps: tuple[Gap, ...] = ()   # the detailed list of discrepancies
    #: The two readings of the same measurement (Sprint 4).
    structural_fidelity: float = 0.0   # content in the right place
    perceptual_fidelity: float = 0.0   # what a human actually sees
    #: Each subsystem's share of the **lost** fidelity, in % summing to 100 —
    #: the project's steering metric: the next sprint is the biggest contributor,
    #: chosen by the data, never by intuition.
    error_contributions: dict[str, float] = field(default_factory=dict)


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


def _renders_alike(reference: _Span, candidate: _Span) -> bool:
    """Do these two runs of identical text *look* the same?

    Deliberately blind to the font name: what the eye sees is the size, the
    weight, the slant and how wide the run actually draws. A metric-compatible
    substitute passes; a genuinely different typeface changes the advance width
    and is caught."""
    if abs(reference.size - candidate.size) > _SIZE_TOL_PT:
        return False
    if reference.bold != candidate.bold or reference.italic != candidate.italic:
        return False
    if reference.width <= 0:
        return candidate.width <= 0
    return abs(reference.width - candidate.width) / reference.width <= _WIDTH_TOL_RATIO


def _read(content: bytes) -> dict:
    """Read **every** page: the spans that carry the rendering, plus the
    document-wide colour/fill/image census."""
    doc = fitz.open(stream=content, filetype="pdf")
    try:
        per_page: list[dict] = []
        text_colors: set = set()
        fills: set = set()

        for number in range(doc.page_count):
            page = doc[number]
            width, height = page.rect.width, page.rect.height
            spans: list[_Span] = []
            for block in page.get_text("dict")["blocks"]:
                for line in block.get("lines", []):
                    for span in line["spans"]:
                        text = _norm(span["text"])
                        if not text:
                            continue
                        x0, y0, x1, y1 = span["bbox"]
                        color = _quant(_int_to_rgb(span["color"]))
                        flags = span.get("flags", 0)
                        spans.append(
                            _Span(
                                text=text,
                                cx=(x0 + x1) / 2,
                                cy=(y0 + y1) / 2,
                                color=color,
                                size=span["size"],
                                width=x1 - x0,
                                bold=bool(flags & _FLAG_BOLD),
                                italic=bool(flags & _FLAG_ITALIC),
                            )
                        )
                        text_colors.add(color)
            for drawing in page.get_drawings():
                if drawing.get("fill"):
                    fills.add(_quant(tuple(drawing["fill"])))
            per_page.append(
                {
                    "diag": (width * width + height * height) ** 0.5 or 1.0,
                    "spans": spans,
                    "images": _drawn_images(page),
                }
            )

        return {
            "pages": doc.page_count or 1,
            "per_page": per_page,
            "text_colors": text_colors,
            "fills": fills,
        }
    finally:
        doc.close()


def _drawn_images(page: "fitz.Page") -> list[tuple[float, float, float, float]]:
    """The images **actually drawn** on the page, as ``(cx, cy, w, h)``.

    ``get_image_info`` reports one entry per *drawing* of an image; unlike
    ``get_images`` (which lists the page's XObject *resources*, many never
    painted), it is what the eye sees — the same shift the oracle made for
    typography (Sprint 4): measure the render, not the technical artefact."""
    placements: list[tuple[float, float, float, float]] = []
    try:
        # Not ``xrefs=True``: matching each drawing back to its XObject xref makes
        # PyMuPDF MD5-hash every pixmap (the dominant cost on image-heavy pages),
        # and we only read ``bbox`` here — the xref is never used.
        infos = page.get_image_info()
    except Exception:
        infos = []
    for info in infos:
        bbox = info.get("bbox")
        if not bbox:
            continue
        x0, y0, x1, y1 = bbox
        width, height = x1 - x0, y1 - y0
        if width <= 0 or height <= 0:
            continue
        placements.append(((x0 + x1) / 2, (y0 + y1) / 2, width, height))
    return placements


def compare_pdfs(reference: bytes, candidate: bytes) -> FidelityReport:
    ref = _read(reference)
    cand = _read(candidate)

    gaps: list[Gap] = []
    reference_texts = 0
    matched = 0
    position_sum = 0.0
    typo_alike = 0
    typo_judged = 0

    # --- Text recall, position and typography, matched **page by page**: a label
    # on page 1 must be reproduced on page 1, not found anywhere in the document.
    common_pages = min(len(ref["per_page"]), len(cand["per_page"]))
    for number in range(common_pages):
        ref_page, cand_page = ref["per_page"][number], cand["per_page"][number]
        cand_spans = cand_page["spans"]
        used = [False] * len(cand_spans)
        diag = ref_page["diag"]

        # Index candidate spans by text so each ref span only scans its own
        # same-text bucket, not every span on the page (O(ref·cand) → O(ref·k),
        # k = duplicates of one string). Indices stay ascending, so the nearest
        # unused candidate — and ties — resolve exactly as the flat scan did.
        by_text: dict[str, list[int]] = {}
        for index, cand_span in enumerate(cand_spans):
            by_text.setdefault(cand_span.text, []).append(index)

        for ref_span in ref_page["spans"]:
            reference_texts += 1
            best_index, best_distance = -1, None
            for index in by_text.get(ref_span.text, ()):
                if used[index]:
                    continue
                cand_span = cand_spans[index]
                distance = (
                    (ref_span.cx - cand_span.cx) ** 2 + (ref_span.cy - cand_span.cy) ** 2
                ) ** 0.5
                if best_distance is None or distance < best_distance:
                    best_index, best_distance = index, distance

            if best_index < 0:
                gaps.append(Gap("texte_manquant", f"p{number + 1} {ref_span.text[:40]}"))
                continue

            used[best_index] = True
            matched += 1
            position_sum += max(0.0, 1.0 - best_distance / diag)
            if best_distance > _POSITION_GAP_PT:
                gaps.append(
                    Gap("position", f"p{number + 1} {ref_span.text[:40]}", round(best_distance, 1))
                )

            # Typography: does it *render* alike? (metrics, never the name)
            cand_span = cand_spans[best_index]
            typo_judged += 1
            if _renders_alike(ref_span, cand_span):
                typo_alike += 1
            else:
                gaps.append(
                    Gap(
                        "typographie",
                        f"p{number + 1} {ref_span.text[:30]} "
                        f"{ref_span.size:.1f}pt/{ref_span.width:.1f}pt → "
                        f"{cand_span.size:.1f}pt/{cand_span.width:.1f}pt",
                        round(abs(ref_span.width - cand_span.width), 1),
                    )
                )

    # Pages the candidate does not have at all: their texts are simply missing.
    for number in range(common_pages, len(ref["per_page"])):
        for ref_span in ref["per_page"][number]["spans"]:
            reference_texts += 1
            gaps.append(Gap("texte_manquant", f"p{number + 1} {ref_span.text[:40]}"))

    text_recall = matched / reference_texts if reference_texts else 1.0
    position_score = position_sum / matched if matched else (1.0 if not reference_texts else 0.0)
    typo_score = typo_alike / typo_judged if typo_judged else 1.0

    color_score = _overlap(ref["text_colors"], cand["text_colors"])
    shape_score = _overlap(ref["fills"], cand["fills"])
    image_score = _image_score(ref["per_page"], cand["per_page"], gaps)
    page_score = 1.0 if ref["pages"] == cand["pages"] else max(
        0.0, 1.0 - abs(ref["pages"] - cand["pages"]) / max(1, ref["pages"])
    )

    for col in ref["text_colors"] - cand["text_colors"]:
        gaps.append(Gap("couleur", "#%02x%02x%02x" % col))
    for col in ref["fills"] - cand["fills"]:
        gaps.append(Gap("forme", "#%02x%02x%02x" % col))
    if ref["pages"] != cand["pages"]:
        gaps.append(Gap("pagination", f"{ref['pages']} → {cand['pages']} pages"))

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
        reference_texts=reference_texts,
        matched_texts=matched,
        gaps=tuple(gaps),
        structural_fidelity=round(_indicator(categories, _STRUCTURAL) * 100, 2),
        perceptual_fidelity=round(_indicator(categories, _PERCEPTUAL) * 100, 2),
        error_contributions=_error_contributions(categories),
    )


def _error_contributions(categories: dict[str, float]) -> dict[str, float]:
    """Decompose the **lost** fidelity by subsystem: each category's weighted
    loss ``weight × (1 − score)`` as a share of the total loss, in % summing to
    100. Answers "what must we improve first?" without debate — a perfect
    document has no lost fidelity, hence an empty budget."""
    losses = {name: _WEIGHTS[name] * (1.0 - categories[name]) for name in _WEIGHTS}
    total = sum(losses.values())
    if total <= 0:
        return {name: 0.0 for name in _WEIGHTS}
    return {name: round(losses[name] / total * 100, 1) for name in _WEIGHTS}


def _image_score(ref_pages: list[dict], cand_pages: list[dict], gaps: list[Gap]) -> float:
    """Perceptual image fidelity: **area-weighted** recall of the images actually
    drawn, matched page by page by position and size — a big logo missing hurts
    more than a tiny icon. Resources never painted are ignored (they are not in
    ``get_image_info``), and a genuinely missing image is caught (its area drops
    out of the numerator). A document with no drawn image scores a perfect 1."""
    reference_area = 0.0
    matched_area = 0.0
    for number, ref_page in enumerate(ref_pages):
        ref_images = ref_page["images"]
        cand_images = cand_pages[number]["images"] if number < len(cand_pages) else []
        used = [False] * len(cand_images)
        diag = ref_page["diag"]
        for cx, cy, width, height in ref_images:
            area = width * height
            reference_area += area
            best_index, best_distance = -1, None
            for index, (cx2, cy2, width2, height2) in enumerate(cand_images):
                if used[index]:
                    continue
                if abs(width - width2) / width > _IMAGE_SIZE_TOL_RATIO:
                    continue
                if abs(height - height2) / height > _IMAGE_SIZE_TOL_RATIO:
                    continue
                distance = ((cx - cx2) ** 2 + (cy - cy2) ** 2) ** 0.5
                if distance > _IMAGE_POSITION_TOL_RATIO * diag:
                    continue
                if best_distance is None or distance < best_distance:
                    best_index, best_distance = index, distance
            if best_index >= 0:
                used[best_index] = True
                matched_area += area
            else:
                gaps.append(
                    Gap("image", f"p{number + 1} {width:.0f}×{height:.0f}", round(area, 0))
                )
    if reference_area <= 0:
        return 1.0
    return matched_area / reference_area


def _indicator(categories: dict[str, float], keys: tuple[str, ...]) -> float:
    """One of the two readings: the categories' weighted mean, renormalised so
    each indicator is itself a 0..1 score."""
    total = sum(_WEIGHTS[k] for k in keys)
    return sum(_WEIGHTS[k] * categories[k] for k in keys) / total if total else 1.0


def _overlap(reference: set, candidate: set) -> float:
    if not reference:
        return 1.0
    return len(reference & candidate) / len(reference)
