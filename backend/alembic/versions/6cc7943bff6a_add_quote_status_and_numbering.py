"""add quote status and numbering

Revision ID: 6cc7943bff6a
Revises: 75aa1c39d0bf
Create Date: 2026-07-17 14:51:19.512162

Hand-adjusted after autogenerate, on three points it got wrong — the
"please adjust!" it prints is not decoration:

1. It declared `quote_number` and `status` NOT NULL with no default. That
   fails outright on any database that already has quotes: PostgreSQL has
   nothing to put in the existing rows. Columns are therefore added
   nullable, backfilled, and only then constrained.
2. It had no backfill at all. Existing quotes need real numbers, and the
   counters need to start where those numbers stop — otherwise the next
   quote created after this migration would claim DEV-2026-0001 again and
   hit the unique constraint.
3. Its `downgrade()` dropped the table but not the `quote_status` ENUM
   type. In PostgreSQL, DROP TABLE does not drop a type created by CREATE
   TYPE, so downgrade-then-upgrade died with 'type "quote_status" already
   exists'. This is the same defect the V1 audit fixed in the four earlier
   migrations; autogenerate reproduces it every time.
"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '6cc7943bff6a'
down_revision: Union[str, None] = '75aa1c39d0bf'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


# Kept in sync with app/quotes/service.py by hand. Duplicating the format
# here is deliberate: a migration must keep producing the same result years
# from now, even if the application's format changes. Importing the app's
# constant would silently rewrite history the day someone edits it.
_BACKFILL_NUMBER_SQL = """
WITH numbered AS (
    SELECT
        id,
        EXTRACT(YEAR FROM created_at)::int AS yr,
        ROW_NUMBER() OVER (
            PARTITION BY company_id, EXTRACT(YEAR FROM created_at)
            ORDER BY created_at, id
        ) AS seq
    FROM quotes
)
UPDATE quotes q
SET quote_number = 'DEV-' || n.yr || '-' || LPAD(n.seq::text, 4, '0')
FROM numbered n
WHERE q.id = n.id
"""

# Seeds each counter at the highest number just handed out, so the next
# quote continues the series instead of colliding with an existing one.
_SEED_COUNTERS_SQL = """
INSERT INTO quote_counters (company_id, year, last_number, created_at, updated_at)
SELECT
    company_id,
    EXTRACT(YEAR FROM created_at)::int AS yr,
    COUNT(*) AS last_number,
    now(),
    now()
FROM quotes
GROUP BY company_id, EXTRACT(YEAR FROM created_at)
"""


def upgrade() -> None:
    op.create_table(
        'quote_counters',
        sa.Column('company_id', sa.Uuid(), nullable=False),
        sa.Column('year', sa.Integer(), nullable=False),
        sa.Column('last_number', sa.Integer(), nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.Column('updated_at', sa.DateTime(), server_default=sa.text('now()'), nullable=False),
        sa.ForeignKeyConstraint(
            ['company_id'], ['companies.id'],
            name=op.f('fk_quote_counters_company_id_companies'), ondelete='CASCADE',
        ),
        sa.PrimaryKeyConstraint('company_id', 'year', name=op.f('pk_quote_counters')),
    )

    quote_status = sa.Enum('draft', 'sent', 'accepted', 'refused', name='quote_status')
    quote_status.create(op.get_bind(), checkfirst=True)

    # Nullable first — see the module docstring.
    op.add_column('quotes', sa.Column('quote_number', sa.String(), nullable=True))
    op.add_column('quotes', sa.Column('status', quote_status, nullable=True))

    # Existing quotes predate the lifecycle: 'draft' is the only honest
    # answer. Claiming they were 'sent' would assert something about the
    # artisan's history that this migration cannot know.
    op.execute("UPDATE quotes SET status = 'draft' WHERE status IS NULL")
    op.execute(_BACKFILL_NUMBER_SQL)
    op.execute(_SEED_COUNTERS_SQL)

    op.alter_column('quotes', 'quote_number', nullable=False)
    op.alter_column('quotes', 'status', nullable=False)

    op.create_index(op.f('ix_quotes_quote_number'), 'quotes', ['quote_number'], unique=False)
    op.create_index(op.f('ix_quotes_status'), 'quotes', ['status'], unique=False)
    op.create_unique_constraint(
        op.f('uq_quotes_company_id'), 'quotes', ['company_id', 'quote_number']
    )


def downgrade() -> None:
    op.drop_constraint(op.f('uq_quotes_company_id'), 'quotes', type_='unique')
    op.drop_index(op.f('ix_quotes_status'), table_name='quotes')
    op.drop_index(op.f('ix_quotes_quote_number'), table_name='quotes')
    op.drop_column('quotes', 'status')
    op.drop_column('quotes', 'quote_number')
    op.drop_table('quote_counters')
    # DROP TABLE / DROP COLUMN leave the type behind — see the module
    # docstring. Without this, re-upgrading fails on 'type already exists'.
    sa.Enum(name='quote_status').drop(op.get_bind(), checkfirst=True)
