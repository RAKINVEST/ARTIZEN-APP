"""Tests for the quote-assistant module (Étape 7, extended in Étape 9): a
free-text description turned into catalog-item suggestions via a fake
AI provider, business-validated, scored, and never turned into a quote
automatically.

The real ``AnthropicProvider`` is never exercised here (no network
call, no API key needed): ``get_default_ai_provider`` is overridden via
``app.dependency_overrides`` with a ``FakeAIProvider`` returning canned
JSON, exactly the mechanism ``app/ai/deps.py`` was built for.
"""

import json
import uuid
from collections.abc import Iterator

import pytest
from httpx import AsyncClient

from app.ai.base import AIProvider
from app.ai.deps import get_default_ai_provider
from app.ai.schemas import AIMessage, AIResponse
from app.catalog.models import ItemType
from app.main import app
from app.quote_assistant.prompt_builder import PromptBuilder
from app.quote_assistant.suggestion_scorer import SuggestionScorer


class FakeAIProvider(AIProvider):
    def __init__(self, content: str) -> None:
        self._content = content

    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        return AIResponse(content=self._content, provider="fake", model="fake-model")


class CapturingFakeAIProvider(AIProvider):
    """Records the messages it was called with, so a test can inspect
    exactly what `PromptBuilder` produced (company context, usage
    counts, ...) without needing a real AI call."""

    def __init__(self, content: str) -> None:
        self._content = content
        self.last_messages: list[AIMessage] | None = None

    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        self.last_messages = messages
        return AIResponse(content=self._content, provider="fake", model="fake-model")


def _mock_ai_response(content: str) -> None:
    app.dependency_overrides[get_default_ai_provider] = lambda: FakeAIProvider(content)


@pytest.fixture(autouse=True)
def _clear_ai_override() -> Iterator[None]:
    yield
    app.dependency_overrides.pop(get_default_ai_provider, None)


@pytest.fixture
async def company_id(client: AsyncClient) -> str:
    response = await client.get("/api/branding/profile")
    return response.json()["company"]["id"]


@pytest.fixture
async def category_id(client: AsyncClient, company_id: str) -> str:
    response = await client.post(
        "/api/catalog/categories", json={"company_id": company_id, "name": "Chauffage"}
    )
    return response.json()["id"]


@pytest.fixture
async def item_id(client: AsyncClient, company_id: str, category_id: str) -> str:
    response = await client.post(
        "/api/catalog/items",
        json={
            "company_id": company_id,
            "category_id": category_id,
            "designation": "Chauffe-eau Atlantic 200 L",
            "item_type": ItemType.PRODUCT.value,
            "unit": "unite",
            "unit_price_ht": "450.00",
            "vat_rate": "20.00",
        },
    )
    return response.json()["id"]


async def test_suggest_valid_ai_response(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    _mock_ai_response(
        json.dumps(
            {
                "items": [
                    {
                        "catalog_item_id": item_id,
                        "quantity": 1,
                        "reason": "Correspond au chauffe-eau demandé",
                    }
                ],
                "confidence": 0.9,
                "comment": "Une seule correspondance claire.",
            }
        )
    )

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={
            "company_id": company_id,
            "description": "Remplacement d'un chauffe-eau Atlantic 200 litres",
        },
    )

    assert response.status_code == 200
    body = response.json()
    assert len(body["items"]) == 1
    assert body["items"][0]["catalog_item_id"] == item_id
    assert body["items"][0]["designation"] == "Chauffe-eau Atlantic 200 L"
    assert body["confidence"] == 0.9
    assert body["comment"] == "Une seule correspondance claire."


