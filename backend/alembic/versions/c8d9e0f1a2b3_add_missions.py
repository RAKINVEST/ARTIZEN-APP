"""add missions table (Mission Engine V1)

Revision ID: c8d9e0f1a2b3
Revises: b7c8d9e0f1a2
Create Date: 2026-08-02 13:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c8d9e0f1a2b3'
down_revision: Union[str, None] = 'b7c8d9e0f1a2'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'missions',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('customer_id', sa.Uuid(), nullable=False),
        sa.Column('site_id', sa.Uuid(), nullable=True),
        sa.Column('workflow_instance_id', sa.Uuid(), nullable=True),
        sa.Column('title', sa.String(), nullable=False),
        sa.Column('status', sa.String(), server_default='nouvelle', nullable=False),
        sa.Column('attachments', sa.JSON(), nullable=False),
        sa.Column('timeline', sa.JSON(), nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_missions_company_id_companies'), ondelete='CASCADE',
        ),
        sa.ForeignKeyConstraint(
            ['customer_id'], ['clients.id'],
            name=op.f('fk_missions_customer_id_clients'), ondelete='RESTRICT',
        ),
        sa.ForeignKeyConstraint(
            ['site_id'], ['sites.id'],
            name=op.f('fk_missions_site_id_sites'), ondelete='SET NULL',
        ),
        sa.ForeignKeyConstraint(
            ['workflow_instance_id'], ['workflow_instances.id'],
            name=op.f('fk_missions_workflow_instance_id_workflow_instances'), ondelete='SET NULL',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_missions')),
    )
    op.create_index(op.f('ix_missions_company_id'), 'missions', ['company_id'], unique=False)
    op.create_index(op.f('ix_missions_customer_id'), 'missions', ['customer_id'], unique=False)
    op.create_index(op.f('ix_missions_site_id'), 'missions', ['site_id'], unique=False)


def downgrade() -> None:
    op.drop_index(op.f('ix_missions_site_id'), table_name='missions')
    op.drop_index(op.f('ix_missions_customer_id'), table_name='missions')
    op.drop_index(op.f('ix_missions_company_id'), table_name='missions')
    op.drop_table('missions')
