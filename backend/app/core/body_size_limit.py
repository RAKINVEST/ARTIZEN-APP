"""Rejects oversized requests before anything parses them.

``read_validated_upload`` enforces a per-endpoint size limit, but it runs
*inside* the route — by which point Starlette has already parsed the
multipart body and streamed the whole file to a temp file on disk (its
``SpooledTemporaryFile`` spills past 1 MB, with no cap of its own). A 2 GB
upload was therefore fully written to the container's disk and *then*
answered with a 413. Repeat that and the disk fills, whatever the
per-endpoint limit says.

This middleware is the guard that actually protects the machine: it reads
the declared ``Content-Length`` off the ASGI scope and refuses before the
app — and therefore before form parsing — ever sees the request.

Deliberately plain ASGI rather than ``BaseHTTPMiddleware``: that base class
reads the request body to hand it on, which is the exact thing this must
not do.

Known gap: a chunked request sends no ``Content-Length``, so it slips past
this check and is bounded only by the per-endpoint limit (i.e. after
buffering). Closing that needs a byte-counting wrapper around ``receive``,
and in front of a real deployment the sane answer is a body limit on the
reverse proxy — uvicorn is currently exposed directly.
"""

from starlette.datastructures import Headers
from starlette.responses import JSONResponse
from starlette.types import ASGIApp, Receive, Scope, Send

# Comfortably above the largest legitimate upload (PDF templates cap at
# 15 MB, logos at 5 MB) plus multipart overhead — this is a blast-radius
# limit, not a business rule. The business limits stay where they are.
DEFAULT_MAX_BODY_BYTES = 20 * 1024 * 1024


class MaxBodySizeMiddleware:
    def __init__(self, app: ASGIApp, max_body_bytes: int = DEFAULT_MAX_BODY_BYTES) -> None:
        self._app = app
        self._max_body_bytes = max_body_bytes

    async def __call__(self, scope: Scope, receive: Receive, send: Send) -> None:
        if scope["type"] != "http":
            await self._app(scope, receive, send)
            return

        declared = Headers(scope=scope).get("content-length")
        if declared is not None:
            try:
                declared_bytes = int(declared)
            except ValueError:
                # A malformed Content-Length is not this middleware's
                # problem to adjudicate; the HTTP layer below rejects it.
                declared_bytes = None
            if declared_bytes is not None and declared_bytes > self._max_body_bytes:
                await JSONResponse(
                    status_code=413,
                    content={
                        "error": {
                            "code": "file_too_large",
                            "message": (
                                "Request body exceeds the maximum allowed size of "
                                f"{self._max_body_bytes // (1024 * 1024)} MB."
                            ),
                        }
                    },
                )(scope, receive, send)
                return

        await self._app(scope, receive, send)