async def test_suggest_tolerates_markdown_code_fence(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    raw = json.dumps(
        {
            "items": [{"catalog_item_id": item_id, "quantity": 2, "reason": "ok"}],
            "confidence": 0.8,
            "comment": "ok",
        }
    )
    _mock_ai_response(f"```json\n{raw}\n```")

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 200
    assert response.json()["items"][0]["quantity"] == "2"


async def test_suggest_rejects_nonexistent_item(client: AsyncClient, company_id: str) -> None:
    _mock_ai_response(
        json.dumps(
            {
                "items": [
                    {
                        "catalog_item_id": str(uuid.uuid4()),
                        "quantity": 1,
                        "reason": "hallucination",
                    }
                ],
                "confidence": 0.95,
                "comment": "je suis très sûr",
            }
        )
    )

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 200
    body = response.json()
    assert body["items"] == []
    assert body["confidence"] == 0.0


async def test_suggest_rejects_inactive_item(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    await client.delete(f"/api/catalog/items/{item_id}")  # deactivates

    _mock_ai_response(
        json.dumps(
            {
                "items": [{"catalog_item_id": item_id, "quantity": 1, "reason": "ok"}],
                "confidence": 0.9,
                "comment": "ok",
            }
        )
    )

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 200
    body = response.json()
    assert body["items"] == []
    assert body["confidence"] == 0.0


async def test_suggest_ignores_item_from_another_company(
    client: AsyncClient, second_client: AsyncClient, item_id: str
) -> None:
    """`item_id` belongs to `client`'s company. Since Étape 10, the
    endpoint derives `company_id` from the authenticated session only —
    never from the request body — so calling it as `second_client` (a
    real, independently-registered company) must never see or validate
    that item, regardless of what `company_id` the request claims."""
    _mock_ai_response(
        json.dumps(
            {
                "items": [{"catalog_item_id": item_id, "quantity": 1, "reason": "ok"}],
                "confidence": 0.9,
                "comment": "ok",
            }
        )
    )

    response = await second_client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": str(uuid.uuid4()), "description": "peu importe"},
    )

    assert response.status_code == 200
    assert response.json()["items"] == []


async def test_suggest_invalid_json_response(client: AsyncClient, company_id: str) -> None:
    _mock_ai_response("this is not JSON at all")

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 502
    assert response.json()["error"]["code"] == "invalid_ai_response"


async def test_suggest_low_confidence_passthrough(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    _mock_ai_response(
        json.dumps(
            {
                "items": [{"catalog_item_id": item_id, "quantity": 1, "reason": "peu sûr"}],
                "confidence": 0.15,
                "comment": "Correspondance incertaine.",
            }
        )
    )

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "description vague"},
    )

    assert response.status_code == 200
    body = response.json()
    assert len(body["items"]) == 1
    assert body["confidence"] == 0.15


async def test_suggest_never_creates_a_quote(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    before = await client.get("/api/quotes", params={"company_id": company_id})
    quotes_before = len(before.json())

    _mock_ai_response(
        json.dumps(
            {
                "items": [{"catalog_item_id": item_id, "quantity": 1, "reason": "ok"}],
                "confidence": 0.9,
                "comment": "ok",
            }
        )
    )
    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )
    assert response.status_code == 200
    assert "id" not in response.json()
    assert "quote_id" not in response.json()

    after = await client.get("/api/quotes", params={"company_id": company_id})
    assert len(after.json()) == quotes_before


def test_scorer_full_validity_keeps_raw_confidence() -> None:
    score = SuggestionScorer().score(raw_confidence=0.8, total_count=2, valid_count=2)
    assert score == 0.8


def test_scorer_partial_validity_discounts_confidence() -> None:
    score = SuggestionScorer().score(raw_confidence=0.8, total_count=2, valid_count=1)
    assert score == 0.4


def test_scorer_no_items_is_zero_confidence() -> None:
    score = SuggestionScorer().score(raw_confidence=0.9, total_count=0, valid_count=0)
    assert score == 0.0


