"""Repairs letter-spaced text before the regex field detectors run.

Some quoting software (observed on Mediabat exports, experiment E-001)
renders every glyph with its own positioning, so ``pypdf`` extracts a
line like ``"S A R L  C H A P O T"`` instead of ``"SARL CHAPOT"``. The
information is all there, but the field regexes (SIRET's ``\\d{14}``, the
phone and email patterns) match on *contiguous* characters and so find
nothing — the Chapot devis scored 0 detected fields despite carrying
every one of them.

The repair rests on a single regularity that holds across the whole
letter-spaced document: **one space glues glyphs inside a word, two or
more spaces separate words.** So within a letter-spaced line we drop
single spaces and collapse runs of two-or-more down to one.

The danger is over-reach: an ordinary line such as ``"Adresse
chantier"`` also uses single spaces between words, and blindly gluing
them would produce ``"Adressechantier"``. The fix is therefore applied
**line by line, and only to lines that look letter-spaced** — a line
whose tokens are overwhelmingly one or two characters long. Normal prose
is left untouched, so a document that never letter-spaces (e.g. the
Solabaie devis, experiment E-002) passes through unchanged and cannot
regress.
"""

import re

# Two-or-more spaces are the word boundary inside a letter-spaced line.
_WORD_GAP = re.compile(r" {2,}")

# A line is only worth touching if it has enough tokens to judge and most
# of them are tiny — the fingerprint of glyph-by-glyph extraction. Below
# this share we assume ordinary text and leave the line alone.
_MIN_TOKENS = 4
_SHORT_TOKEN_MAX_LEN = 2
_LETTER_SPACED_SHARE = 0.6


def _looks_letter_spaced(line: str) -> bool:
    tokens = line.split()
    if len(tokens) < _MIN_TOKENS:
        return False
    short = sum(1 for token in tokens if len(token) <= _SHORT_TOKEN_MAX_LEN)
    return short / len(tokens) >= _LETTER_SPACED_SHARE


def _collapse_line(line: str) -> str:
    # Split on real word boundaries first, glue each word's glyphs, then
    # rejoin the words with a single space.
    words = _WORD_GAP.split(line.strip())
    return " ".join(word.replace(" ", "") for word in words)


def collapse_letter_spacing(text: str) -> str:
    """Return ``text`` with letter-spaced lines de-spaced, others verbatim."""
    return "\n".join(
        _collapse_line(line) if _looks_letter_spaced(line) else line
        for line in text.split("\n")
    )
