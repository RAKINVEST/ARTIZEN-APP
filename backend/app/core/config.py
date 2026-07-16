"""Centralized application configuration.

All runtime configuration is loaded here from environment variables (or a
``.env`` file) via ``pydantic-settings``. No module outside of ``core``
should read ``os.environ`` directly: every other layer depends on the
``settings`` singleton exported below.
"""

from functools import lru_cache
from typing import Annotated, Literal

from pydantic import field_validator
from pydantic_settings import BaseSettings, NoDecode, SettingsConfigDict


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
