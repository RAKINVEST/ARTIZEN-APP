"""Identity coherence at import — Décision 8.

Does the imported devis's identity (SIRET, raison sociale) match the account's
own? This verifies the promise — *ARTIZEN reproduces **your** identity* — and is
**never** a fraud gate.

Deliberately **conservative on false positives** (a false accusation of a honest
artisan costs more than a rare miss):

* the **SIRET** is the strong signal. Both present and equal → *recognized*; both
  present and **different** → *mismatch* (the only case that warns — and even then
  the product asks to confirm, it never blocks, because a legitimate SIRET can
  differ: rachat, changement de forme sociale, franchise, groupe…);
* a differing **name** alone never warns — extraction is noisy and legal forms
  vary; the name only serves to *confirm* recognition when no SIRET is available;
* no legible identity, or an account not yet configured → *unverified* (a soft
  "is this your company?"), never a mismatch.
"""

import re

from app.template_import.schemas import IdentityCoherence, IdentityVerdict

# Legal forms carry no identity signal — dropped before comparing names.
_LEGAL_FORMS = frozenset(
    {"sarl", "sas", "sasu", "eurl", "ei", "eirl", "sa", "sci", "scop", "snc",
     "ets", "entreprise", "societe", "ste", "sarlu"}
)


def _digits(value: str | None) -> str:
    return re.sub(r"\D", "", value or "")


def _name_tokens(name: str | None) -> set[str]:
    cleaned = re.sub(r"[^0-9a-zà-ÿ]+", " ", (name or "").lower())
    return {token for token in cleaned.split() if token and token not in _LEGAL_FORMS}


def _names_match(extracted: str | None, account: str | None) -> bool:
    """A positive-only signal: enough distinctive tokens in common. Never used to
    *raise* a mismatch, only to *confirm* recognition when no SIRET is available."""
    left, right = _name_tokens(extracted), _name_tokens(account)
    if not left or not right:
        return False
    common = left & right
    return bool(common) and len(common) >= min(len(left), len(right)) * 0.5


def assess(
    *,
    extracted_siret: str | None,
    extracted_name: str | None,
    account_siret: str | None,
    account_names: list[str | None],
) -> IdentityCoherence:
    """Judge whether the imported identity looks like the account's own."""
    siret_extracted, siret_account = _digits(extracted_siret), _digits(account_siret)

    if siret_extracted and siret_account:
        matches = siret_extracted == siret_account
        return IdentityCoherence(
            verdict=IdentityVerdict.RECOGNIZED if matches else IdentityVerdict.MISMATCH,
            siret_matches=matches,
            extracted_siret=extracted_siret,
            extracted_name=extracted_name,
        )

    if extracted_name and any(_names_match(extracted_name, name) for name in account_names):
        return IdentityCoherence(
            verdict=IdentityVerdict.RECOGNIZED,
            siret_matches=None,
            extracted_siret=extracted_siret,
            extracted_name=extracted_name,
        )

    return IdentityCoherence(
        verdict=IdentityVerdict.UNVERIFIED,
        siret_matches=None,
        extracted_siret=extracted_siret,
        extracted_name=extracted_name,
    )
