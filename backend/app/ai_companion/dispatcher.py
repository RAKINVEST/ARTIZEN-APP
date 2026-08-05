"""Tool Dispatcher — the only place the Companion reaches other engines, and it
does so **exclusively through their public services**, never a repository/DB.

Read intents are answered by the Reasoning/Context layers; this handles the
*write* intents: it builds a proposed action (with any still-missing parameters)
and, only after explicit human validation, executes it via the owning engine.

Quote is deliberately **not executable here**: a quote is only ever created by
the artisan's explicit ``POST /quotes`` gesture (Invariant #1). The Companion may
*preview* one (read-only ``calculate`` — no persistence) and hand the prepared
payload back, but it never creates it.
"""

import logging
import uuid

from app.ai_companion.intents import CompanionIntent, ResolvedIntent
from app.ai_companion.schemas import ProposedAction
from app.notification.service import NotificationService
from app.orchestration.service import OrchestrationService
from app.planning.schemas import PlanningCreate
from app.planning.service import PlanningService
from app.quotes.schemas import QuoteCalculationRequest
from app.quotes.service import QuoteService

logger = logging.getLogger(__name__)

# Required parameters per write tool; anything missing is asked for, never guessed.
_REQUIRED: dict[CompanionIntent, tuple[str, ...]] = {
    CompanionIntent.PLAN_INTERVENTION: ("customer_id",),
    CompanionIntent.SCHEDULE: ("start_at", "duration_minutes"),
    CompanionIntent.SEND_NOTIFICATION: ("recipient",),
    CompanionIntent.CREATE_QUOTE: ("client_id", "lines"),
}

# Tools the Companion may itself execute. Quote is excluded on purpose.
_EXECUTABLE: frozenset[str] = frozenset(
    {
        CompanionIntent.PLAN_INTERVENTION.value,
        CompanionIntent.SCHEDULE.value,
        CompanionIntent.SEND_NOTIFICATION.value,
    }
)

_LABELS: dict[CompanionIntent, str] = {
    CompanionIntent.PLAN_INTERVENTION: "planifier automatiquement une intervention",
    CompanionIntent.SCHEDULE: "réserver un créneau au planning",
    CompanionIntent.SEND_NOTIFICATION: "envoyer une notification",
    CompanionIntent.CREATE_QUOTE: "préparer un devis",
}


class ToolDispatcher:
    def __init__(
        self,
        *,
        orchestration: OrchestrationService,
        planning: PlanningService,
        notification: NotificationService,
        quotes: QuoteService,
        company_id: uuid.UUID,
        actor: str,
    ) -> None:
        self._orchestration = orchestration
        self._planning = planning
        self._notification = notification
        self._quotes = quotes
        self._company_id = company_id
        self._actor = actor

    def propose(self, resolved: ResolvedIntent, slots: dict) -> ProposedAction:
        required = _REQUIRED.get(resolved.intent, ())
        missing = [name for name in required if not slots.get(name)]
        return ProposedAction(
            tool=resolved.intent.value,
            engine=resolved.engine,
            description=_LABELS.get(resolved.intent, "exécuter l'action"),
            params=dict(slots),
            missing=missing,
        )

    async def preview_quote(self, slots: dict) -> dict | None:
        """Read-only price preview via the single calculator (ADR-023). Persists
        nothing — used to show the artisan the totals before they create it."""
        lines = slots.get("lines")
        if not lines:
            return None
        calculation = await self._quotes.calculate(
            QuoteCalculationRequest(company_id=self._company_id, lines=lines)
        )
        return calculation.model_dump(mode="json")

    async def execute(self, action: ProposedAction) -> tuple[bool, dict]:
        """Run a validated action. Returns ``(executed, result)``. For a quote,
        ``executed`` is False and the payload is handed back for POST /quotes."""
        tool = action.tool
        params = action.params

        if tool == CompanionIntent.CREATE_QUOTE.value:
            # Never persisted by the AI — the artisan submits it themselves.
            logger.info("companion.dispatch.quote_handoff company_id=%s", self._company_id)
            return False, {
                "handoff": "POST /api/quotes",
                "payload": {
                    "client_id": params.get("client_id"),
                    "lines": params.get("lines", []),
                },
            }

        if tool == CompanionIntent.PLAN_INTERVENTION.value:
            instance = await self._orchestration.start(
                company_id=self._company_id, actor=self._actor,
                plan_kind="intervention", context=params,
            )
            return True, OrchestrationService.to_read(instance).model_dump(mode="json")

        if tool == CompanionIntent.SCHEDULE.value:
            entry = await self._planning.create(
                company_id=self._company_id, actor=self._actor,
                data=PlanningCreate(
                    mission_id=params.get("mission_id"),
                    start_at=params["start_at"],
                    duration_minutes=int(params["duration_minutes"]),
                    artisan=params.get("artisan", ""),
                ),
            )
            return True, PlanningService.to_read(entry).model_dump(mode="json")

        if tool == CompanionIntent.SEND_NOTIFICATION.value:
            notification = await self._notification.notify(
                company_id=self._company_id, actor=self._actor,
                channel=params.get("channel", "email"), recipient=params["recipient"],
                subject=params.get("subject", ""), body=params.get("body", ""),
                template_key=params.get("template_key", ""), context=params.get("context", {}),
                related_type=params.get("related_type", ""), related_id=params.get("related_id", ""),
            )
            return True, NotificationService.to_read(notification).model_dump(mode="json")

        # Unknown tool — never fabricate an effect.
        return False, {"error": f"unknown_tool:{tool}"}

    @staticmethod
    def is_executable(tool: str) -> bool:
        return tool in _EXECUTABLE
