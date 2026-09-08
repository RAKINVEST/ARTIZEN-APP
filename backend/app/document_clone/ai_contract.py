"""The Brique 5 contract — the frozen input/output shape of the *single* AI call
the clone pipeline ever makes, written **before** the AI so the rest of the
engine never has to move when it lands.

The division of labour, per the product invariant: the AI **understands, it
never draws**. Given the raw positioned blocks that structural extraction
(Brique 4) pulls out of a native PDF, its only job is to say *what each block
is* — this run of text is the company name, that one is a table header, these
four columns are Désignation / Qté / PU / Montant, this figure is the Total TTC.
It assigns **roles**; it invents no coordinates, no amounts, no VAT. One call,
at import time. Everything downstream — turning that understanding into a
``.artizen`` business layer, then rendering every future document — is **100 %
deterministic** and costs nothing per document.

Because the seam is a plain data contract:

    ExtractionBlocks  --(AIEnricher.enrich)-->  SemanticStructure
    SemanticStructure --(assemble_business_layer, deterministic)--> BusinessLayer

the day a real enricher replaces :class:`MockAIEnricher`, **nothing else in the
engine changes**. :func:`assemble_business_layer` already consumes the contract
today, with zero AI, which is the proof the seam holds.
"""

from enum import Enum
from typing import Protocol

from pydantic import BaseModel, Field

from app.document_clone.artizen_format import (
    BusinessLayer,
    CalcMethod,
    CalcRule,
    DocumentType,
    FieldBinding,
    Rect,
    SectionPresence,
    TextStyle,
)


# ----------------------------------------------------------------- Input contract
class RawBlockKind(str, Enum):
    TEXT = "text"
    IMAGE = "image"
    SHAPE = "shape"


class RawBlock(BaseModel):
    """One positioned element as structural extraction found it — geometry and
    style, but **no meaning yet**. The AI's input; the AI's job is to add the
    meaning."""

    id: int
    #: 0-based index of the source page within the document's pages — the same
    #: ordering the rest of the engine uses (``GraphicLayer.pages``, the renderer's
    #: ``enumerate(pages)``, the comparator). Producers set it explicitly; the
    #: default suits single-page inputs (all blocks on page 0).
    page: int = 0
    kind: RawBlockKind = RawBlockKind.TEXT
    text: str = ""
    rect: Rect
    font: str = ""
    size: float = 0.0
    color: str = "#000000"
    bold: bool = False


class ExtractionBlocks(BaseModel):
    """Everything the deterministic reader extracted — the whole input handed to
    the one AI call, self-contained and serialisable."""

    document_type: DocumentType = DocumentType.DEVIS
    page_count: int = 1
    blocks: list[RawBlock] = Field(default_factory=list)


# ---------------------------------------------------------------- Output contract
class FieldRole(str, Enum):
    """What a block *is*. Roles carrying a canonical ``field`` path become
    variable bindings in the ``.artizen``; the rest inform section presence."""

    COMPANY_NAME = "company.name"
    COMPANY_ADDRESS = "company.address"
    COMPANY_SIRET = "company.siret"
    CLIENT_NAME = "client.name"
    CLIENT_ADDRESS = "client.address"
    WORKSITE_ADDRESS = "worksite.address"
    DOC_NUMBER = "doc.number"
    DOC_DATE = "doc.date"
    VALID_UNTIL = "doc.valid_until"
    TABLE_HEADER = "table.header"
    TOTAL_HT = "totals.ht"
    TOTAL_VAT = "totals.vat"
    TOTAL_TTC = "totals.ttc"
    DEPOSIT = "totals.deposit"
    RESTE_A_PAYER = "totals.reste"
    IBAN = "payment.iban"
    BIC = "payment.bic"
    SIGNATURE = "signature"
    LEGAL = "legal"
    FOOTER = "footer"
    FIXED_LABEL = "fixed_label"  # a static label, reproduced verbatim


#: Roles whose block is a variable zone → a FieldBinding (``field`` = the role's
#: value). Roles absent here (SIGNATURE, LEGAL, FOOTER, FIXED_LABEL, TABLE_HEADER)
#: are structural, not bound.
_BOUND_ROLES = {
    FieldRole.COMPANY_NAME, FieldRole.COMPANY_ADDRESS, FieldRole.COMPANY_SIRET,
    FieldRole.CLIENT_NAME, FieldRole.CLIENT_ADDRESS, FieldRole.WORKSITE_ADDRESS,
    FieldRole.DOC_NUMBER, FieldRole.DOC_DATE, FieldRole.VALID_UNTIL,
    FieldRole.TOTAL_HT, FieldRole.TOTAL_VAT, FieldRole.TOTAL_TTC,
    FieldRole.DEPOSIT, FieldRole.RESTE_A_PAYER, FieldRole.IBAN, FieldRole.BIC,
}


