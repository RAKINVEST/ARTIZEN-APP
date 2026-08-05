# Kit vitrier

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-vitrier` |
| Titre | Kit vitrier |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- **Coupe-verre** (roulette/molette), règle de coupe, pince à rompre, meule/pierre à arêter. `[C]`
- **Ventouses** (simple/double/pompe) pour manutention, chevalet de transport, sangles. `[A]`
- Mastic/joints, mastic-colle miroir, cales de vitrage, couteau à mastic, pistolet. `[C]`
- **EPI** : **gants anti-coupure**, manches longues, lunettes, chaussures ; harnais si hauteur. `[A]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie type:kit cluster:decoupe cluster:manutention equipement:ventouse-vitrage`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
