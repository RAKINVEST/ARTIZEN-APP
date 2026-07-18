"""Provider-agnostic data structures for the AI abstraction layer.

Every field a business service reads is defined here, not in a vendor SDK's
own types, so no caller ever imports ``anthropic`` / ``openai`` / a Whisper
client just to read a result. Confidence is always a plain ``float`` in
``[0, 1]`` regardless of how the underlying provider scores things — the
decision policy (Blueprint §5) depends on that normalization.
"""

from typing import Literal

from pydantic import BaseModel, Field


class AIMessage(BaseModel):
    role: Literal["system", "user", "assistant"]
    content: str


class AIResponse(BaseModel):
    content: str
    provider: str
    model: str


# --- Voice-to-Quote (V3.3 L1) ------------------------------------------------


class TranscriptSegment(BaseModel):
    """One time-bounded chunk of a transcription, with its own confidence so a
    single noisy phrase can be flagged without discarding the whole turn."""

    text: str
    start: float = Field(ge=0)  # seconds from the start of the audio
    end: float = Field(ge=0)
    confidence: float = Field(ge=0, le=1)


class TranscriptionResult(BaseModel):
    text: str
    segments: list[TranscriptSegment] = Field(default_factory=list)
    # The language the provider actually transcribed, which may differ from the
    # hint passed in (BCP-47-ish, e.g. "fr"). Carried on the Conversation later.
    language: str = "fr"
    confidence: float = Field(ge=0, le=1)
    provider: str
    model: str


class SynthesisResult(BaseModel):
    """Spoken audio for one assistant utterance. ``audio`` is the raw encoded
    bytes; ``content_type`` tells the client how to play them."""

    audio: bytes
    content_type: str
    voice: str
    provider: str
    model: str


class EmbeddingResult(BaseModel):
    vector: list[float]
    dimensions: int
    provider: str
    model: str
