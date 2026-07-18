"""Centralized application configuration.

All runtime configuration is loaded here from environment variables (or a
``.env`` file) via ``pydantic-settings``. No module outside of ``core``
should read ``os.environ`` directly: every other layer depends on the
``settings`` singleton exported below.
"""

from functools import lru_cache
from typing import Annotated, Literal

from pydantic import ValidationInfo, field_validator
from pydantic_settings import BaseSettings, NoDecode, SettingsConfigDict

# Kept in sync with .env.example by hand: the point is to catch the exact
# strings a copy-paste deployment carries, not to guess at weak secrets.
_PLACEHOLDER_SECRETS = frozenset(
    {
        "change_me_super_secret_key",
        "change_me",
        "secret",
        "changeme",
    }
)
_MIN_PRODUCTION_SECRET_LENGTH = 32


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=True,
        extra="ignore",
    )

    # --- Application ---
    PROJECT_NAME: str = "Artizen"
    VERSION: str = "2.0.0"
    ENVIRONMENT: Literal["development", "staging", "production"] = "development"
    DEBUG: bool = False
    API_PREFIX: str = "/api"

    # --- CORS ---
    # NoDecode: pydantic-settings would otherwise try to JSON-decode this
    # env var (since it's typed as a list) before the validator below runs.
    CORS_ORIGINS: Annotated[list[str], NoDecode] = ["http://localhost:3000"]

    @field_validator("CORS_ORIGINS", mode="before")
    @classmethod
    def _split_cors_origins(cls, value: object) -> object:
        if isinstance(value, str):
            return [origin.strip() for origin in value.split(",") if origin.strip()]
        return value

    # --- Logging ---
    LOG_LEVEL: str = "INFO"

    # --- Database ---
    POSTGRES_HOST: str = "db"
    POSTGRES_PORT: int = 5432
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str
    POSTGRES_DB: str

    @property
    def DATABASE_URL(self) -> str:
        return (
            f"postgresql+asyncpg://{self.POSTGRES_USER}:{self.POSTGRES_PASSWORD}"
            f"@{self.POSTGRES_HOST}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"
        )

    # --- Security / JWT ---
    SECRET_KEY: str
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24

    @field_validator("SECRET_KEY")
    @classmethod
    def _reject_placeholder_secret_in_production(cls, value: str, info: ValidationInfo) -> str:
        """Refuse to boot a production instance on the example secret.

        Declaring SECRET_KEY without a default already forces an explicit
        value, but the value everyone reaches for is the one printed in
        `.env.example` — and a deployment made by copying that file ships a
        publicly known signing key. Anyone could then forge a JWT for any
        `sub` and impersonate any artisan of any company.

        Only enforced for ENVIRONMENT=production: development and tests
        must stay copy-.env.example-and-go.
        """
        if info.data.get("ENVIRONMENT") != "production":
            return value
        if value in _PLACEHOLDER_SECRETS:
            raise ValueError(
                "SECRET_KEY is still the placeholder from .env.example. Generate a "
                "real one (e.g. `python -c \"import secrets; print(secrets.token_urlsafe(64))\"`) "
                "before running in production."
            )
        if len(value) < _MIN_PRODUCTION_SECRET_LENGTH:
            raise ValueError(
                f"SECRET_KEY must be at least {_MIN_PRODUCTION_SECRET_LENGTH} characters "
                "in production."
            )
        return value

    @field_validator("DEBUG")
    @classmethod
    def _reject_debug_in_production(cls, value: bool, info: ValidationInfo) -> bool:
        # DEBUG surfaces internals through FastAPI's error pages, and
        # LOG_LEVEL=DEBUG alongside it widens what third-party libraries
        # log. Neither belongs in front of real artisans.
        if value and info.data.get("ENVIRONMENT") == "production":
            raise ValueError("DEBUG must be false when ENVIRONMENT=production.")
        return value

    # --- Rate limiting (see app/core/rate_limit.py) ---
    # Only togglable so the test suite can turn it off: conftest registers a
    # fresh account per test, from one address, which is exactly the traffic
    # shape this is built to refuse. Leave it on everywhere else — it is the
    # only thing standing between /auth and unlimited enumeration.
    AUTH_RATE_LIMIT_ENABLED: bool = True
    AUTH_RATE_LIMIT_MAX_REQUESTS: int = 10
    AUTH_RATE_LIMIT_WINDOW_SECONDS: int = 60
    # "memory" (per-worker, the V2 behaviour) or "redis" (shared across all
    # workers/replicas). Default stays "memory" so nothing is required to run
    # or to test; production sets "redis" to close the ~4x-ceiling gap. The
    # redis backend degrades to the in-memory one if Redis is unreachable.
    RATE_LIMIT_BACKEND: Literal["memory", "redis"] = "memory"

    # --- AI providers (abstraction layer, see app/ai) ---
    DEFAULT_AI_PROVIDER: Literal["openai", "anthropic", "mistral"] = "anthropic"
    OPENAI_API_KEY: str | None = None
    ANTHROPIC_API_KEY: str | None = None
    MISTRAL_API_KEY: str | None = None

    # --- Voice-to-Quote providers (V3.3 L1, see app/ai/base.py, docs/v3/06) ---
    # STT (speech-to-text), TTS (text-to-speech) and embeddings each sit behind
    # their own abstraction, selected here exactly like DEFAULT_AI_PROVIDER. Only
    # "mock" is wired today (deterministic, fully offline): real providers
    # (Whisper, ElevenLabs, OpenAI embeddings…) are added in later lots and will
    # extend these Literals. As with the LLM layer, a missing key never fails —
    # the factory falls back to the mock.
    STT_PROVIDER: Literal["mock"] = "mock"
    TTS_PROVIDER: Literal["mock"] = "mock"
    EMBEDDING_PROVIDER: Literal["mock"] = "mock"

    # --- Voice-to-Quote confidence thresholds (Blueprint §5, adjustment #1) ---
    # Externalized rather than hardcoded so they can be calibrated on real
    # jobsite data without a code change. The decision policy (see docs/v3/06 §5):
    #   final score >= VOICE_CONFIDENCE_AUTO      -> include silently ("à relire")
    #   VOICE_CONFIDENCE_CLARIFY..AUTO            -> ask / mark for review
    #   < VOICE_CONFIDENCE_CLARIFY                -> omit and signal explicitly
    VOICE_CONFIDENCE_AUTO: float = 0.80
    VOICE_CONFIDENCE_CLARIFY: float = 0.50
    # Per-stage guards, upstream of the composite score:
    VOICE_STT_MIN_SEGMENT_CONFIDENCE: float = 0.60  # below -> ask to repeat
    VOICE_MATCH_MIN_SIMILARITY: float = 0.45  # below -> "hors catalogue", never forced
    # Dialogue circuit breaker, NOT the normal stop condition (Blueprint §5.3,
    # adjustment #2): questions stop when no mandatory slot is left unresolved.
    # This cap only guards against an extraction that loops without converging.
    VOICE_MAX_QUESTIONS: int = 8

    @field_validator("VOICE_CONFIDENCE_CLARIFY")
    @classmethod
    def _clarify_below_auto(cls, value: float, info: ValidationInfo) -> float:
        # A clarify threshold at or above the auto threshold would collapse the
        # middle "ask a question" band to nothing (or invert it), silently
        # turning every uncertain line into either auto-accept or outright
        # omission — the opposite of the conversational policy.
        auto = info.data.get("VOICE_CONFIDENCE_AUTO", 0.80)
        if not 0.0 <= value <= auto:
            raise ValueError(
                "VOICE_CONFIDENCE_CLARIFY must be between 0 and VOICE_CONFIDENCE_AUTO."
            )
        return value

    # --- Storage (abstraction layer, see app/branding/storage.py) ---
    STORAGE_PROVIDER: Literal["local"] = "local"
    STORAGE_LOCAL_ROOT: str = "/data/storage"

    # --- Email (transactional: password reset, welcome, receipts) ---
    # "mock" (default) logs the message and never fails — the app runs and the
    # reset flow works end-to-end without any email account. "smtp" sends for
    # real through any standard SMTP service (Brevo, Postmark, Mailjet, SES…):
    # set the SMTP_* variables below and switch EMAIL_PROVIDER=smtp. Nothing
    # that sends email changes — both are chosen behind the same EmailProvider
    # contract (same pattern as the AI/storage abstractions).
    EMAIL_PROVIDER: Literal["mock", "smtp"] = "mock"
    EMAIL_FROM: str = "no-reply@artizen.app"
    # Public URL of the web app, used to build links inside emails (the reset
    # link points at <APP_BASE_URL>/reset-password?token=…). Override in prod.
    APP_BASE_URL: str = "http://localhost:3000"
    # How long a password-reset link stays valid.
    RESET_TOKEN_TTL_MINUTES: int = 60

    # --- SMTP (only used when EMAIL_PROVIDER=smtp) ---
    # Typical setups: port 587 + STARTTLS (SMTP_USE_TLS=true) — the default of
    # most providers — or port 465 + SSL (SMTP_USE_SSL=true). Username/password
    # are the SMTP credentials your provider gives you (often an API key).
    SMTP_HOST: str = ""
    SMTP_PORT: int = 587
    SMTP_USERNAME: str = ""
    SMTP_PASSWORD: str = ""
    SMTP_USE_TLS: bool = True  # STARTTLS on the default 587
    SMTP_USE_SSL: bool = False  # implicit SSL on 465 (mutually exclusive with STARTTLS)

    # --- Redis (V3 foundations: task broker, cache, shared rate limit) ---
    # Optional: when unreachable, the app still starts and every dependent
    # feature degrades gracefully (in-memory rate limit, tasks refused with a
    # clear error). "redis" is the compose service name; override for local.
    REDIS_URL: str = "redis://redis:6379/0"


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()
