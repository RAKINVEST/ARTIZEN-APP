"""The ``.artizen`` format — the intelligent documentary model an import
compiles to. Not a template: a full description of a company's documentary
identity, in three layers (as designed with the product owner).

* **Graphique** — everything about rendering: page, margins, columns,
  coordinates, fonts, sizes, colours, shapes, fills, logo, table geometry.
* **Métier** — what the document *carries*: which zones are variable (company,
  client, worksite, lines, totals…) versus fixed, and which sections exist.
* **Comportemental** — the rules: how HT/TTC/VAT are computed, discounts,
  deposits, retentions, conditional display, pagination, totals carry-over.

Serialise an :class:`ArtizenTemplate` to JSON and that JSON *is* the ``.artizen``
file — self-contained (fonts and images embedded as base64), so it reproduces
the identity with no external dependency, deterministically, forever.

Deliberately **generic**: the same structure clones a devis, a facture, an
avoir, a contrat, a PV… only :class:`DocumentType` and the behavioural rules
change — the same principle as ``app/pdf/`` (a neutral engine that never learned
what a "quote" is).
"""

from enum import Enum

from pydantic import BaseModel, Field


class HAlign(str, Enum):
    LEFT = "left"
    CENTER = "center"
    RIGHT = "right"


class DocumentType(str, Enum):
    """One engine, every document — only the business rules differ."""

    DEVIS = "devis"
    FACTURE = "facture"
    AVOIR = "avoir"
    BON_INTERVENTION = "bon_intervention"
    BON_COMMANDE = "bon_commande"
    CONTRAT = "contrat"
    RAPPORT_CHANTIER = "rapport_chantier"
    PROCES_VERBAL = "proces_verbal"


class SourceKind(str, Enum):
    NATIVE = "native"
    HYBRID = "hybrid"
    IMAGE = "image"


class Rect(BaseModel):
    """Position in PDF points, origin top-left."""

    x: float
    y: float
    w: float
    h: float


class TextStyle(BaseModel):
    font: str = "Exo 2"
    size: float = 9.0
    color: str = "#1E293B"  # hex
    bold: bool = False
    italic: bool = False
    align: HAlign = HAlign.LEFT


# --------------------------------------------------------------- Layer 1 : graphique
class PageGeometry(BaseModel):
    width: float
    height: float
    # top, right, bottom, left — in points
    margins: tuple[float, float, float, float] = (34, 34, 40, 34)


class FontRef(BaseModel):
    family: str
    #: key into :attr:`ArtizenTemplate.assets` — the embedded font bytes
    #: (extracted from the source PDF when present, so the *exact* font is kept).
    asset_ref: str | None = None


class Shape(BaseModel):
    kind: str = "rect"  # rect | line
    rect: Rect
    fill: str | None = None
    stroke: str | None = None
    stroke_width: float = 0.0
    radius: float = 0.0  # rounded-corner radius, points


class FixedText(BaseModel):
    """A static label — reproduced verbatim ("DEVIS", "LIBELLÉ", the mentions…)."""

    text: str
    rect: Rect
    style: TextStyle = Field(default_factory=TextStyle)


class ImageBlock(BaseModel):
    role: str = "logo"  # logo | picto | …
    rect: Rect
    asset_ref: str  # -> assets (embedded image bytes)


class TableColumn(BaseModel):
    key: str  # designation | qty | unit | pu_ht | remise | vat | total_ht | …
    label: str
    x: float
    width: float
    align: HAlign = HAlign.RIGHT


class TableSpec(BaseModel):
    rect: Rect  # the table region (header + body area)
    #: 0-based source page of the table (P2.2 — see FieldBinding.page).
    page: int = 0
    columns: list[TableColumn] = Field(default_factory=list)
    #: The document's own header labels, captured at assembly (P2.4) as FixedText at
    #: their real positions. Empty when the TableSpec draws its own labels via
    #: ``columns``. When present, reflow repeats these verbatim on continuation pages
    #: — so a table whose headers are FixedText (not TableSpec labels) still repeats
    #: correctly, at the original coordinates, with no fragile detection.
    header_texts: list[FixedText] = Field(default_factory=list)
    header_style: TextStyle = Field(default_factory=TextStyle)
    header_fill: str | None = None
    body_style: TextStyle = Field(default_factory=TextStyle)
    row_height: float = 18.0
    zebra_fill: str | None = None
    grid_color: str | None = None


