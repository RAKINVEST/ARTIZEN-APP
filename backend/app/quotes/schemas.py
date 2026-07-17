"""Pydantic schemas for the quotes module.

``QuoteLineCreate`` intentionally has no price field: the only input is
which catalog item and how much of it — the amount is always derived by
``QuoteCalculator`` from the catalog, never supplied by the caller.
"""

import uuid
from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, ConfigDict, Field


class QuoteLineCreate(BaseModel):
    catalog_item_id: uuid.UUID
    # Bounded to exactly what QuoteLine.quantity's Numeric(10, 2) column can
    # hold. Without this, PostgreSQL silently rounds the persisted quantity
    # while QuoteCalculator has already computed total_ht from the unrounded
    # value: "0.333 × 300.00" persists as "0.33 × 300.00 = 99.90", a line the
    # artisan cannot justify. A quantity that doesn't fit must be refused
    # (422), never silently altered.
    quantity: Decimal = Field(gt=0, max_digits=10, decimal_places=2)


class QuoteCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # quotes/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    client_id: uuid.UUID
    lines: list[QuoteLineCreate] = Field(min_length=1)


class QuoteLineRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    catalog_item_id: uuid.UUID
    designation: str
    unit: str
    quantity: Decimal
    unit_price_ht: Decimal
    vat_rate: Decimal
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal


class QuoteRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    client_id: uuid.UUID
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal
    lines: list[QuoteLineRead]
    created_at: datetime
    updated_at: datetime
