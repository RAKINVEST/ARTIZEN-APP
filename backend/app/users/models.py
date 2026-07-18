"""ORM model for the users module: ``User``.

One row per account. Each ``User`` belongs to exactly one ``Company``
(``branding.models.Company``) — the multi-tenant boundary Artizen was
missing until Étape 10: every other module's data (clients, catalog,
quotes, ...) is scoped by ``company_id``, but until this module existed
nothing actually verified that the caller was entitled to the
``company_id`` it sent. A ``Company`` is now only ever created as a side
effect of registering a ``User`` (see ``AuthService.register``) — the
old "auto-create the first company" singleton hack in
``BrandingService`` is gone.
"""

import uuid
from datetime import datetime

from sqlalchemy import DateTime, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class User(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "users"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    email: Mapped[str] = mapped_column(String, unique=True, index=True)
    hashed_password: Mapped[str]
    full_name: Mapped[str | None] = mapped_column(default=None)
    is_active: Mapped[bool] = mapped_column(default=True)

    # Password reset: only the token's SHA-256 hash is stored (the raw token is
    # emailed), and it expires. Indexed for the lookup on reset. Both null when
    # no reset is pending.
    reset_token_hash: Mapped[str | None] = mapped_column(String, default=None, index=True)
    reset_token_expires_at: Mapped[datetime | None] = mapped_column(
        DateTime(timezone=True), default=None
    )
