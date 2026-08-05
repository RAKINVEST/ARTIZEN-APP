"""add sites table (capability #8 chantiers)

Revision ID: f1a2b3c4d5e6
Revises: e0c465a09a0d
Create Date: 2026-08-02 10:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'f1a2b3c4d5e6'
down_revision: Union[str, None] = 'e0c465a09a0d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'sites',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('customer_id', sa.Uuid(), nullable=False),
        sa.Column('name', sa.String(), nullable=False),
        sa.Column('address', sa.String(), nullable=True),
        sa.Column('status', sa.String(), server_default='active', nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_sites_company_id_companies'), ondelete='CASCADE',
        ),
        sa.ForeignKeyConstraint(
            ['customer_id'], ['clients.id'],
            name=op.f('fk_sites_customer_id_clients'), ondelete='RESTRICT',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_sites')),
    )
    op.create_index(op.f('ix_sites_company_id'), 'sites', ['company_id'], unique=False)
    op.create_index(op.f('ix_sites_customer_id'), 'sites', ['customer_id'], unique=False)


def downgrade() -> None:
    op.drop_index(op.f('ix_sites_customer_id'), table_name='sites')
    op.drop_index(op.f('ix_sites_company_id'), table_name='sites')
    op.drop_table('sites')
