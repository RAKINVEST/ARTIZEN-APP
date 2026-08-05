# Phrase — références normatives électricité

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `normes-electricite-reference` |
| Titre | Phrase — références normatives électricité |
| Profession | `metier:electricite-generale` |
| Famille | `famille:electricite` |
| Sous-famille | `sous-famille:conformite` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Formulation (cluster « Normes »)
> « Nos travaux électriques respectent les règles de l'art, notamment la **NF C 15-100** (installations électriques basse tension) et la **NF C 18-510** (opérations et habilitation). » `[C]` ⟦versions exactes à valider par un expert⟧

> **Relations inter-Livres** : l'alimentation électrique des équipements de **Chauffage**, **Climatisation**, **Ventilation** et **PAC** (⟦equipement:pac⟧) relève de ce Livre (circuits dédiés, protections). `[C]`

## Cadre
- **Normes** : installations électriques BT **NF C 15-100** ; opérations/consignation **NF C 18-510** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `cite-carte` → [mettre-en-service-split](../../professions/climatisation/cards/mettre-en-service-split.md).
- **Tags** : `metier:electricite-generale equipement:pac famille:electricite type:phrase usage:normes cluster:normes relation:chauffage relation:climatisation relation:ventilation relation:pac`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
