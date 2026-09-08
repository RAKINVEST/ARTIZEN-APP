"""Assembler — turn an AI (or stand-in) :class:`SemanticStructure` into a
variabilised ``.artizen`` template, then replay the document's own data.

Deterministic, **no AI**. Given the extracted template, the flattened blocks and
the semantic understanding, it:

* binds each recognised field to a :class:`FieldBinding` at the block's own
  coordinates and style (via :func:`assemble_business_layer`);
* builds a :class:`TableSpec` whose column geometry is inferred from the **body
  cells**, not the header positions — the P1 discovery: real devis headers are
  routinely misaligned from their cells (pneu: "Désignation" header at x154, its
  cells at x70), so the header only *identifies* a column while the body cells are
  the source of truth for x / width / alignment;
* removes the original ``FixedText`` that became variable (fields and table body
  cells), so nothing is drawn twice (anti double-draw);
* reads the document's own rows back out (:func:`extract_original_rows`) as the
  replay dataset — the exact original data, no fabrication.

Single-page today. Multi-page tables need the ``RawBlock.page`` contract evolution
(see :mod:`app.document_clone.adapter`); bound fields likewise render on page 0
only in the current renderer.
"""

from collections import Counter
from statistics import median, pstdev

from app.document_clone.adapter import iter_blocks, page_list
from app.document_clone.ai_contract import (
    _BOUND_ROLES,
    BlockRole,
    ExtractionBlocks,
    FieldRole,
    RawBlockKind,
    SemanticStructure,
    assemble_business_layer,
)
from app.document_clone.artizen_format import (
    ArtizenTemplate,
    BusinessLayer,
    FixedText,
    GraphicLayer,
    GraphicPage,
    HAlign,
    Rect,
    TableColumn,
    TableSpec,
    TextStyle,
)

_LEFT_KEYS = {"designation", "description", "reference", "libelle"}


def dedup_bound_roles(semantics: SemanticStructure) -> SemanticStructure:
    """Anti-collapse guard. A bound role holds ONE value per document (the
    FieldBinding model is one value per field path), so if the enricher assigned the
    same bound role to several blocks — e.g. company.address ×4, client.name ×2 —
    the replay's single value would overwrite the others and drop originals. Here,
    for each bound role only the best candidate keeps the binding; every other block
    is demoted to non-bound, so it stays a FixedText (unchanged coordinates, never
    removed, nothing invented).

    Only the contract's exact bound set (:data:`_BOUND_ROLES`) is deduped; the
    structural, legitimately repeated roles (TABLE_HEADER, FIXED_LABEL, FOOTER,
    LEGAL, SIGNATURE) and the columns pass through untouched. The tiebreak is
    deterministic and does NOT trust the enricher's response order: highest
    confidence first, then lowest block_id (reading order from extraction).
    """
    best: dict[FieldRole, BlockRole] = {}
    passthrough: list[BlockRole] = []
    for role in semantics.roles:
        if role.role not in _BOUND_ROLES:
            passthrough.append(role)
            continue
        incumbent = best.get(role.role)
        if incumbent is None or (role.confidence, -role.block_id) > (incumbent.confidence, -incumbent.block_id):
            best[role.role] = role
    kept = passthrough + list(best.values())
    return semantics.model_copy(update={"roles": kept})


def _bound_block_ids(semantics: SemanticStructure, business: BusinessLayer) -> set[int]:
    """Block ids that became bound fields — derived from the business layer the
    deterministic assembler already produced (public data, so no dependency on the
    contract's private bound-role set)."""
    field_paths = {fb.field for fb in business.fields}
    return {r.block_id for r in semantics.roles if r.role.value in field_paths}


def _in_region(rect: Rect, region: Rect) -> bool:
    cx, cy = rect.x + rect.w / 2.0, rect.y + rect.h / 2.0
    return (region.x <= cx <= region.x + region.w
            and region.y <= cy <= region.y + region.h)


def _body_cells(blocks: ExtractionBlocks, region: Rect, exclude_ids: set[int], page: int = 0):
    """Body cells of the table region ON A GIVEN SOURCE PAGE (P2.2). Scoping by
    ``page`` (not just the rect) stops two blocks that share a y-band across
    different pages from being merged into one physical table."""
    return [b for b in blocks.blocks
            if b.id not in exclude_ids and b.text and b.page == page and _in_region(b.rect, region)]


def _column_bands(body, gap_eps: float = 3.5) -> list[tuple[float, float]]:
    """Columns from the body cells by x-gap projection: union each cell's x-interval,
    starting a new band wherever a gap wider than ``gap_eps`` appears. Handles tables
    whose header labels are misaligned from their cells (pneu: the qty digits and the
    designation text sit only ~6pt apart yet are distinct columns)."""
    intervals = sorted((c.rect.x, c.rect.x + c.rect.w) for c in body)
    bands: list[list[float]] = []
    for x0, x1 in intervals:
        if bands and x0 - bands[-1][1] <= gap_eps:
            bands[-1][1] = max(bands[-1][1], x1)
        else:
            bands.append([x0, x1])
    return [(b[0], b[1]) for b in bands]


