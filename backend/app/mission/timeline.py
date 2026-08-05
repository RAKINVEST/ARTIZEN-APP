"""Timeline manager — records mission events into the append-only timeline.

Same substrate as the Workflow Engine (History + logging), no external bus
invented. Each entry is {event, actor, detail, at}.
"""

import logging
from datetime import datetime, timezone

logger = logging.getLogger(__name__)


class TimelineManager:
    @staticmethod
    def record(timeline: list, *, event: str, actor: str, detail: str = "") -> dict:
        entry = {
            "event": event,
            "actor": actor,
            "detail": detail,
            "at": datetime.now(timezone.utc).isoformat(),
        }
        timeline.append(entry)
        logger.info("mission.event event=%s actor=%s", event, actor)
        return entry
