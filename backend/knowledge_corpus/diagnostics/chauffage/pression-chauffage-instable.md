# Pression de chauffage instable

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `pression-chauffage-instable` |
| Titre | Pression de chauffage instable |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- La pression du circuit **chute** ou **monte** anormalement (appoints fréquents, soupape qui crache). `[C]`

## Causes probables
1. **Vase d'expansion** dégonflé ou membrane percée. `[C]` → [controler-regonfler-vase-expansion](../../professions/chauffage/cards/controler-regonfler-vase-expansion.md)
2. Fuite sur le circuit (micro-fuite). `[C]`
3. Air non purgé. `[C]` → [purger-radiateur](../../professions/chauffage/cards/purger-radiateur.md)

## Résolution
- Contrôler/regonfler le vase, chercher les fuites, purger. `[C]`

## Cadre
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [controler-regonfler-vase-expansion](../../professions/chauffage/cards/controler-regonfler-vase-expansion.md).
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau probleme:pression probleme:fuite equipement:vase-expansion type:diagnostic`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
