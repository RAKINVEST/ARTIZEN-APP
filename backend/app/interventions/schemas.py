"""The Intervention domain model — the one new first-class concept of V2.

Generic by construction: a trade or an equipment ("chauffe-eau", "PAC") is
*data* carried in slugs/labels, never code. The model composes references to
what a job needs and stays independent of every other library:

- an ``article``/``consumable`` component references a personal-catalogue item by
  id only (the catalogue stays the article store; this library never imports its
  internals);
- ``kit_ids``, ``mission_id`` and ``visibility`` are cheap forward-compat hooks
  so Kits (Vol.2), Missions (Vol.4) and community sharing (Vol.7) can attach
  later **without a migration or a model change** — the evolvability the 10-year
  test demands — while none of those engines is built ahead of a real need.

No amount is computed and nothing is persisted here.
"""

from __future__ import annotations

from decimal import Decimal
from enum import Enum
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field


class ComponentKind(str, Enum):
    """What a component contributes to the job — the composable kinds of Vol.1."""

    article = "article"
    labor = "labor"  # main-d'œuvre
    travel = "travel"  # déplacement
    consumable = "consumable"
    guarantee = "guarantee"
    condition = "condition"
    phrase = "phrase"


class Difficulty(str, Enum):
    easy = "easy"
    standard = "standard"
    hard = "hard"


class Visibility(str, Enum):
    """Vol.7 forward-compat: every shareable object carries a visibility. One
    enum costs nothing today and lets the community engine attach later."""

    private = "private"
    company = "company"
    group = "group"
    public = "public"


class InterventionComponent(BaseModel):
    model_config = ConfigDict(extra="ignore")

    kind: ComponentKind
    order: int = 0
    #: article/consumable -> the catalogue item it references (id only, so this
    #: library never depends on the catalogue's internals; no circular import).
    catalog_item_id: UUID | None = None
    #: A human label: the article designation snapshot, or a short title.
    label: str | None = None
    #: The template default the artisan set for this component (fully editable
    #: once dropped into a devis). ``None`` when the template did not fix one.
    default_quantity: Decimal | None = None
    unit: str | None = None
    #: phrase/guarantee/condition -> the reusable text (from the Phrases library
    #: when it exists; a plain string until then).
    text: str | None = None


class Intervention(BaseModel):
    """A named, reusable description of a job ("Remplacement chauffe-eau").

    It composes components directly and/or references reusable kits; it may be
    **empty** (Vol.2: an artisan can start from a blank intervention and build
    freely). It is the unit the devis is organised around — one intervention,
    one block.
    """

    model_config = ConfigDict(extra="ignore")

    id: UUID | None = None
    company_id: UUID | None = None
    name: str
    #: References the frozen trade taxonomy by slug (families/activities). Kept as
    #: plain slugs so this model never imports the taxonomy engine.
    trade_slug: str | None = None
    family_slug: str | None = None
    #: The artisan's verb + object intent (Vol.2): "installer" / "remplacer" … and
    #: "chauffe-eau" / "PAC" …, carried as data, never branched on in code.
    action: str | None = None
    equipment: str | None = None
    category: str | None = None
    tags: list[str] = Field(default_factory=list)
    difficulty: Difficulty = Difficulty.standard
    average_time_minutes: int | None = None
    components: list[InterventionComponent] = Field(default_factory=list)
    #: Vol.2 forward-compat: several kits may back one intervention (id refs only;
    #: the Kit library is built when a real consumer needs it).
    kit_ids: list[UUID] = Field(default_factory=list)
    #: Vol.4 forward-compat: an intervention belongs to a Mission once that object
    #: exists. Nullable today; no Mission engine is built ahead of need.
    mission_id: UUID | None = None
    visibility: Visibility = Visibility.private
