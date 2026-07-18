"""Abstract contracts every AI provider must implement.

Business services (quote drafting, message summarization, voice-to-quote,
...) depend only on these interfaces, never on a concrete provider, so
switching or combining vendors later requires no change to calling code.

Four capabilities, each its own abstraction so a vendor can be swapped for
one without touching the others (Blueprint §8):

- ``AIProvider``       — LLM chat completion (extraction, variants, e-mail).
- ``SttProvider``      — speech-to-text (audio -> transcript + confidence).
- ``TtsProvider``      — text-to-speech (spoken questions and confirmations).
- ``EmbeddingProvider``— text -> vector (semantic catalog matching).

They live together in the ``ai/`` layer — transverse from the first
consumer — because the consumers of STT/TTS/embeddings are already
declared (the whole voice-to-quote pipeline, across several lots), which
is exactly the "app/pdf" exception to the "second consumer" rule (see
CLAUDE.md). Every one has a deterministic, fully offline mock so the app
boots and answers with no key configured.
"""

from abc import ABC, abstractmethod

from app.ai.schemas import (
    AIMessage,
    AIResponse,
    EmbeddingResult,
    SynthesisResult,
    TranscriptionResult,
)


class AIProvider(ABC):
    @abstractmethod
    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        """Send a chat completion request to the underlying AI provider."""
        raise NotImplementedError


class SttProvider(ABC):
    @abstractmethod
    async def transcribe(
        self, audio: bytes, *, language: str = "fr", **kwargs: object
    ) -> TranscriptionResult:
        """Transcribe spoken audio into text plus per-segment confidence.

        ``language`` is a hint, not a constraint: a provider may detect and
        report a different language in the result. The confidence scores are
        what the decision policy (Blueprint §5) reads to decide whether to
        trust a segment or ask the artisan to repeat it.
        """
        raise NotImplementedError


class TtsProvider(ABC):
    @abstractmethod
    async def synthesize(
        self, text: str, *, language: str = "fr", voice: str | None = None, **kwargs: object
    ) -> SynthesisResult:
        """Render ``text`` to speech. Used for the assistant's spoken
        questions and confirmations — always optional at the UI level, so the
        whole flow stays usable in silence (Blueprint §7)."""
        raise NotImplementedError


class EmbeddingProvider(ABC):
    @abstractmethod
    async def embed(self, texts: list[str], **kwargs: object) -> list[EmbeddingResult]:
        """Return one vector per input text, in the same order. Powers
        semantic catalog matching ("je change le ballon" -> "Chauffe-eau
        200 L"); the vectors are stored in pgvector in a later lot."""
        raise NotImplementedError