class GraphicPage(BaseModel):
    """One physical page's graphic content — the multipage unit. Each page keeps
    its own geometry, so a document mixing A4 portrait and landscape reproduces
    faithfully. A flat (legacy, single-page) :class:`GraphicLayer` is treated as
    one implicit page by the renderer."""

    page: PageGeometry
    fixed_texts: list[FixedText] = Field(default_factory=list)
    shapes: list[Shape] = Field(default_factory=list)
    images: list[ImageBlock] = Field(default_factory=list)
    table: TableSpec | None = None


class GraphicLayer(BaseModel):
    page: PageGeometry
    fonts: list[FontRef] = Field(default_factory=list)
    palette: dict[str, str] = Field(default_factory=dict)  # named -> hex
    fixed_texts: list[FixedText] = Field(default_factory=list)
    shapes: list[Shape] = Field(default_factory=list)
    images: list[ImageBlock] = Field(default_factory=list)
    table: TableSpec | None = None
    #: Multipage content. When non-empty, the renderer draws these pages (and
    #: ignores the flat single-page fields above, kept for backward compat).
    #: A real devis is multi-page — page breaks, headers and footers are part of
    #: the identity, so they are reproduced page by page, never recomposed.
    pages: list[GraphicPage] = Field(default_factory=list)


# --------------------------------------------------------------- Layer 2 : métier
class FieldBinding(BaseModel):
    """A variable zone: at generation, ``field`` is resolved from the document's
    data and drawn at ``rect`` with ``style``. Anything not bound stays fixed."""

    field: str  # company.name | client.name | quote.number | totals.ttc | …
    #: 0-based source page of this variable zone (P2.2). Records which page the
    #: field came from so multi-page placement (P2.3) draws it on the right page.
    page: int = 0
    #: True for a total that sits BELOW the table (Total HT/TVA/TTC, acompte, reste).
    #: When reflow (P2.4) pushes the table onto more pages, such a field follows the
    #: table to the last page instead of staying behind. Its rect/style are kept.
    after_table: bool = False
    rect: Rect
    style: TextStyle = Field(default_factory=TextStyle)
    prefix: str = ""
    suffix: str = ""


class SectionPresence(BaseModel):
    """What the AI recognised in the document — drives the Template Studio's
    "Logo ✓ / Client ✓ / Tableau ✓…" recognition report."""

    logo: bool = False
    company: bool = False
    client: bool = False
    worksite: bool = False
    table: bool = False
    vat: bool = False
    totals: bool = False
    deposit: bool = False  # acompte
    signature: bool = False
    legal: bool = False
    footer: bool = False


class BusinessLayer(BaseModel):
    fields: list[FieldBinding] = Field(default_factory=list)
    sections: SectionPresence = Field(default_factory=SectionPresence)


# --------------------------------------------------------------- Layer 3 : comportemental
class CalcMethod(str, Enum):
    SUM_LINES_HT = "sum_lines_ht"
    VAT_PER_LINE_HALF_UP = "vat_per_line_half_up"
    VAT_GLOBAL = "vat_global"
    TTC_HT_PLUS_VAT = "ttc_ht_plus_vat"
    RESTE_TTC_MINUS_DEPOSITS = "reste_ttc_minus_deposits"


class CalcRule(BaseModel):
    target: str  # total_ht | total_vat | total_ttc | reste_a_payer
    method: CalcMethod


class ConditionalRule(BaseModel):
    show: str  # a section/field key
    when: str  # a condition key: has_deposit | is_franchise | has_discount | …


class BehavioralLayer(BaseModel):
    calc_rules: list[CalcRule] = Field(default_factory=list)
    vat_mode: str = "per_line"  # per_line | global
    rounding: str = "half_up_per_line"
    line_discount: bool = False  # remises par ligne ?
    deposits: bool = False  # acomptes ?
    retentions: bool = False  # retenues ?
    repeat_table_header: bool = True
    footer_every_page: bool = True
    conditional: list[ConditionalRule] = Field(default_factory=list)


# --------------------------------------------------------------- Top level
class ArtizenTemplate(BaseModel):
    """The compiled documentary identity — the ``.artizen`` model itself.

    ``model_dump_json()`` produces the ``.artizen`` file; ``model_validate_json()``
    reads it back. Fully self-contained via :attr:`assets`.
    """

    version: str = "1.0"
    document_type: DocumentType = DocumentType.DEVIS
    source_kind: SourceKind = SourceKind.NATIVE
    confidence_stars: int = 3
    estimated_fidelity: int = 90

    graphic: GraphicLayer
    business: BusinessLayer = Field(default_factory=BusinessLayer)
    behavioral: BehavioralLayer = Field(default_factory=BehavioralLayer)

    #: asset_ref -> base64 (embedded fonts + images), so the model reproduces
    #: the identity with no external files.
    assets: dict[str, str] = Field(default_factory=dict)
