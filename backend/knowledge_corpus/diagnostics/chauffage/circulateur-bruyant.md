# Circulateur bruyant

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `circulateur-bruyant` |
| Titre | Circulateur bruyant |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Bruit anormal du circulateur (ronflement, cavitation). `[C]`

## Causes probables
1. **Air** dans le circuit (pression/purge). `[C]`
2. **Boues** / grippage. `[C]` → [desembouer-circuit-chauffage](../../professions/chauffage/cards/desembouer-circuit-chauffage.md)
3. Vitesse trop élevée / circulateur usé. `[C]`

## Résolution
- Purger et rétablir la pression ; désembouer si nécessaire ; régler la vitesse ; remplacer si usé. → [remplacer-circulateur](../../professions/chauffage/cards/remplacer-circulateur.md)

## Cadre
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-circulateur](../../professions/chauffage/cards/remplacer-circulateur.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau probleme:bruit probleme:cavitation equipement:circulateur type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
