"""Tests for the letter-spacing normalizer (experiment E-001 / U-010).

The strings here are taken verbatim from ``pypdf``'s extraction of a real
Mediabat devis (the Chapot quote) — the exact input that scored 0 detected
fields before this repair — plus ordinary prose that MUST pass through
untouched so a well-behaved export (the Solabaie devis, E-002) cannot
regress.
"""

from app.document_detection.text_normalizer import collapse_letter_spacing


def test_collapses_letter_spaced_company_name() -> None:
    # One space glues glyphs, two spaces separate words.
    assert collapse_letter_spacing("S A R L  C H A P O T") == "SARL CHAPOT"


def test_collapses_letter_spaced_phone() -> None:
    assert collapse_letter_spacing("0 6  5 9  1 9  2 5  9 5") == "06 59 19 25 95"


def test_collapses_letter_spaced_email() -> None:
    assert (
        collapse_letter_spacing("c h a p o t c h a u f f a g e @ o u t lo o k .f r")
        == "chapotchauffage@outlook.fr"
    )


def test_collapses_mixed_length_fragments() -> None:
    # pypdf emits fragments, not always single glyphs: "A lfr e d" -> "Alfred".
    assert (
        collapse_letter_spacing("7  IM P  A lfr e d  d e  M u s s e t")
        == "7 IMP Alfred de Musset"
    )


def test_leaves_ordinary_prose_untouched() -> None:
    # Ordinary lines use single spaces between words too — gluing them would
    # produce "Adressechantier". These must survive verbatim.
    for line in ["Adresse chantier", "8 Avenue de Carcassonne", "Mr Rakotovao Sylvio"]:
        assert collapse_letter_spacing(line) == line


def test_multiline_touches_only_letter_spaced_lines() -> None:
    text = "S A R L  C H A P O T\n8 Avenue de Carcassonne\n0 6  5 9  1 9"
    assert collapse_letter_spacing(text) == "SARL CHAPOT\n8 Avenue de Carcassonne\n06 59 19"


def test_short_lines_are_never_touched() -> None:
    # Below the token floor there is no reliable signal, so leave it alone —
    # a stray "T V A" must not be mistaken for letter spacing on its own.
    assert collapse_letter_spacing("T V A") == "T V A"
