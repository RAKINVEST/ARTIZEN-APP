"""add workflow_instances table (Workflow Engine V1)

Revision ID: b7c8d9e0f1a2
Revises: f1a2b3c4d5e6
Create Date: 2026-08-02 12:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'b7c8d9e0f1a2'
down_revision: Union[str, None] = 'f1a2b3c4d5e6'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'workflow_instances',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('definition_slug', sa.String(), nullable=False),
        sa.Column('current_state', sa.String(), nullable=False),
        sa.Column('status', sa.String(), server_default='running', nullable=False),
        sa.Column('context', sa.JSON(), nullable=False),
        sa.Column('history', sa.JSON(), nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_workflow_instances_company_id_companies'), ondelete='CASCADE',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_workflow_instances')),
    )
    op.create_index(
        op.f('ix_workflow_instances_company_id'), 'workflow_instances', ['company_id'], unique=False
    )
    op.create_index(
        op.f('ix_workflow_instances_definition_slug'),
        'workflow_instances', ['definition_slug'], unique=False,
    )


def downgrade() -> None:
    op.drop_index(op.f('ix_workflow_instances_definition_slug'), table_name='workflow_instances')
    op.drop_index(op.f('ix_workflow_instances_company_id'), table_name='workflow_instances')
    op.drop_table('workflow_instances')
