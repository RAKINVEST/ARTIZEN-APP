"""Port for a future AI-assisted catalog matching feature.

Not implemented and not called anywhere yet — only the contract is
fixed. Its future role: turn a free-text description (e.g. dictated or
typed by an artisan, or extracted from an imported document) into a
list of existing ``CatalogItem`` rows. Artizen never invents prices or
lines: an AI-backed implementation of this interface would only ever
*select* among items that already exist in the catalog, never create
new ones or propose a price — that logic (if any) belongs elsewhere,
this module stays independent of any AI provider.

Étape 7 built the first real AI-assisted matcher
(``quote_assistant.CatalogMatcherClaude``) but does not implement this
exact interface: the feature also needs a quantity, a per-item reason,
a global confidence score and a comment per request, none of which fit
a bare ``list[CatalogItem]`` return type. Rather than stretch this
placeholder to fit after the fact, ``quote_assistant`` defines its own
purpose-built shape (``quote_assistant.schemas``). This interface stays
here for a possible simpler matcher later; unify the two only if a
second real implementation actually needs the same contract.
"""

import uuid
from abc import ABC, abstractmethod

from app.catalog.models import CatalogItem


class CatalogMatcher(ABC):
    @abstractmethod
    async def match(self, description: str, *, company_id: uuid.UUID) -> list[CatalogItem]:
        raise NotImplementedError
