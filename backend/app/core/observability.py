"""Request-scoped observability: correlation id, response time, access log.

Pure-ASGI (like the security/body-size middlewares) so it stays off the hot
path. Every request gets a correlation id — reused from an inbound
``X-Request-ID`` (so a reverse proxy or the frontend can thread one through) or
generated — which is:

- put in a ``ContextVar`` so **every log line of that request carries it**
  (``CorrelationIdFilter`` below injects it into each record);
- echoed back as ``X-Request-ID`` and paired with ``X-Response-Time-ms``;
- logged once per request as a structured access line (method, path, status,
  duration) on the ``app.access`` logger.

No business logic, no persistence — pure infrastructure.
"""

import logging
import time
import uuid
from contextvars import ContextVar

from starlette.types import ASGIApp, Message, Receive, Scope, Send

#: The current request's correlation id ("-" outside a request).
correlation_id_var: ContextVar[str] = ContextVar("correlation_id", default="-")

_REQUEST_ID_HEADER = b"x-request-id"
_RESPONSE_TIME_HEADER = b"x-response-time-ms"
_access_logger = logging.getLogger("app.access")


class CorrelationIdFilter(logging.Filter):
    """Injects the current correlation id into every log record so the format
    string can print it. Defaults to "-" when there is no active request."""

    def filter(self, record: logging.LogRecord) -> bool:
        record.correlation_id = correlation_id_var.get()
        return True


class RequestContextMiddleware:
    def __init__(self, app: ASGIApp) -> None:
        self.app = app

    async def __call__(self, scope: Scope, receive: Receive, send: Send) -> None:
        if scope["type"] != "http":
            await self.app(scope, receive, send)
            return

        request_id = self._inbound_id(scope) or uuid.uuid4().hex
        token = correlation_id_var.set(request_id)
        start = time.perf_counter()
        status_holder = {"code": 500}

        async def send_wrapper(message: Message) -> None:
            if message["type"] == "http.response.start":
                status_holder["code"] = message["status"]
                elapsed_ms = round((time.perf_counter() - start) * 1000, 1)
                headers = message.setdefault("headers", [])
                headers.append((_REQUEST_ID_HEADER, request_id.encode()))
                headers.append((_RESPONSE_TIME_HEADER, str(elapsed_ms).encode()))
            await send(message)

        try:
            await self.app(scope, receive, send_wrapper)
        finally:
            elapsed_ms = round((time.perf_counter() - start) * 1000, 1)
            _access_logger.info(
                "%s %s -> %s (%sms)",
                scope.get("method", "?"),
                scope.get("path", "?"),
                status_holder["code"],
                elapsed_ms,
            )
            correlation_id_var.reset(token)

    @staticmethod
    def _inbound_id(scope: Scope) -> str | None:
        for name, value in scope.get("headers", []):
            if name == _REQUEST_ID_HEADER:
                decoded = value.decode(errors="replace").strip()
                # Bounded + sanitized: never trust an inbound header verbatim.
                return decoded[:64] if decoded else None
        return None
