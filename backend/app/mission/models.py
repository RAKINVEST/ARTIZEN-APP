"""ORM model for the mission module: ``Mission`` (the real intervention).

The Mission Engine owns the intervention aggregate: it references a client
(required), optionally a site (chantier) and a workflow instance, and carries
its attachments and its append-only timeline. Tenant-scoped. Business data is
never destroyed (Loi 5): a mission is cancelled/closed, never deleted, so the
FK to ``clients`` is RESTRICT (a client with missions can't be orphaned).
"""

import uuid

from sqlalchemy import JSON, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin
from app.mission.lifecycle import MISSION_NOUVELLE


class Mission(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "missions"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    customer_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("clients.id", ondelete="RESTRICT"), index=True
    )
    # Optional chantier and workflow. SET NULL: business data (sites are
    # archived, not deleted; a workflow removal shouldn't orphan the mission).
    site_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("sites.id", ondelete="SET NULL"), default=None, index=True
    )
    workflow_instance_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("workflow_instances.id", ondelete="SET NULL"), default=None
    )
    title: Mapped[str]
    status: Mapped[str] = mapped_column(server_default=MISSION_NOUVELLE)
    # Attachment references [{kind, label, reference, text, at}, …].
    attachments: Mapped[list] = mapped_column(JSON, default=list)
    # Append-only event timeline [{event, actor, detail, at}, …] (Loi 4/5).
    timeline: Mapped[list] = mapped_column(JSON, default=list)
