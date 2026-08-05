"""The extraction service: PDF text -> validated ``ExtractedQuote``.

Provider-abstracted (``app.ai``), so a real vendor is swapped in with a key and
no caller changes. The one thing it refuses to do is fabricate: if the only
available provider is the offline deterministic mock (no real key configured),
it raises ``ExtractionProviderUnavailableError`` instead of returning invented
data. Extraction *quality* is a real-AI concern; extraction *honesty* is
enforced here regardless of provider.
"""

from __future__ import annotations

import json

from app.ai.base import AIProvider
from app.ai.providers.mock_provider import MockAIProvider
from app.quote_extraction.exceptions import (
    ExtractionProviderUnavailableError,
    ExtractionResponseError,
)
from app.quote_extraction.guards import reject_fabricated_data
from app.quote_extraction.prompt import build_extraction_messages
from app.quote_extraction.schemas import ExtractedQuote


def parse_extraction_json(content: str) -> ExtractedQuote:
    """Parse a provider's raw text into a validated ``ExtractedQuote``.

    Tolerates the common ways models wrap JSON — a leading ```json fence, or
    prose around the object — by decoding from the first ``{``. Anything that
    still will not parse or validate raises ``ExtractionResponseError``: we never
    guess what a malformed answer meant. Kept a module function so it is unit
    tested without a provider."""
    start = content.find("{")
    if start == -1:
        raise ExtractionResponseError("Extraction response contained no JSON object.")
    try:
        obj, _ = json.JSONDecoder().raw_decode(content, start)
    except ValueError as exc:
        raise ExtractionResponseError(
            f"Extraction response was not valid JSON: {exc}"
        ) from exc
    try:
        return ExtractedQuote.model_validate(obj)
    except ValueError as exc:
        raise ExtractionResponseError(
            f"Extraction response did not match the ExtractedQuote schema: {exc}"
        ) from exc


class QuoteExtractor:
    def __init__(self, provider: AIProvider) -> None:
        self._provider = provider

    async def extract(self, document_text: str) -> ExtractedQuote:
        """Extract a full quote from a document's text.

        Raises ``ExtractionProviderUnavailableError`` when no real AI is
        configured (the mock cannot read a quote and must never invent one),
        ``ExtractionResponseError`` on an unusable answer, and
        ``FabricatedDataError`` if a known demonstration literal slips through."""
        if isinstance(self._provider, MockAIProvider):
            raise ExtractionProviderUnavailableError(
                "Aucun fournisseur IA réel n'est configuré : l'extraction de "
                "devis ne peut pas s'exécuter sans invention de données, ce qui "
                "est interdit. Configurez une clé (ex. ANTHROPIC_API_KEY)."
            )
        if not document_text or not document_text.strip():
            raise ExtractionResponseError("Le document ne contient aucun texte à extraire.")

        messages = build_extraction_messages(document_text)
        response = await self._provider.complete(messages)
        extracted = parse_extraction_json(response.content)
        reject_fabricated_data(extracted)
        return extracted
