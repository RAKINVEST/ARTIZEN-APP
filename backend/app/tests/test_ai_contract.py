"""Tests for the Brique 5 AI contract.

The point of the contract is that the engine never moves when the real model
lands. So these pin: the input/output round-trip losslessly (they are stored
artefacts), the offline mock returns a valid structure (the app must always
answer with no key), and — the crux — the deterministic assembler turns an AI
output into a ``.artizen`` business layer with **zero AI**, placing each bound
field at its own block's coordinates. That last test *is* the proof the seam
holds: swap the mock for Claude and nothing here changes.
"""

from app.document_clone.ai_contract import (
    AIEnricher,
    BlockRole,
    ColumnMapping,
    ExtractionBlocks,
    FieldRole,
    MockAIEnricher,
    RawBlock,
    SemanticStructure,
    assemble_business_layer,
)
from app.document_clone.artizen_format import DocumentType, Rect


def _blocks() -> ExtractionBlocks:
    return ExtractionBlocks(
        document_type=DocumentType.DEVIS,
        page_count=1,
        blocks=[
            RawBlock(id=1, text="ARTIZEN PLOMBERIE", rect=Rect(x=45, y=36, w=250, h=18),
                     font="Exo 2", size=14, color="#140E55", bold=True),
            RawBlock(id=2, text="M. Dupont", rect=Rect(x=45, y=120, w=200, h=14), size=10),
            RawBlock(id=3, text="1 234,56", rect=Rect(x=480, y=700, w=70, h=14), size=11),
            RawBlock(id=4, text="Désignation", rect=Rect(x=40, y=200, w=200, h=12), size=9),
        ],
    )


def _semantics() -> SemanticStructure:
    return SemanticStructure(
        document_type=DocumentType.DEVIS,
        roles=[
            BlockRole(block_id=1, role=FieldRole.COMPANY_NAME, confidence=0.99),
            BlockRole(block_id=2, role=FieldRole.CLIENT_NAME, confidence=0.97),
            BlockRole(block_id=3, role=FieldRole.TOTAL_TTC, confidence=0.95),
            BlockRole(block_id=4, role=FieldRole.TABLE_HEADER, confidence=0.9),  # not bound
        ],
        columns=[ColumnMapping(block_id=4, key="designation", label="Désignation")],
        confidence=0.96,
    )


def test_contract_round_trips_losslessly() -> None:
    blocks = _blocks()
    semantics = _semantics()

    assert ExtractionBlocks.model_validate_json(blocks.model_dump_json()) == blocks
    assert SemanticStructure.model_validate_json(semantics.model_dump_json()) == semantics


async def test_mock_enricher_answers_offline() -> None:
    enricher: AIEnricher = MockAIEnricher()

    result = await enricher.enrich(_blocks())

    # A valid, well-formed structure with no model and no network.
    assert isinstance(result, SemanticStructure)
    assert result.document_type is DocumentType.DEVIS
    assert result.calc_rules  # sane default behaviour is carried
    assert result.confidence == 0.0  # the mock claims no certainty


def test_assembler_maps_roles_to_bindings_deterministically() -> None:
    business = assemble_business_layer(_blocks(), _semantics())

    bound = {f.field: f for f in business.fields}
    # Only the bound roles become fields; the table header does not.
    assert set(bound) == {"company.name", "client.name", "totals.ttc"}
    # Each field lands at its own block's coordinates and keeps its style.
    assert bound["company.name"].rect == Rect(x=45, y=36, w=250, h=18)
    assert bound["company.name"].style.color == "#140E55"
    assert bound["company.name"].style.bold is True
    assert bound["totals.ttc"].rect.x == 480


def test_assembler_is_pure_no_ai() -> None:
    """Same input → identical output, forever (deterministic downstream)."""
    a = assemble_business_layer(_blocks(), _semantics())
    b = assemble_business_layer(_blocks(), _semantics())
    assert a == b
