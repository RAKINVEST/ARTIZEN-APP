# Principe de la couverture (tuiles, ardoises, bac acier, panneaux)

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `principe-couverture` |
| Titre | Principe de la couverture (tuiles, ardoises, bac acier, panneaux) |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : comprendre le rôle de la couverture (mettre le bâti hors d'eau) et ses grands types selon la pente et le support. `[C]`
- **Résumé** : la couverture assure la mise **hors d'eau** ; grands types : **tuiles** (terre cuite/béton), **ardoises**, **bac acier / panneaux**, posés sur un support (liteaux/voliges) selon une **pente** minimale et le climat. `[C]` ⟦pente/recouvrement selon matériau et zone à confirmer⟧

## Réalisation
- **Étapes** :
  1. **Tuiles / ardoises** : pente et recouvrement adaptés. `[C]` → [remplacer-tuiles-ardoises](remplacer-tuiles-ardoises.md)
  2. **Bac acier / panneaux** : fixation, recouvrement, condensation. `[C]` → [poser-controler-bac-acier](poser-controler-bac-acier.md)
  3. **Points singuliers** : faîtage, rives, arêtiers, noues, émergences. `[C]` → [realiser-faitage](realiser-faitage.md)
  4. **Support** (charpente : liteaux/voliges) contrôlé avant pose. `[C]` → [controler-liteaux-voliges](../../../professions/charpente/cards/controler-liteaux-voliges.md)
- **Points critiques** : **pente/recouvrement** conformes au matériau ; ventilation de la sous-toiture ; évacuation de l'eau.
- **Sécurité** : hauteur ; circulation sur toiture ; stabilité du support. **Travail en **hauteur** sur toiture : risque de **chute** (du toit ou à travers une plaque fragile) — protections **collectives** (échafaudage/filet/garde-corps) prioritaires, EPI antichute, **circulation sur toiture** maîtrisée (échelle de couvreur — jamais d'appui direct sur tuiles/plaques fragiles), **stabilité du support** vérifiée, **météo** (vent/gel/pluie/neige) surveillée. **Arrêt immédiat en cas de danger.** Une intervention en couverture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Ventilation de sous-toiture** : `cite-carte` → [entretenir-vmc-simple-flux](../../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)

## Relations & tags
- **Tags** : `metier:couverture equipement:tuile equipement:ardoise equipement:bac-acier famille:enveloppe sous-famille:couverture intervention:comprendre cluster:tuiles cluster:ardoises cluster:bac-acier cluster:panneaux-de-couverture type:principe securite:hauteur relation:charpente relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
