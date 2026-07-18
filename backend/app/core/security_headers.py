"""Baseline security response headers on every response.

Pure-ASGI (like ``MaxBodySizeMiddleware``) to stay off the request hot path.
HSTS is deliberately omitted: the app runs behind a TLS-terminating reverse
proxy in production (see DEPLOYMENT_GUIDE), which is where HSTS belongs —
setting it here, on a plain-HTTP origin, would be wrong.
"""

from starlette.types import ASGIApp, Message, Receive, Scope, Send

_HEADERS: list[tuple[bytes, bytes]] = [
    (b"x-content-type-options", b"nosniff"),
    (b"x-frame-options", b"DENY"),
    (b"referrer-policy", b"strict-origin-when-cross-origin"),
    (b"permissions-policy", b"geolocation=(), camera=()"),
    # 0, not 1: modern guidance disables the legacy XSS auditor rather than
    # enabling its buggy heuristics.
    (b"x-xss-protection", b"0"),
]


class SecurityHeadersMiddleware:
    def __init__(self, app: ASGIApp) -> None:
        self.app = app

    async def __call__(self, scope: Scope, receive: Receive, send: Send) -> None:
        if scope["type"] != "http":
            await self.app(scope, receive, send)
            return

        async def send_with_headers(message: Message) -> None:
            if message["type"] == "http.response.start":
                headers = message.setdefault("headers", [])
                present = {name.lower() for name, _ in headers}
                for name, value in _HEADERS:
                    if name not in present:
                        headers.append((name, value))
            await send(message)

        await self.app(scope, receive, send_with_headers)
