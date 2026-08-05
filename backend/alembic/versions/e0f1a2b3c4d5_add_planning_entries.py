"""add planning_entries table (Planning Engine V1)

Revision ID: e0f1a2b3c4d5
Revises: d9e0f1a2b3c4
Create Date: 2026-08-02 15:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'e0f1a2b3c4d5'
down_revision: Union[str, None] = 'd9e0f1a2b3c4'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'planning_entries',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('mission_id', sa.Uuid(), nullable=True),
        sa.Column('start_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('duration_minutes', sa.Integer(), nullable=False),
        sa.Column('artisan', sa.String(), server_default='', nullable=False),
        sa.Column('team', sa.String(), server_default='', nullable=False),
        sa.Column('vehicle', sa.String(), server_default='', nullable=False),
        sa.Column('status', sa.String(), server_default='planifiee', nullable=False),
        sa.Column('history', sa.JSON(), nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_planning_entries_company_id_companies'), ondelete='CASCADE',
        ),
        sa.ForeignKeyConstraint(
            ['mission_id'], ['missions.id'],
            name=op.f('fk_planning_entries_mission_id_missions'), ondelete='SET NULL',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_planning_entries')),
    )
    op.create_index(op.f('ix_planning_entries_company_id'), 'planning_entries', ['company_id'], unique=False)
    op.create_index(op.f('ix_planning_entries_mission_id'), 'planning_entries', ['mission_id'], unique=False)
    op.create_index(op.f('ix_planning_entries_start_at'), 'planning_entries', ['start_at'], unique=False)


def downgrade() -> None:
    op.drop_index(op.f('ix_planning_entries_start_at'), table_name='planning_entries')
    op.drop_index(op.f('ix_planning_entries_mission_id'), table_name='planning_entries')
    op.drop_index(op.f('ix_planning_entries_company_id'), table_name='planning_entries')
    op.drop_table('planning_entries')
