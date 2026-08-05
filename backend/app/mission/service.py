"""Mission business logic — owns the intervention aggregate.

Write-side: creates missions, drives their lifecycle, associates a site and a
workflow, manages attachments, and keeps the append-only timeline. It validates
that the referenced client/site/workflow belong to the caller's company
(read-only dependencies on clients/sites/workflow — one-directional, justified).
No amount is ever computed here (ADR-023).
"""

import logging
import uuid

from sqlalchemy.ext.asyncio import AsyncSession

from app.clients.repository import ClientRepository
from app.core.exceptions import NotFoundError
from app.mission.attachments import AttachmentManager
from app.mission.exceptions import MissionNotFoundError
from app.mission.lifecycle import (
    MISSION_NOUVELLE,
    ProgressCalculator,
    ensure_transition,
    is_terminal,
)
from app.mission.models import Mission
from app.mission.repository import MissionRepository
from app.mission.schemas import MissionCreate, MissionRead
from app.mission.timeline import TimelineManager
from app.sites.repository import SiteRepository
from app.workflow.repository import WorkflowInstanceRepository

logger = logging.getLogger(__name__)


class MissionService:
    def __init__(
        self,
        session: AsyncSession,
        missions: MissionRepository,
        clients: ClientRepository,
        sites: SiteRepository,
        workflows: WorkflowInstanceRepository,
    ) -> None:
        self._session = session
        self._missions = missions
        self._clients = clients
        self._sites = sites
        self._workflows = workflows

    async def create(self, *, company_id: uuid.UUID, data: MissionCreate) -> Mission:
        await self._ensure_customer(data.customer_id, company_id)
        if data.site_id is not None:
            await self._ensure_site(data.site_id, company_id)
        timeline: list[dict] = []
        TimelineManager.record(
            timeline, event="created", actor=str(company_id), detail=data.title
        )
        mission = Mission(
            company_id=company_id,
            customer_id=data.customer_id,
            site_id=data.site_id,
            title=data.title,
            status=MISSION_NOUVELLE,
            attachments=[],
            timeline=timeline,
        )
        return await self._missions.create(mission)

    async def get(self, mission_id: uuid.UUID) -> Mission:
        mission = await self._missions.get(mission_id)
        if mission is None:
            raise MissionNotFoundError(f"Mission {mission_id} not found.")
        return mission

    async def list(
        self,
        *,
        company_id: uuid.UUID,
        customer_id: uuid.UUID | None = None,
        offset: int = 0,
        limit: int = 100,
    ) -> list[Mission]:
        return await self._missions.list_by_company(
            company_id, customer_id=customer_id, offset=offset, limit=limit
        )

    async def change_status(
        self, *, mission_id: uuid.UUID, target: str, actor: str
    ) -> Mission:
        mission = await self.get(mission_id)
        ensure_transition(mission.status, target)  # 409 if not allowed
        from_status = mission.status
        mission.status = target
        self._append_timeline(
            mission, event=f"status:{target}", actor=actor, detail=f"{from_status}->{target}"
        )
        await self._session.flush()
        await self._session.refresh(mission)
        return mission

    async def associate_workflow(
        self, *, mission_id: uuid.UUID, workflow_instance_id: uuid.UUID, company_id: uuid.UUID,
        actor: str,
    ) -> Mission:
        mission = await self.get(mission_id)
        await self._ensure_workflow(workflow_instance_id, company_id)
        mission.workflow_instance_id = workflow_instance_id
        self._append_timeline(
            mission, event="workflow_associated", actor=actor,
            detail=str(workflow_instance_id),
        )
        await self._session.flush()
        await self._session.refresh(mission)
        return mission

    async def add_attachment(
        self, *, mission_id: uuid.UUID, kind: str, label: str, reference: str, text: str,
        actor: str,
    ) -> Mission:
        mission = await self.get(mission_id)
        entry = AttachmentManager.build(kind, label=label, reference=reference, text=text)
        mission.attachments = [*mission.attachments, entry]  # reassign -> JSON dirty
        self._append_timeline(
            mission, event=f"attachment:{kind}", actor=actor, detail=label or reference or "note"
        )
        await self._session.flush()
        await self._session.refresh(mission)
        return mission

    @staticmethod
    def to_read(mission: Mission) -> MissionRead:
        return MissionRead(
            id=mission.id,
            company_id=mission.company_id,
            customer_id=mission.customer_id,
            site_id=mission.site_id,
            workflow_instance_id=mission.workflow_instance_id,
            title=mission.title,
            status=mission.status,
            progress=ProgressCalculator.progress(mission.status),
            is_terminal=is_terminal(mission.status),
            attachments=mission.attachments,
            timeline=mission.timeline,
            created_at=mission.created_at,
            updated_at=mission.updated_at,
        )

    # --- internal helpers ---
    def _append_timeline(self, mission: Mission, *, event: str, actor: str, detail: str) -> None:
        new_timeline = list(mission.timeline)
        TimelineManager.record(new_timeline, event=event, actor=actor, detail=detail)
        mission.timeline = new_timeline  # reassign -> JSON dirty detection

    async def _ensure_customer(self, customer_id: uuid.UUID, company_id: uuid.UUID) -> None:
        client = await self._clients.get(customer_id)
        if client is None or client.company_id != company_id:
            raise NotFoundError(f"Customer {customer_id} not found.")

    async def _ensure_site(self, site_id: uuid.UUID, company_id: uuid.UUID) -> None:
        site = await self._sites.get(site_id)
        if site is None or site.company_id != company_id:
            raise NotFoundError(f"Site {site_id} not found.")

    async def _ensure_workflow(
        self, workflow_instance_id: uuid.UUID, company_id: uuid.UUID
    ) -> None:
        instance = await self._workflows.get(workflow_instance_id)
        if instance is None or instance.company_id != company_id:
            raise NotFoundError(f"Workflow {workflow_instance_id} not found.")