#: Bound roles that sit BELOW the table (the totals block). Flagged so reflow keeps
#: them with the table's last page instead of leaving them behind (P2.4).
_AFTER_TABLE_ROLES = {
    FieldRole.TOTAL_HT, FieldRole.TOTAL_VAT, FieldRole.TOTAL_TTC,
    FieldRole.DEPOSIT, FieldRole.RESTE_A_PAYER,
}


class BlockRole(BaseModel):
    block_id: int
    role: FieldRole
    confidence: float = 0.0  # 0..1, the AI's certainty for this assignment


class ColumnMapping(BaseModel):
    """One table column, understood: which header block, and the canonical key
    the renderer feeds rows from."""

    block_id: int
    key: str    # designation | qty | unit | pu_ht | remise | vat | total_ht
    label: str


class SemanticStructure(BaseModel):
    """The AI's understanding — the single output of the enrichment call. It maps
    straight onto the ``.artizen`` business + behavioural layers, deterministically."""

    document_type: DocumentType = DocumentType.DEVIS
    roles: list[BlockRole] = Field(default_factory=list)
    columns: list[ColumnMapping] = Field(default_factory=list)
    sections: SectionPresence = Field(default_factory=SectionPresence)
    calc_rules: list[CalcRule] = Field(default_factory=list)
    line_discount: bool = False
    deposits: bool = False
    confidence: float = 0.0  # 0..1, overall


class AIEnricher(Protocol):
    """The one seam the real model plugs into. A single method, so swapping the
    mock for a real enricher touches nothing else — the factory pattern the rest
    of the app already uses for AIProvider and storage.

    ``enrich`` is async: the real enricher issues an ``AIProvider.complete`` call,
    which is async across every provider, so the seam is async end to end. The
    offline mock is trivially async too."""

    async def enrich(self, blocks: ExtractionBlocks) -> SemanticStructure: ...


class MockAIEnricher:
    """Deterministic, offline stub — the fallback when no API key is set, exactly
    like ``MockAIProvider``. It returns a valid, empty-but-well-formed structure
    so the whole pipeline runs end-to-end with no model and no network: the app
    must always start and always answer, per the provider-abstraction rule."""

    async def enrich(self, blocks: ExtractionBlocks) -> SemanticStructure:
        return SemanticStructure(
            document_type=blocks.document_type,
            calc_rules=[
                CalcRule(target="total_ht", method=CalcMethod.SUM_LINES_HT),
                CalcRule(target="total_vat", method=CalcMethod.VAT_PER_LINE_HALF_UP),
                CalcRule(target="total_ttc", method=CalcMethod.TTC_HT_PLUS_VAT),
            ],
            confidence=0.0,
        )


def assemble_business_layer(
    blocks: ExtractionBlocks, semantics: SemanticStructure
) -> BusinessLayer:
    """Turn the AI's understanding into a ``.artizen`` business layer — **purely
    and deterministically**, no AI involved. Each bound role becomes a
    :class:`FieldBinding` at its block's own coordinates and style; the recognised
    sections carry straight through. This function existing *now*, consuming the
    contract with a mock, is what guarantees the real AI is a drop-in later."""
    by_id = {b.id: b for b in blocks.blocks}
    fields: list[FieldBinding] = []
    for r in semantics.roles:
        if r.role not in _BOUND_ROLES:
            continue
        block = by_id.get(r.block_id)
        if block is None:
            continue
        fields.append(
            FieldBinding(
                field=r.role.value,
                page=block.page,  # keep the field's source page (P2.2)
                after_table=r.role in _AFTER_TABLE_ROLES,  # totals follow the table (P2.4)
                rect=block.rect,
                style=TextStyle(
                    font=block.font or "Exo 2",
                    size=block.size or 9.0,
                    color=block.color or "#1E293B",
                    bold=block.bold,
                ),
            )
        )
    return BusinessLayer(fields=fields, sections=semantics.sections)
