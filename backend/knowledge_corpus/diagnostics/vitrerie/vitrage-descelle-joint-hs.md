# Vitrage descellé / joint dégradé

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `vitrage-descelle-joint-hs` |
| Titre | Vitrage descellé / joint dégradé |
| Profession | `metier:vitrerie` |
| Famille | `famille:specialises` |
| Sous-famille | `sous-famille:vitrerie` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Vitrage qui **bouge/vibre**, **mastic/joint** craquelé, infiltration d'eau/air, parclose desserrée. `[C]`

## Causes probables
1. **Mastic/joint** d'étanchéité vieilli. `[C]` → [entretenir-diagnostiquer-vitrerie](../../professions/vitrerie/cards/entretenir-diagnostiquer-vitrerie.md)
2. **Calage** absent/tassé (le vitrage porte sur le châssis). `[C]` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md)
3. **Châssis** déformé (→ Métallerie / Menuiserie, métiers distincts). `[C]`

## Résolution
- Refaire le **mastic/joint**, reprendre le **calage** et les parcloses ; châssis déformé = corps d'état concerné. `[C]`

## Cadre
- **Normes** : travaux de **vitrerie-miroiterie** **DTU 39** ; menuiseries métalliques recevant le vitrage (**interface**) **DTU 37.1** ; verre de sécurité trempé / feuilleté (**NF EN 12150 / NF EN 14449 / ISO 12543**), vitrage isolant **NF EN 1279**, résistance au choc **NF EN 12600**, garde-corps **NF P01-012** ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [poser-remplacer-vitrage](../../professions/vitrerie/cards/poser-remplacer-vitrage.md).
- **Tags** : `metier:vitrerie famille:specialises sous-famille:vitrerie probleme:etancheite cluster:pose-vitrage cluster:diagnostic type:diagnostic securite:coupure relation:serrurerie-metallerie`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
