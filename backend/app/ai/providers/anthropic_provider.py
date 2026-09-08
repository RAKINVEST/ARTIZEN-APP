"""Anthropic (Claude) implementation of the ``AIProvider`` contract.

The first real network call in the AI abstraction layer (Étape 7). Every
business service still depends only on ``AIProvider`` — this class is
the only file that imports the ``anthropic`` SDK, including its exception
types, which it translates into the provider-agnostic
``AIProviderUnavailableError`` so callers never import the SDK just to
handle a failure.
"""

import logging

from anthropic import APIError, AsyncAnthropic

from app.ai.base import AIProvider
from app.ai.exceptions import AIProviderUnavailableError
from app.ai.schemas import AIMessage, AIResponse

logger = logging.getLogger(__name__)

# The SDK's own defaults are a 10-minute timeout with 2 retries — up to
# 30 minutes on a single request an artisan is synchronously waiting on.
# 30s is well past a normal catalog match, and fails fast enough to show a
# real message instead of a hung screen.
_REQUEST_TIMEOUT_SECONDS = 30.0
_MAX_RETRIES = 2

# Covers the JSON answer with room to spare. This budget is shared with
# thinking tokens whenever thinking is active, so a tight value can be
# consumed before the reply even starts and surface as a bogus "invalid AI
# response" — 1024 was too close for comfort.
_DEFAULT_MAX_TOKENS = 4096


class AnthropicProvider(AIProvider):
    def __init__(self, api_key: str, model: str = "claude-sonnet-5") -> None:
        self._client = AsyncAnthropic(
            api_key=api_key,
            timeout=_REQUEST_TIMEOUT_SECONDS,
            max_retries=_MAX_RETRIES,
        )
        self.model = model

    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        # The Messages API takes "system" as a separate top-level string,
        # not as a message with role "system" like OpenAI-style APIs do.
        system_prompt = "\n\n".join(m.content for m in messages if m.role == "system")
        conversation = [
            {"role": m.role, "content": m.content} for m in messages if m.role != "system"
        ]

        max_tokens = kwargs.get("max_tokens", _DEFAULT_MAX_TOKENS)
        # Optional per-request timeout override. Additive and backward-compatible:
        # existing (interactive) callers pass none and keep the 30s client budget;
        # a heavier, non-interactive caller (the document-clone enricher, whose
        # Claude call runs well past 30s with default extended thinking) can raise
        # it without changing the copilot's behaviour.
        request_timeout = kwargs.get("timeout")
        extra = {} if request_timeout is None else {"timeout": float(request_timeout)}
        try:
            response = await self._client.messages.create(
                model=self.model,
                system=system_prompt or "You are a helpful assistant.",
                messages=conversation,
                max_tokens=(
                    int(max_tokens)
                    if isinstance(max_tokens, int | str)
                    else _DEFAULT_MAX_TOKENS
                ),
                **extra,
            )
        except APIError as exc:
            # Base class of every SDK failure: connection, timeout, 429 and
            # 5xx alike. They all mean one thing to the caller — the copilot
            # can't answer right now — so they collapse into a single
            # provider-agnostic error instead of a raw 500.
            logger.warning("anthropic.request_failed model=%s error=%s", self.model, exc)
            raise AIProviderUnavailableError(
                "The AI provider is momentarily unavailable. Please try again."
            ) from exc

        content = "".join(
            block.text for block in response.content if getattr(block, "type", None) == "text"
        )
        return AIResponse(content=content, provider="anthropic", model=self.model)
