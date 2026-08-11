"""quote object (objet du devis)

Adds the optional free-text subject of a quote (V1.1 #6) to ``quotes`` — a human
label for what the quote is about ("Rénovation SDB — M. Dupont"), distinct from
the folder (navigation only, décision P4.3). Nullable with no server_default: a
pre-existing quote keeps ``NULL`` and renders exactly as before. Length is
bounded at the schema (255), not the column, matching how ``designation`` is
stored. Not a monetary field.

Revision ID: b3a9c1d7e2f4
Revises: c4e8b1a6f2d9
Create Date: 2026-08-11 00:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'b3a9c1d7e2f4'
down_revision: Union[str, None] = 'c4e8b1a6f2d9'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column('quotes', sa.Column('object', sa.String(), nullable=True))


def downgrade() -> None:
    op.drop_column('quotes', 'object')
