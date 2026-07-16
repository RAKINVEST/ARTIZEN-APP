"""OpenAI implementation of the ``AIProvider`` contract.

The actual API call is intentionally not implemented yet: this foundation
phase only wires the abstraction so a real integration can be dropped in
without touching ``AIProvider`` consumers.
"""

from app.ai.base import AIProvider
from app.ai.schemas import AIMessage, AIResponse


class OpenAIProvider(AIProvider):
    def __init__(self, api_key: str, model: str = "gpt-4o-mini") -> None:
        self.api_key = api_key
        self.model = model

    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        raise NotImplementedError(
            "OpenAIProvider.complete will be implemented alongside the first AI feature."
        )
