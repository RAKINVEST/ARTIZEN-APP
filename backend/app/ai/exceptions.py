"""Provider-agnostic AI errors, built on the shared ``AppException``
hierarchy (see ``app/core/exceptions.py``).

Each concrete provider translates its own SDK's exceptions into these, so
callers depending on ``AIProvider`` keep depending only on the
abstraction — importing ``anthropic``'s exception types to catch a rate
limit would defeat the whole point of the layer.
"""

from app.core.exceptions import AppException


class AIProviderUnavailableError(AppException):
    """Raised when the AI provider could not be reached or refused to
    answer (network failure, timeout, rate limit, upstream outage).

    503 rather than 500: nothing is wrong with the caller's request or
    with Artizen — the upstream vendor is momentarily unavailable and the
    same request is worth retrying. The artisan gets a message saying so
    instead of an opaque "internal server error".
    """

    status_code = 503
    error_code = "ai_provider_unavailable"
