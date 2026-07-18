"""Tests for Phase 1 — legal compliance & full company configuration.

Two layers: pure unit tests on the legal-mention builder (no DB), and
API-level tests proving an artisan can configure their whole company through
``PUT /branding/company`` and that the VAT regime drives the quote's amounts.
"""

import uuid

from httpx import AsyncClient

from app.branding.schemas import CompanyRead
from app.quotes.document_mapper import _quote_legal_mentions


def _company(**overrides) -> CompanyRead:
    base = dict(
        id=uuid.uuid4(), name="X", legal_name=None, siret=None, vat_number=None,
        address_line=None, postal_code=None, city=None, country="France", phone=None,
        email=None, website=None, legal_form=None, share_capital=None, rcs_rm=None,
        ape_code=None, insurance_name=None, insurance_contract=None, insurance_coverage=None,
        rge_number=None, payment_terms=None, vat_regime="normal", quote_validity_days=30,
    )
    base.update(overrides)
    return CompanyRead(**base)


# --- unit: the legal-mention builder ----------------------------------------


def test_franchise_states_the_293b_mention() -> None:
    mentions = _quote_legal_mentions(_company(vat_regime="franchise"))
    assert any("293 B du CGI" in m for m in mentions)


def test_normal_regime_has_no_293b_mention() -> None:
    mentions = _quote_legal_mentions(_company(vat_regime="normal"))
    assert not any("293 B" in m for m in mentions)


def test_insurance_and_rge_are_printed_when_configured() -> None:
    mentions = _quote_legal_mentions(
        _company(
            insurance_name="AXA",
            insurance_contract="DEC-99",
            insurance_coverage="France métropolitaine",
            rge_number="QB/12345",
        )
    )
    assert any("Assurance décennale : AXA" in m and "DEC-99" in m and "métropolitaine" in m for m in mentions)
    assert any("RGE : QB/12345" in m for m in mentions)


def test_validity_period_is_configurable() -> None:
    assert any("45 jours" in m for m in _quote_legal_mentions(_company(quote_validity_days=45)))
    assert any("30 jours" in m for m in _quote_legal_mentions(_company(quote_validity_days=30)))


def test_unconfigured_company_omits_optional_mentions() -> None:
    # A brand-new account prints only what applies — never an empty "Assurance : ".
    mentions = _quote_legal_mentions(_company())
    assert not any("Assurance" in m for m in mentions)
    assert not any("RGE" in m for m in mentions)


# --- API: full self-service configuration + VAT regime ----------------------

_FULL_CONFIG = {
    "legal_name": "PLOMBERIE TEST SARL",
    "siret": "12345678900012",
    "legal_form": "SARL",
    "share_capital": "5 000 €",
    "rcs_rm": "RCS Paris 123 456 789",
    "ape_code": "4322A",
    "vat_number": "FR12345678900",
    "insurance_name": "AXA",
    "insurance_contract": "DEC-2024-99",
    "insurance_coverage": "France métropolitaine",
    "rge_number": "QB/12345",
    "payment_terms": "30 jours nets",
    "quote_validity_days": 45,
}


async def test_company_can_be_fully_configured_via_api(client: AsyncClient) -> None:
    response = await client.put("/api/branding/company", json=_FULL_CONFIG)
    assert response.status_code == 200
    body = response.json()
    for field, value in _FULL_CONFIG.items():
        assert body[field] == value, f"{field} not persisted"


async def _make_quote_vat(client: AsyncClient, vat_regime: str) -> str:
    await client.put("/api/branding/company", json={"vat_regime": vat_regime})
    cat = (await client.post("/api/catalog/categories", json={"name": "C"})).json()["id"]
    item = (
        await client.post(
            "/api/catalog/items",
            json={
                "category_id": cat, "designation": "Chaudière", "item_type": "product",
                "unit": "u", "unit_price_ht": "1000.00", "vat_rate": "20.00",
            },
        )
    ).json()["id"]
    cli = (await client.post("/api/clients", json={"last_name": "Martin"})).json()["id"]
    quote = (
        await client.post(
            "/api/quotes",
            json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "1.00"}]},
        )
    ).json()
    return quote["total_vat"]


async def test_franchise_regime_produces_a_vat_free_quote(client: AsyncClient) -> None:
    assert await _make_quote_vat(client, "franchise") == "0.00"


async def test_normal_regime_computes_vat(client: AsyncClient) -> None:
    assert await _make_quote_vat(client, "normal") == "200.00"


async def test_configured_quote_pdf_carries_the_legal_mentions(client: AsyncClient) -> None:
    """End-to-end: configure the company, create a quote, and confirm the PDF
    it renders contains the mandatory mentions."""
    import io

    from pypdf import PdfReader

    await client.put("/api/branding/company", json={**_FULL_CONFIG, "vat_regime": "franchise"})
    cat = (await client.post("/api/catalog/categories", json={"name": "C"})).json()["id"]
    item = (
        await client.post(
            "/api/catalog/items",
            json={
                "category_id": cat, "designation": "Chaudière", "item_type": "product",
                "unit": "u", "unit_price_ht": "1000.00", "vat_rate": "20.00",
            },
        )
    ).json()["id"]
    cli = (await client.post("/api/clients", json={"last_name": "Martin"})).json()["id"]
    quote = (
        await client.post(
            "/api/quotes",
            json={"client_id": cli, "lines": [{"catalog_item_id": item, "quantity": "1.00"}]},
        )
    ).json()
    pdf = (await client.get(f"/api/quotes/{quote['id']}/pdf")).content
    text = " ".join(page.extract_text() for page in PdfReader(io.BytesIO(pdf)).pages)

    assert "293 B du CGI" in text
    assert "Assurance décennale : AXA" in text
    assert "RGE : QB/12345" in text
    assert "Bon pour accord" in text
    assert "SARL au capital de 5 000" in text
    assert "Total TVA" not in text  # franchise: no VAT total shown
