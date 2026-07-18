"""The "devis prêt à émettre" engine (Phase 1.1, Mission 2).

One pure function decides whether a quote is ready to be downloaded, printed or
sent, and — when it is not — returns the *precise* list of what is missing, each
item tagged with where to go and fix it. Pure and reusable: it takes plain
records and returns plain issues, so it can back an API endpoint today and any
other "is this ready?" check tomorrow, and it is trivially testable.

It never mutates anything and never renders — it only judges.
"""

from app.branding.schemas import BrandProfileRead, CompanyRead
from app.clients.models import Client
from app.quotes.models import Quote, QuoteLine
from app.quotes.schemas import ReadinessIssue


def evaluate_readiness(
    *,
    company: CompanyRead,
    brand: BrandProfileRead,
    client: Client | None,
    quote: Quote,
    lines: list[QuoteLine],
) -> list[ReadinessIssue]:
    issues: list[ReadinessIssue] = []

    def add(code: str, label: str, target: str, field: str | None = None) -> None:
        issues.append(ReadinessIssue(code=code, label=label, target=target, field=field))  # type: ignore[arg-type]

    # --- Company identity & regulatory (all fixable in "Mon entreprise") ---
    if not (company.legal_name or company.name):
        add("company_name", "Nom de l'entreprise manquant", "company_profile", "name")
    if not (company.address_line and (company.postal_code or company.city)):
        add("company_address", "Adresse de l'entreprise incomplète", "company_profile", "addressLine")
    if not company.siret:
        add("siret", "SIRET manquant", "company_profile", "siret")
    # Régime TVA : toujours défini ; en régime réel, le n° de TVA est attendu.
    if company.vat_regime == "normal" and not company.vat_number:
        add("vat_number", "N° de TVA manquant (régime réel)", "company_profile", "vatNumber")
    if not company.insurance_name:
        add("insurance", "Assurance décennale non renseignée", "company_profile", "insuranceName")
    if not company.payment_terms:
        add("payment_terms", "Conditions de paiement manquantes", "company_profile", "paymentTerms")
    if not company.quote_validity_days:
        add("validity", "Durée de validité du devis manquante", "company_profile", "quoteValidityDays")
    if not (company.phone or company.email):
        add("contact", "Coordonnées manquantes (téléphone ou email)", "company_profile", "email")
    if not brand.logo_path:
        add("logo", "Logo de l'entreprise absent", "company_profile", "logo")

    # --- Client ---
    if client is None:
        add("client", "Client introuvable", "quote")
    else:
        if not (client.company_name or client.last_name):
            add("client_name", "Nom du client manquant", "client", "lastName")
        if not client.address:
            add("client_address", "Adresse du client manquante", "client", "address")

    # --- Quote content & maths ---
    if not lines:
        add("no_lines", "Le devis ne contient aucune ligne", "quote")
    # The calculator guarantees this; checked anyway so a corrupted row can
    # never leave as a document (defence in depth, not a computation).
    if quote.total_ttc != quote.total_ht + quote.total_vat:
        add("totals", "Incohérence dans les totaux du devis", "quote")

    return issues
