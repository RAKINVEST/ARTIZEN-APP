# Contrôler l'évacuation des condensats

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-evacuation-condensats` |
| Titre | Contrôler l'évacuation des condensats |
| Profession | `metier:climatisation` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:climatisation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'évacuation des condensats (bac, siphon, pompe de relevage) pour éviter fuites et odeurs. `[C]`
- **Résumé** : nettoyer le bac et la ligne de condensats, contrôler la pente/siphon et la pompe de relevage éventuelle, désinfecter, puis tester l'écoulement. `[C]`

## Réalisation
- **Étapes** :
  1. Couper l'alimentation électrique. `[A]`
  2. Nettoyer le **bac** et la ligne de condensats (bio-film). `[C]`
  3. Contrôler la pente / le siphon et la **pompe de relevage** éventuelle. `[C]`
  4. Désinfecter, tester l'écoulement (verser de l'eau). `[C]` → [clim-fuite-eau](../../../diagnostics/climatisation/clim-fuite-eau.md)
- **Points critiques** : ligne obstruée = **fuite d'eau** dans le bâti ; siphon indispensable (odeurs). `[C]`
- **Sécurité** : électricité coupée ; hygiène (bio-contamination). `[B]`

## Cadre & suites
- **Normes** : climatiseurs à détente directe **DTU 65.16** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Diagnostics liés** : `traite-diagnostic` → [clim-fuite-eau](../../../diagnostics/climatisation/clim-fuite-eau.md)

## Relations & tags
- **Tags** : `metier:climatisation equipement:climatiseur famille:fluides sous-famille:climatisation intervention:controler intervention:entretenir cluster:entretien cluster:controle probleme:condensats equipement:bac-condensats complexite:simple type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
