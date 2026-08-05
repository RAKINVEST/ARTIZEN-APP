# Vitrage cassé / fissuré

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `vitrage-casse-fissure` |
| Titre | Vitrage cassé / fissuré |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Vitrage **cassé**, **fissuré**, éclaté ; éclats coupants. `[C]`

> **Danger de coupure** : sécuriser/baliser, porter des **gants anti-coupure**, évacuer les éclats avant tout. `[A]`

## Causes probables
1. **Choc** / vandalisme / effraction. `[C]`
2. **Contrainte** (choc thermique, calage absent, châssis qui a travaillé). `[C]` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md)
3. Verre **inadapté** à l'usage (aurait dû être sécurité). `[C]` → [poser-vitrage-securite-garde-corps](../../professions/vitrerie/cards/poser-vitrage-securite-garde-corps.md)

## Résolution
- Sécuriser, déposer les éclats, relever les cotes, remplacer par un vitrage **conforme à l'usage** (sécurité si requis). `[C]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie probleme:casse cluster:remplacement cluster:diagnostic type:diagnostic securite:coupure`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
