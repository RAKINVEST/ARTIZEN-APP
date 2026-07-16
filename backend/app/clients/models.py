"""ORM model for the clients module: ``Client``.

``last_name`` is the only required identifying field; everything else
(``first_name``, ``company_name``, ``address``, ``phone``, ``email``,
``notes``) is optional — a client record can start as just a name and
get filled in over time. ``company_name`` is the *client's* own company
(e.g. when quoting a professional), not to be confused with Artizen's
own ``Company`` entity from ``branding/``.
"""

import uuid

from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class Client(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "clients"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    last_name: Mapped[str]
    first_name: Mapped[str | None] = mapped_column(default=None)
    company_name: Mapped[str | None] = mapped_column(default=None)
    address: Mapped[str | None] = mapped_column(default=None)
    phone: Mapped[str | None] = mapped_column(default=None)
    email: Mapped[str | None] = mapped_column(default=None)
    notes: Mapped[str | None] = mapped_column(default=None)
