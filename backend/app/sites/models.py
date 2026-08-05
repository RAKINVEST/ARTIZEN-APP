"""ORM model for the sites module: ``Site`` (a jobsite / "chantier").

A ``Site`` is a place where work happens, attached to exactly one client
(``customer_id``). It carries the tenant ``company_id`` like every other
business row. ``name`` is the only required label (e.g. "Chantier rue de
la Paix"); ``address`` is optional and printed on future documents.

Lifecycle is Active -> Archived (``status``): business data is never hard
deleted (Loi 5), so there is deliberately no delete path — a site is
archived instead. ``customer_id`` uses ``ondelete="RESTRICT"`` so a client
who still has sites cannot be silently destroyed, the same protection
``quotes`` already applies to ``clients``.
"""

import uuid

from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin

#: The only two lifecycle states a site can be in (see module docstring).
SITE_STATUS_ACTIVE = "active"
SITE_STATUS_ARCHIVED = "archived"


class Site(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "sites"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # A site belongs to exactly one client (Site fiche: "rattaché à un
    # Customer"). RESTRICT protects that client from a delete that would
    # orphan the site.
    customer_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("clients.id", ondelete="RESTRICT"), index=True
    )
    name: Mapped[str]
    address: Mapped[str | None] = mapped_column(default=None)
    status: Mapped[str] = mapped_column(server_default=SITE_STATUS_ACTIVE)
