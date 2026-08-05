# Phrase — références normatives étanchéité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-etancheite-reference` |
| Titre | Phrase — références normatives étanchéité |
| Profession | `metier:etancheite` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:etancheite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes »)
> « Nos ouvrages d'étanchéité respectent les règles de l'art, notamment le **DTU 43.1** (toitures-terrasses, support maçonnerie), le **DTU 43.3** (support acier) et le **DTU 43.5** (réfection) ; les systèmes SEL/résines sont posés sous **Avis Technique**. » `[C]` ⟦versions/DTA exacts à valider par un expert⟧

> **Relations inter-Livres** : l'étanchéité s'articule avec la **Couverture** (jonctions/émergences), la **Zinguerie** (évacuation EP), la **Façade** (relèvés contre mur), l'**Isolation** (toiture-terrasse isolée), l'**Isolation Extérieure** (acrotères/ITE) et la **Charpente** (support bois, DTU 43.4). `[C]`

## Cadre
- **Normes** : étanchéité des toitures-terrasses (support maçonnerie) **DTU 43.1** ; support acier **DTU 43.3** ; réfection des ouvrages d'étanchéité **DTU 43.5** ; SEL/résines sous **Avis Technique** ⟦à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [traiter-noues-emergences](../../professions/couverture/cards/traiter-noues-emergences.md).
- **Tags** : `metier:etancheite famille:enveloppe type:phrase usage:normes cluster:normes relation:couverture relation:zinguerie relation:facade relation:isolation relation:isolation-exterieure relation:charpente`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
