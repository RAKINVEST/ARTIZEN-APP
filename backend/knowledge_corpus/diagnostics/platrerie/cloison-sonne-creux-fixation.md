# Cloison qui bouge / fixation défaillante

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `cloison-sonne-creux-fixation` |
| Titre | Cloison qui bouge / fixation défaillante |
| Profession | `metier:platrerie` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:platrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Cloison qui **bouge**, sonne creux, fixation d'objet lourd qui s'arrache. `[C]`

## Causes probables
1. **Entraxe des montants** trop grand / ossature insuffisante. `[C]` → [monter-cloison-seche](../../professions/platrerie/cards/monter-cloison-seche.md)
2. Fixation dans le **vide** (sans renfort) pour charge lourde. `[C]`
3. Rails/montants mal fixés au gros œuvre. `[C]`

## Résolution
- Renforcer l'ossature/ajouter un **renfort** (traverse/bois) pour les charges ; **chevilles adaptées** au support. `[C]`

## Cadre
- **Normes** : ouvrages en plaques de plâtre **DTU 25.41** ; doublages / habillages **DTU 25.42** ; plafonds suspendus **DTU 58.1** ; électricité (perc ements / boîtes) **NF C 15-100** ; en rénovation, diagnostic **amiante** avant travaux (Code de la santé) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [monter-cloison-seche](../../professions/platrerie/cards/monter-cloison-seche.md).
- **Tags** : `metier:platrerie famille:finition sous-famille:platrerie probleme:fixation cluster:montants cluster:diagnostics type:diagnostic securite:manutention`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
