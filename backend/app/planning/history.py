"""Event publisher / history recorder for planning changes.

Same substrate as the other engines (History + logging), no external bus.
Events: PlanningCreated, PlanningUpdated, PlanningMoved, PlanningAssigned,
PlanningCancelled, PlanningCompleted.
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
        logger.info("planning.event event=%s actor=%s", event, actor)
        return entry
