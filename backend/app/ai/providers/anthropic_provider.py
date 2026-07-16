"""Anthropic (Claude) implementation of the ``AIProvider`` contract.

The first real network call in the AI abstraction layer (Étape 7). Every
business service still depends only on ``AIProvider`` — this class is
the only file that imports the ``anthropic`` SDK.
"""

from anthropic import AsyncAnthropic

from app.ai.base import AIProvider
from app.ai.schemas import AIMessage, AIResponse


class AnthropicProvider(AIProvider):
    def __init__(self, api_key: str, model: str = "claude-sonnet-5") -> None:
        self._client = AsyncAnthropic(api_key=api_key)
        self.model = model

    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        # The Messages API takes "system" as a separate top-level string,
        # not as a message with role "system" like OpenAI-style APIs do.
        system_prompt = "\n\n".join(m.content for m in messages if m.role == "system")
        conversation = [
            {"role": m.role, "content": m.content} for m in messages if m.role != "system"
        ]

        max_tokens = kwargs.get("max_tokens", 1024)
        response = await self._client.messages.create(
            model=self.model,
            system=system_prompt or "You are a helpful assistant.",
            messages=conversation,
            max_tokens=int(max_tokens) if isinstance(max_tokens, int | str) else 1024,
        )

        content = "".join(
            block.text for block in response.content if getattr(block, "type", None) == "text"
        )
        return AIResponse(content=content, provider="anthropic", model=self.model)
