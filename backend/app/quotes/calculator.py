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


@dataclass
class DiscountedTotals:
    """A quote's totals once a global HT discount has been applied.

    ``subtotal_*`` is the gross (sum of the lines, before discount); ``net_*``
    is after. The VAT is recomputed per rate on the discounted base, so
    ``vat_rows`` is the *net* per-rate summary the document prints.
    """

    subtotal_ht: Decimal
    subtotal_vat: Decimal
    subtotal_ttc: Decimal
    discount_amount: Decimal
    net_ht: Decimal
    net_vat: Decimal
    net_ttc: Decimal
    vat_rows: list[VatBucket]


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

    def resolve_amount(
        self, *, adjustment_type: str | None, value: Decimal, base: Decimal
    ) -> Decimal:
        """Resolve a discount/deposit parameter to a euro amount.

        A ``percent`` is applied to ``base`` and rounded to the cent; an
        ``amount`` is taken as the euro figure it already is; ``None`` means no
        adjustment. Resolving a percentage is a monetary computation, so it
        lives here and never in a caller (décision 3).
        """
        if adjustment_type is None:
            return Decimal("0.00")
        if adjustment_type == "percent":
            return _round_amount(base * value / Decimal("100"))
        return _round_amount(value)

    def apply_discount(
        self,
        lines: list[tuple[Decimal, Decimal, Decimal]],
        *,
        discount_type: str | None,
        discount_value: Decimal,
    ) -> DiscountedTotals:
        """Apply a global HT discount and recompute VAT per rate.

        ``lines`` is ``(vat_rate, total_ht, total_vat)`` per line — the same
        already-computed amounts :meth:`calculate_vat_breakdown` takes. The
        discount is spread across the VAT buckets in proportion to each bucket's
        HT, and the **last bucket absorbs the rounding residual** so the parts
        sum back to exactly the discount. VAT is then re-derived on each
        bucket's discounted base. Every euro is recomputed from the line inputs
        — nothing is trusted from outside.
        """
        buckets = self.calculate_vat_breakdown(lines)
        subtotal_ht = sum((b.base_ht for b in buckets), Decimal("0.00"))
        subtotal_vat = sum((b.vat_amount for b in buckets), Decimal("0.00"))

        discount_amount = self.resolve_amount(
            adjustment_type=discount_type, value=discount_value, base=subtotal_ht
        )
        # Never discount more than there is (defence in depth — the service also
        # rejects an over-large amount with a 422 before reaching here).
        if discount_amount > subtotal_ht:
            discount_amount = subtotal_ht

        net_rows: list[VatBucket] = []
        allocated = Decimal("0.00")
        for index, bucket in enumerate(buckets):
            is_last = index == len(buckets) - 1
            if is_last:
                bucket_discount = discount_amount - allocated
            elif subtotal_ht > 0:
                bucket_discount = _round_amount(
                    discount_amount * bucket.base_ht / subtotal_ht
                )
                allocated += bucket_discount
            else:
                bucket_discount = Decimal("0.00")
            net_base = bucket.base_ht - bucket_discount
            net_vat = _round_amount(net_base * bucket.rate / Decimal("100"))
            net_rows.append(
                VatBucket(rate=bucket.rate, base_ht=net_base, vat_amount=net_vat)
            )

        net_ht = subtotal_ht - discount_amount
        net_vat = sum((row.vat_amount for row in net_rows), Decimal("0.00"))
        return DiscountedTotals(
            subtotal_ht=subtotal_ht,
            subtotal_vat=subtotal_vat,
            subtotal_ttc=subtotal_ht + subtotal_vat,
            discount_amount=discount_amount,
            net_ht=net_ht,
            net_vat=net_vat,
            net_ttc=net_ht + net_vat,
            vat_rows=net_rows,
        )

    def apply_deposit(
        self, net_ttc: Decimal, *, deposit_type: str | None, deposit_value: Decimal
    ) -> tuple[Decimal, Decimal]:
        """Split the net TTC into ``(deposit, balance)``. A deposit changes no
        total — it is only how the net TTC is to be paid. Returns euro amounts;
        the deposit is capped at the net TTC (the service rejects an over-large
        one with a 422 first)."""
        deposit_amount = self.resolve_amount(
            adjustment_type=deposit_type, value=deposit_value, base=net_ttc
        )
        if deposit_amount > net_ttc:
            deposit_amount = net_ttc
        return deposit_amount, net_ttc - deposit_amount
