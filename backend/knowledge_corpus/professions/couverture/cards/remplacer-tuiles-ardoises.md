# Remplacer des tuiles / ardoises

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `remplacer-tuiles-ardoises` |
| Titre | Remplacer des tuiles / ardoises |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : remplacer des tuiles ou ardoises cassées/déplacées en rétablissant l'étanchéité et le recouvrement. `[C]`
- **Résumé** : accéder en sécurité, déposer les éléments dégradés, poser des éléments **identiques** (modèle/format), rétablir crochets/fixations et recouvrement, contrôler l'écoulement. `[C]` ⟦modèle/format à confirmer⟧

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (protections collectives, échelle de couvreur). `[A]`
  2. Déposer les éléments cassés/déplacés ; contrôler le support. `[C]` → [tuile-cassee-deplacee](../../../diagnostics/couverture/tuile-cassee-deplacee.md)
  3. Poser des éléments **identiques** ; rétablir crochets (ardoises) / fixations. `[C]`
  4. Vérifier **recouvrement** et écoulement (pas d'infiltration). `[C]`
- **Points critiques** : éléments identiques (format/modèle) ; recouvrement respecté ; ne pas casser les tuiles voisines.
- **Sécurité** : hauteur ; **jamais d'appui direct** sur les tuiles/ardoises ; météo. **Travail en **hauteur** sur toiture : risque de **chute** (du toit ou à travers une plaque fragile) — protections **collectives** (échafaudage/filet/garde-corps) prioritaires, EPI antichute, **circulation sur toiture** maîtrisée (échelle de couvreur — jamais d'appui direct sur tuiles/plaques fragiles), **stabilité du support** vérifiée, **météo** (vent/gel/pluie/neige) surveillée. **Arrêt immédiat en cas de danger.** Une intervention en couverture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fuites liées** : `traite-diagnostic` → [fuite-toiture](../../../diagnostics/couverture/fuite-toiture.md)

## Relations & tags
- **Tags** : `metier:couverture equipement:tuile equipement:ardoise famille:enveloppe sous-famille:couverture intervention:remplacer intervention:reparer cluster:tuiles cluster:ardoises cluster:remplacement-elements cluster:reparation complexite:moyenne type:reparation securite:hauteur`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
