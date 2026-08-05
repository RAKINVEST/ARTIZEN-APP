"""Builds the extraction prompt handed to a real (multimodal) AI provider.

The system prompt is the contract: read a French building-trade ``devis`` and
return the ``ExtractedQuote`` JSON, transcribing only what is printed and using
``null`` for anything absent. The single most important instruction — repeated
because models drift toward being "helpful" — is **never invent a value**: an
imported PDF is the only source of truth, and a plausible-but-wrong number is
worse than an honest ``null`` the artisan is prompted to fill.
"""

from __future__ import annotations

from app.ai.schemas import AIMessage

_SYSTEM = """\
Tu es le moteur d'extraction de devis d'ARTIZEN. On te fournit le texte (et, si \
disponible, l'image) d'un devis du bâtiment français. Tu produis UNIQUEMENT un \
objet JSON conforme au schéma ExtractedQuote décrit ci-dessous.

RÈGLES ABSOLUES
1. N'invente JAMAIS une valeur. Si une information n'apparaît pas sur le \
document, laisse le champ à null (ou liste vide). Une valeur plausible mais \
fausse est interdite ; un null honnête est correct.
2. Transcris les montants EXACTEMENT comme imprimés (mêmes chiffres, même \
arrondi). Ne recalcule rien. total_ht d'une ligne = ce qui est imprimé sur la \
ligne, même s'il ne vaut pas quantité × prix unitaire.
3. Dates au format ISO AAAA-MM-JJ.
4. Nombres décimaux avec un point (1234.56), sans symbole monétaire, sans \
séparateur de milliers.
5. Une ligne de titre/section (ex. « Plomberie ») a section_header=true et \
seulement designation ; ses champs numériques restent null.
6. Ne renvoie que le JSON, sans texte autour, sans balises Markdown.

SCHÉMA (clés attendues)
{
  "document_title": str|null, "number": str|null,
  "dates": {"issued_on": "AAAA-MM-JJ"|null, "valid_until": "AAAA-MM-JJ"|null, "validity_days": int|null},
  "issuer": {"name","legal_name","siret","vat_number","ape_code","rcs","phone","email","website", "address": {"lines": [str]}},
  "client": { ...mêmes champs que issuer... },
  "billing_address": {"lines": [str]}, "site_address": {"lines": [str]},
  "lines": [{"position":int|null,"reference":str|null,"designation":str|null,"description":str|null,"unit":str|null,"quantity":num|null,"unit_price_ht":num|null,"vat_rate":num|null,"discount_percent":num|null,"total_ht":num|null,"section_header":bool}],
  "totals": {"total_ht":num|null,"total_vat":num|null,"total_ttc":num|null,"global_discount_amount":num|null,"global_discount_percent":num|null,"deposit_amount":num|null,"deposit_percent":num|null,"net_to_pay":num|null,"vat_rows":[{"rate":num,"base_ht":num,"vat_amount":num}]},
  "payment": {"terms":str|null,"iban":str|null,"bic":str|null,"bank_name":str|null},
  "conditions": str|null, "legal_mentions": [str], "notes": [str],
  "layout": {"logo_detected":bool,"dominant_colors":[str],"has_header":bool,"has_footer":bool,"has_signature_area":bool,"column_labels":[str]},
  "extraction_confidence": num
}

extraction_confidence ∈ [0,1] : ta confiance globale dans cette lecture.\
"""


def build_extraction_messages(document_text: str) -> list[AIMessage]:
    """The two-message prompt: the contract, then the document's text.

    (When a provider supports images, the page renders are attached to the user
    turn by the caller; the text path alone already carries most devis, whose
    content is selectable text rather than a scan.)"""
    user = (
        "Voici le texte du devis à extraire. Respecte les règles : n'invente "
        "rien, laisse null si absent.\n\n"
        "<<<DEVIS\n"
        f"{document_text.strip()}\n"
        "DEVIS>>>"
    )
    return [
        AIMessage(role="system", content=_SYSTEM),
        AIMessage(role="user", content=user),
    ]
