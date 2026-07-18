"""Deterministic, fully offline embedding stand-in (V3.3 L1).

Selected whenever ``EMBEDDING_PROVIDER=mock`` (the default and only wired
provider today). It derives each vector from a hash of the text, so it is
perfectly deterministic (same text -> same vector, no network, no randomness)
and safe in tests.

Honest limitation: a hash-based vector carries NO semantic meaning — two
synonyms get unrelated vectors. That is fine here, because semantic catalog
matching (pgvector) is a later lot; the mock exists only to prove the
abstraction and to let the pipeline run offline. Until a real embedding
provider is wired, catalog matching relies on the lexical ``MatchValidator``
path (Blueprint §2, step 8), not on these vectors.
"""

import hashlib
import math

from app.ai.base import EmbeddingProvider
from app.ai.schemas import EmbeddingResult

# Small on purpose: the mock only needs determinism and a stable shape, not a
# realistic dimensionality. A real provider reports its own (e.g. 1536).
_DIMENSIONS = 8


def _vector(text: str) -> list[float]:
    digest = hashlib.sha256(text.encode("utf-8")).digest()
    # Map the first _DIMENSIONS bytes into [-1, 1], then L2-normalize so the
    # vectors are unit length and cosine similarity is well-defined.
    raw = [(digest[i] / 255.0) * 2.0 - 1.0 for i in range(_DIMENSIONS)]
    norm = math.sqrt(sum(component * component for component in raw)) or 1.0
    return [component / norm for component in raw]


class MockEmbeddingProvider(EmbeddingProvider):
    async def embed(self, texts: list[str], **kwargs: object) -> list[EmbeddingResult]:
        return [
            EmbeddingResult(
                vector=_vector(text),
                dimensions=_DIMENSIONS,
                provider="mock",
                model="mock-embedding",
            )
            for text in texts
        ]
