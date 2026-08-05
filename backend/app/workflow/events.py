"""Event publisher — records workflow events into history and the log.

The codebase has no external event bus (clients/quotes emit none), so V1 does
not invent one: events are appended to the instance's append-only ``history``
and logged (the substrate the Orchestration spec names: History + logging). A
real bus can replace this later behind the same ``publish`` call.
"""

import logging
from datetime import datetime, timezone

logger = logging.getLogger(__name__)


class EventPublisher:
    @staticmethod
    def record(
        history: list[dict],
        *,
        event: str,
        from_state: str,
        to_state: str,
        actor: str,
    ) -> dict:
        entry = {
            "event": event,
            "from": from_state,
            "to": to_state,
            "actor": actor,
            "at": datetime.now(timezone.utc).isoformat(),
        }
        history.append(entry)
        logger.info(
            "workflow.event event=%s from=%s to=%s actor=%s",
            event,
            from_state,
            to_state,
            actor,
        )
        return entry
