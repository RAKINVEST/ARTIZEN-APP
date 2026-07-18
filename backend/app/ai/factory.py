"""Factory selecting the configured AI provider.

Services should call ``get_ai_provider()`` instead of importing a concrete
provider class directly, keeping ``DEFAULT_AI_PROVIDER`` the single place
that decides which vendor is active.

Selection is fully automatic and key-driven, decided once at process
startup (the result is cached — see ``@lru_cache``): if the API key for
the configured provider is present, that provider is used; if it is
absent, ``MockAIProvider`` (a fully offline, deterministic stand-in —
see ``providers/mock_provider.py``) is used instead. The application
must always boot and every AI-backed feature must always return a
usable response, with nothing to configure and no question to answer —
a missing key is never a startup or request failure. The day a real
key is added to ``.env``, restarting the process is the only step
needed to switch to the real provider: no code change anywhere that
depends on ``AIProvider``.
"""

from functools import lru_cache

from app.ai.base import AIProvider, EmbeddingProvider, SttProvider, TtsProvider
from app.ai.providers.anthropic_provider import AnthropicProvider
from app.ai.providers.mistral_provider import MistralProvider
from app.ai.providers.mock_embedding import MockEmbeddingProvider
from app.ai.providers.mock_provider import MockAIProvider
from app.ai.providers.mock_stt import MockSttProvider
from app.ai.providers.mock_tts import MockTtsProvider
from app.ai.providers.openai_provider import OpenAIProvider
from app.core.config import settings
from app.core.exceptions import AppException


@lru_cache
def get_ai_provider(provider_name: str | None = None) -> AIProvider:
    name = provider_name or settings.DEFAULT_AI_PROVIDER

    if name == "openai":
        return OpenAIProvider(api_key=settings.OPENAI_API_KEY) if settings.OPENAI_API_KEY else MockAIProvider()

    if name == "anthropic":
        return (
            AnthropicProvider(api_key=settings.ANTHROPIC_API_KEY)
            if settings.ANTHROPIC_API_KEY
            else MockAIProvider()
        )

    if name == "mistral":
        return MistralProvider(api_key=settings.MISTRAL_API_KEY) if settings.MISTRAL_API_KEY else MockAIProvider()

    raise AppException(f"Unknown AI provider: {name}")


# --- Voice-to-Quote providers (V3.3 L1) --------------------------------------
# Same contract as get_ai_provider: pick the configured provider, fall back to
# the deterministic mock. Only "mock" is wired today; real providers (Whisper,
# ElevenLabs, OpenAI embeddings…) become new branches in later lots, and no
# caller changes when they do.


@lru_cache
def get_stt_provider(provider_name: str | None = None) -> SttProvider:
    name = provider_name or settings.STT_PROVIDER
    if name == "mock":
        return MockSttProvider()
    raise AppException(f"Unknown STT provider: {name}")


@lru_cache
def get_tts_provider(provider_name: str | None = None) -> TtsProvider:
    name = provider_name or settings.TTS_PROVIDER
    if name == "mock":
        return MockTtsProvider()
    raise AppException(f"Unknown TTS provider: {name}")


@lru_cache
def get_embedding_provider(provider_name: str | None = None) -> EmbeddingProvider:
    name = provider_name or settings.EMBEDDING_PROVIDER
    if name == "mock":
        return MockEmbeddingProvider()
    raise AppException(f"Unknown embedding provider: {name}")
