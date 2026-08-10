"""Pydantic schemas for the quotes module.

``QuoteLineCreate`` accepts two shapes (décision 5): a **catalog line**
(``catalog_item_id`` set, with an *optional* ``unit_price_ht`` override) or a
**free line** (``catalog_item_id`` null, price/désignation typed from scratch).
A supplied price is only ever an input to ``QuoteCalculator`` — which stays the
one place any total is computed — never an amount trusted as-is.
"""

import uuid
from datetime import datetime
from decimal import Decimal
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, model_validator

from app.quotes.models import QuoteStatus


class ReadinessIssue(BaseModel):
    """One thing standing between the quote and being ready to send.

    ``target`` + ``field`` let the client turn the issue into a tap that jumps
    straight to the screen and field to fix (Phase 1.1, Mission 2)."""

    code: str
    label: str
    target: Literal["company_profile", "client", "quote"]
    field: str | None = None


class QuoteReadiness(BaseModel):
    """🟢 ``ready`` or 🔴 the precise list of what is missing."""

    ready: bool
    issues: list[ReadinessIssue] = Field(default_factory=list)


class QuoteLineCreate(BaseModel):
    """A quote line to price — a catalog article or a free line (décision 5).

    Disambiguated by ``catalog_item_id``:

    - **Catalog line** (``catalog_item_id`` set): the service snapshots
      designation/unit/VAT from the catalog; ``unit_price_ht`` is an *optional*
      override ("un prix peut différer de celui du catalogue"). The other
      free-line fields are ignored.
    - **Free line** (``catalog_item_id`` null/absent): typed from scratch
      (péage, location, intervention exceptionnelle), so ``designation``,
      ``unit``, ``unit_price_ht`` and ``vat_rate`` are all **required**.

    A supplied price is never trusted as an amount: it is only an input to
    ``QuoteCalculator``, still the one place a total is computed (décision 3).
    The AI never fills these — a custom price is a human act.
    """

    catalog_item_id: uuid.UUID | None = None
    # Bounded to exactly what QuoteLine.quantity's Numeric(10, 2) column can
    # hold. Without this, PostgreSQL silently rounds the persisted quantity
    # while QuoteCalculator has already computed total_ht from the unrounded
    # value: "0.333 × 300.00" persists as "0.33 × 300.00 = 99.90", a line the
    # artisan cannot justify. A quantity that doesn't fit must be refused
    # (422), never silently altered.
    quantity: Decimal = Field(gt=0, max_digits=10, decimal_places=2)
    # Free-line fields — also the optional price override for a catalog line.
    # Bounds mirror the QuoteLine columns (Numeric(10,2) price, Numeric(5,2)
    # rate) so a value that can't be stored is refused (422), never truncated.
    designation: str | None = Field(default=None, min_length=1, max_length=255)
    unit: str | None = Field(default=None, min_length=1, max_length=32)
    unit_price_ht: Decimal | None = Field(
        default=None, gt=0, max_digits=10, decimal_places=2
    )
    vat_rate: Decimal | None = Field(
        default=None, ge=0, le=100, max_digits=5, decimal_places=2
    )

    @model_validator(mode="after")
    def _check_line_shape(self) -> "QuoteLineCreate":
        """A free line must carry everything the catalog would have supplied."""
        if self.catalog_item_id is None:
            missing = [
                name
                for name, value in (
                    ("designation", self.designation),
                    ("unit", self.unit),
                    ("unit_price_ht", self.unit_price_ht),
                    ("vat_rate", self.vat_rate),
                )
                if value is None
            ]
            if missing:
                raise ValueError(
                    "A free line (no catalog_item_id) requires: "
                    + ", ".join(missing)
                    + "."
                )
        return self


class QuoteCreate(BaseModel):
    # Always overridden with the authenticated user's company_id (see
    # quotes/router.py) — optional here so callers don't need to send a
    # value that would be ignored anyway.
    company_id: uuid.UUID | None = None
    client_id: uuid.UUID
    lines: list[QuoteLineCreate] = Field(min_length=1)


class QuoteCalculationRequest(BaseModel):
    """Input of the stateless pricing preview (``POST /quotes/calculate``).

    Deliberately lighter than ``QuoteCreate``: no ``client_id``, because no
    amount depends on the client, so the guided flow can show a running
    total before one has been picked. Empty ``lines`` is valid and prices to
    zero — an artisan who hasn't added anything yet is not a 422.
    """

    # Always overridden with the authenticated user's company_id, exactly
    # like QuoteCreate: the VAT regime that drives the rate is the caller's,
    # never something the client may assert.
    company_id: uuid.UUID | None = None
    lines: list[QuoteLineCreate] = Field(default_factory=list)


class QuoteLineCalculation(BaseModel):
    """One priced line of a preview: the same figures a persisted
    ``QuoteLineRead`` carries, minus the ids nothing has been given yet."""

    model_config = ConfigDict(from_attributes=True)

    # Null for a free line — it has no catalog article behind it.
    catalog_item_id: uuid.UUID | None
    designation: str
    unit: str
    quantity: Decimal
    unit_price_ht: Decimal
    vat_rate: Decimal
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal


class QuoteCalculation(BaseModel):
    """What a quote *would* total if it were created right now.

    Nothing is persisted: no quote row, no number burned from the counter,
    no status. It exists so the client can display live totals while the
    artisan edits, without ever computing money itself.
    """

    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal
    lines: list[QuoteLineCalculation] = Field(default_factory=list)


class QuoteLineRead(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: uuid.UUID
    # Null for a free line — it has no catalog article behind it (and becomes
    # null on an existing line if its catalog item is later deleted, SET NULL).
    catalog_item_id: uuid.UUID | None
    designation: str
    unit: str
    quantity: Decimal
    unit_price_ht: Decimal
    vat_rate: Decimal
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal


class QuoteStatusUpdate(BaseModel):
    """The only mutation a quote accepts. Deliberately not a full update:
    the lines and totals of a quote are never edited — see
    ``QuoteService.delete``."""

    status: QuoteStatus


class QuoteRead(BaseModel):
    id: uuid.UUID
    company_id: uuid.UUID
    client_id: uuid.UUID
    # The identity the artisan and their customer use ("DEV-2026-0001"),
    # as opposed to `id`, which is a UUID nobody reads out loud.
    quote_number: str
    status: QuoteStatus
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal
    lines: list[QuoteLineRead]
    created_at: datetime
    updated_at: datetime
