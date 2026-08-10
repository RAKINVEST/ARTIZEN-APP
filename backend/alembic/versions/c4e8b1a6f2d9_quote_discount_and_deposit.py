"""quote discount + deposit fields (remise + acompte)

Adds the discount (global, on HT) and deposit (split of the net TTC) fields to
``quotes`` — décision 5: these are quote fields, not lines. ``total_*`` stays the
GROSS subtotal (sum of lines); ``net_total_*`` is after discount; ``balance_due``
is the net TTC minus the deposit. Every amount is still computed only by
``QuoteCalculator``.

Existing quotes are backfilled to neutral values (net == gross, no deposit,
balance == ttc) so they stay coherent without a discount ever having existed.

Revision ID: c4e8b1a6f2d9
Revises: a7f3c1b9d2e4
Create Date: 2026-08-10 00:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c4e8b1a6f2d9'
down_revision: Union[str, None] = 'a7f3c1b9d2e4'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None

_MONEY = sa.Numeric(precision=10, scale=2)

# The NOT NULL numeric columns: added with a server_default so the ALTER
# succeeds on existing rows, then the default is dropped so new inserts rely on
# the ORM default (matching the model, which declares no server_default).
_NUMERIC_COLS = (
    'discount_value',
    'discount_amount',
    'net_total_ht',
    'net_total_vat',
    'net_total_ttc',
    'deposit_value',
    'deposit_amount',
    'balance_due',
)


def upgrade() -> None:
    op.add_column('quotes', sa.Column('discount_type', sa.String(), nullable=True))
    op.add_column('quotes', sa.Column('deposit_type', sa.String(), nullable=True))
    for name in _NUMERIC_COLS:
        op.add_column(
            'quotes',
            sa.Column(name, _MONEY, nullable=False, server_default='0.00'),
        )

    # Backfill: a pre-existing quote has no discount, so its net equals its
    # gross and its balance equals its TTC.
    op.execute(
        "UPDATE quotes SET "
        "net_total_ht = total_ht, "
        "net_total_vat = total_vat, "
        "net_total_ttc = total_ttc, "
        "balance_due = total_ttc"
    )

    for name in _NUMERIC_COLS:
        op.alter_column('quotes', name, server_default=None)


def downgrade() -> None:
    for name in (*_NUMERIC_COLS, 'deposit_type', 'discount_type'):
        op.drop_column('quotes', name)
