# Évacuation lente

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `evacuation-lente` |
| Titre | Évacuation lente |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Écoulement lent, remontée d'odeur. `[C]`

## Causes probables
1. Bouchon partiel du siphon. `[C]`
2. Obstruction de la canalisation. `[C]`

## Résolution
- Déboucher l'évacuation sanitaire. → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md)

## Cadre
- **Normes** : installation sanitaire — **DTU 60.1** `[B]` ⟦référence exacte à confirmer par le validateur⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [deboucher-evacuation-sanitaire](../../professions/plomberie/cards/deboucher-evacuation-sanitaire.md).
- **Tags** : `metier:plomberie famille:fluides sous-famille:evacuation probleme:obstruction probleme:odeur equipement:siphon type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | consolidation au standard Factory (Brouillon) |
