# Chaudière en sécurité (mise en sécurité)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `chaudiere-en-securite` |
| Titre | Chaudière en sécurité (mise en sécurité) |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:generation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La chaudière se met **en sécurité** (arrêt, code défaut, voyant). `[C]`

## Causes probables
1. Manque de **pression** d'eau. `[C]` → [controler-regonfler-vase-expansion](../../professions/chauffage/cards/controler-regonfler-vase-expansion.md)
2. Air dans le circuit / défaut de circulation. `[C]`
3. Défaut d'allumage, de fumées ou de sonde. `[D]` ⟦selon code fabricant à confirmer⟧

## Résolution
- Rétablir la pression, purger, contrôler ; si récurrent, **entretien** et diagnostic fabricant. → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md)

## Cadre
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-chaudiere](../../professions/chauffage/cards/entretenir-chaudiere.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:generation probleme:mise-en-securite probleme:pression equipement:chaudiere type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
