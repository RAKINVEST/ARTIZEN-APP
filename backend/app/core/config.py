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
    VERSION: str = "0.1.0"
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

    # --- AI providers (abstraction layer, see app/ai) ---
    DEFAULT_AI_PROVIDER: Literal["openai", "anthropic", "mistral"] = "anthropic"
    OPENAI_API_KEY: str | None = None
    ANTHROPIC_API_KEY: str | None = None
    MISTRAL_API_KEY: str | None = None

    # --- Storage (abstraction layer, see app/branding/storage.py) ---
    STORAGE_PROVIDER: Literal["local"] = "local"
    STORAGE_LOCAL_ROOT: str = "/data/storage"


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()
