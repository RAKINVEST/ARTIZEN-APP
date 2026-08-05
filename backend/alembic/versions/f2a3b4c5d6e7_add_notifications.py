"""add notifications table (Notification Engine V1)

Revision ID: f2a3b4c5d6e7
Revises: e0f1a2b3c4d5
Create Date: 2026-08-02 16:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'f2a3b4c5d6e7'
down_revision: Union[str, None] = 'e0f1a2b3c4d5'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'notifications',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('channel', sa.String(), nullable=False),
        sa.Column('recipient', sa.String(), nullable=False),
        sa.Column('subject', sa.String(), server_default='', nullable=False),
        sa.Column('body', sa.String(), server_default='', nullable=False),
        sa.Column('status', sa.String(), server_default='pending', nullable=False),
        sa.Column('template_key', sa.String(), server_default='', nullable=False),
        sa.Column('related_type', sa.String(), server_default='', nullable=False),
        sa.Column('related_id', sa.String(), server_default='', nullable=False),
        sa.Column('history', sa.JSON(), nullable=False),
        sa.Column('id', sa.Uuid(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_notifications_company_id_companies'), ondelete='CASCADE',
        ),
        sa.PrimaryKeyConstraint('id', name=op.f('pk_notifications')),
    )
    op.create_index(op.f('ix_notifications_company_id'), 'notifications', ['company_id'], unique=False)


def downgrade() -> None:
    op.drop_index(op.f('ix_notifications_company_id'), table_name='notifications')
    op.drop_table('notifications')