def test_prompt_builder_includes_description_and_catalog() -> None:
    from app.catalog.models import CatalogItem

    item = CatalogItem(
        id=uuid.uuid4(),
        company_id=uuid.uuid4(),
        category_id=uuid.uuid4(),
        designation="Groupe de sécurité",
        item_type=ItemType.PRODUCT,
        unit="unite",
        unit_price_ht="15.00",
        vat_rate="20.00",
    )

    messages = PromptBuilder().build("Remplacement chauffe-eau", [item])

    assert messages[0].role == "system"
    assert "jamais" in messages[0].content.lower()
    assert messages[1].role == "user"
    assert "Remplacement chauffe-eau" in messages[1].content
    assert "Groupe de sécurité" in messages[1].content
    assert str(item.id) in messages[1].content


# --- Étape 9: company context, usage frequency, ambiguity handling ---


def test_prompt_builder_includes_company_context_and_usage_counts() -> None:
    from app.catalog.models import CatalogItem

    item_id = uuid.uuid4()
    item = CatalogItem(
        id=item_id,
        company_id=uuid.uuid4(),
        category_id=uuid.uuid4(),
        designation="Groupe de sécurité",
        item_type=ItemType.PRODUCT,
        unit="unite",
        unit_price_ht="15.00",
        vat_rate="20.00",
    )

    messages = PromptBuilder().build(
        "Remplacement chauffe-eau",
        [item],
        company_name="Chauffage Rapide",
        usage_counts={item_id: 4},
    )

    user_content = messages[1].content
    assert "Chauffage Rapide" in user_content
    assert '"times_used_previously": 4' in user_content


def test_prompt_builder_without_context_omits_it_gracefully() -> None:
    messages = PromptBuilder().build("Une description", [])

    assert "Entreprise" not in messages[1].content


