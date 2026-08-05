"""ORM model for the notification module: ``Notification``.

The Notification Engine is the exclusive owner of notifications: one row per
notification, tenant-scoped, with its channel, rendered content, status and
append-only history. It may reference another object (mission/quote…) by a
loose (type, id) pair without coupling to that engine's model.
"""

import uuid

from sqlalchemy import JSON, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class Notification(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "notifications"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    channel: Mapped[str]  # email | sms | push
    recipient: Mapped[str]
    subject: Mapped[str] = mapped_column(default="")
    body: Mapped[str] = mapped_column(default="")
    status: Mapped[str] = mapped_column(server_default="pending")  # pending|sent|failed
    template_key: Mapped[str] = mapped_column(default="")
    # Loose reference to what the notification is about (no cross-engine FK).
    related_type: Mapped[str] = mapped_column(default="")
    related_id: Mapped[str] = mapped_column(default="")
    history: Mapped[list] = mapped_column(JSON, default=list)
