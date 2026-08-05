# Fuite au mitigeur

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fuite-mitigeur` |
| Titre | Fuite au mitigeur |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Goutte-à-goutte au bec ou fuite à la base du mitigeur. `[C]`

## Causes probables
1. Cartouche céramique usée. `[C]`
2. Joint de base / fixation. `[C]`

## Résolution
- Remplacer la cartouche du mitigeur. → [remplacer-cartouche-mitigeur](../../professions/plomberie/cards/remplacer-cartouche-mitigeur.md)

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-cartouche-mitigeur](../../professions/plomberie/cards/remplacer-cartouche-mitigeur.md).
- **Tags** : `metier:plomberie famille:fluides sous-famille:robinetterie probleme:fuite probleme:usure equipement:mitigeur type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
