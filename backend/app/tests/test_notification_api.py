"""HTTP-level tests for the Notification Engine (require the DB — run in Docker).

A freshly registered tenant, real JWT: send a notification (raw and from a
template), list, read, resend, and stay tenant-scoped. The mock channel provider
makes every send deterministic (status=sent), so these assertions are stable.
"""

from httpx import AsyncClient


async def _send(ac: AsyncClient, **overrides) -> dict:
    payload = {"channel": "email", "recipient": "client@example.com", "body": "Bonjour"}
    payload.update(overrides)
    r = await ac.post("/api/notifications", json=payload)
    assert r.status_code == 201, r.text
    return r.json()


async def test_send_raw_notification(client: AsyncClient) -> None:
    notif = await _send(client, subject="Info", body="Votre RDV est confirmé")
    assert notif["channel"] == "email"
    assert notif["status"] == "sent"  # mock provider
    assert notif["subject"] == "Info"
    events = [e["event"] for e in notif["history"]]
    assert events == ["NotificationCreated", "NotificationSent"]


async def test_send_from_template_renders(client: AsyncClient) -> None:
    notif = await _send(
        client,
        template_key="mission_scheduled",
        context={"title": "Chaudière", "date": "12/03"},
    )
    assert notif["subject"] == "Intervention planifiée"
    assert "Chaudière" in notif["body"]
    assert notif["template_key"] == "mission_scheduled"


async def test_send_unknown_channel_rejected(client: AsyncClient) -> None:
    r = await client.post(
        "/api/notifications",
        json={"channel": "fax", "recipient": "x@y.z", "body": "hi"},
    )
    assert r.status_code == 400


async def test_send_missing_template_variable_rejected(client: AsyncClient) -> None:
    r = await client.post(
        "/api/notifications",
        json={"channel": "email", "recipient": "x@y.z", "template_key": "mission_scheduled",
              "context": {"title": "Chaudière"}},  # no {date}
    )
    assert r.status_code == 400


async def test_list_returns_sent_notifications(client: AsyncClient) -> None:
    await _send(client, recipient="a@example.com")
    await _send(client, recipient="b@example.com")
    r = await client.get("/api/notifications")
    assert r.status_code == 200, r.text
    recipients = {n["recipient"] for n in r.json()}
    assert {"a@example.com", "b@example.com"} <= recipients


async def test_get_and_resend(client: AsyncClient) -> None:
    notif = await _send(client)
    r = await client.get(f"/api/notifications/{notif['id']}")
    assert r.status_code == 200, r.text

    r = await client.post(f"/api/notifications/{notif['id']}/resend")
    assert r.status_code == 200, r.text
    resent = r.json()
    assert resent["status"] == "sent"
    # Resend appends to the append-only history, never rewrites it.
    assert len(resent["history"]) == len(notif["history"]) + 1


async def test_list_templates(client: AsyncClient) -> None:
    r = await client.get("/api/notifications/templates")
    assert r.status_code == 200, r.text
    assert "mission_scheduled" in r.json()


async def test_no_hard_delete(client: AsyncClient) -> None:
    notif = await _send(client)
    r = await client.delete(f"/api/notifications/{notif['id']}")
    assert r.status_code == 405  # Loi 5 — no route


async def test_scoped_to_company(client: AsyncClient, second_client: AsyncClient) -> None:
    notif = await _send(client)
    r = await second_client.get(f"/api/notifications/{notif['id']}")
    assert r.status_code == 404
