# Phrase — références normatives climatisation

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-climatisation-reference` |
| Titre | Phrase — références normatives climatisation |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes »)
> « Nos interventions de climatisation respectent les règles de l'art, notamment le **DTU 65.16** (climatiseurs à détente directe) et la réglementation **F-Gaz** pour le circuit frigorifère (intervenant attesté). » `[C]` ⟦liste et versions exactes à valider par un expert⟧

> **Relations inter-Livres** : un climatiseur **réversible** est une PAC air/air (⟦equipement:pac⟧) ; la partie électrique relève du Livre Électricité. `[C]`

## Cadre
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-phrase` → [entretenir-climatiseur](../../professions/climatisation/cards/entretenir-climatiseur.md).
- **Tags** : `metier:climatisation equipement:climatiseur equipement:pac famille:fluides type:phrase usage:normes cluster:normes relation:pac relation:electricite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
