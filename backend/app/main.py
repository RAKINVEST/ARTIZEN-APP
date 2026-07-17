"""Application entrypoint: FastAPI app assembly.

This module wires together configuration, logging, error handling and
routers. It intentionally contains no business logic.
"""

import logging
from contextlib import asynccontextmanager
from typing import AsyncIterator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.endpoints import health
from app.api.router import api_router
from app.core.body_size_limit import MaxBodySizeMiddleware
from app.core.config import settings
from app.core.exceptions import register_exception_handlers
from app.core.logging import setup_logging
from app.core.rate_limit import AuthRateLimitMiddleware
from app.database.session import engine

setup_logging()
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncIterator[None]:
    logger.info("Starting %s v%s (%s)", settings.PROJECT_NAME, settings.VERSION, settings.ENVIRONMENT)
    yield
    logger.info("Shutting down %s", settings.PROJECT_NAME)
    await engine.dispose()


app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    debug=settings.DEBUG,
    lifespan=lifespan,
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
    )

# Added last so it runs first: middlewares wrap in reverse registration
# order, and this one is only worth anything if it refuses an oversized
# body before any of the machinery below starts reading it.
app.add_middleware(MaxBodySizeMiddleware)

register_exception_handlers(app)

# Health is unprefixed so container/orchestrator probes can hit /health directly.
app.include_router(health.router, tags=["health"])
# All future business endpoints are registered on api_router and mounted here.
app.include_router(api_router, prefix=settings.API_PREFIX)


@app.get("/", tags=["root"])
async def root() -> dict[str, str]:
    return {
        "name": settings.PROJECT_NAME,
        "version": settings.VERSION,
        "status": "running",
        "docs": "/docs",
    }
