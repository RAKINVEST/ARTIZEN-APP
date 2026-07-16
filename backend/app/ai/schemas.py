"""Provider-agnostic data structures for the AI abstraction layer."""

from typing import Literal

from pydantic import BaseModel


class AIMessage(BaseModel):
    role: Literal["system", "user", "assistant"]
    content: str


class AIResponse(BaseModel):
    content: str
    provider: str
    model: str
