"""Centralizes every quote calculation rule: HT, VAT, TTC, rounding,
subtotals. No other file computes a monetary amount — ``QuoteService``
only calls into this class and persists what it returns.

Rounding policy: amounts are rounded to the cent (``ROUND_HALF_UP``,
i.e. standard "commercial" rounding — 0.005 rounds up, not to even)
**per line**, then line totals are summed for the quote's totals. This
is the common French invoicing convention (as opposed to computing VAT
once on the grand total) and is documented here because it's the one
choice that would silently change every total if altered.

All amounts are ``Decimal``, never ``float`` — floating-point rounding
errors are unacceptable for money.
"""

from dataclasses import dataclass
from decimal import ROUND_HALF_UP, Decimal

_CENTS = Decimal("0.01")


def _round_amount(value: Decimal) -> Decimal:
    return value.quantize(_CENTS, rounding=ROUND_HALF_UP)


@dataclass
class LineTotals:
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal


@dataclass
class QuoteTotals:
    total_ht: Decimal
    total_vat: Decimal
    total_ttc: Decimal


@dataclass
class VatBucket:
    """One row of the per-rate VAT summary a French document must carry."""

    rate: Decimal
    base_ht: Decimal
    vat_amount: Decimal


class QuoteCalculator:
    def calculate_line(
        self, *, quantity: Decimal, unit_price_ht: Decimal, vat_rate: Decimal
    ) -> LineTotals:
        total_ht = _round_amount(quantity * unit_price_ht)
        total_vat = _round_amount(total_ht * vat_rate / Decimal("100"))
        total_ttc = total_ht + total_vat
        return LineTotals(total_ht=total_ht, total_vat=total_vat, total_ttc=total_ttc)

    def calculate_quote(self, lines: list[LineTotals]) -> QuoteTotals:
        total_ht = sum((line.total_ht for line in lines), Decimal("0.00"))
        total_vat = sum((line.total_vat for line in lines), Decimal("0.00"))
        total_ttc = total_ht + total_vat
        return QuoteTotals(total_ht=total_ht, total_vat=total_vat, total_ttc=total_ttc)

    def calculate_vat_breakdown(
        self, lines: list[tuple[Decimal, Decimal, Decimal]]
    ) -> list[VatBucket]:
        """Group already-computed line amounts by VAT rate.

        ``lines`` is ``(vat_rate, total_ht, total_vat)`` per line — amounts
        this class already produced. Nothing new is computed from prices
        here: this only sums, which is why it lives in this file rather
        than in the PDF engine that needs it. A document is required to
        show what part of its VAT sits at each rate, and that summary is a
        monetary figure like any other — the moment it were derived
        anywhere else, "amounts are only computed here" would stop being
        true.

        Sorted by rate ascending, so a document's summary reads the same
        way every time regardless of the order lines were entered.
        """
        by_rate: dict[Decimal, VatBucket] = {}
        for vat_rate, total_ht, total_vat in lines:
            bucket = by_rate.get(vat_rate)
            if bucket is None:
                by_rate[vat_rate] = VatBucket(
                    rate=vat_rate, base_ht=total_ht, vat_amount=total_vat
                )
            else:
                bucket.base_ht += total_ht
                bucket.vat_amount += total_vat
        return [by_rate[rate] for rate in sorted(by_rate)]
