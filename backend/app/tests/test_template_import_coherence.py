"""Décision 8 — identity coherence at import.

The check keeps the promise ("we reproduce *your* identity") and is deliberately
conservative on false positives: only a **differing SIRET** ever warns; a
differing name alone, or an unconfigured account, never does.
"""

from app.template_import.coherence import assess
from app.template_import.schemas import IdentityVerdict


def test_matching_siret_is_recognized() -> None:
    result = assess(
        extracted_siret="948 081 807 00018",  # spacing must not matter
        extracted_name="SARL CHAPOT ÉNERGIES",
        account_siret="94808180700018",
        account_names=["Chapot Énergies Renouvelables", None],
    )
    assert result.verdict is IdentityVerdict.RECOGNIZED
    assert result.siret_matches is True


def test_a_different_siret_is_a_mismatch() -> None:
    result = assess(
        extracted_siret="11111111100011",
        extracted_name="Menuiserie Durand",
        account_siret="94808180700018",
        account_names=["Chapot", None],
    )
    assert result.verdict is IdentityVerdict.MISMATCH
    assert result.siret_matches is False


def test_name_confirms_recognition_when_no_siret() -> None:
    result = assess(
        extracted_siret=None,
        extracted_name="SARL Chapot Énergies Renouvelables",
        account_siret=None,
        account_names=["Chapot Énergies", None],
    )
    assert result.verdict is IdentityVerdict.RECOGNIZED


def test_a_differing_name_alone_never_warns() -> None:
    """No SIRET to confirm, and a different name → unverified, NOT mismatch.
    Extraction is noisy; a name difference must never accuse an honest artisan."""
    result = assess(
        extracted_siret=None,
        extracted_name="Menuiserie Durand",
        account_siret=None,
        account_names=["Chapot Énergies", None],
    )
    assert result.verdict is IdentityVerdict.UNVERIFIED


def test_no_legible_identity_is_unverified() -> None:
    result = assess(
        extracted_siret=None, extracted_name=None, account_siret=None, account_names=[None, None]
    )
    assert result.verdict is IdentityVerdict.UNVERIFIED


def test_account_without_a_siret_never_mismatches() -> None:
    """A brand-new account (no SIRET configured yet) importing its first devis is
    the primary legitimate case — it must never be flagged as a mismatch."""
    result = assess(
        extracted_siret="94808180700018",
        extracted_name="Chapot",
        account_siret=None,
        account_names=[None, None],
    )
    assert result.verdict is not IdentityVerdict.MISMATCH
