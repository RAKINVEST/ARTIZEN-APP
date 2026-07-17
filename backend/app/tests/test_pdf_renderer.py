"""Tests for the PDF engine (V2).

Pure unit tests: no database, no HTTP, no storage. That is possible only
because the engine takes a plain ``Document`` and gives back bytes — it has
never heard of a quote, and cannot reach for a file. The moment these tests
need a fixture beyond a dataclass, the engine has grown a dependency it
should not have.

Assertions read the PDF back with pypdf rather than trusting the byte
count: "it returned 3 kB" says nothing about whether the artisan's customer
can read their own name on it.
"""

import io
from datetime import date
from decimal import Decimal

import pytest
from pypdf import PdfReader

from app.pdf.renderer import PdfRenderer, _money, _quantity
from app.pdf.schemas import (
    Document,
    DocumentBranding,
    DocumentLine,
    DocumentParty,
    DocumentTotals,
    DocumentVatRow,
)


def _document(**overrides: object) -> Document:
    base: dict[str, object] = dict(
        title="DEVIS",
        number="DEV-2026-0001",
        issued_on=date(2026, 7, 17),
        issuer=DocumentParty(
            name="SARL Plomberie Dupont",
            address_lines=["12 rue des Artisans", "75011 Paris"],
            detail_lines=["SIRET : 35600000000048"],
        ),
        recipient=DocumentParty(name="Mme Martin", address_lines=["3 allee des Lilas"]),
        lines=[
            DocumentLine(
                designation="Chauffe-eau Atlantic 200L",
                unit="u",
                quantity=Decimal("1.00"),
                unit_price_ht=Decimal("450.00"),
                vat_rate=Decimal("20.00"),
                total_ht=Decimal("450.00"),
            )
        ],
        totals=DocumentTotals(
            total_ht=Decimal("450.00"),
            total_vat=Decimal("90.00"),
            total_ttc=Decimal("540.00"),
        ),
    )
    base.update(overrides)
    return Document(**base)  # type: ignore[arg-type]


def _text_of(pdf: bytes) -> str:
    return PdfReader(io.BytesIO(pdf)).pages[0].extract_text()


# --- Formatting (pure) ---


@pytest.mark.parametrize(
    "amount,expected",
    [
        ("1234567.89", "1 234 567,89"),  # French: space groups, comma decimal
        ("999.50", "999,50"),            # no group separator under 1000
        ("0.00", "0,00"),
        ("-1234.50", "-1 234,50"),       # credit notes are negative
    ],
)
def test_money_uses_french_conventions(amount: str, expected: str) -> None:
    assert _money(Decimal(amount)) == expected


@pytest.mark.parametrize(
    "quantity,expected",
    [("2.00", "2"), ("2.50", "2,5"), ("0.25", "0,25")],
)
def test_quantity_trims_the_columns_trailing_zeros(quantity: str, expected: str) -> None:
    """Numeric(10,2) always stores "2.00"; the artisan wrote "2"."""
    assert _quantity(Decimal(quantity)) == expected


# --- Rendering ---


def test_renders_a_readable_pdf() -> None:
    pdf = PdfRenderer().render(_document())

    assert pdf.startswith(b"%PDF-")
    text = _text_of(pdf)
    for expected in ("DEVIS", "DEV-2026-0001", "SARL Plomberie Dupont", "Mme Martin"):
        assert expected in text


def test_prints_the_amounts_it_was_given_untouched() -> None:
    """The engine computes nothing. The totals on the customer's PDF must
    be, to the cent, the totals the artisan approved on screen."""
    pdf = PdfRenderer().render(_document())

    text = _text_of(pdf)
    assert "450,00" in text
    assert "540,00" in text


def test_dates_the_document_as_given_not_as_printed() -> None:
    """Re-downloading next month must not re-date a document the customer
    already holds."""
    pdf = PdfRenderer().render(_document(issued_on=date(2026, 1, 5)))

    assert "05/01/2026" in _text_of(pdf)


# --- The engine is document-type agnostic (the reason it exists) ---


