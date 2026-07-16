"""Declarative base and reusable mixins shared by all ORM models.

Every future domain model (User, Client, Devis, Facture, ...) inherits from
``Base`` and, when relevant, from the mixins below so new tables stay
consistent without repeating boilerplate columns.
"""

import uuid
from datetime import datetime

from sqlalchemy import MetaData
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy.sql import func

# Explicit naming convention so Alembic autogenerate produces stable,
# predictable constraint/index names instead of database-assigned ones.
NAMING_CONVENTION = {
    "ix": "ix_%(column_0_label)s",
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s",
}


class Base(DeclarativeBase):
    metadata = MetaData(naming_convention=NAMING_CONVENTION)


class UUIDMixin:
    """Adds a UUID primary key, the default identifier strategy for Artizen."""

    id: Mapped[uuid.UUID] = mapped_column(
        primary_key=True, default=uuid.uuid4, nullable=False
    )


class TimestampMixin:
    """Adds ``created_at`` / ``updated_at`` columns managed by the database."""

    created_at: Mapped[datetime] = mapped_column(
        server_default=func.now(), nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        server_default=func.now(), onupdate=func.now(), nullable=False
    )
