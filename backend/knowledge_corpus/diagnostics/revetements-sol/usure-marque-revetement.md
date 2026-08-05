# Usure / marques du revêtement

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `usure-marque-revetement` |
| Titre | Usure / marques du revêtement |
| Profession | `metier:revetements-sol` |
| Famille | `famille:finition` |
| Sous-famille | `sous-famille:revetements-sol` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- **Usure** prématurée, marques de meubles/roulettes, joints ouverts. `[C]`

## Causes probables
1. **Classement UPEC** inadapté au trafic. `[C]` → [principe-revetements-sol](../../professions/revetements-sol/cards/principe-revetements-sol.md)
2. Entretien inadapté (produits agressifs / excès d'eau). `[C]` → [entretenir-reprendre-sol](../../professions/revetements-sol/cards/entretenir-reprendre-sol.md)
3. Joints/soudures ouverts (pose). `[C]`

## Résolution
- Adapter l'entretien, protéger (patins/roulettes souples), reprendre les zones usées ; choisir un UPEC supérieur en réfection. `[C]`

## Cadre
- **Normes** : revêtements de sol PVC collés **DTU 53.2** ; revêtements textiles / moquettes **DTU 53.1** ; pose flottante des sols stratifiés **DTU 51.11** (interface) ; électricité (avant découpe/percement, sols techniques) **NF C 15-100** ; classement **UPEC**, étiquetage **COV** et diagnostic **amiante** (anciennes dalles/colles) ⟦en prose, à confirmer⟧ `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [entretenir-reprendre-sol](../../professions/revetements-sol/cards/entretenir-reprendre-sol.md).
- **Tags** : `metier:revetements-sol famille:finition sous-famille:revetements-sol probleme:usure cluster:entretien cluster:diagnostic type:diagnostic securite:cov`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-05 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
