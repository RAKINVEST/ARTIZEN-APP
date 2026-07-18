"""The steps the orchestrator depends on but does NOT own.

These two capabilities need things the engine must stay clear of: the LLM
(extraction) and the business database (catalog matching). They are declared
here as ``Protocol`` ports so the orchestrator depends only on a shape, never
on a concrete implementation. The real, DB-backed / LLM-backed adapters are
built and injected by an outer layer in later lots (L3); tests inject
deterministic fakes. Speech-to-text and text-to-speech are already abstractions
in ``app.ai`` (``SttProvider`` / ``TtsProvider``) and are used directly.

Keeping these as ports is exactly what enforces "no direct business-database
dependency": ``CatalogMatcher``'s implementation will import the catalog
repository, but this module — and the orchestrator — never do.
"""

import uuid
from typing import Protocol, runtime_checkable

from app.ai.schemas import TranscriptionResult
from app.voice_quote.schemas import ExtractionResult, MatchedService, ServiceRequest


@runtime_checkable
class ServiceExtractor(Protocol):
    """Turns a transcription into structured prestations (NLU). The concrete
    implementation prompts the LLM with a strict JSON schema and the company's
    catalog vocabulary (Blueprint §2, steps 5-6)."""

    async def extract(
        self, transcription: TranscriptionResult, *, language: str = "fr"
    ) -> ExtractionResult: ...


@runtime_checkable
class CatalogMatcher(Protocol):
    """Links each prestation to a real, active, same-company catalog item and
    reports a match confidence. The concrete implementation reuses
    ``quote_assistant.MatchValidator`` + the catalog repository — which is why
    it lives outside this package. A prestation with no acceptable match is
    simply absent from the result (it becomes an ``UnresolvedItem`` upstream),
    never forced."""

    async def match(
        self, services: list[ServiceRequest], *, company_id: uuid.UUID
    ) -> list[MatchedService]: ...
