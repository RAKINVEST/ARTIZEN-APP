"""Application entrypoint: FastAPI app assembly.

This module wires together configuration, logging, error handling and
routers. It intentionally contains no business logic.
"""

import logging
from collections.abc import AsyncIterator
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.endpoints import health
from app.api.router import api_router
from app.core.body_size_limit import MaxBodySizeMiddleware
from app.core.config import settings
from app.core.exceptions import register_exception_handlers
from app.core.logging import setup_logging
from app.core.observability import RequestContextMiddleware
from app.core.rate_limit import AuthRateLimitMiddleware
from app.core.security_headers import SecurityHeadersMiddleware
from app.database.session import engine
from app.redis_client import close_redis
from app.tasks.queue import close_pool

setup_logging()
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncIterator[None]:
    logger.info("Starting %s v%s (%s)", settings.PROJECT_NAME, settings.VERSION, settings.ENVIRONMENT)
    # TEMP diagnostic: the exact list handed to CORSMiddleware.allow_origins, shown
    # in the startup logs (%r so a trailing slash or stray space is visible). Remove
    # once the production CORS value is confirmed.
    logger.info("CORS allow_origins = %r", settings.CORS_ORIGINS)
    yield
    logger.info("Shutting down %s", settings.PROJECT_NAME)
    await engine.dispose()
    await close_pool()
    await close_redis()


# Interactive API docs (/docs, /redoc, /openapi.json) expose the full endpoint
# schema; useful in dev, needless information disclosure in front of real users.
_docs_enabled = settings.ENVIRONMENT != "production"

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    debug=settings.DEBUG,
    lifespan=lifespan,
    docs_url="/docs" if _docs_enabled else None,
    redoc_url="/redoc" if _docs_enabled else None,
    openapi_url="/openapi.json" if _docs_enabled else None,
)

if settings.CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.CORS_ORIGINS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

if settings.AUTH_RATE_LIMIT_ENABLED:
    app.add_middleware(
        AuthRateLimitMiddleware,
        max_requests=settings.AUTH_RATE_LIMIT_MAX_REQUESTS,
        window_seconds=settings.AUTH_RATE_LIMIT_WINDOW_SECONDS,
        backend=settings.RATE_LIMIT_BACKEND,
    )

app.add_middleware(SecurityHeadersMiddleware)

# Added last so it runs first: middlewares wrap in reverse registration
# order, and this one is only worth anything if it refuses an oversized
# body before any of the machinery below starts reading it.
app.add_middleware(MaxBodySizeMiddleware)

# Outermost of all: assign a correlation id and start the response-time clock
# before any other middleware runs, so even a request rejected by the body-size
# or rate-limit guard is still traced and timed.
app.add_middleware(RequestContextMiddleware)

register_exception_handlers(app)

# Health is unprefixed so container/orchestrator probes can hit /health directly.
app.include_router(health.router, tags=["health"])
# Also exposed under the API prefix (/api/health): a single-domain reverse proxy
# (Nginx `location /api/` -> backend, prefix preserved) then serves the probe and
# every business route through one clean rule, with no path-stripping rewrite.
app.include_router(health.router, prefix=settings.API_PREFIX, tags=["health"])
# All business endpoints are registered on api_router and mounted here.
app.include_router(api_router, prefix=settings.API_PREFIX)


@app.get("/", tags=["root"])
async def root() -> dict[str, str]:
    return {
        "name": settings.PROJECT_NAME,
        "version": settings.VERSION,
        "status": "running",
        "docs": "/docs",
    }
