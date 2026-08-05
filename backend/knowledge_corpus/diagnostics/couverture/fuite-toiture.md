# Fuite en toiture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../cards/CARD_TEMPLATE.md](../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `fuite-toiture` |
| Titre | Fuite en toiture |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Symptôme
- Traces d'eau / infiltration sous toiture, tache au plafond. `[C]`

## Causes probables
1. Élément **cassé/déplacé** (tuile, ardoise). `[C]` → [tuile-cassee-deplacee](tuile-cassee-deplacee.md)
2. Point singulier défaillant (**noue, émergence, solin**). `[C]` → [realiser-noue-metallique](../../professions/zinguerie/cards/realiser-noue-metallique.md)
3. **Condensation** (sous-toiture mal ventilée). `[C]` → [entretenir-vmc-simple-flux](../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)

## Résolution
- Localiser l'entrée d'eau, remplacer l'élément / reprendre le point singulier, contrôler la ventilation. `[C]` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md)

## Cadre
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦référence exacte à confirmer⟧. `respecte-norme`
- **Relations** : `traite-diagnostic` → [remplacer-tuiles-ardoises](../../professions/couverture/cards/remplacer-tuiles-ardoises.md).
- **Tags** : `metier:couverture famille:enveloppe sous-famille:couverture probleme:fuite probleme:infiltration cluster:diagnostic cluster:reparation type:diagnostic securite:hauteur relation:zinguerie relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
