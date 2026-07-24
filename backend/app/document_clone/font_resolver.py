"""Font **resolution** for the renderer (U-013, strategy E — decided with the PO).

Not a replacement, a *hierarchy* — the renderer asks this module, at draw time,
which real font to use for a span while the ``.artizen`` keeps the **original**
font metadata untouched (so the true font can be restored later):

1. the **embedded** font, when complete, usable and licence-permissive  (strategy
   A — hook only for now, populated by the renderer's ``mapping``);
2. otherwise a **metric-compatible, freely-licensed substitute** that reproduces
   the same visual rendering and covers the needed Unicode (strategy C):
   *Liberation Sans* ≡ Arial/Helvetica, *Liberation Serif* ≡ Times New Roman,
   *Liberation Mono* ≡ Courier — an **intelligent fallback**, never a final answer.

Substitutes are chosen by **family class** (serif / sans / mono), so the rule
**generalises** to any software's fonts (Calibri, Verdana… → sans) instead of
overfitting Arial. Exact metric identity holds for the Arial/Times/Courier pairs;
other families get a faithful visual approximation, refined per corpus later.

The substitute never fails the document: if a file is missing, it degrades to
reportlab's base-14 Helvetica — the previous behaviour.
"""

import logging
import os

from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

from app.document_clone.artizen_format import TextStyle

logger = logging.getLogger(__name__)

# Where the freely-licensed substitutes live (installed with the image; a later
# hardening step may vendor them into the package for full portability).
_FONT_DIRS = (
    "/usr/share/fonts/truetype/liberation",
    "/usr/share/fonts/truetype/dejavu",
    "/usr/share/fonts/truetype/liberation2",
)

# reportlab registration name → TTF filename.
_FILES: dict[str, str] = {
    "LiberationSans": "LiberationSans-Regular.ttf",
    "LiberationSans-Bold": "LiberationSans-Bold.ttf",
    "LiberationSans-Italic": "LiberationSans-Italic.ttf",
    "LiberationSans-BoldItalic": "LiberationSans-BoldItalic.ttf",
    "LiberationSerif": "LiberationSerif-Regular.ttf",
    "LiberationSerif-Bold": "LiberationSerif-Bold.ttf",
    "LiberationSerif-Italic": "LiberationSerif-Italic.ttf",
    "LiberationSerif-BoldItalic": "LiberationSerif-BoldItalic.ttf",
    "LiberationMono": "LiberationMono-Regular.ttf",
    "LiberationMono-Bold": "LiberationMono-Bold.ttf",
    "LiberationMono-Italic": "LiberationMono-Italic.ttf",
    "LiberationMono-BoldItalic": "LiberationMono-BoldItalic.ttf",
    "DejaVuSans": "DejaVuSans.ttf",
    "DejaVuSans-Bold": "DejaVuSans-Bold.ttf",
}

# Case-insensitive substrings that reclassify a font away from the sans default.
_SERIF_HINTS = (
    "times", "serif", "georgia", "garamond", "roman", "minion", "cambria",
    "book antiqua", "palatino", "century",
)
_MONO_HINTS = ("mono", "courier", "consol", "menlo")

_registered: dict[str, bool] = {}  # reportlab name → is it usable?


def _ensure(name: str) -> bool:
    """Register the substitute with reportlab once; cache whether it worked."""
    if name in _registered:
        return _registered[name]
    filename = _FILES.get(name)
    ok = False
    if filename:
        for directory in _FONT_DIRS:
            path = os.path.join(directory, filename)
            if os.path.exists(path):
                try:
                    pdfmetrics.registerFont(TTFont(name, path))
                    ok = True
                except Exception:
                    logger.warning("font_resolver.register_failed name=%s", name)
                break
    _registered[name] = ok
    return ok


def _family_base(font_name: str) -> str:
    low = (font_name or "").lower()
    if any(hint in low for hint in _MONO_HINTS):
        return "LiberationMono"
    if any(hint in low for hint in _SERIF_HINTS):
        return "LiberationSerif"
    return "LiberationSans"  # Arial, Helvetica, Calibri, Verdana, unknown…


def _styled(base: str, bold: bool, italic: bool) -> str:
    if bold and italic:
        return f"{base}-BoldItalic"
    if bold:
        return f"{base}-Bold"
    if italic:
        return f"{base}-Italic"
    return base


def resolve(style: TextStyle) -> str:
    """Return the reportlab font name to draw ``style`` with (strategy C).

    Metric-compatible substitute by family class, then progressively safer
    fallbacks, never failing the document. The renderer additionally scales each
    run horizontally to the original advance width, so the small residual metric
    difference between any substitute and the source font is absorbed."""
    base = _family_base(style.font)
    candidates = [
        _styled(base, style.bold, style.italic),
        base,                       # same family, regular, if the style file is absent
        _styled("LiberationSans", style.bold, style.italic),
        "DejaVuSans-Bold" if style.bold else "DejaVuSans",  # broad Unicode last resort
    ]
    for name in candidates:
        if _ensure(name):
            return name
    return "Helvetica-Bold" if style.bold else "Helvetica"  # base-14, previous behaviour
