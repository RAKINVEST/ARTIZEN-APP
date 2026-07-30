"""Deploy-time configuration behaviour (T3 production): the managed-platform
database URL override, and the fail-fast guards that refuse a misconfigured
production boot (selected-but-unconfigured providers, wildcard CORS)."""

import pytest

from app.core.config import Settings


def _base(**over):
    """A minimal valid Settings, overridable. Explicit kwargs win over the .env
    file, so these tests are independent of the local environment."""
    defaults = dict(
        POSTGRES_USER="u",
        POSTGRES_PASSWORD="p",
        POSTGRES_DB="d",
        SECRET_KEY="x" * 40,
    )
    defaults.update(over)
    return Settings(**defaults)


def test_to_asyncpg_url_normalises_scheme_and_strips_libpq_params() -> None:
    assert (
        Settings._to_asyncpg_url("postgres://u:p@h:5432/d?sslmode=require")
        == "postgresql+asyncpg://u:p@h:5432/d"
    )
    assert (
        Settings._to_asyncpg_url("postgresql://u:p@h:5432/d")
        == "postgresql+asyncpg://u:p@h:5432/d"
    )


def test_database_url_override_wins_over_discrete_vars() -> None:
    s = _base(DATABASE_URL_OVERRIDE="postgres://a:b@managed:5432/prod?sslmode=require")
    assert s.DATABASE_URL == "postgresql+asyncpg://a:b@managed:5432/prod"


def test_database_url_falls_back_to_discrete_vars() -> None:
    s = _base(POSTGRES_HOST="db", POSTGRES_PORT=5432)
    assert s.DATABASE_URL == "postgresql+asyncpg://u:p@db:5432/d"


def test_s3_provider_requires_all_credentials() -> None:
    with pytest.raises(ValueError):
        _base(
            STORAGE_PROVIDER="s3",
            STORAGE_S3_ENDPOINT_URL="",
            STORAGE_S3_BUCKET="",
            STORAGE_S3_ACCESS_KEY="",
            STORAGE_S3_SECRET_KEY="",
        )


def test_s3_provider_accepts_full_configuration() -> None:
    s = _base(
        STORAGE_PROVIDER="s3",
        STORAGE_S3_ENDPOINT_URL="https://s3.fr-par.example",
        STORAGE_S3_BUCKET="b",
        STORAGE_S3_ACCESS_KEY="k",
        STORAGE_S3_SECRET_KEY="s",
    )
    assert s.STORAGE_PROVIDER == "s3"


def test_smtp_provider_requires_host() -> None:
    with pytest.raises(ValueError):
        _base(EMAIL_PROVIDER="smtp", SMTP_HOST="")


def test_wildcard_cors_is_rejected_in_production() -> None:
    with pytest.raises(ValueError):
        _base(ENVIRONMENT="production", CORS_ORIGINS=["*"])


def test_wildcard_cors_is_tolerated_outside_production() -> None:
    # Only production forbids it — dev/staging must stay frictionless.
    s = _base(ENVIRONMENT="development", CORS_ORIGINS=["*"])
    assert s.CORS_ORIGINS == ["*"]
