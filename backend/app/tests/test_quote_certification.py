"""Phase 1.1 — commercial certification of the quote.

Two parts:
- the "devis prêt à émettre" engine (Mission 2), unit-tested on plain records;
- an automatic PDF recette (Mission 5): every scenario a real artisan hits must
  render a correct PDF — complete/minimal company, micro/normal VAT, with/without
  logo, signature, stamp, particulier/pro client, very large / very small quote.
"""

import io
import uuid
from datetime import date
from decimal import Decimal

from pypdf import PdfReader

from app.branding.schemas import BrandProfileRead, CompanyRead
from app.clients.models import Client
from app.pdf.renderer import PdfRenderer
from app.pdf.schemas import (
    Document,
    DocumentBranding,
    DocumentLine,
    DocumentParty,
    DocumentTotals,
    DocumentVatRow,
)
from app.quotes.models import Quote, QuoteLine, QuoteStatus
from app.quotes.readiness import evaluate_readiness

_RENDERER = PdfRenderer()


def _png(color=(10, 35, 63), size=(8, 8)) -> bytes:
    from PIL import Image

    buffer = io.BytesIO()
    Image.new("RGB", size, color).save(buffer, format="PNG")
    return buffer.getvalue()


def _pdf_text(pdf: bytes) -> tuple[PdfReader, str]:
    reader = PdfReader(io.BytesIO(pdf))
    return reader, " ".join(page.extract_text() for page in reader.pages)


# --- Mission 2: readiness engine --------------------------------------------


def _company(**overrides) -> CompanyRead:
    base = dict(
        id=uuid.uuid4(), name="Durand", legal_name="PLOMBERIE DURAND SARL",
        siret="12345678900012", vat_number="FR123", address_line="12 rue X",
        postal_code="75011", city="Paris", country="France", phone="0102030405",
        email="c@d.fr", website=None, legal_form="SARL", share_capital="5 000 €",
        rcs_rm="RCS Paris 1", ape_code="4322A", insurance_name="AXA",
        insurance_contract="DEC-9", insurance_coverage="France", rge_number="QB/1",
        payment_terms="30 jours", vat_regime="normal", quote_validity_days=30,
    )
    base.update(overrides)
    return CompanyRead(**base)


def _brand(logo: bool = True) -> BrandProfileRead:
    return BrandProfileRead(
        id=uuid.uuid4(), logo_path="logos/x.png" if logo else None,
        primary_color="#10233F", secondary_color=None, font_family=None,
        tagline=None, signature_path=None, stamp_path=None,
    )


def _client(**overrides) -> Client:
    base = dict(last_name="Martin", address="1 rue du Client, 75000 Paris")
    base.update(overrides)
    return Client(**base)


def _quote(ht="100.00", vat="20.00", ttc="120.00") -> Quote:
    return Quote(
        company_id=uuid.uuid4(), client_id=uuid.uuid4(), quote_number="DEV-2026-0001",
        status=QuoteStatus.DRAFT, total_ht=Decimal(ht), total_vat=Decimal(vat),
        total_ttc=Decimal(ttc),
    )


def test_fully_configured_quote_is_ready() -> None:
    issues = evaluate_readiness(
        company=_company(), brand=_brand(logo=True), client=_client(),
        quote=_quote(), lines=[QuoteLine()],
    )
    assert issues == []


def test_minimal_company_lists_precise_missing_items() -> None:
    bare = _company(
        legal_name=None, name=None, siret=None, address_line=None, postal_code=None,
        city=None, insurance_name=None, payment_terms=None, phone=None, email=None,
    )
    issues = evaluate_readiness(
        company=bare, brand=_brand(logo=False), client=_client(), quote=_quote(),
        lines=[QuoteLine()],
    )
    codes = {i.code for i in issues}
    assert {"company_name", "company_address", "siret", "insurance", "payment_terms", "contact", "logo"} <= codes
    # Each issue points at where to fix it.
    by_code = {i.code: i for i in issues}
    assert by_code["siret"].target == "company_profile" and by_code["siret"].field == "siret"


def test_missing_lines_and_client_address_are_flagged() -> None:
    no_lines = evaluate_readiness(
        company=_company(), brand=_brand(), client=_client(), quote=_quote(), lines=[]
    )
    assert any(i.code == "no_lines" and i.target == "quote" for i in no_lines)

    no_addr = evaluate_readiness(
        company=_company(), brand=_brand(), client=_client(address=None),
        quote=_quote(), lines=[QuoteLine()],
    )
    assert any(i.code == "client_address" and i.target == "client" for i in no_addr)


def test_franchise_company_does_not_require_a_vat_number() -> None:
    normal = evaluate_readiness(
        company=_company(vat_regime="normal", vat_number=None), brand=_brand(),
        client=_client(), quote=_quote(), lines=[QuoteLine()],
    )
    assert any(i.code == "vat_number" for i in normal)
    franchise = evaluate_readiness(
        company=_company(vat_regime="franchise", vat_number=None), brand=_brand(),
        client=_client(), quote=_quote(), lines=[QuoteLine()],
    )
    assert not any(i.code == "vat_number" for i in franchise)


