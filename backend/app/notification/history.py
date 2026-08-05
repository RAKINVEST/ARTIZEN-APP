"""History recorder for notifications (append-only) + logging. No external bus.

Events: NotificationCreated, NotificationSent, NotificationFailed.
"""

import logging
from datetime import datetime, timezone

logger = logging.getLogger(__name__)


class EventPublisher:
    @staticmethod
    def record(history: list, *, event: str, actor: str, detail: str = "") -> dict:
        entry = {
            "event": event,
            "actor": actor,
            "detail": detail,
            "at": datetime.now(timezone.utc).isoformat(),
        }
        history.append(entry)
        logger.info("notification.event event=%s actor=%s", event, actor)
        return entry
