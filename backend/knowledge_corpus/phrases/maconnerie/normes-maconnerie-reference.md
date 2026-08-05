# Phrase — normes & réglementation maçonnerie

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-maconnerie-reference` |
| Titre | Phrase — normes & réglementation maçonnerie |
| Profession | `metier:maconnerie` |
| Famille | `famille:gros-oeuvre` |
| Sous-famille | `sous-famille:maconnerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (clusters « Normes » / « Réglementation »)
> « Nos ouvrages de maçonnerie respectent les règles de l'art, notamment le **DTU 20.1** (maçonnerie de petits éléments), le **DTU 20.13** (cloisons) et le **DTU 21** (chaînages/béton), avec un calcul selon l'**Eurocode 6 (NF EN 1996)**. » `[C]` ⟦versions exactes à valider par un expert⟧

> **Frontières (taxonomie)** : le **béton armé structurel** (chaînages, linteaux) est traité **au sein de la maçonnerie** — « béton » / « béton armé » / « fondations » ne sont **pas des activités de la taxonomie gelée** (pas de Livre dédié). Les **fondations** relèvent du **Terrassement**, la **dépose** de la **Démolition** (futurs Livres Gros Œuvre). `[C]`

> **Relations inter-Livres** : la maçonnerie porte la **Charpente** (appuis/chaînage haut) et reçoit la **Façade** (enduit de finition). `[C]`

## Cadre
- **Normes** : ouvrages en maçonnerie de petits éléments **DTU 20.1** ; cloisons en maçonnerie **DTU 20.13** ; chaînages / éléments en béton **DTU 21** ; calcul **Eurocode 6 (NF EN 1996)** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [inspecter-charpente](../../professions/charpente/cards/inspecter-charpente.md).
- **Tags** : `metier:maconnerie famille:gros-oeuvre type:phrase usage:normes cluster:normes cluster:reglementation relation:charpente relation:facade relation:terrassement relation:demolition`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
