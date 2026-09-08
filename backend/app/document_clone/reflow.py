"""Deterministic pagination (reflow) for a NEW document — Brique multi-page.

Given a variabilised ``.artizen`` whose table page carries a :class:`TableSpec`
with labelled columns, and a NEW list of rows (possibly fewer or many more than
the original), split the rows across as many pages as needed and repeat the table
header on each page. Pure and deterministic: same (template, rows) always yields
the same pagination — no AI, no invented coordinates.

Everything it needs is already in the model: ``TableSpec.row_height`` and
``TableSpec.rect`` (the table region and its top), plus the page's
``height``/``margins``. The table region is read from the existing TableSpec, so
no ``table_regions`` argument is needed here (auto-detected from the assembled
template).

Conservative scope (P2.4):
* Rows + header repetition only.
* Continuation pages reuse the table's own region (uniform capacity) rather than
  reclaiming the top margin — simpler and deterministic.
* Totals are NOT repositioned when the table overflows onto new pages: the model
  carries no "totals follow the last row" relation, so a bound totals field keeps
  its own ``page``. Documented limit, not invented behaviour.
"""

from math import floor

from app.document_clone.artizen_format import (
    ArtizenTemplate,
    GraphicLayer,
    GraphicPage,
    TableSpec,
)


def page_capacity(table_spec: TableSpec, page, *, reserve_bottom: float = 0.0) -> int:
    """Max data rows that fit BELOW the header in this table region on one page.
    The header occupies the first row slot (``_draw_table`` draws it at ``rect.y``
    then advances by ``row_height``)."""
    rh = table_spec.row_height
    if rh <= 0:
        return 0
    bottom_limit = page.height - page.margins[2] - reserve_bottom  # margins = (top,right,bottom,left)
    body_top = table_spec.rect.y + rh
    return max(0, floor((bottom_limit - body_top) / rh))


def chunk_rows(rows, capacity_first: int, capacity_rest: int) -> list[list]:
    """Split ``rows`` into per-page chunks, order preserved, none lost or
    duplicated. The first page may hold fewer (e.g. space reserved for totals)."""
    if not rows:
        return [[]]
    chunks: list[list] = []
    index = 0
    cap = max(1, capacity_first)
    chunks.append(list(rows[index:index + cap]))
    index += cap
    while index < len(rows):
        cap = max(1, capacity_rest)
        chunks.append(list(rows[index:index + cap]))
        index += cap
    return chunks


def reflow_document(
    template: ArtizenTemplate,
    rows: list[dict[str, str]],
    *,
    table_page: int = 0,
) -> tuple[ArtizenTemplate, dict[int, list[dict[str, str]]]]:
    """Paginate ``rows`` over the table found on ``table_page``. Returns a template
    with as many pages as needed and a ``{page: rows}`` map ready for
    :func:`render_artizen`:

    * page 0 keeps its chrome and its table;
    * continuation pages repeat the header (the TableSpec's ``header_texts`` when it
      captured the document's own labels, else its ``columns`` labels) + their rows;
    * ``after_table`` totals follow the table to its last page (rect/style kept); if
      that page's rows would reach the totals, the totals go on a fresh trailing page.

    If the page has no TableSpec it is a safe no-op (rows returned as one page)."""
    pages = template.graphic.pages or [
        GraphicPage(
            page=template.graphic.page,
            fixed_texts=template.graphic.fixed_texts,
            shapes=template.graphic.shapes,
            images=template.graphic.images,
            table=template.graphic.table,
        )
    ]
    base = pages[table_page]
    if base.table is None:
        return template, {table_page: list(rows)}

    ts = base.table
    rh = ts.row_height
    cap_full = page_capacity(ts, base.page)

    # Totals below the table cap how many rows may share the last page.
    totals = [f for f in template.business.fields if f.after_table]
    if totals and rh > 0:
        totals_top = min(f.rect.y for f in totals)
        cap_last = max(1, floor((totals_top - (ts.rect.y + rh)) / rh))
    else:
        cap_last = cap_full

    chunks = chunk_rows(rows, cap_full, cap_full)  # order preserved, no loss/dup

    new_pages = [base.model_copy(update={"table": ts.model_copy(update={"page": table_page})})]
    for offset in range(1, len(chunks)):
        pg = table_page + offset
        new_pages.append(
            GraphicPage(
                page=base.page,
                fixed_texts=[h.model_copy() for h in ts.header_texts],  # repeat the header verbatim
                shapes=[],
                images=[],
                table=ts.model_copy(update={"page": pg}),
            )
        )
    rows_by_page = {table_page + offset: chunk for offset, chunk in enumerate(chunks)}

    business = template.business
    if totals:
        last_page = table_page + len(chunks) - 1
        if len(chunks[-1]) <= cap_last:
            target = last_page                       # totals fit below the last row
        else:
            target = last_page + 1                   # no room — totals on a fresh page
            new_pages.append(GraphicPage(page=base.page, fixed_texts=[], shapes=[], images=[], table=None))
        if target != table_page:                     # single-page case leaves them untouched
            fields = [f.model_copy(update={"page": target}) if f.after_table else f
                      for f in business.fields]
            business = business.model_copy(update={"fields": fields})

    graphic = GraphicLayer(
        page=new_pages[0].page,
        fonts=template.graphic.fonts,
        palette=template.graphic.palette,
        pages=new_pages,
    )
    return template.model_copy(update={"graphic": graphic, "business": business}), rows_by_page
