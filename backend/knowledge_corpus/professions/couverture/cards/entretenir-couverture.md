# Entretenir une couverture

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `entretenir-couverture` |
| Titre | Entretenir une couverture |
| Profession | `metier:couverture` |
| Famille | `famille:enveloppe` |
| Sous-famille | `sous-famille:couverture` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : entretenir une couverture (démoussage, contrôle des éléments et points singuliers) pour prévenir fuites et dégradations. `[C]`
- **Résumé** : contrôler l'état des éléments, démousser par méthode douce, vérifier faîtage/rives/noues/émergences et la ventilation de sous-toiture, en sécurité. `[C]`

## Réalisation
- **Étapes** :
  1. Sécuriser l'accès (protections, échelle de couvreur). `[A]`
  2. **Démousser** (méthode douce, produit adapté). `[C]` ⟦produit à confirmer⟧
  3. Contrôler éléments, faîtage, rives, noues, émergences. `[C]` → [controle-maintenance-couverture](../../../checklists/couverture/controle-maintenance-couverture.md)
  4. Vérifier la **ventilation de sous-toiture** (condensation). `[C]` → [entretenir-vmc-simple-flux](../../../professions/ventilation/cards/entretenir-vmc-simple-flux.md)
- **Points critiques** : démoussage **doux** (haute pression proscrite sur tuiles poreuses) ; ne pas circuler sur éléments fragiles.
- **Sécurité** : hauteur ; circulation sur toiture ; produits (EPI) ; météo. **Travail en **hauteur** sur toiture : risque de **chute** (du toit ou à travers une plaque fragile) — protections **collectives** (échafaudage/filet/garde-corps) prioritaires, EPI antichute, **circulation sur toiture** maîtrisée (échelle de couvreur — jamais d'appui direct sur tuiles/plaques fragiles), **stabilité du support** vérifiée, **météo** (vent/gel/pluie/neige) surveillée. **Arrêt immédiat en cas de danger.** Une intervention en couverture relève de **compétences adaptées**.** `[A]`

## Cadre & suites
- **Normes** : couverture en tuiles de terre cuite **DTU 40.21** ; couverture en ardoises **DTU 40.11** ; couverture en plaques nervurées / bac acier **DTU 40.35** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Kit** : `utilise-kit` → [kit-couvreur](../../../kits/couverture/kit-couvreur.md)

## Relations & tags
- **Tags** : `metier:couverture famille:enveloppe sous-famille:couverture intervention:entretenir cluster:entretien cluster:maintenance cluster:controle complexite:simple type:entretien securite:hauteur relation:ventilation`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
