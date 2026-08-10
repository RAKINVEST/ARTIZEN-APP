"""quote_lines.catalog_item_id nullable + ON DELETE SET NULL

Free lines (décision 5) reference no catalog article, and for a catalog line
``catalog_item_id`` is only a trace of origin — not a dependency. So the column
becomes nullable and its FK switches RESTRICT -> SET NULL: deleting a catalog
item nulls the reference on any line that used it (each keeps its own snapshot
— designation, unit, price, VAT), instead of being blocked. No backfill is
needed: every existing line already carries a catalog_item_id.

Revision ID: a7f3c1b9d2e4
Revises: f2a3b4c5d6e7
Create Date: 2026-08-10 00:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'a7f3c1b9d2e4'
down_revision: Union[str, None] = 'f2a3b4c5d6e7'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None

# The constraint name Alembic gave the FK when the table was created
# (6521371f0e54, via op.f() and the metadata naming convention).
_FK = 'fk_quote_lines_catalog_item_id_catalog_items'


def upgrade() -> None:
    op.alter_column(
        'quote_lines', 'catalog_item_id', existing_type=sa.Uuid(), nullable=True
    )
    op.drop_constraint(_FK, 'quote_lines', type_='foreignkey')
    op.create_foreign_key(
        _FK,
        'quote_lines',
        'catalog_items',
        ['catalog_item_id'],
        ['id'],
        ondelete='SET NULL',
    )


def downgrade() -> None:
    # Reverts to the original RESTRICT + NOT NULL. Fails if any free line
    # (catalog_item_id IS NULL) exists — deliberately, since such rows cannot
    # satisfy the old contract.
    op.drop_constraint(_FK, 'quote_lines', type_='foreignkey')
    op.create_foreign_key(
        _FK,
        'quote_lines',
        'catalog_items',
        ['catalog_item_id'],
        ['id'],
        ondelete='RESTRICT',
    )
    op.alter_column(
        'quote_lines', 'catalog_item_id', existing_type=sa.Uuid(), nullable=False
    )
