"""Card scaffold generator — produces a **Brouillon** conforming to the model.

A tool, not a content producer: it emits an empty, well-structured draft (every
required field/section present, values left as ⟦…⟧ placeholders) for an editor to
fill. It never fills in knowledge and never publishes.
"""


def generate_card(
    *, slug: str, title: str, profession: str, kind: str = "card",
    author: str = "IA (proposition)", version: str = "v0.1", date: str = "",
) -> str:
    """Return the Markdown of a blank draft card. Deterministic (``date`` is
    passed in, never read from the clock)."""
    metier = profession if profession.startswith("metier:") else f"metier:{profession}"
    return f"""# {title}

> **Brouillon (v0) — à compléter et valider métier.** Modèle : cards/CARD_TEMPLATE.md.
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `{slug}` |
| Titre | {title} |
| Profession | `{metier}` |
| Famille | ⟦à préciser⟧ |
| Version | {version} |
| Auteur | {author} |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | ⟦A/B/C/D à préciser⟧ |

## Cadrage
- **Objectif** : ⟦à compléter⟧
- **Résumé** : ⟦à compléter — test des 5 secondes⟧

## Réalisation
- **Étapes** : ⟦1. … 2. … 3. …⟧
- **Points critiques** : ⟦ce qui ne pardonne pas⟧
- **Sécurité** : ⟦EPI, risques, consignes⟧

## Cadre & suites
- **Normes** : ⟦source DTU/NF à citer⟧
- **Relations** : ⟦lier au moins une connaissance⟧

## Relations & tags
- **Tags** : `{metier}`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| {version} | {date or "⟦date⟧"} | {author} | ⟦—⟧ | création (Brouillon) |
"""


__all__ = ["generate_card"]
