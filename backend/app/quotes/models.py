"""ORM models for the quotes module: ``Quote`` and ``QuoteLine``.

A ``QuoteLine`` is a **photograph** (décision 5): ``designation``, ``unit``,
``unit_price_ht`` and ``vat_rate`` are copied onto the line when it is created,
not looked up live — so if the artisan later changes a catalog price, past
quotes keep showing the amounts they were actually issued with.

A line may come from a catalog article (``catalog_item_id`` set — only a trace
of origin) or be a **free line** typed from scratch (``catalog_item_id`` null:
péage, location, intervention exceptionnelle). Its price may differ from the
catalog's. Artizen still never *invents* an amount: a price is only ever an
input to ``QuoteCalculator``, which stays the one place a total is computed.
"""

import enum
import uuid
from decimal import Decimal

from sqlalchemy import Enum as SAEnum
from sqlalchemy import ForeignKey, Numeric, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from app.database.base import Base, TimestampMixin, UUIDMixin


class QuoteStatus(str, enum.Enum):
    """The commercial life of a quote.

    Only ``DRAFT`` is mutable. That is not a convenience — it is what keeps
    a quote's persisted totals consistent with its lines: ``QuoteCalculator``
    has no recalculation entry point for an existing quote, so any write
    path that bypassed it would leave a total that no longer matches what
    it sums. Freezing everything past ``DRAFT`` removes that class of bug
    rather than relying on a future caller to remember.

    The life cycle is one-directional, brouillon → en attente → envoyé:
    ``DRAFT`` is the artisan's editable working copy; validating it moves it to
    ``PENDING`` ("en attente"), the state from which it is sent to the customer;
    ``SENT`` is the point of no return — a PDF has left for the customer, so the
    document must never change afterwards. Correcting a sent quote means issuing
    a new one. A quote never travels backwards (nothing returns to ``DRAFT``).
    """

    DRAFT = "draft"
    PENDING = "pending"
    SENT = "sent"
    ACCEPTED = "accepted"
    REFUSED = "refused"


#: Which statuses a quote may move to from a given one. Absent key = final.
#: The artisan first *validates* a draft (→ pending), then *sends* it (→ sent);
#: there is no shortcut straight from draft to sent, and no way back.
QUOTE_TRANSITIONS: dict[QuoteStatus, frozenset[QuoteStatus]] = {
    QuoteStatus.DRAFT: frozenset({QuoteStatus.PENDING}),
    QuoteStatus.PENDING: frozenset({QuoteStatus.SENT}),
    QuoteStatus.SENT: frozenset({QuoteStatus.ACCEPTED, QuoteStatus.REFUSED}),
    QuoteStatus.ACCEPTED: frozenset(),
    QuoteStatus.REFUSED: frozenset(),
}


class QuoteCounter(Base, TimestampMixin):
    """Per-company, per-year quote counter — the source of quote numbers.

    A table rather than ``SELECT MAX(quote_number) + 1``: two quotes created
    at the same instant would both read the same max and both try to claim
    the same number. The unique constraint would catch it, but one artisan
    would get an error for something they did nothing wrong about.

    Here the row is locked (``SELECT ... FOR UPDATE``) before being
    incremented, so concurrent creations queue behind each other and each
    gets its own number. The lock is scoped to one company's one year, so
    it never serializes unrelated tenants.

    Deliberately not a PostgreSQL sequence: sequences cannot be created per
    tenant without DDL at runtime, and they are explicitly allowed to leave
    gaps on rollback — which is exactly what invoice numbering (art. 242
    nonies A CGI) will forbid when this scheme is inherited.
    """

    __tablename__ = "quote_counters"

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), primary_key=True
    )
    year: Mapped[int] = mapped_column(primary_key=True)
    last_number: Mapped[int] = mapped_column(default=0)


class Quote(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "quotes"

    # Unique per company, never globally: two artisans both having a
    # "DEV-2026-0001" is normal and expected. Enforced by the database
    # rather than by the service, because a check-then-insert in Python is
    # a race however carefully it is written.
    __table_args__ = (UniqueConstraint("company_id", "quote_number"),)

    company_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("companies.id", ondelete="CASCADE"), index=True
    )
    # The identity the artisan and their customer actually use. A UUID is
    # not something you write on a document or quote over the phone.
    quote_number: Mapped[str] = mapped_column(index=True)
    status: Mapped[QuoteStatus] = mapped_column(
        SAEnum(
            QuoteStatus,
            name="quote_status",
            # Store the value ("draft"), not the member name ("DRAFT") —
            # same reason as ItemType in catalog/models.py: anything reading
            # the column directly should see what the API exposes.
            values_callable=lambda enum_cls: [member.value for member in enum_cls],
        ),
        default=QuoteStatus.DRAFT,
        index=True,
    )
    # RESTRICT: a client with existing quotes shouldn't be deletable by
    # accident (mirrors CatalogItem's protection against deleting a
    # category that still has items). ClientService.delete translates the
    # resulting IntegrityError into a 409 — the database guard is only half
    # the protection, and for a while this comment claimed a translation
    # that did not exist, so deleting such a client returned a bare 500.
    client_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("clients.id", ondelete="RESTRICT"), index=True
    )
    total_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))
    total_vat: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))
    total_ttc: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=Decimal("0.00"))


class QuoteLine(Base, UUIDMixin, TimestampMixin):
    __tablename__ = "quote_lines"

    quote_id: Mapped[uuid.UUID] = mapped_column(
        ForeignKey("quotes.id", ondelete="CASCADE"), index=True
    )
    # SET NULL + nullable (décision 5): catalog_item_id is a trace of origin,
    # not a dependency. Deleting a catalog item nulls it on the lines that used
    # it — each keeps its own snapshot, so past quotes stay intact while the
    # artisan can still prune their catalog. Null from the start for a free
    # line, which references no catalog article at all.
    catalog_item_id: Mapped[uuid.UUID | None] = mapped_column(
        ForeignKey("catalog_items.id", ondelete="SET NULL"), nullable=True
    )
    designation: Mapped[str]
    unit: Mapped[str]
    quantity: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    unit_price_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    vat_rate: Mapped[Decimal] = mapped_column(Numeric(5, 2))
    total_ht: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    total_vat: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    total_ttc: Mapped[Decimal] = mapped_column(Numeric(10, 2))
