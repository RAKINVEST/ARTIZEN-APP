"""ORM model for the orchestration module: ``OrchestrationInstance``.

The Orchestration Engine owns **only** the orchestration state — never business
data. An instance records the plan, the saga timeline (append-only), the step
results and the final status, all tenant-scoped. It coordinates the owning
engines through their public services; it stores no business entity of its own.
"""

import uuid

from sqlalchemy import JSON, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin
from app.orchestration.saga import ORCH_A_TRAITER


class OrchestrationInstance(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "orchestration_instances"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # Correlation id ties every event/step of one orchestration together.
    correlation_id: Mapped[str] = mapped_column(index=True)
    plan_kind: Mapped[str]
    status: Mapped[str] = mapped_column(server_default=ORCH_A_TRAITER)
    # The originating context (e.g. the validated decision).
    context: Mapped[dict] = mapped_column(JSON, default=dict)
    # Serialized plan steps (observability): [{id, engine, action}, …].
    plan: Mapped[list] = mapped_column(JSON, default=list)
    # Append-only saga event timeline (Loi 4/5).
    timeline: Mapped[list] = mapped_column(JSON, default=list)
    # Per-step results (e.g. created mission/workflow ids).
    results: Mapped[dict] = mapped_column(JSON, default=dict)
