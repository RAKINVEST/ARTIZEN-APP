"""add orchestration_instances table (Orchestration Engine V1)

Revision ID: d9e0f1a2b3c4
Revises: c8d9e0f1a2b3
Create Date: 2026-08-02 14:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd9e0f1a2b3c4'
down_revision: Union[str, None] = 'c8d9e0f1a2b3'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'orchestration_instances',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('correlation_id', sa.String(), nullable=False),
        sa.Column('plan_kind', sa.String(), nullable=False),
        sa.Column('status', sa.String(), server_default='a_traiter', nullable=False),
        sa.Column('context', sa.JSON(), nullable=False),
        sa.Column('plan', sa.JSON(), nullable=False),
        sa.Column('timeline', sa.JSON(), nullable=False),
        sa.Column('results', sa.JSON(), nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_orchestration_instances_company_id_companies'), ondelete='CASCADE',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_orchestration_instances')),
    )
    op.create_index(
        op.f('ix_orchestration_instances_company_id'),
        'orchestration_instances', ['company_id'], unique=False,
    )
    op.create_index(
        op.f('ix_orchestration_instances_correlation_id'),
        'orchestration_instances', ['correlation_id'], unique=False,
    )


def downgrade() -> None:
    op.drop_index(
        op.f('ix_orchestration_instances_correlation_id'), table_name='orchestration_instances'
    )
    op.drop_index(
        op.f('ix_orchestration_instances_company_id'), table_name='orchestration_instances'
    )
    op.drop_table('orchestration_instances')
