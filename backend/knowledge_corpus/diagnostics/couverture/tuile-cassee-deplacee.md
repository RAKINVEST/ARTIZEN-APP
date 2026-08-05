# Tuile / ardoise cassée ou déplacée

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `tuile-cassee-deplacee` |
| Titre | Tuile / ardoise cassée ou déplacée |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Élément **cassé**, glissé ou manquant visible depuis le sol/combles. `[C]`

## Causes probables
1. **Tempête** / vent (soulèvement, projection). `[C]` → [controle-couverture-apres-tempete](../../procedures/couverture/controle-couverture-apres-tempete.md)
2. Gélivité / vieillissement du matériau. `[C]`
3. Circulation inadaptée sur la toiture. `[C]`

## Résolution
- Remplacer l'élément par un modèle identique, contrôler les voisins. `[C]` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md)

## Cadre
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md).
- **Tags** : `metier:couverture equipement:tuile famille:enveloppe sous-famille:couverture probleme:casse cluster:diagnostic cluster:tuiles cluster:ardoises type:diagnostic securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