def _bands_to_keys(bands, blocks: ExtractionBlocks, semantics: SemanticStructure):
    """Map each body-derived band to the semantic key of the nearest header centre.
    The header identifies the column; the band supplies the geometry."""
    by_id = {b.id: b for b in blocks.blocks}
    headers = [
        (cm.key, cm.label, by_id[cm.block_id].rect.x + by_id[cm.block_id].rect.w / 2.0)
        for cm in semantics.columns
        if cm.block_id in by_id
    ]
    banded = []
    for x0, x1 in bands:
        cx = (x0 + x1) / 2.0
        if headers:
            key, label, _ = min(headers, key=lambda h: abs(h[2] - cx))
        else:
            key, label = None, None
        banded.append((x0, x1, key, label))
    return banded


def _assign_band(cx: float, banded):
    for x0, x1, key, _label in banded:
        if x0 - 1.0 <= cx <= x1 + 1.0:
            return key
    return min(banded, key=lambda b: abs((b[0] + b[1]) / 2.0 - cx))[2] if banded else None


def _body_text_style(body) -> TextStyle:
    """A body style that mirrors the original cells (most common font, median size),
    so the replayed rows keep the document's own typography rather than a guess."""
    fonts = [c.font for c in body if c.font]
    sizes = [c.size for c in body if c.size]
    font = Counter(fonts).most_common(1)[0][0] if fonts else "Helvetica"
    size = float(median(sizes)) if sizes else 10.0
    return TextStyle(font=font, size=size)


def _build_table_spec(body, banded, region: Rect, first_row_y: float, row_height: float, page: int = 0) -> TableSpec:
    """Column geometry inferred from the body cells; header labels left empty (the
    real header blocks stay fixed above). ``rect.y`` is set so the first data row
    lands at ``first_row_y`` — the renderer draws an empty header row at ``rect.y``
    then the rows below it."""
    buckets: dict[str, list] = {}
    for c in body:
        key = _assign_band(c.rect.x + c.rect.w / 2.0, banded)
        if key is not None:
            buckets.setdefault(key, []).append(c)
    columns = []
    for x0, x1, key, _label in banded:
        cells = buckets.get(key, [])
        band_w = max(10.0, x1 - x0)
        if not cells:
            columns.append(TableColumn(key=key, label="", x=x0, width=band_w, align=HAlign.RIGHT))
            continue
        lefts = [c.rect.x for c in cells]
        rights = [c.rect.x + c.rect.w for c in cells]
        left_var = pstdev(lefts) if len(lefts) > 1 else 0.0
        right_var = pstdev(rights) if len(rights) > 1 else 0.0
        if left_var <= right_var:  # consistent left edge → left aligned
            columns.append(TableColumn(key=key, label="", x=median(lefts), width=band_w, align=HAlign.LEFT))
        else:                      # consistent right edge → right aligned
            redge = median(rights)
            columns.append(TableColumn(key=key, label="", x=redge - band_w, width=band_w, align=HAlign.RIGHT))
    body_style = _body_text_style(body)
    rect = Rect(x=region.x, y=first_row_y - row_height, w=region.w, h=region.h + row_height)
    return TableSpec(
        rect=rect,
        page=page,  # source page of the table (P2.2)
        columns=columns,
        header_style=body_style.model_copy(update={"bold": True}),
        header_fill=None,
        body_style=body_style,
        row_height=row_height,
    )


def table_geometry(blocks: ExtractionBlocks, region: Rect, exclude_ids: set[int], page: int = 0) -> tuple[float | None, float]:
    """Derive ``(first_row_y, row_height)`` from the body cells of the given source
    page: the first row is the topmost cell, the row height the median vertical gap
    between rows. So a caller only ever has to point at the table region."""
    body = _body_cells(blocks, region, exclude_ids, page)
    if not body:
        return None, 14.0
    first_row_y = min(c.rect.y for c in body)
    ys = sorted({round(c.rect.y, 1) for c in body})
    gaps = [b - a for a, b in zip(ys, ys[1:]) if b - a > 3.0]
    return first_row_y, (float(median(gaps)) if gaps else 14.0)


