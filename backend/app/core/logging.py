"""Centralized logging configuration.

``setup_logging`` is called once, at application startup, before any other
module emits a log line. It replaces the default handlers with a single
stream handler so log format stays consistent across the app, SQLAlchemy
and uvicorn.
"""

import logging
import sys

from app.core.config import settings

_LOG_FORMAT = "%(asctime)s | %(levelname)-8s | %(name)s | %(message)s"
_DATE_FORMAT = "%Y-%m-%d %H:%M:%S"


def setup_logging() -> None:
    level = getattr(logging, settings.LOG_LEVEL.upper(), logging.INFO)

    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(logging.Formatter(fmt=_LOG_FORMAT, datefmt=_DATE_FORMAT))

    root_logger = logging.getLogger()
    root_logger.setLevel(level)
    root_logger.handlers.clear()
    root_logger.addHandler(handler)

    # SQLAlchemy is noisy at INFO level; only enable it in debug mode.
    logging.getLogger("sqlalchemy.engine").setLevel(
        logging.INFO if settings.DEBUG else logging.WARNING
    )

    # Pinned for secrecy, not noise: these propagate to the root logger,
    # so LOG_LEVEL=DEBUG would make the HTTP layer under the Anthropic SDK
    # dump request headers — including the "x-api-key" carrying the AI
    # provider credential — straight into stdout, and from there into
    # whatever collects container logs. Nothing below WARNING from these
    # libraries is worth that risk.
    for third_party_logger in ("anthropic", "httpx", "httpcore"):
        logging.getLogger(third_party_logger).setLevel(logging.WARNING)
