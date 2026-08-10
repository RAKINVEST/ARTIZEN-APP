"""Unit tests for the discount/deposit calculator logic (V1.1 #3).

Pure ``Decimal`` maths, no DB: a global HT discount recomputes VAT per rate,
is spread proportionally across the VAT buckets with the last bucket absorbing
the rounding residual (so the parts sum back to exactly the discount), and the
deposit only splits the net TTC without changing any total.
"""

from decimal import Decimal

from app.quotes.calculator import QuoteCalculator

calc = QuoteCalculator()


def _lines(*triples: tuple[str, str, str]) -> list[tuple[Decimal, Decimal, Decimal]]:
    return [(Decimal(r), Decimal(ht), Decimal(v)) for r, ht, v in triples]


def test_no_discount_net_equals_gross() -> None:
    d = calc.apply_discount(
        _lines(("20.00", "100.00", "20.00")), discount_type=None, discount_value=Decimal("0")
    )
    assert d.discount_amount == Decimal("0.00")
    assert d.net_ht == Decimal("100.00")
    assert d.net_vat == Decimal("20.00")
    assert d.net_ttc == Decimal("120.00")


def test_percent_discount_recomputes_vat() -> None:
    # 20% rate, HT 100, 10% discount -> net HT 90, VAT 18, TTC 108.
    d = calc.apply_discount(
        _lines(("20.00", "100.00", "20.00")),
        discount_type="percent",
        discount_value=Decimal("10"),
    )
    assert d.discount_amount == Decimal("10.00")
    assert d.net_ht == Decimal("90.00")
    assert d.net_vat == Decimal("18.00")
    assert d.net_ttc == Decimal("108.00")


def test_amount_discount() -> None:
    d = calc.apply_discount(
        _lines(("20.00", "100.00", "20.00")),
        discount_type="amount",
        discount_value=Decimal("25.00"),
    )
    assert d.discount_amount == Decimal("25.00")
    assert d.net_ht == Decimal("75.00")
    assert d.net_vat == Decimal("15.00")
    assert d.net_ttc == Decimal("90.00")


def test_multi_rate_proportional_allocation() -> None:
    # 20% on HT 100, 10% on HT 300 ; subtotal 400 ; 10% discount = 40.
    # Net HT 360 ; VAT = 18 (on 90) + 27 (on 270) = 45.
    lines = _lines(("20.00", "100.00", "20.00"), ("10.00", "300.00", "30.00"))
    d = calc.apply_discount(lines, discount_type="percent", discount_value=Decimal("10"))
    assert d.discount_amount == Decimal("40.00")
    assert sum(b.base_ht for b in d.vat_rows) == Decimal("360.00")
    assert d.net_ht == Decimal("360.00")
    assert d.net_vat == Decimal("45.00")
    assert d.net_ttc == Decimal("405.00")


def test_residual_is_absorbed_so_parts_sum_to_the_discount() -> None:
    # Three rates whose proportional shares don't divide cleanly: the sum of the
    # per-rate discounts must still equal the global discount exactly.
    lines = _lines(
        ("20.00", "33.33", "6.67"),
        ("10.00", "33.33", "3.33"),
        ("5.50", "33.34", "1.83"),
    )
    d = calc.apply_discount(lines, discount_type="percent", discount_value=Decimal("10"))
    gross = calc.calculate_vat_breakdown(lines)
    per_rate = [o.base_ht - n.base_ht for o, n in zip(gross, d.vat_rows)]
    assert sum(per_rate) == d.discount_amount
    assert d.net_ht == d.subtotal_ht - d.discount_amount


def test_discount_capped_at_subtotal() -> None:
    d = calc.apply_discount(
        _lines(("20.00", "100.00", "20.00")),
        discount_type="amount",
        discount_value=Decimal("500.00"),
    )
    assert d.discount_amount == Decimal("100.00")
    assert d.net_ht == Decimal("0.00")
    assert d.net_vat == Decimal("0.00")
    assert d.net_ttc == Decimal("0.00")


def test_deposit_percent_and_balance() -> None:
    deposit, balance = calc.apply_deposit(
        Decimal("108.00"), deposit_type="percent", deposit_value=Decimal("30")
    )
    assert deposit == Decimal("32.40")
    assert balance == Decimal("75.60")


def test_deposit_amount_and_balance() -> None:
    deposit, balance = calc.apply_deposit(
        Decimal("108.00"), deposit_type="amount", deposit_value=Decimal("50.00")
    )
    assert deposit == Decimal("50.00")
    assert balance == Decimal("58.00")


def test_no_deposit_keeps_full_balance() -> None:
    deposit, balance = calc.apply_deposit(
        Decimal("108.00"), deposit_type=None, deposit_value=Decimal("0")
    )
    assert deposit == Decimal("0.00")
    assert balance == Decimal("108.00")


def test_deposit_capped_at_net_ttc() -> None:
    deposit, balance = calc.apply_deposit(
        Decimal("108.00"), deposit_type="amount", deposit_value=Decimal("999.00")
    )
    assert deposit == Decimal("108.00")
    assert balance == Decimal("0.00")
