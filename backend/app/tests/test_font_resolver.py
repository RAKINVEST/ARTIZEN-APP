"""Font resolution (U-013, strategy C) — the metric-compatible substitute per
family class. Locks the mapping the experiments established so it never drifts.

Requires the Liberation fonts (installed with the image). If a machine lacks
them, resolution degrades to base-14 Helvetica — asserted separately."""

from app.document_clone.artizen_format import TextStyle
from app.document_clone.font_resolver import resolve


def _r(font: str, *, bold: bool = False, italic: bool = False) -> str:
    return resolve(TextStyle(font=font, bold=bold, italic=italic))


def test_sans_serif_fonts_map_to_liberation_sans() -> None:
    # Arial, Helvetica, Calibri, Verdana, unknown → Liberation Sans (Arial metrics).
    for font in ["Arial", "ArialMT", "Helvetica", "Calibri", "Verdana", "Some Unknown Sans"]:
        assert _r(font) == "LiberationSans", font


def test_serif_fonts_map_to_liberation_serif() -> None:
    for font in ["Times New Roman", "TimesNewRoman,Bold", "Georgia", "Times-Roman"]:
        assert _r(font).startswith("LiberationSerif"), font


def test_monospace_fonts_map_to_liberation_mono() -> None:
    for font in ["Courier New", "Consolas", "Some Mono"]:
        assert _r(font).startswith("LiberationMono"), font


def test_weight_and_slant_pick_the_right_style() -> None:
    assert _r("Arial") == "LiberationSans"
    assert _r("Arial,Bold", bold=True) == "LiberationSans-Bold"
    assert _r("Arial,Italic", italic=True) == "LiberationSans-Italic"
    assert _r("Arial", bold=True, italic=True) == "LiberationSans-BoldItalic"
    assert _r("Times New Roman", bold=True) == "LiberationSerif-Bold"


def test_the_original_font_name_is_never_returned() -> None:
    # The .artizen keeps the original name; the *renderer* never draws with it —
    # it always resolves to a real, available font.
    assert "arial" not in _r("Arial,Bold", bold=True).lower()
