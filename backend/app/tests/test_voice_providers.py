"""Tests for the Voice-to-Quote provider abstractions (V3.3 L1).

These cover the deterministic mocks and the factory's key-free fallback — the
contract the rest of the pipeline (later lots) will build on. No network, no
real key, fully offline: exactly what the mocks guarantee.
"""

import math

from app.ai.base import EmbeddingProvider, SttProvider, TtsProvider
from app.ai.factory import (
    get_embedding_provider,
    get_stt_provider,
    get_tts_provider,
)
from app.core.config import settings

# --- Factory: selects the mock, needs no key ---------------------------------


def test_factory_returns_mock_providers_by_default() -> None:
    assert isinstance(get_stt_provider(), SttProvider)
    assert isinstance(get_tts_provider(), TtsProvider)
    assert isinstance(get_embedding_provider(), EmbeddingProvider)


# --- STT ---------------------------------------------------------------------


async def test_mock_stt_is_deterministic_and_well_formed() -> None:
    stt = get_stt_provider()
    first = await stt.transcribe(b"any-audio-bytes")
    second = await stt.transcribe(b"different-bytes")

    # A mock cannot really transcribe: same canned output regardless of input.
    assert first.model_dump() == second.model_dump()
    assert first.language == "fr"
    assert 0.0 <= first.confidence <= 1.0
    assert first.segments, "the transcript should be split into segments"
    for segment in first.segments:
        assert segment.start < segment.end
        assert 0.0 <= segment.confidence <= 1.0
    # Reconstructed transcript is the residential-AC MVP scenario.
    assert "climatiseur" in first.text.lower()


async def test_mock_stt_honours_a_transcript_hint() -> None:
    stt = get_stt_provider()
    result = await stt.transcribe(b"", hint="Installation d'une VMC double flux.")

    assert result.text == "Installation d'une VMC double flux."
    assert result.segments  # the hint is still segmented


# --- TTS ---------------------------------------------------------------------


async def test_mock_tts_is_deterministic_and_reversible() -> None:
    tts = get_tts_provider()
    first = await tts.synthesize("Votre devis est prêt.")
    second = await tts.synthesize("Votre devis est prêt.")

    assert first.audio == second.audio
    assert first.content_type == "audio/x-mock"  # signals "show text instead"
    assert first.voice == "mock-fr"
    # The spoken text is recoverable from the bytes (inspectable in tests).
    assert "Votre devis est prêt." in first.audio.decode("utf-8")


# --- Embeddings --------------------------------------------------------------


async def test_mock_embeddings_are_deterministic_unit_vectors() -> None:
    embedder = get_embedding_provider()
    once = await embedder.embed(["climatiseur réversible"])
    twice = await embedder.embed(["climatiseur réversible"])

    assert once[0].vector == twice[0].vector  # deterministic
    assert once[0].dimensions == len(once[0].vector)
    # L2-normalized, so cosine similarity is well-defined downstream.
    norm = math.sqrt(sum(component * component for component in once[0].vector))
    assert math.isclose(norm, 1.0, rel_tol=1e-9)


async def test_mock_embeddings_differ_by_text_and_keep_order() -> None:
    embedder = get_embedding_provider()
    results = await embedder.embed(["mono-split", "unité extérieure"])

    assert len(results) == 2
    assert results[0].vector != results[1].vector


# --- Config: confidence thresholds are externalized and coherent -------------


def test_voice_confidence_thresholds_are_ordered() -> None:
    # The "ask a question" band only exists if clarify < auto (Blueprint §5).
    assert 0.0 <= settings.VOICE_CONFIDENCE_CLARIFY < settings.VOICE_CONFIDENCE_AUTO <= 1.0
    assert 0.0 <= settings.VOICE_STT_MIN_SEGMENT_CONFIDENCE <= 1.0
    assert 0.0 <= settings.VOICE_MATCH_MIN_SIMILARITY <= 1.0