async def test_suggest_includes_company_name_and_usage_counts_in_prompt(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    await client.put("/api/branding/company", json={"name": "Chauffage Rapide"})

    client_response = await client.post(
        "/api/clients", json={"company_id": company_id, "last_name": "Client Assistant"}
    )
    quote_client_id = client_response.json()["id"]
    await client.post(
        "/api/quotes",
        json={
            "company_id": company_id,
            "client_id": quote_client_id,
            "lines": [{"catalog_item_id": item_id, "quantity": "1"}],
        },
    )

    capturing = CapturingFakeAIProvider(
        json.dumps({"items": [], "confidence": 0.0, "comment": "ok"})
    )
    app.dependency_overrides[get_default_ai_provider] = lambda: capturing

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 200
    assert capturing.last_messages is not None
    user_message = next(m for m in capturing.last_messages if m.role == "user")
    assert "Chauffage Rapide" in user_message.content
    assert '"times_used_previously": 1' in user_message.content


async def test_suggest_deduplicates_repeated_item_and_discounts_confidence(
    client: AsyncClient, company_id: str, item_id: str
) -> None:
    _mock_ai_response(
        json.dumps(
            {
                "items": [
                    {"catalog_item_id": item_id, "quantity": 1, "reason": "premiere mention"},
                    {"catalog_item_id": item_id, "quantity": 2, "reason": "deuxieme mention"},
                ],
                "confidence": 0.9,
                "comment": "ambigu",
            }
        )
    )

    response = await client.post(
        "/api/quote-assistant/suggest",
        json={"company_id": company_id, "description": "peu importe"},
    )

    assert response.status_code == 200
    body = response.json()
    assert len(body["items"]) == 1
    assert body["items"][0]["reason"] == "premiere mention"
    # total_count=2, valid_count=1 -> 0.9 * 0.5 = 0.45, minus one duplicate
    # penalty (0.05) = 0.40.
    assert body["confidence"] == 0.40


def test_scorer_duplicate_penalty_reduces_confidence() -> None:
    score = SuggestionScorer().score(
        raw_confidence=0.8, total_count=1, valid_count=1, duplicate_count=1
    )
    assert score == 0.75


def test_scorer_clamps_out_of_range_raw_confidence() -> None:
    score = SuggestionScorer().score(raw_confidence=1.5, total_count=1, valid_count=1)
    assert score == 1.0


def test_scorer_never_goes_negative() -> None:
    score = SuggestionScorer().score(
        raw_confidence=0.1, total_count=1, valid_count=1, duplicate_count=10
    )
    assert score == 0.0


async def test_match_validator_reports_rejection_reasons() -> None:
    from app.catalog.repository import CatalogItemRepository
    from app.quote_assistant.match_validator import MatchValidator
    from app.quote_assistant.schemas import RawSuggestionItem

    class _NoopRepo:
        async def get(self, item_id: object) -> None:
            return None

    validator = MatchValidator(_NoopRepo())  # type: ignore[arg-type]
    same_id = uuid.uuid4()
    result = await validator.validate(
        [
            RawSuggestionItem(catalog_item_id=same_id, quantity=1, reason="a"),
            RawSuggestionItem(catalog_item_id=same_id, quantity=1, reason="b"),
        ],
        company_id=uuid.uuid4(),
    )

    assert result.duplicate_count == 1
    reasons = {rejected.reason for rejected in result.rejected_items}
    assert "duplicate" in reasons
    assert "not_found" in reasons


def test_mock_provider_cites_matched_keywords_in_reason() -> None:
    import asyncio

    from app.ai.providers.mock_provider import MockAIProvider

    catalog = [
        {
            "catalog_item_id": "item-1",
            "designation": "Chauffe-eau Atlantic 200 L",
            "description": None,
            "unit": "unite",
            "item_type": "product",
            "times_used_previously": 0,
        },
    ]
    user_content = (
        f"Catalogue disponible (JSON) :\n{json.dumps(catalog)}\n\n"
        "Description du client à analyser :\nRemplacement chauffe-eau Atlantic"
    )

    response = asyncio.run(
        MockAIProvider().complete([AIMessage(role="user", content=user_content)])
    )

    payload = json.loads(response.content)
    reason = payload["items"][0]["reason"]
    assert "atlantic" in reason.lower()
    assert "chauffe-eau" in reason.lower()


def test_mock_provider_lowers_confidence_on_tied_ambiguous_candidates() -> None:
    import asyncio

    from app.ai.providers.mock_provider import MockAIProvider

    catalog = [
        {
            "catalog_item_id": "item-1",
            "designation": "Radiateur electrique 1000W",
            "description": None,
            "unit": "unite",
            "item_type": "product",
            "times_used_previously": 0,
        },
        {
            "catalog_item_id": "item-2",
            "designation": "Radiateur electrique 1500W",
            "description": None,
            "unit": "unite",
            "item_type": "product",
            "times_used_previously": 0,
        },
    ]
    user_content = (
        f"Catalogue disponible (JSON) :\n{json.dumps(catalog)}\n\n"
        "Description du client à analyser :\nInstallation d'un radiateur electrique"
    )

    response = asyncio.run(
        MockAIProvider().complete([AIMessage(role="user", content=user_content)])
    )

    payload = json.loads(response.content)
    assert payload["confidence"] == 0.35


def test_mock_provider_breaks_ties_with_usage_frequency() -> None:
    import asyncio

    from app.ai.providers.mock_provider import MockAIProvider

    catalog = [
        {
            "catalog_item_id": "item-rare",
            "designation": "Radiateur electrique",
            "description": None,
            "unit": "unite",
            "item_type": "product",
            "times_used_previously": 0,
        },
        {
            "catalog_item_id": "item-frequent",
            "designation": "Radiateur electrique",
            "description": None,
            "unit": "unite",
            "item_type": "product",
            "times_used_previously": 12,
        },
    ]
    user_content = (
        f"Catalogue disponible (JSON) :\n{json.dumps(catalog)}\n\n"
        "Description du client à analyser :\nInstallation d'un radiateur electrique"
    )

    response = asyncio.run(
        MockAIProvider().complete([AIMessage(role="user", content=user_content)])
    )

    payload = json.loads(response.content)
    # Same keyword overlap for both -> tie broken by usage frequency, not
    # left to arbitrary list order.
    assert payload["items"][0]["catalog_item_id"] == "item-frequent"
