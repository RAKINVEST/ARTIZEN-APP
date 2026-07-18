"""Deterministic, fully offline text-to-speech stand-in (V3.3 L1).

Selected whenever ``TTS_PROVIDER=mock`` (the default and only wired provider
today). It produces no real audio — it returns a stable, inspectable payload
that encodes the spoken text, with a mock content type so the client knows to
fall back to showing the question on screen rather than trying to play it.

This is exactly why TTS is optional in the interaction protocol (Blueprint
§7): the whole flow must stay usable in silence, and offline "demo mode" is
the silent case by construction.
"""

from app.ai.base import TtsProvider
from app.ai.schemas import SynthesisResult

# Not "audio/wav": the bytes below are NOT decodable audio, and claiming a real
# type would make a client try to play noise. A mock type signals "show the
# text instead", which is the silent fallback the protocol already allows.
_MOCK_CONTENT_TYPE = "audio/x-mock"
_DEFAULT_VOICE = "mock-fr"


class MockTtsProvider(TtsProvider):
    async def synthesize(
        self, text: str, *, language: str = "fr", voice: str | None = None, **kwargs: object
    ) -> SynthesisResult:
        # Deterministic and reversible: the text is recoverable from the bytes,
        # so a test can assert exactly what would have been spoken.
        audio = f"MOCK_TTS::{language}::{text}".encode()
        return SynthesisResult(
            audio=audio,
            content_type=_MOCK_CONTENT_TYPE,
            voice=voice or _DEFAULT_VOICE,
            provider="mock",
            model="mock-tts",
        )
