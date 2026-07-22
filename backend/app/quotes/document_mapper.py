"""Turns a quote into the generic ``Document`` the PDF engine renders.

This lives in ``quotes/`` and not in ``pdf/`` on purpose, and the direction
matters: ``pdf/`` is transverse infrastructure that must serve invoices,
credit notes and purchase orders too, so it can never learn what a
``Quote`` is. Knowledge flows one way — the module that owns the quote
knows how to describe it; the engine only knows how to lay a description
out. When ``invoices/`` arrives it will bring its own mapper, and the
engine will not change.

**No amount is computed here.** Every figure is copied from what
``QuoteCalculator`` already produced, including the per-rate VAT summary.
This is a translation, not a calculation.
"""

from datetime import date, timedelta
from decimal import Decimal

from app.branding.schemas import BrandingProfileRead, CompanyRead
from app.clients.models import Client
from app.pdf.schemas import (
    Document,
    DocumentBranding,
    DocumentLine,
    DocumentParty,
    DocumentTotals,
    DocumentVatRow,
)
from app.quotes.calculator import VatBucket
from app.quotes.models import Quote, QuoteLine

#: What the reader sees at the top. Invoices will pass "FACTURE", credit
#: notes "AVOIR" — the engine takes any string, which is what stops it
#: needing a branch per document type.
QUOTE_TITLE = "DEVIS"

#: Drawn as a signature area at the bottom of a quote — the "Bon pour accord"
#: a devis needs to play its contractual role (the document claims acceptance
#: on signature, so it must give the client somewhere to sign).
QUOTE_SIGNATURE_LABEL = "Bon pour accord — Date et signature du client :"


def _legal_identity_line(company: CompanyRead) -> str | None:
    """Forme juridique (+ capital social) on one line, the way it reads on a
    real French commercial document ("SARL au capital de 5 000 €")."""
    if company.legal_form and company.share_capital:
        return f"{company.legal_form} au capital de {company.share_capital}"
    if company.legal_form:
        return company.legal_form
    if company.share_capital:
        return f"Capital social : {company.share_capital}"
    return None


def _quote_legal_mentions(company: CompanyRead) -> list[str]:
    """The legal mentions a French building-trade *quote* must carry, built
    from the company's own regulatory data. Only what is actually configured
    is printed — a missing field is left out rather than shown empty — so the
    document is as complete as the artisan has made themselves.

    An invoice's mentions differ and are not this module's business.
    """
    validity = company.quote_validity_days or 30
    mentions = [
        f"Devis gratuit et sans engagement. Validité : {validity} jours à compter de la date "
        "d'émission.",
    ]
    if company.vat_regime == "franchise":
        mentions.append("TVA non applicable, art. 293 B du CGI.")
    if company.payment_terms:
        mentions.append(f"Conditions de règlement : {company.payment_terms}")
    if company.insurance_name:
        insurance = f"Assurance décennale : {company.insurance_name}"
        if company.insurance_contract:
            insurance += f", contrat n° {company.insurance_contract}"
        if company.insurance_coverage:
            insurance += f" (couverture : {company.insurance_coverage})"
        mentions.append(insurance)
    if company.rge_number:
        mentions.append(f"Certification RGE : {company.rge_number}")
    mentions.append("Le présent devis vaut acceptation des conditions dès signature du client.")
    return mentions


def _company_party(profile: BrandingProfileRead) -> DocumentParty:
    company = profile.company
    address = [
        line
        for line in (
            company.address_line,
            " ".join(filter(None, (company.postal_code, company.city))).strip() or None,
            company.country,
        )
        if line
    ]
    details = [
        label
        for label in (
            _legal_identity_line(company),
            f"SIRET : {company.siret}" if company.siret else None,
            f"{company.rcs_rm}" if company.rcs_rm else None,
            f"APE : {company.ape_code}" if company.ape_code else None,
            f"TVA : {company.vat_number}" if company.vat_number else None,
            f"Tél : {company.phone}" if company.phone else None,
            company.email,
        )
        if label
    ]
    # legal_name is what belongs on a commercial document; `name` is the
    # everyday one. Falling back keeps a brand-new account — which has
    # neither filled in — from producing a nameless document.
    return DocumentParty(
        name=company.legal_name or company.name or "—",
        address_lines=address,
        detail_lines=details,
    )


