"""FastAPI-injectable accessor for the configured AI provider.

A thin wrapper around ``get_ai_provider()`` (which takes an optional
explicit provider name, incompatible with FastAPI's ``Depends()``, which
only calls dependencies with no arguments or other dependencies). Tests
override ``get_default_ai_provider`` via ``app.dependency_overrides`` to
inject a fake provider, so no test needs a real ``ANTHROPIC_API_KEY``.
"""

from typing import Annotated

from fastapi import Depends

from app.ai.base import AIProvider
from app.ai.factory import get_ai_provider


def get_default_ai_provider() -> AIProvider:
    return get_ai_provider()


AIProviderDep = Annotated[AIProvider, Depends(get_default_ai_provider)]
