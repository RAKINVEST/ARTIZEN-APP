"""HTTP-level tests for request observability (require the app — run in Docker).

Every response carries a correlation id and a response-time header; an inbound
``X-Request-ID`` is threaded through rather than replaced.
"""

from httpx import AsyncClient


async def test_response_carries_correlation_and_timing(client: AsyncClient) -> None:
    response = await client.get("/health")
    assert response.status_code == 200
    assert response.headers.get("x-request-id")  # generated
    assert response.headers.get("x-response-time-ms")  # timed
    float(response.headers["x-response-time-ms"])  # numeric


async def test_inbound_request_id_is_threaded_through(client: AsyncClient) -> None:
    response = await client.get("/health", headers={"X-Request-ID": "trace-xyz-1"})
    assert response.headers.get("x-request-id") == "trace-xyz-1"


async def test_correlation_id_is_bounded(client: AsyncClient) -> None:
    # An over-long inbound id is truncated (never trusted verbatim).
    response = await client.get("/health", headers={"X-Request-ID": "z" * 200})
    assert len(response.headers.get("x-request-id", "")) <= 64
