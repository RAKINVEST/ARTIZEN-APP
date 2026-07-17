"""Builds the exact messages sent to the AI provider.

The only file that knows the wording of the matching prompt —
``CatalogMatcherClaude`` just forwards whatever this returns to
``AIProvider.complete()``. Kept as a pure function of its inputs (no
I/O), so the prompt's content is trivially unit-testable without a real
AI call.
"""

import json
import uuid

from app.ai.schemas import AIMessage
from app.catalog.models import CatalogItem

_SYSTEM_PROMPT = """Tu es un assistant qui aide un artisan à préparer un devis à partir d'une description libre de travaux.

Règles strictes, à respecter sans exception :
- Tu ne dois JAMAIS proposer un article qui n'est pas dans le catalogue fourni ci-dessous.
- Tu ne dois JAMAIS indiquer, calculer ou inventer un prix : les prix sont déjà connus par le système, tu ne les manipules pas.
- Si aucun article du catalogue ne correspond à la description, réponds avec "items": [] et une "confidence" basse plutôt que d'inventer une correspondance approximative.
- Si la description est ambiguë entre plusieurs articles plausibles, choisis l'article le plus probable — en t'aidant si besoin de "times_used_previously" (les articles déjà utilisés par cette entreprise sont un indice, jamais une certitude) — et baisse la "confidence" en conséquence plutôt que de proposer les deux à la fois.
- Chaque "reason" doit citer précisément les mots ou le passage de la description qui justifient ce choix (par exemple : "correspond à 'chauffe-eau Atlantic 200 litres' dans la description"), jamais une justification générique du type "correspondance trouvée".
- Chaque "quantity" doit être un nombre strictement positif avec au maximum 2 décimales (par exemple 1, 2.5, 0.75). Une quantité plus précise que le centième ne peut pas être enregistrée dans un devis et serait refusée.
- Tu dois répondre UNIQUEMENT avec un objet JSON strictement conforme au schéma suivant, sans aucun texte avant ou après, sans balises de code :

{"items": [{"catalog_item_id": "<uuid d'un article du catalogue fourni>", "quantity": <nombre>, "reason": "<justification précise et courte>"}], "confidence": <nombre entre 0 et 1>, "comment": "<commentaire court>"}"""


class PromptBuilder:
    def build(
        self,
        description: str,
        catalog_items: list[CatalogItem],
        *,
        company_name: str | None = None,
        usage_counts: dict[uuid.UUID, int] | None = None,
    ) -> list[AIMessage]:
        usage_counts = usage_counts or {}
        catalog_payload = [
            {
                "catalog_item_id": str(item.id),
                "designation": item.designation,
                "description": item.description,
                "unit": item.unit,
                "item_type": item.item_type.value,
                # A purely informational disambiguation hint — see the
                # system prompt's guidance on ambiguous descriptions.
                # Never used to alter a suggestion outside the AI call.
                "times_used_previously": usage_counts.get(item.id, 0),
            }
            for item in catalog_items
        ]

        context_line = f"Entreprise : {company_name}\n\n" if company_name else ""
        user_content = (
            f"{context_line}"
            "Catalogue disponible (JSON, articles actifs de cette entreprise "
            "uniquement — \"times_used_previously\" indique combien de fois "
            "chaque article a déjà été utilisé dans les devis de cette "
            "entreprise) :\n"
            f"{json.dumps(catalog_payload, ensure_ascii=False)}\n\n"
            f"Description du client à analyser :\n{description}"
        )
        return [
            AIMessage(role="system", content=_SYSTEM_PROMPT),
            AIMessage(role="user", content=user_content),
        ]
