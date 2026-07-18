"""Deterministic, fully offline speech-to-text stand-in (V3.3 L1).

Selected automatically whenever ``STT_PROVIDER=mock`` (the default) — which
is also the only wired provider today. A mock cannot actually transcribe
arbitrary audio, and it deliberately does not try: it returns a fixed,
inspectable transcript so the app boots and the whole voice pipeline runs
end-to-end with no key, no network, and no randomness (same input -> same
output, safe for tests and demos).

Two ways it is used:

- **Demo / offline**: returns a canned residential-air-conditioning request
  in French — the strict MVP scenario (Blueprint §17, adjustment #3) — so the
  downstream extraction/matching stages have realistic material to work on.
- **Tests**: a caller can pass ``hint="<transcript>"`` to drive the exact text
  the rest of the pipeline should see, keeping later-lot tests deterministic
  without a real STT engine.
"""

from app.ai.base import SttProvider
from app.ai.schemas import TranscriptionResult, TranscriptSegment

# The MVP scenario, verbatim: a residential AC install described the way an
# artisan actually would on site. Kept here (not in a business module) as plain
# demo data — the ai/ layer stays ignorant of any feature's rules.
_CANNED_TRANSCRIPT = (
    "Bonjour, je passe pour l'installation d'un climatiseur réversible dans le salon. "
    "Ce sera un mono-split, avec une unité intérieure murale et l'unité extérieure à "
    "poser sur le mur du fond. Il faudra aussi la liaison frigorifique sur environ "
    "quatre mètres."
)

# Fixed, high but not perfect: enough to clear the auto threshold, low enough
# that the pipeline's confidence composition (Blueprint §5) stays meaningful.
_SEGMENT_CONFIDENCE = 0.9
_SECONDS_PER_SEGMENT = 3.0


def _segment(text: str) -> list[TranscriptSegment]:
    """Split on sentence boundaries into evenly-spaced, deterministic
    segments. Timings are synthetic (no real audio to align to) but stable."""
    sentences = [part.strip() for part in text.split(". ") if part.strip()]
    segments: list[TranscriptSegment] = []
    for index, sentence in enumerate(sentences):
        # Restore the period the split consumed on every sentence but the last.
        clean = sentence if sentence.endswith(".") else f"{sentence}."
        segments.append(
            TranscriptSegment(
                text=clean,
                start=index * _SECONDS_PER_SEGMENT,
                end=(index + 1) * _SECONDS_PER_SEGMENT,
                confidence=_SEGMENT_CONFIDENCE,
            )
        )
    return segments


class MockSttProvider(SttProvider):
    async def transcribe(
        self, audio: bytes, *, language: str = "fr", **kwargs: object
    ) -> TranscriptionResult:
        hint = kwargs.get("hint")
        text = hint if isinstance(hint, str) and hint.strip() else _CANNED_TRANSCRIPT
        return TranscriptionResult(
            text=text,
            segments=_segment(text),
            language=language,
            confidence=_SEGMENT_CONFIDENCE,
            provider="mock",
            model="mock-stt",
        )
