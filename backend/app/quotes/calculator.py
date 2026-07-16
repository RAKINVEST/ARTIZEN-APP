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
