"""Abstract contract every AI provider must implement.

Business services (quote drafting, message summarization, ...) depend only
on this interface, never on a concrete provider, so switching or combining
OpenAI / Anthropic / Mistral later requires no change to calling code.
"""

from abc import ABC, abstractmethod

from app.ai.schemas import AIMessage, AIResponse


class AIProvider(ABC):
    @abstractmethod
    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        """Send a chat completion request to the underlying AI provider."""
        raise NotImplementedError
