"""ORM model for the planning module: ``PlanningEntry``.

The Planning Engine is the sole owner of the schedule. An entry references a
mission (optionally) and carries its time slot, its assignment (artisan / team /
vehicle) and its append-only history. Tenant-scoped. Business data is never
destroyed (Loi 5): an entry is cancelled, never deleted.
"""

import uuid
from datetime import datetime

from sqlalchemy import JSON, DateTime, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin

PLANNING_PLANIFIEE = "planifiee"
PLANNING_DEPLACEE = "deplacee"
PLANNING_ANNULEE = "annulee"
PLANNING_TERMINEE = "terminee"


class PlanningEntry(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "planning_entries"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    mission_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("missions.id", ondelete="SET NULL"), default=None, index=True
    )
    start_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), index=True)
    duration_minutes: Mapped[int]
    # Assignment. Free-text ids/labels in V1 (no Team/Vehicle module yet): the
    # assignment is recorded and drives conflict detection by identity.
    artisan: Mapped[str] = mapped_column(default="")
    team: Mapped[str] = mapped_column(default="")
    vehicle: Mapped[str] = mapped_column(default="")
    status: Mapped[str] = mapped_column(server_default=PLANNING_PLANIFIEE)
    # Append-only trail [{event, actor, detail, at}, …] (Loi 4/5).
    history: Mapped[list] = mapped_column(JSON, default=list)
