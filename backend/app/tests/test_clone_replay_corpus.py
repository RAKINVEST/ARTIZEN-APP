"""End-to-end replay on the real native devis corpus.

    ORIGINAL PDF → extraction → adapter → stand-in semantics → assemble
        → replay of the ORIGINAL data → renderer → comparator vs ORIGINAL.

The stand-in semantics are hand-pinned to each PDF's real blocks (every pin
asserts the block's real text) — NOT a real AIEnricher, and no data is fabricated.
They exist to exercise the deterministic chain with a correct semantic input while
no ANTHROPIC_API_KEY is available.

``Corpus/inbox`` is gitignored private client data, so every test skips when its
PDF is absent (it runs locally / in Docker, where the corpus is present). The
assertion is non-regression: variabilising + replaying the original data must
reproduce the document as well as the untouched as-is baseline.
"""

from pathlib import Path

import pytest

from app.document_clone.adapter import artizen_to_blocks
from app.document_clone.ai_contract import (
    BlockRole,
    ColumnMapping,
    FieldRole,
    SemanticStructure,
    assemble_business_layer,
)
from app.document_clone.artizen_format import Rect, SectionPresence
from app.document_clone.assembler import (
    _bound_block_ids,
    assemble_artizen,
    extract_original_rows,
    table_geometry,
)
from app.document_clone.comparator import compare_pdfs
from app.document_clone.extraction.pdf_extractor import extract
from app.document_clone.renderer import render_artizen

CORPUS = Path(__file__).resolve().parents[2] / "Corpus" / "inbox"
TOL = 0.5  # points of overall fidelity allowed below the as-is baseline

R = FieldRole
# (role, block_id, expected text substring)
PNEU_ROLES = [
    (R.COMPANY_NAME, 0, "LAGUZOU"), (R.CLIENT_NAME, 1, "SYLVIO"),
    (R.DOC_NUMBER, 14, "1015958"), (R.DOC_DATE, 15, "14/06/2024"),
    (R.TOTAL_HT, 80, "034,63"), (R.TOTAL_VAT, 81, "206,93"), (R.TOTAL_TTC, 82, "241,56"),
]
# (block_id, key, expected header substring)
PNEU_COLS = [
    (18, "qty", "Quantité"), (19, "designation", "Désignation"), (20, "prix_brut", "Prix"),
    (21, "remise", "Remise"), (22, "prix_net", "Prix"), (23, "total_ht", "Montant"), (24, "vat", "tva"),
]
PNEU_REGION = Rect(x=16.0, y=308.0, w=552.0, h=82.0)

# Multi-page docs: page-0 field path only (multi-page tables need RawBlock.page — P2).
FIELD_ONLY = {
    "chapot.pdf": [(R.COMPANY_NAME, 4, "CHAPOT"), (R.DOC_NUMBER, 18, "2025000250"),
                   (R.DOC_DATE, 21, "24/10/2025")],
    "poele.pdf": [(R.DOC_NUMBER, 104, "DC24_02055"), (R.DOC_DATE, 105, "09/12/2024"),
                  (R.VALID_UNTIL, 103, "08/01/2025")],
    "sje.pdf": [(R.COMPANY_NAME, 0, "SJE"), (R.DOC_NUMBER, 8, "D-25/10-01123")],
}


def _require(name: str) -> bytes:
    pdf = CORPUS / name
    if not pdf.exists():
        pytest.skip(f"corpus PDF absent (gitignored private data): {pdf}")
    return pdf.read_bytes()


def _pin_roles(pins, by_id) -> list[BlockRole]:
    roles = []
    for role, bid, expect in pins:
        block = by_id.get(bid)
        assert block is not None, f"stand-in id {bid} for {role.value} not found — corpus drift?"
        assert expect.lower() in block.text.lower(), (
            f"stand-in id {bid} expected ~{expect!r} got {block.text!r} — corpus drift?")
        roles.append(BlockRole(block_id=bid, role=role, confidence=1.0))
    return roles


def _replay_fields(semantics, business, by_id) -> dict[str, str]:
    field_paths = {f.field for f in business.fields}
    return {r.role.value: by_id[r.block_id].text
            for r in semantics.roles if r.role.value in field_paths}


def test_replay_pneu_full_chain_no_regression() -> None:
    original = _require("pneu.pdf")
    template = extract(original)
    blocks = artizen_to_blocks(template)
    by_id = {b.id: b for b in blocks.blocks}

    columns = []
    for bid, key, expect in PNEU_COLS:
        assert expect.lower() in by_id[bid].text.lower(), f"col {key} drift at id {bid}"
        columns.append(ColumnMapping(block_id=bid, key=key, label=by_id[bid].text))
    semantics = SemanticStructure(
        roles=_pin_roles(PNEU_ROLES, by_id), columns=columns,
        sections=SectionPresence(logo=True, company=True, client=True, table=True,
                                 vat=True, totals=True, footer=True),
        line_discount=True, confidence=1.0,
    )

    business = assemble_business_layer(blocks, semantics)
    bound = _bound_block_ids(semantics, business)
    _first, rh = table_geometry(blocks, PNEU_REGION, bound)
    fields = _replay_fields(semantics, business, by_id)
    rows = extract_original_rows(blocks, semantics, PNEU_REGION, bound, rh)

    art = assemble_artizen(template, blocks, semantics, table_region=PNEU_REGION)
    baseline = compare_pdfs(original, render_artizen(template, {}, []))
    p1 = compare_pdfs(original, render_artizen(art, fields, rows))

    # the whole chain exercised: 7 fields, 7 columns, 5 rows, correctly split
    assert len(fields) == 7
    assert len(art.graphic.pages[0].table.columns) == 7
    assert len(rows) == 5
    assert rows[0]["designation"] == "CREMAILLERE DIRECTION REF"
    assert rows[0]["qty"] == "1"
    # non-regression vs the as-is baseline
    assert p1.text_recall >= baseline.text_recall - 0.1
    assert p1.overall >= baseline.overall - TOL


@pytest.mark.parametrize("name", sorted(FIELD_ONLY))
def test_replay_multipage_field_path_no_regression(name: str) -> None:
    original = _require(name)
    template = extract(original)
    blocks = artizen_to_blocks(template)
    by_id = {b.id: b for b in blocks.blocks}
    page0_count = len(template.graphic.pages[0].fixed_texts)

    pins = [(role, bid, expect) for role, bid, expect in FIELD_ONLY[name] if bid < page0_count]
    assert pins, f"{name}: no page-0 field pins"
    semantics = SemanticStructure(roles=_pin_roles(pins, by_id),
                                  sections=SectionPresence(company=True), confidence=1.0)

    business = assemble_business_layer(blocks, semantics)
    fields = _replay_fields(semantics, business, by_id)
    art = assemble_artizen(template, blocks, semantics)  # field path only, no table

    before = sum(len(p.fixed_texts) for p in template.graphic.pages)
    after = sum(len(p.fixed_texts) for p in art.graphic.pages)
    assert before - after == len(fields)  # exactly the bound fields removed

    baseline = compare_pdfs(original, render_artizen(template, {}, []))
    p1 = compare_pdfs(original, render_artizen(art, fields, []))
    assert p1.text_recall >= baseline.text_recall - 0.1
    assert p1.overall >= baseline.overall - TOL