# --- Mission 5: PDF recette --------------------------------------------------


def _party(name="PLOMBERIE DURAND SARL", details=None) -> DocumentParty:
    return DocumentParty(
        name=name, address_lines=["12 rue des Artisans", "75011 Paris"],
        detail_lines=details if details is not None else ["SIRET : 12345678900012", "Tél : 0102030405"],
    )


def _dline(i: int) -> DocumentLine:
    return DocumentLine(
        designation=f"Prestation {i}", unit="u", quantity=Decimal("1.00"),
        unit_price_ht=Decimal("100.00"), vat_rate=Decimal("20.00"), total_ht=Decimal("100.00"),
    )


def _document(*, lines=None, show_vat=True, branding=None, recipient=None) -> Document:
    lines = lines if lines is not None else [_dline(1)]
    n = len(lines)
    if show_vat:
        totals = DocumentTotals(
            total_ht=Decimal(f"{100 * n}.00"), total_vat=Decimal(f"{20 * n}.00"),
            total_ttc=Decimal(f"{120 * n}.00"),
            vat_rows=[DocumentVatRow(rate=Decimal("20.00"), base_ht=Decimal(f"{100 * n}.00"), vat_amount=Decimal(f"{20 * n}.00"))],
        )
    else:
        totals = DocumentTotals(
            total_ht=Decimal(f"{100 * n}.00"), total_vat=Decimal("0.00"),
            total_ttc=Decimal(f"{100 * n}.00"), vat_rows=[],
        )
    return Document(
        title="DEVIS", number="DEV-2026-0001", issued_on=date(2026, 1, 1),
        issuer=_party(), recipient=recipient or _party(name="Client Particulier", details=[]),
        lines=lines, totals=totals,
        legal_mentions=["Devis gratuit. Validité : 30 jours.", "TVA non applicable, art. 293 B du CGI."] if not show_vat else ["Devis gratuit. Validité : 30 jours."],
        branding=branding or DocumentBranding(primary_color="#10233F"),
        show_vat=show_vat, signature_label="Bon pour accord — Date et signature du client :",
    )


def _renders(document: Document, *, min_pages: int = 1) -> str:
    pdf = _RENDERER.render(document)
    assert pdf.startswith(b"%PDF"), "output is a PDF"
    reader, text = _pdf_text(pdf)
    assert len(reader.pages) >= min_pages
    assert "Bon pour accord" in text  # signature area always present on a quote
    return text


def test_recette_complete_company_with_logo_signature_stamp() -> None:
    branding = DocumentBranding(
        logo=_png(), primary_color="#10233F", secondary_color="#D4AF37",
        tagline="Votre artisan de confiance", signature=_png((0, 0, 0)), stamp=_png((200, 0, 0)),
    )
    _renders(_document(branding=branding))


def test_recette_minimal_company_no_branding() -> None:
    # Name only, no logo/colour/signature — must still render cleanly.
    doc = _document(branding=DocumentBranding())
    _renders(doc)


def test_recette_micro_entrepreneur_hides_vat() -> None:
    text = _renders(_document(show_vat=False))
    assert "Montant TVA" not in text
    assert "293 B du CGI" in text


def test_recette_normal_vat_shows_vat() -> None:
    text = _renders(_document(show_vat=True))
    assert "Montant TVA" in text


def test_recette_without_signature_still_has_client_box() -> None:
    _renders(_document(branding=DocumentBranding()))  # no artisan signature


def test_recette_with_signature_only_and_stamp_only() -> None:
    _renders(_document(branding=DocumentBranding(signature=_png())))
    _renders(_document(branding=DocumentBranding(stamp=_png())))


def test_recette_pro_client_and_private_client() -> None:
    pro = DocumentParty(name="ACME BTP SARL", address_lines=["5 av. Pro", "69000 Lyon"], detail_lines=["contact@acme.fr"])
    _renders(_document(recipient=pro))
    private = DocumentParty(name="Jean Martin", address_lines=["1 rue Privée", "75000 Paris"], detail_lines=[])
    _renders(_document(recipient=private))


def test_recette_very_large_quote_paginates() -> None:
    # 150 lines must span multiple pages and keep the header on each.
    _renders(_document(lines=[_dline(i) for i in range(150)]), min_pages=2)


def test_recette_very_small_quote_single_line() -> None:
    _renders(_document(lines=[_dline(1)]))


def test_recette_long_values_do_not_crash_rendering() -> None:
    # Long unit + big amount + ampersand/brackets in designation.
    line = DocumentLine(
        designation="Dépose & repose chaudière <gaz> [urgent] avec évacuation des déchets sur site",
        unit="forfait mensuel", quantity=Decimal("12.00"),
        unit_price_ht=Decimal("1234567.89"), vat_rate=Decimal("20.00"),
        total_ht=Decimal("14814814.68"),
    )
    _renders(_document(lines=[line]))