#: A canned demo used only for the "aperçu du rendu" a company sees right
#: after importing a template — real amounts, a fictitious client — so the
#: artisan can confirm their identity and colours are applied without having
#: to create a real quote first. Reuses the exact same ``Document`` shape and
#: renderer as a genuine quote, so the preview cannot drift from the real
#: thing.
def sample_document(
    *,
    profile: BrandingProfileRead,
    logo: bytes | None,
    signature: bytes | None = None,
    stamp: bytes | None = None,
) -> Document:
    brand = profile.brand
    company = profile.company
    # The preview must be faithful to the company's regime: a franchise-en-base
    # artisan sees an HT-only document, exactly like their real quotes will be.
    vat_exempt = company.vat_regime == "franchise"
    line_vat = Decimal("0.00") if vat_exempt else None
    if vat_exempt:
        totals = DocumentTotals(
            total_ht=Decimal("1200.00"),
            total_vat=Decimal("0.00"),
            total_ttc=Decimal("1200.00"),
            vat_rows=[],
        )
    else:
        totals = DocumentTotals(
            total_ht=Decimal("1200.00"),
            total_vat=Decimal("210.00"),
            total_ttc=Decimal("1410.00"),
            vat_rows=[
                DocumentVatRow(
                    rate=Decimal("10.00"), base_ht=Decimal("300.00"), vat_amount=Decimal("30.00")
                ),
                DocumentVatRow(
                    rate=Decimal("20.00"), base_ht=Decimal("900.00"), vat_amount=Decimal("180.00")
                ),
            ],
        )
    return Document(
        title=QUOTE_TITLE,
        number="DEV-2026-0001",
        issued_on=date(2026, 1, 1),
        valid_until=date(2026, 1, 1) + timedelta(days=company.quote_validity_days or 30),
        issuer=_company_party(profile),
        recipient=DocumentParty(
            name="Client Démonstration",
            address_lines=["10 rue de l'Exemple", "75000 Paris"],
            detail_lines=[],
        ),
        lines=[
            DocumentLine(
                designation="Fourniture et pose (exemple)",
                unit="u",
                quantity=Decimal("2.00"),
                unit_price_ht=Decimal("450.00"),
                vat_rate=line_vat if line_vat is not None else Decimal("20.00"),
                total_ht=Decimal("900.00"),
            ),
            DocumentLine(
                designation="Main-d'œuvre (exemple)",
                unit="h",
                quantity=Decimal("5.00"),
                unit_price_ht=Decimal("60.00"),
                vat_rate=line_vat if line_vat is not None else Decimal("10.00"),
                total_ht=Decimal("300.00"),
            ),
        ],
        totals=totals,
        legal_mentions=_quote_legal_mentions(company),
        branding=DocumentBranding(
            logo=logo,
            primary_color=brand.primary_color,
            secondary_color=brand.secondary_color,
            tagline=brand.tagline,
            signature=signature,
            stamp=stamp,
        ),
        show_vat=not vat_exempt,
        signature_label=QUOTE_SIGNATURE_LABEL,
    )


def _client_party(client: Client) -> DocumentParty:
    personal = " ".join(filter(None, (client.first_name, client.last_name))).strip()
    # A company client is addressed by its company name, with the contact
    # underneath; a private individual only has the name.
    name = client.company_name or personal
    details = [
        line
        for line in (
            personal if client.company_name else None,
            f"Tél : {client.phone}" if client.phone else None,
            client.email,
        )
        if line
    ]
    address = [client.address] if client.address else []
    return DocumentParty(name=name or "—", address_lines=address, detail_lines=details)


def quote_to_document(
    *,
    quote: Quote,
    lines: list[QuoteLine],
    client: Client,
    profile: BrandingProfileRead,
    vat_breakdown: list[VatBucket],
    logo: bytes | None,
    signature: bytes | None = None,
    stamp: bytes | None = None,
    issued_on: date | None = None,
) -> Document:
    """``logo`` arrives as bytes, already read from storage by the caller.

    The engine must not know a ``StorageProvider`` exists, and this mapper
    has no business reading files either — so the service loads, and both
    of these stay pure functions of their inputs.
    """
    brand = profile.brand
    # The document is dated when it was created, not when it was printed:
    # re-downloading a quote next month must not silently re-date the document
    # the customer already holds.
    resolved_issued_on = issued_on or quote.created_at.date()
    validity_days = profile.company.quote_validity_days or 30
    return Document(
        title=QUOTE_TITLE,
        number=quote.quote_number,
        issued_on=resolved_issued_on,
        valid_until=resolved_issued_on + timedelta(days=validity_days),
        issuer=_company_party(profile),
        recipient=_client_party(client),
        lines=[
            DocumentLine(
                designation=line.designation,
                unit=line.unit,
                quantity=line.quantity,
                unit_price_ht=line.unit_price_ht,
                vat_rate=line.vat_rate,
                total_ht=line.total_ht,
            )
            for line in lines
        ],
        totals=DocumentTotals(
            total_ht=quote.total_ht,
            total_vat=quote.total_vat,
            total_ttc=quote.total_ttc,
            vat_rows=[
                DocumentVatRow(rate=b.rate, base_ht=b.base_ht, vat_amount=b.vat_amount)
                for b in vat_breakdown
            ],
        ),
        legal_mentions=_quote_legal_mentions(profile.company),
        branding=DocumentBranding(
            logo=logo,
            primary_color=brand.primary_color,
            secondary_color=brand.secondary_color,
            tagline=brand.tagline,
            signature=signature,
            stamp=stamp,
        ),
        # Franchise-en-base quotes carry no VAT (the rate was forced to 0 at
        # creation), so the document shows no VAT column/total and states the
        # 293 B mention instead.
        show_vat=profile.company.vat_regime != "franchise",
        signature_label=QUOTE_SIGNATURE_LABEL,
    )
