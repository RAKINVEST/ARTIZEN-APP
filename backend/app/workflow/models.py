"""ORM model for the workflow module: ``WorkflowInstance``.

The Workflow Engine owns the business *processes*: an instance is one running
process (of a code-defined ``WorkflowDefinition``), tenant-scoped like every
business row. ``context`` holds what started it (e.g. a validated decision's
intent), ``history`` is the append-only trail of transitions. Definitions live
in code (``definitions.py``); only instances are persisted.
"""

import uuid

from sqlalchemy import JSON, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin

WORKFLOW_STATUS_RUNNING = "running"
WORKFLOW_STATUS_COMPLETED = "completed"
WORKFLOW_STATUS_CANCELLED = "cancelled"


class WorkflowInstance(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "workflow_instances"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    definition_slug: Mapped[str] = mapped_column(index=True)
    current_state: Mapped[str]
    status: Mapped[str] = mapped_column(server_default=WORKFLOW_STATUS_RUNNING)
    # What started the process (e.g. the validated decision's intent). JSON so a
    # process carries its context without a bespoke column per workflow.
    context: Mapped[dict] = mapped_column(JSON, default=dict)
    # Append-only trail: [{event, from, to, actor, at}, …] (Loi 4/5).
    history: Mapped[list] = mapped_column(JSON, default=list)
