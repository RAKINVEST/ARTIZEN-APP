"""add quote_status 'pending' (en attente)

Adds the "en attente" state to the quote life cycle, between draft and sent:
a draft is *validated* into ``pending``, then *sent* from there. The status
column is a Postgres ENUM, so the value has to be declared with ALTER TYPE —
Alembic autogenerate never sees enum-value additions.

Revision ID: b2f8a1c9d3e7
Revises: 7dd52a8e7c70
Create Date: 2026-07-22 16:40:00.000000

"""
from typing import Sequence, Union

from alembic import op


# revision identifiers, used by Alembic.
revision: str = 'b2f8a1c9d3e7'
down_revision: Union[str, None] = '7dd52a8e7c70'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ALTER TYPE ... ADD VALUE is the only way to extend a Postgres enum. On
    # PG 12+ it runs fine inside the migration's transaction as long as the new
    # value isn't *used* in the same transaction — here it is only declared.
    # IF NOT EXISTS keeps a re-run idempotent; AFTER 'draft' places it in the
    # natural life-cycle order (draft → pending → sent → …).
    op.execute("ALTER TYPE quote_status ADD VALUE IF NOT EXISTS 'pending' AFTER 'draft'")


def downgrade() -> None:
    # Postgres cannot remove a value from an enum type without recreating it and
    # rewriting every column that uses it. Not attempted: a downgrade would only
    # be safe once no quote is left in 'pending', and rebuilding the type here
    # would be far riskier than the value simply going unused.
    pass
