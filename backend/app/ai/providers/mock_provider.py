"""Deterministic, fully offline fallback used automatically whenever no
real AI provider API key is configured (see ``ai/factory.py``).

Guarantees the application always boots and every AI-backed feature
always returns a usable response — no missing-key exception, no
blocking prompt, nothing for a developer or a demo audience to
configure or answer. The day a real key is added to ``.env``, the
factory switches to the real provider automatically on the next
process start: nothing here, or anywhere that depends on ``AIProvider``,
needs to change.

Because this lives in the provider-agnostic ``ai/`` layer, it knows
nothing about any specific feature's business rules (e.g. quote
matching). To still produce a genuinely useful response for prompts
that embed a JSON array of candidate objects — as
``quote_assistant.PromptBuilder`` does — it does simple, deterministic,
case-insensitive keyword overlap between the free-text portion of the
prompt and each candidate's text fields. No network call, no
randomness: same input always produces the same output, which keeps it
safe to use in tests as well as demos.

Two Étape 9 refinements, both still purely deterministic:

- **Reason cites the actual overlapping words** rather than a generic
  sentence, so even offline "demo mode" gives a genuinely inspectable
  justification.
- **Ambiguity detection**: when the top two candidates tie on keyword
  overlap, the description didn't clearly favor one over the other —
  confidence is lowered to reflect that honestly, mirroring the same
  guidance given to the real prompt (see `PromptBuilder`'s system
  prompt) rather than silently picking one arbitrarily.
"""

import json
import re

from app.ai.base import AIProvider
from app.ai.schemas import AIMessage, AIResponse

_JSON_ARRAY_PATTERN = re.compile(r"\[.*\]", re.DOTALL)
# Allows internal hyphens so French compound trade terms ("chauffe-eau",
# "porte-fenêtre") stay a single token instead of splitting into two
# unrelated words that would otherwise inflate/deflate overlap counts.
_WORD_PATTERN = re.compile(
    r"[a-zàâäéèêëïîôöùûüç0-9]+(?:-[a-zàâäéèêëïîôöùûüç0-9]+)*", re.IGNORECASE
)
_STOPWORDS = {
    "de", "du", "des", "le", "la", "les", "un", "une", "et", "avec", "pour",
    "sur", "dans", "en", "au", "aux", "d", "l", "à", "avec",
}

_CONFIDENT_MATCH = 0.6
_AMBIGUOUS_MATCH = 0.35
_NO_MATCH = 0.0


def _words(text: str) -> set[str]:
    return {word for word in _WORD_PATTERN.findall(text.lower()) if word not in _STOPWORDS and len(word) > 2}


def _extract_candidates(text: str) -> tuple[list[dict], str]:
    """Finds the first JSON array embedded in `text` (the catalog the
    prompt lists), returning it alongside the remaining free text (the
    description to match against)."""
    match = _JSON_ARRAY_PATTERN.search(text)
    if not match:
        return [], text
    try:
        candidates = json.loads(match.group(0))
    except ValueError:
        return [], text
    if not isinstance(candidates, list):
        return [], text
    free_text = text[: match.start()] + text[match.end() :]
    return candidates, free_text


class MockAIProvider(AIProvider):
    async def complete(self, messages: list[AIMessage], **kwargs: object) -> AIResponse:
        user_content = "\n".join(message.content for message in messages if message.role == "user")
        candidates, free_text = _extract_candidates(user_content)
        query_words = _words(free_text)

        # (overlap_count, times_used_previously, candidate_id, matched_words)
        scored: list[tuple[int, int, str, set[str]]] = []
        for candidate in candidates:
            candidate_id = candidate.get("catalog_item_id")
            if not candidate_id:
                continue
            candidate_text = f"{candidate.get('designation', '')} {candidate.get('description') or ''}"
            overlap = query_words & _words(candidate_text)
            if overlap:
                times_used = candidate.get("times_used_previously") or 0
                scored.append((len(overlap), times_used, candidate_id, overlap))

        # Most keyword overlap first; ties broken by how often this
        # company has actually used the item before (see PromptBuilder).
        scored.sort(key=lambda entry: (entry[0], entry[1]), reverse=True)

        items = [
            {
                "catalog_item_id": candidate_id,
                "quantity": 1,
                "reason": (
                    f"Correspondance par mots-clés : {', '.join(sorted(matched))} "
                    "(mode démonstration hors-ligne)."
                ),
            }
            for _, _, candidate_id, matched in scored[:3]
        ]

        if not items:
            confidence = _NO_MATCH
        elif len(scored) >= 2 and scored[0][0] == scored[1][0]:
            # Ambiguous: the top two candidates matched equally well.
            confidence = _AMBIGUOUS_MATCH
        else:
            confidence = _CONFIDENT_MATCH

        payload = {
            "items": items,
            "confidence": confidence,
            "comment": (
                "Suggestion générée en mode démonstration hors-ligne "
                "(aucun fournisseur IA réel configuré)."
                if items
                else "Mode démonstration hors-ligne : aucune correspondance trouvée."
            ),
        }
        return AIResponse(
            content=json.dumps(payload, ensure_ascii=False),
            provider="mock",
            model="mock-keyword-matcher",
        )
