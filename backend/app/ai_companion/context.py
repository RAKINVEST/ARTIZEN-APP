"""Context Engine — assembles a read-only snapshot from the owning engines.

The Companion reasons over a picture built **exclusively** from other engines'
public read services (missions, planning) plus the conversation itself. It reads;
it never writes, and never touches another engine's repository/DB. Kept light
(a few recent items) so building context costs one cheap read per engine.
"""

import uuid
from dataclasses import dataclass, field

from app.ai_companion.session import CompanionSession
from app.mission.service import MissionService
from app.planning.service import PlanningService


@dataclass
class CompanionContext:
    company_id: str
    recent_missions: list[dict] = field(default_factory=list)
    recent_plannings: list[dict] = field(default_factory=list)
    conversation_summary: str = ""
    recent_turns: list[dict] = field(default_factory=list)

    def brief(self) -> str:
        """A compact, human-readable digest for prompts and explanations."""
        parts = [
            f"{len(self.recent_missions)} mission(s) récente(s)",
            f"{len(self.recent_plannings)} créneau(x) récent(s)",
        ]
        if self.conversation_summary:
            parts.append(f"résumé: {self.conversation_summary[:160]}")
        return " · ".join(parts)


class ContextBuilder:
    def __init__(self, *, missions: MissionService, planning: PlanningService) -> None:
        self._missions = missions
        self._planning = planning

    async def build(
        self, *, company_id: uuid.UUID, session: CompanionSession
    ) -> CompanionContext:
        missions = await self._missions.list(company_id=company_id, limit=5)
        plannings = await self._planning.list(company_id=company_id, limit=5)
        return CompanionContext(
            company_id=str(company_id),
            recent_missions=[
                {"id": str(m.id), "title": m.title, "status": m.status} for m in missions[:5]
            ],
            recent_plannings=[
                {"id": str(p.id), "artisan": p.artisan, "status": p.status}
                for p in plannings[:5]
            ],
            conversation_summary=session.summary,
            recent_turns=[
                {"role": t.role, "text": t.text} for t in session.turns[-6:]
            ],
        )
