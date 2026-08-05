# Kit désembouage chauffage

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-desembouage` |
| Titre | Kit désembouage chauffage |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Désembouant + inhibiteur de protection (compatibles installation). `[C]`
- Filtre / pot à boue magnétique. `[C]`
- Pompe de désembouage (méthode hydrodynamique). `[C]`
- EPI, récipients de rinçage. `[C]`

## Cadre
- **Normes** : installations de chauffage central — **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [desembouer-circuit-chauffage](../../professions/chauffage/cards/desembouer-circuit-chauffage.md).
- **Tags** : `metier:chauffage famille:fluides type:kit probleme:boue equipement:circuit`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
