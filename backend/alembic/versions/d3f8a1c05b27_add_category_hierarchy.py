"""add category hierarchy (parent_id, sort_order)

Revision ID: d3f8a1c05b27
Revises: 75aa1c39d0bf
Create Date: 2026-07-20 00:05:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd3f8a1c05b27'
down_revision: Union[str, None] = '75aa1c39d0bf'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        'catalog_categories',
        sa.Column('parent_id', sa.Uuid(), nullable=True),
    )
    op.add_column(
        'catalog_categories',
        sa.Column('sort_order', sa.Integer(), nullable=False, server_default='0'),
    )
    op.create_index(
        op.f('ix_catalog_categories_parent_id'),
        'catalog_categories',
        ['parent_id'],
        unique=False,
    )
    op.create_foreign_key(
        op.f('fk_catalog_categories_parent_id_catalog_categories'),
        'catalog_categories',
        'catalog_categories',
        ['parent_id'],
        ['id'],
        ondelete='CASCADE',
    )


def downgrade() -> None:
    op.drop_constraint(
        op.f('fk_catalog_categories_parent_id_catalog_categories'),
        'catalog_categories',
        type_='foreignkey',
    )
    op.drop_index(op.f('ix_catalog_categories_parent_id'), table_name='catalog_categories')
    op.drop_column('catalog_categories', 'sort_order')
    op.drop_column('catalog_categories', 'parent_id')
