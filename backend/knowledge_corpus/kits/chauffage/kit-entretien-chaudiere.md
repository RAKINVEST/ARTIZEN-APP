# Kit entretien chaudière

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `kit-entretien-chaudiere` |
| Titre | Kit entretien chaudière |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:generation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Composition conseillée
- Joints et pièces d'usure selon modèle. `[C]` ⟦selon fabricant⟧
- Produits de nettoyage corps de chauffe / brûleur. `[C]`
- Appareil de mesure de combustion (le cas échéant). `[C]`
- EPI, détecteur CO. `[B]`

## Cadre
- **Normes** : conduits de fumée **DTU 24.1** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `utilise-kit` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:generation type:kit equipement:chaudiere`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
