"""Adapter — ``ArtizenTemplate`` → ``ExtractionBlocks`` (deterministic, no AI).

The pure geometry→contract seam between structural extraction (Brique 4, which
produces an :class:`ArtizenTemplate`) and the one AI enrichment call (Brique 5,
which consumes :class:`ExtractionBlocks`). It flattens the graphic layer's
positioned text and image elements into ``RawBlock`` s, preserving reading order
(the order extraction produced), text, rect, font, size, colour and weight. It
interprets nothing — meaning is the enricher's job.

The block-id convention lives here, in :func:`iter_blocks`, and is the **single
source of truth** shared with :mod:`app.document_clone.assembler` (which maps ids
back to the elements it removes). Adapter and assembler therefore can never drift.

P2 debt (documented, not worked around): ``RawBlock`` carries no page number, so
on a multi-page document the blocks are one flat list and page boundaries are
implicit. Enough for document-wide role assignment and single-page assembly;
faithful multi-page field/table placement needs a contract evolution
(``page`` on ``RawBlock``) — see the engine's UNKNOWNS/dette P2.
"""

from collections.abc import Iterator

from app.document_clone.ai_contract import ExtractionBlocks, RawBlock, RawBlockKind
from app.document_clone.artizen_format import ArtizenTemplate, GraphicPage


def page_list(template: ArtizenTemplate) -> list[GraphicPage]:
    """The template's pages. A flat (legacy, single-page) graphic layer is treated
    as one implicit page — the same rule the renderer applies."""
    g = template.graphic
    return g.pages or [
        GraphicPage(
            page=g.page,
            fixed_texts=g.fixed_texts,
            shapes=g.shapes,
            images=g.images,
            table=g.table,
        )
    ]


def iter_blocks(
    template: ArtizenTemplate,
) -> Iterator[tuple[int, int, RawBlockKind, object]]:
    """Yield ``(block_id, page_index, kind, element)`` in the canonical order:
    per page, every fixed text (in order) then every image. This IS the id
    convention — both :func:`artizen_to_blocks` and the assembler consume it, so
    a block id always maps back to the same element.

    Shapes are intentionally not surfaced: they carry no text and no semantic role
    to assign, and the deterministic renderer reproduces them from the graphic
    layer directly.
    """
    bid = 0
    for page_index, page in enumerate(page_list(template)):
        for fixed_text in page.fixed_texts:
            yield bid, page_index, RawBlockKind.TEXT, fixed_text
            bid += 1
        for image in page.images:
            yield bid, page_index, RawBlockKind.IMAGE, image
            bid += 1


def artizen_to_blocks(template: ArtizenTemplate) -> ExtractionBlocks:
    """Flatten ``template`` into the enricher's input contract, id-ordered."""
    blocks: list[RawBlock] = []
    for bid, _page_index, kind, element in iter_blocks(template):
        if kind is RawBlockKind.TEXT:
            blocks.append(
                RawBlock(
                    id=bid,
                    kind=RawBlockKind.TEXT,
                    text=element.text,
                    rect=element.rect,
                    font=element.style.font,
                    size=element.style.size,
                    color=element.style.color,
                    bold=element.style.bold,
                )
            )
        else:  # IMAGE
            blocks.append(
                RawBlock(
                    id=bid,
                    kind=RawBlockKind.IMAGE,
                    text="",
                    rect=element.rect,
                    font="",
                    size=0.0,
                    color="#000000",
                    bold=False,
                )
            )
    return ExtractionBlocks(
        document_type=template.document_type,
        page_count=len(page_list(template)),
        blocks=blocks,
    )
