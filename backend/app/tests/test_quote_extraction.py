"""Offline unit tests for the V2 quote-extraction engine.

No database, no network, no AI key — every test here runs on pure data
structures, so it validates the engine's *honesty contract* (never fabricate,
transcribe verbatim, fail loudly on gaps) independently of extraction quality,
which is a real-AI concern tested later against the corpus.
"""

from decimal import Decimal

import pytest

from app.ai.providers.mock_provider import MockAIProvider
from app.quote_extraction.exceptions import (
    ExtractionProviderUnavailableError,
    ExtractionResponseError,
    FabricatedDataError,
    IncompleteExtractionError,
)
from app.quote_extraction.extractor import QuoteExtractor, parse_extraction_json
from app.quote_extraction.guards import reject_fabricated_data
from app.quote_extraction.mapper import extracted_quote_to_document
from app.quote_extraction.prompt import build_extraction_messages
from app.quote_extraction.schemas import (
    ExtractedDates,
    ExtractedLine,
    ExtractedParty,
    ExtractedQuote,
    ExtractedTotals,
)


def _complete() -> ExtractedQuote:
    """A fully, realistically populated extraction (a real devis would look
    like this once read)."""
    return ExtractedQuote(
        document_title="DEVIS",
        number="2024-0187",
        dates=ExtractedDates(issued_on="2024-03-15", valid_until="2024-04-14"),
        issuer=ExtractedParty(name="Menuiserie Bernard", siret="12345678900012"),
        client=ExtractedParty(name="Mme Martin", phone="0601020304"),
        lines=[
            ExtractedLine(section_header=True, designation="Menuiserie"),
            ExtractedLine(
                designation="Fenêtre PVC 120x100",
                unit="u",
                quantity=Decimal("3"),
                unit_price_ht=Decimal("240.00"),
                vat_rate=Decimal("10"),
                total_ht=Decimal("720.00"),
            ),
        ],
        totals=ExtractedTotals(
            total_ht=Decimal("720.00"),
            total_vat=Decimal("72.00"),
            total_ttc=Decimal("792.00"),
        ),
    )


def test_default_extraction_invents_nothing() -> None:
    e = ExtractedQuote()
    assert e.number is None
    assert e.client.name is None
    assert e.lines == []
    assert e.totals.total_ttc is None
    assert e.extraction_confidence == 0.0


def test_mapper_builds_faithful_document() -> None:
    doc = extracted_quote_to_document(_complete())
    assert doc.number == "2024-0187"
    assert doc.issued_on.isoformat() == "2024-03-15"
    assert doc.recipient.name == "Mme Martin"
    assert doc.issuer.name == "Menuiserie Bernard"
    assert "SIRET 12345678900012" in doc.issuer.detail_lines
    # Section header row is NOT rendered as a fake numeric line.
    assert len(doc.lines) == 1
    assert doc.lines[0].designation == "Fenêtre PVC 120x100"
    assert doc.totals.total_ttc == Decimal("792.00")
    assert doc.show_vat is True


def test_mapper_transcribes_amounts_verbatim() -> None:
    # A line whose printed total does NOT equal quantity * unit_price must be
    # kept as printed — the reproduction matches the source, never recomputes.
    e = _complete()
    e.lines[1].total_ht = Decimal("700.00")  # printed override, != 3 * 240
    doc = extracted_quote_to_document(e)
    assert doc.lines[0].total_ht == Decimal("700.00")


def test_mapper_reports_missing_number_and_date() -> None:
    e = _complete()
    e.number = None
    e.dates.issued_on = None
    with pytest.raises(IncompleteExtractionError) as exc:
        extracted_quote_to_document(e)
    assert "numéro du devis" in exc.value.missing
    assert "date d'émission" in exc.value.missing


def test_mapper_reports_missing_line_amounts() -> None:
    e = _complete()
    e.lines[1].total_ht = None
    with pytest.raises(IncompleteExtractionError) as exc:
        extracted_quote_to_document(e)
    assert any("Fenêtre PVC" in m for m in exc.value.missing)


def test_mapper_parses_french_date_format() -> None:
    e = _complete()
    e.dates.issued_on = "15/03/2024"
    doc = extracted_quote_to_document(e)
    assert doc.issued_on.isoformat() == "2024-03-15"


def test_mapper_hides_vat_for_franchise() -> None:
    e = _complete()
    e.totals.total_vat = None
    e.totals.total_ttc = e.totals.total_ht
    doc = extracted_quote_to_document(e)
    assert doc.show_vat is False


@pytest.mark.parametrize(
    "field, value",
    [
        ("client_name", "Client Démonstration"),
        ("number", "DEV-2026-0001"),
        ("address", "10 rue de l'Exemple"),
        ("designation", "Fourniture et pose (exemple)"),
    ],
)
def test_guard_rejects_every_demo_literal(field: str, value: str) -> None:
    e = _complete()
    if field == "client_name":
        e.client.name = value
    elif field == "number":
        e.number = value
    elif field == "address":
        e.client.address.lines = [value]
    elif field == "designation":
        e.lines[1].designation = value
    with pytest.raises(FabricatedDataError):
        reject_fabricated_data(e)


def test_guard_passes_genuine_data() -> None:
    reject_fabricated_data(_complete())  # must not raise


def test_parse_json_tolerates_markdown_fence() -> None:
    raw = '```json\n{"number": "A-1", "extraction_confidence": 0.9}\n```'
    parsed = parse_extraction_json(raw)
    assert parsed.number == "A-1"


def test_parse_json_rejects_non_json() -> None:
    with pytest.raises(ExtractionResponseError):
        parse_extraction_json("désolé, je ne peux pas.")


def test_prompt_carries_the_never_invent_rule() -> None:
    messages = build_extraction_messages("Devis n° 2024-0187 …")
    system = next(m.content for m in messages if m.role == "system")
    assert "N'invente JAMAIS" in system
    assert "2024-0187" in messages[-1].content


def test_extractor_refuses_the_mock_provider() -> None:
    import asyncio

    extractor = QuoteExtractor(MockAIProvider())
    with pytest.raises(ExtractionProviderUnavailableError):
        asyncio.run(extractor.extract("Devis n° 2024-0187, Total TTC 792,00 €"))
