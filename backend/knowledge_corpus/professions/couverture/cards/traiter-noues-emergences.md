# Traiter noues et émergences

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `traiter-noues-emergences` |
| Titre | Traiter noues et émergences |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : assurer l'étanchéité des noues (angles rentrants) et émergences (cheminées, sorties de toit) côté couverture. `[C]`
- **Résumé** : raccorder la couverture à la noue et aux émergences avec recouvrements suffisants et solins/bavettes (interface **zinguerie**), assurer l'écoulement sans rétention. `[C]` ⟦détails selon pente/matériau à confirmer⟧

## Réalisation
- **Étapes** :
  1. Raccorder la couverture à la **noue** (recouvrement). `[C]` → [realiser-noue-metallique](../../../professions/zinguerie/cards/realiser-noue-metallique.md)
  2. Traiter les **émergences** (cheminée, sortie de toit) avec solin/bavette. `[C]`
  3. Vérifier l'écoulement (pas de rétention). `[C]`
  4. Contrôler l'étanchéité des raccords. `[C]` → [fuite-toiture](../../../diagnostics/couverture/fuite-toiture.md)
- **Points critiques** : recouvrements suffisants ; sens d'écoulement ; interface **zinguerie** maîtrisée (bavettes/solins).
- **Sécurité** : hauteur ; émergences (obstacles) ; météo. **Travail en **hauteur** sur toiture : risque de **chute** (du toit ou à travers une plaque fragile) — protections **collectives** (échafaudage/filet/garde-corps) prioritaires, EPI antichute, **circulation sur toiture** maîtrisée (échelle de couvreur — jamais d'appui direct sur tuiles/plaques fragiles), **stabilité du support** vérifiée, **météo** (vent/gel/pluie/neige) surveillée. **Arrêt immédiat en cas de danger.** Une intervention en couverture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Fenetres de toit** : `cite-carte` → [poser-fenetre-de-toit](poser-fenetre-de-toit.md)

## Relations & tags
- **Tags** : `metier:couverture equipement:noue famille:enveloppe sous-famille:couverture intervention:realiser intervention:reparer cluster:noues cluster:emergences cluster:reparation complexite:avancee type:installation securite:hauteur relation:zinguerie relation:etancheite`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