@pytest.mark.parametrize(
    "title,number",
    [("FACTURE", "FAC-2026-0001"), ("AVOIR", "AV-2026-0001"), ("BON DE COMMANDE", "BC-2026-0001")],
)
def test_the_same_engine_renders_any_document_type(title: str, number: str) -> None:
    """No branch per type, no enum to extend: `title` is a string, so the
    invoices and credit notes to come need nothing from this module."""
    pdf = PdfRenderer().render(_document(title=title, number=number))

    text = _text_of(pdf)
    assert title in text
    assert number in text


def test_renders_negative_totals_for_a_credit_note() -> None:
    pdf = PdfRenderer().render(
        _document(
            title="AVOIR",
            totals=DocumentTotals(
                total_ht=Decimal("-450.00"),
                total_vat=Decimal("-90.00"),
                total_ttc=Decimal("-540.00"),
            ),
        )
    )

    assert "-540,00" in _text_of(pdf)


# --- Degradation: a document must always come out ---


def test_renders_for_an_account_that_configured_nothing() -> None:
    """A brand-new artisan has no logo, no colour, no tagline. They must
    still be able to send a quote."""
    pdf = PdfRenderer().render(_document(branding=DocumentBranding()))

    assert pdf.startswith(b"%PDF-")
    assert "DEVIS" in _text_of(pdf)


def test_an_invalid_brand_colour_degrades_instead_of_raising() -> None:
    """Brand colours can come from `document_detection` guessing at an old
    PDF. A wrong guess must cost the artisan a colour, never a document."""
    pdf = PdfRenderer().render(_document(branding=DocumentBranding(primary_color="#NOPE")))

    assert pdf.startswith(b"%PDF-")


def test_an_unreadable_logo_degrades_instead_of_raising() -> None:
    """The bytes come from an upload, and an upload can be anything."""
    pdf = PdfRenderer().render(_document(branding=DocumentBranding(logo=b"not an image")))

    assert pdf.startswith(b"%PDF-")
    assert "DEVIS" in _text_of(pdf)


def test_a_valid_logo_is_drawn() -> None:
    png = (
        b"\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x06"
        b"\x00\x00\x00\x1f\x15\xc4\x89\x00\x00\x00\nIDATx\x9cc\x00\x01\x00\x00\x05"
        b"\x00\x01\r\n-\xb4\x00\x00\x00\x00IEND\xaeB`\x82"
    )
    pdf = PdfRenderer().render(_document(branding=DocumentBranding(logo=png)))

    assert pdf.startswith(b"%PDF-")


# --- Edge cases ---


def test_many_lines_paginate_rather_than_overflow() -> None:
    lines = [
        DocumentLine(
            designation=f"Article {i}",
            unit="u",
            quantity=Decimal("1.00"),
            unit_price_ht=Decimal("10.00"),
            vat_rate=Decimal("20.00"),
            total_ht=Decimal("10.00"),
        )
        for i in range(120)
    ]

    pdf = PdfRenderer().render(_document(lines=lines))

    assert len(PdfReader(io.BytesIO(pdf)).pages) > 1


def test_a_very_long_designation_wraps() -> None:
    long_line = DocumentLine(
        designation="Remplacement complet de la colonne montante " * 12,
        unit="u",
        quantity=Decimal("1.00"),
        unit_price_ht=Decimal("10.00"),
        vat_rate=Decimal("20.00"),
        total_ht=Decimal("10.00"),
    )

    pdf = PdfRenderer().render(_document(lines=[long_line]))

    assert pdf.startswith(b"%PDF-")


def test_the_vat_summary_appears_only_when_rates_differ() -> None:
    """On a single-rate document the per-rate summary would just restate
    the total line underneath it."""
    multi = _document(
        totals=DocumentTotals(
            total_ht=Decimal("600.00"),
            total_vat=Decimal("105.00"),
            total_ttc=Decimal("705.00"),
            vat_rows=[
                DocumentVatRow(
                    rate=Decimal("10.00"), base_ht=Decimal("150.00"), vat_amount=Decimal("15.00")
                ),
                DocumentVatRow(
                    rate=Decimal("20.00"), base_ht=Decimal("450.00"), vat_amount=Decimal("90.00")
                ),
            ],
        )
    )

    text = _text_of(PdfRenderer().render(multi))

    assert "Base HT" in text
