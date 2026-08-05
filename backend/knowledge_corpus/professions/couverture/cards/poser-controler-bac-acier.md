# Poser / contrôler une couverture bac acier (panneaux)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `poser-controler-bac-acier` |
| Titre | Poser / contrôler une couverture bac acier (panneaux) |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : poser ou contrôler une couverture en plaques nervurées / panneaux (bac acier, panneaux sandwich) — fixation, recouvrement, condensation. `[C]`
- **Résumé** : poser les plaques dans le sens du vent dominant avec recouvrements et fixations en sommet d'onde, gérer la **condensation** (sous-face/ventilation), et traiter les points singuliers ; toute plaque **fragile** interdit l'appui direct. `[C]` ⟦entraxes/fixations selon fabricant à confirmer⟧

## Réalisation
- **Étapes** :
  1. Contrôler support/pannes et sens de pose (vent). `[C]`
  2. Poser plaques avec **recouvrements** ; fixer en **sommet d'onde**. `[C]` ⟦fixation fabricant à confirmer⟧
  3. Gérer la **condensation** (sous-face anti-condensation / ventilation). `[C]`
  4. Traiter faîtage/rives/émergences. `[C]` → [realiser-faitage](realiser-faitage.md)
- **Points critiques** : **plaques fragiles** = risque de chute au travers (protection sous face) ; condensation ; fixation correcte.
- **Sécurité** : hauteur ; **chute à travers plaque fragile** (filet/protection) ; coupure (tôle) ; météo. **Travail en **hauteur** sur toiture : risque de **chute** (du toit ou à travers une plaque fragile) — protections **collectives** (échafaudage/filet/garde-corps) prioritaires, EPI antichute, **circulation sur toiture** maîtrisée (échelle de couvreur — jamais d'appui direct sur tuiles/plaques fragiles), **stabilité du support** vérifiée, **météo** (vent/gel/pluie/neige) surveillée. **Arrêt immédiat en cas de danger.** Une intervention en couverture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fuites/condensation** : `traite-diagnostic` → [fuite-toiture](../../../diagnostics/couverture/fuite-toiture.md)

## Relations & tags
- **Tags** : `metier:couverture equipement:bac-acier famille:enveloppe sous-famille:couverture intervention:poser intervention:controler cluster:bac-acier cluster:panneaux-de-couverture cluster:controle complexite:avancee type:installation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
