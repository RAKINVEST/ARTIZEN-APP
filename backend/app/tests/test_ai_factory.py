"""Tests for the automatic, key-driven AI provider selection: a missing
API key must never raise, never block, and never require a decision
from anyone — it must transparently fall back to ``MockAIProvider``.
Adding the key back must switch to the real provider automatically, on
the very next call, without touching any code.
"""

import json

import pytest

from app.ai import factory
from app.ai.providers.anthropic_provider import AnthropicProvider
from app.ai.providers.mock_provider import MockAIProvider
from app.ai.schemas import AIMessage
from app.core.exceptions import AppException


@pytest.fixture(autouse=True)
def _clear_provider_cache():
    factory.get_ai_provider.cache_clear()
    yield
    factory.get_ai_provider.cache_clear()


def test_falls_back_to_mock_when_anthropic_key_is_missing(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(factory.settings, "ANTHROPIC_API_KEY", None)

    provider = factory.get_ai_provider("anthropic")

    assert isinstance(provider, MockAIProvider)


def test_uses_anthropic_automatically_once_the_key_is_present(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    monkeypatch.setattr(factory.settings, "ANTHROPIC_API_KEY", "sk-ant-test-000")

    provider = factory.get_ai_provider("anthropic")

    assert isinstance(provider, AnthropicProvider)


def test_falls_back_to_mock_for_openai_and_mistral_too(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(factory.settings, "OPENAI_API_KEY", None)
    monkeypatch.setattr(factory.settings, "MISTRAL_API_KEY", None)

    assert isinstance(factory.get_ai_provider("openai"), MockAIProvider)
    assert isinstance(factory.get_ai_provider("mistral"), MockAIProvider)


def test_unknown_provider_name_still_raises() -> None:
    with pytest.raises(AppException):
        factory.get_ai_provider("does-not-exist")


async def test_mock_provider_matches_by_keyword_overlap() -> None:
    catalog = [
        {
            "catalog_item_id": "item-1",
            "designation": "Chauffe-eau Atlantic 200 L",
            "description": None,
            "unit": "unite",
            "item_type": "product",
        },
        {
            "catalog_item_id": "item-2",
            "designation": "Robinet thermostatique",
            "description": None,
            "unit": "unite",
            "item_type": "product",
        },
    ]
    user_content = (
        f"Catalogue disponible (JSON) :\n{json.dumps(catalog)}\n\n"
        "Description du client à analyser :\nRemplacement d'un chauffe-eau Atlantic 200 litres"
    )

    response = await MockAIProvider().complete(
        [AIMessage(role="system", content="ignored"), AIMessage(role="user", content=user_content)]
    )

    payload = json.loads(response.content)
    assert payload["items"]
    assert payload["items"][0]["catalog_item_id"] == "item-1"
    assert payload["confidence"] > 0


async def test_mock_provider_returns_empty_but_valid_response_when_no_match() -> None:
    user_content = 'Catalogue disponible (JSON) :\n[]\n\nDescription du client à analyser :\nrien'

    response = await MockAIProvider().complete([AIMessage(role="user", content=user_content)])

    payload = json.loads(response.content)
    assert payload["items"] == []
    assert payload["confidence"] == 0.0
    assert "comment" in payload
