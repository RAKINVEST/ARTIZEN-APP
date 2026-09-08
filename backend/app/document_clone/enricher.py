"""The real enricher behind the :class:`AIEnricher` seam.

STATUS: **CODE PRESENT — NOT VALIDATED IN REAL CONDITIONS.** No ``ANTHROPIC_API_KEY``
has ever exercised it. It is written so the day a key exists it drops in with no
change elsewhere (the whole point of the frozen contract), and until then it
**refuses** to run against :class:`MockAIProvider` — a mocked enrichment would be a
silent fabrication of the document's meaning (same discipline as
``quote_extraction``). It must never be presented as working in production.

Division of labour (product invariant): the model **understands, it never draws**.
It is asked for roles and column identities only — never a coordinate, never an
amount, never a total. Everything numeric and positional is deterministic
downstream (:mod:`app.document_clone.assembler`). And its answer is **re-validated
against the real blocks** before use (invariant "an AI response is never trusted on
its word"): unknown block ids and unknown roles are dropped.
"""

import json

from app.ai.base import AIProvider
from app.ai.providers.mock_provider import MockAIProvider
from app.ai.schemas import AIMessage
from app.document_clone.ai_contract import (
    AIEnricher,
    BlockRole,
    ColumnMapping,
    ExtractionBlocks,
    FieldRole,
    SemanticStructure,
)
from app.document_clone.artizen_format import SectionPresence


class EnricherProviderUnavailableError(RuntimeError):
    """Raised when enrichment is attempted with no real AI provider. Enrichment is
    never silently mocked — a mock would invent the document's meaning."""


_COLUMN_KEYS = "designation, qty, unit, pu_ht, prix_brut, remise, prix_net, vat, total_ht"

_SYSTEM = (
    "Tu es un lecteur de documents. On te donne les blocs de texte positionnés d'un "
    "devis (chaque bloc a un id, un texte, une position). Ta seule tâche : dire CE "
    "QU'EST chaque bloc. Tu n'inventes AUCUN texte, AUCUN montant, AUCUNE coordonnée. "
    "Tu réponds UNIQUEMENT en JSON : "
    '{"roles":[{"block_id":int,"role":str,"confidence":float}],'
    '"columns":[{"block_id":int,"key":str,"label":str}],'
    '"sections":{"logo":bool,"company":bool,"client":bool,"worksite":bool,'
    '"table":bool,"vat":bool,"totals":bool,"deposit":bool,"signature":bool,'
    '"legal":bool,"footer":bool},"confidence":float}. '
    "Rôles autorisés : " + ", ".join(r.value for r in FieldRole) + ". "
    "Clés de colonne : " + _COLUMN_KEYS + "."
)


def _blocks_as_prompt(blocks: ExtractionBlocks) -> str:
    lines = [f"document_type={blocks.document_type.value} pages={blocks.page_count}"]
    for b in blocks.blocks:
        if b.kind is not b.kind.TEXT:
            continue
        r = b.rect
        lines.append(
            f"#{b.id} x={r.x:.0f} y={r.y:.0f} w={r.w:.0f} "
            f"size={b.size:.0f} bold={int(b.bold)} :: {b.text}"
        )
    return "\n".join(lines)


class AnthropicAIEnricher(AIEnricher):
    """Real enricher: one ``provider.complete`` call, parsed back into the frozen
    :class:`SemanticStructure`. Refuses the mock provider."""

    def __init__(self, provider: AIProvider) -> None:
        if isinstance(provider, MockAIProvider):
            raise EnricherProviderUnavailableError(
                "AnthropicAIEnricher requires a real AI provider (ANTHROPIC_API_KEY). "
                "Refusing to fabricate a document's meaning with the mock."
            )
        self._provider = provider

    async def enrich(self, blocks: ExtractionBlocks) -> SemanticStructure:
        # async because AIProvider.complete is async — see the AIEnricher Protocol.
        messages = [
            AIMessage(role="system", content=_SYSTEM),
            AIMessage(role="user", content=_blocks_as_prompt(blocks)),
        ]
        # claude-sonnet-5 runs default extended thinking (~5k+ reasoning tokens)
        # on top of the JSON and takes well over 30s, so the interactive defaults
        # (4096 tokens / 30s) truncate and time out. This is a one-shot, import-time,
        # non-interactive call, so a generous output budget and a long timeout are
        # appropriate (cost is per actual token; the cap only prevents truncation).
        # Demonstrated on the real corpus during P1 validation.
        response = await self._provider.complete(messages, max_tokens=32000, timeout=180.0)
        return self._parse(response.content, blocks)

    @staticmethod
    def _parse(content: str, blocks: ExtractionBlocks) -> SemanticStructure:
        """Re-validate the model's answer against the real blocks: unknown ids and
        unknown roles are dropped, not trusted."""
        start = content.find("{")
        if start < 0:
            raise ValueError("enricher response carries no JSON object")
        payload, _end = json.JSONDecoder().raw_decode(content[start:])
        valid_ids = {b.id for b in blocks.blocks}
        valid_roles = {r.value for r in FieldRole}
        roles = [
            BlockRole(
                block_id=r["block_id"],
                role=FieldRole(r["role"]),
                confidence=float(r.get("confidence", 0.0)),
            )
            for r in payload.get("roles", [])
            if r.get("block_id") in valid_ids and r.get("role") in valid_roles
        ]
        columns = [
            ColumnMapping(block_id=c["block_id"], key=c["key"], label=c.get("label", ""))
            for c in payload.get("columns", [])
            if c.get("block_id") in valid_ids
        ]
        sections = SectionPresence(
            **{k: bool(v) for k, v in payload.get("sections", {}).items()
               if k in SectionPresence.model_fields}
        )
        return SemanticStructure(
            document_type=blocks.document_type,
            roles=roles,
            columns=columns,
            sections=sections,
            confidence=float(payload.get("confidence", 0.0)),
        )
