# Double vitrage embué (condensation interne)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `double-vitrage-embue` |
| Titre | Double vitrage embué (condensation interne) |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Buée / condensation à l'intérieur** du double vitrage (entre les verres), voile persistant. `[C]`

## Causes probables
1. **Joint de scellement** périphérique du vitrage isolant **HS** → perte du gaz/étanchéité. `[C]` → [remplacer-double-vitrage](../../professions/vitrerie/cards/remplacer-double-vitrage.md)
2. **Feuillure non drainée/ventilée** (eau stagnante) accélère la défaillance. `[C]`
3. Âge / choc thermique. `[C]`

## Résolution
- Un vitrage isolant embué est **irréparable** → **remplacement à l'identique** ; corriger le **drainage** de feuillure. `[C]`

> Ne pas confondre avec une condensation **de surface** (ventilation/hygrométrie du logement). `[C]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-double-vitrage](../../professions/vitrerie/cards/remplacer-double-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie probleme:embuage cluster:double-vitrage cluster:diagnostic type:diagnostic securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