def extract_original_rows(
    blocks: ExtractionBlocks,
    semantics: SemanticStructure,
    region: Rect,
    exclude_ids: set[int],
    row_height: float,
    page: int = 0,
) -> list[dict[str, str]]:
    """The replay dataset: the document's own table rows on the given source page,
    read back from the extraction (no fabrication). Cells are clustered by y into
    rows and mapped to column keys by the same body-derived bands as the geometry."""
    body = sorted(_body_cells(blocks, region, exclude_ids, page), key=lambda b: (round(b.rect.y, 0), b.rect.x))
    banded = _bands_to_keys(_column_bands(body), blocks, semantics)
    rows: list[list] = []
    current: list = []
    current_y: float | None = None
    for cell in body:
        if current_y is None or abs(cell.rect.y - current_y) <= row_height * 0.5:
            current.append(cell)
            current_y = cell.rect.y if current_y is None else current_y
        else:
            rows.append(current)
            current = [cell]
            current_y = cell.rect.y
    if current:
        rows.append(current)
    out: list[dict[str, str]] = []
    for row_cells in rows:
        record: dict[str, str] = {}
        for cell in sorted(row_cells, key=lambda b: b.rect.x):
            key = _assign_band(cell.rect.x + cell.rect.w / 2.0, banded)
            if key is not None:
                record[key] = (record[key] + " " + cell.text).strip() if key in record else cell.text
        out.append(record)
    return out


def assemble_artizen(
    template: ArtizenTemplate,
    blocks: ExtractionBlocks,
    semantics: SemanticStructure,
    *,
    table_region: Rect | None = None,
    table_page: int = 0,
    table_regions: dict[int, Rect] | None = None,
    first_row_y: float | None = None,
    row_height: float | None = None,
) -> ArtizenTemplate:
    """Build the variabilised template: bound fields + (optional) TableSpec(s), with
    the corresponding original ``FixedText`` removed.

    * Single page: pass ``table_region`` (+ ``table_page``); the row geometry is
      auto-derived from that page's body cells unless ``first_row_y`` / ``row_height``
      are given.
    * Multi-page: pass ``table_regions`` as ``{page: region}`` — one TableSpec is
      built per page, each scoped to and attached to its own source page, so lines
      from different pages are never merged. Geometry is auto-derived per page.

    Omit both table arguments for the field path only. Building the ORIGINAL rows for
    replay is the caller's job (``extract_original_rows`` per page)."""
    # Anti-collapse guard: keep one block per bound role (best confidence); the rest
    # stay FixedText. Idempotent, so callers may pass raw or already-deduped roles.
    semantics = dedup_bound_roles(semantics)
    business = assemble_business_layer(blocks, semantics)
    bound = _bound_block_ids(semantics, business)

    regions: dict[int, Rect] = {}
    if table_regions is not None:
        regions = table_regions
    elif table_region is not None:
        regions = {table_page: table_region}
    single = table_regions is None  # explicit row geometry only for the single-page shortcut

    table_specs: dict[int, TableSpec] = {}
    body_ids: set[int] = set()
    if semantics.columns and regions:
        # Capture the document's own header labels at assembly (the header block ids
        # are known here), so reflow can repeat them verbatim on continuation pages
        # without any fragile detection. These blocks also stay as page FixedText.
        by_id = {b.id: b for b in blocks.blocks}
        header_texts = [
            FixedText(
                text=by_id[cm.block_id].text,
                rect=by_id[cm.block_id].rect,
                style=TextStyle(font=by_id[cm.block_id].font or "Exo 2",
                                size=by_id[cm.block_id].size or 9.0,
                                color=by_id[cm.block_id].color or "#1E293B",
                                bold=by_id[cm.block_id].bold),
            )
            for cm in semantics.columns if cm.block_id in by_id
        ]
        for pg, region in regions.items():
            body = _body_cells(blocks, region, bound, pg)
            if not body:
                continue
            body_ids |= {c.id for c in body}
            derived_y, derived_h = table_geometry(blocks, region, bound, pg)
            row_y = first_row_y if (single and first_row_y is not None) else derived_y
            row_h = row_height if (single and row_height is not None) else derived_h
            if row_y is None:
                continue
            banded = _bands_to_keys(_column_bands(body), blocks, semantics)
            spec = _build_table_spec(body, banded, region, row_y, row_h, pg)
            table_specs[pg] = spec.model_copy(update={"header_texts": header_texts})

    remove = bound | body_ids
    drop = {id(el) for bid, _pi, kind, el in iter_blocks(template)
            if kind is RawBlockKind.TEXT and bid in remove}

    new_pages = []
    for page_index, page in enumerate(page_list(template)):
        kept = [ft for ft in page.fixed_texts if id(ft) not in drop]
        new_pages.append(
            GraphicPage(
                page=page.page,
                fixed_texts=kept,
                shapes=page.shapes,
                images=page.images,
                # each page keeps the TableSpec built for it (if any)
                table=table_specs.get(page_index, page.table),
            )
        )
    new_graphic = GraphicLayer(
        page=new_pages[0].page,
        fonts=template.graphic.fonts,
        palette=template.graphic.palette,
        pages=new_pages,
    )
    return ArtizenTemplate(
        version=template.version,
        document_type=template.document_type,
        source_kind=template.source_kind,
        confidence_stars=template.confidence_stars,
        estimated_fidelity=template.estimated_fidelity,
        graphic=new_graphic,
        business=business,
        behavioral=template.behavioral,
        assets=template.assets,
    )
