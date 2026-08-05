# Contrôler et regonfler un vase d'expansion

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-regonfler-vase-expansion` |
| Titre | Contrôler et regonfler un vase d'expansion |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:reseau` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : contrôler et rétablir la pression de gonflage d'un vase d'expansion pour stabiliser la pression du circuit. `[C]`
- **Résumé** : isoler et purger le vase côté eau, contrôler la pression d'azote à la valve, regonfler à la valeur préconisée, remettre en service et vérifier la stabilité de la pression. `[C]` ⟦valeur de gonflage selon installation à confirmer⟧

## Réalisation
- **Étapes** :
  1. Isoler le vase et **purger** sa pression d'eau. `[B]`
  2. Contrôler la pression à la **valve** (côté azote) au manomètre. `[C]`
  3. Regonfler à la valeur préconisée (souvent liée à la hauteur d'installation). `[C]` ⟦à confirmer⟧
  4. Remettre en service ; contrôler la **stabilité** de la pression du circuit. `[B]` → [pression-chauffage-instable](../../../diagnostics/chauffage/pression-chauffage-instable.md)
- **Points critiques** : vase HS = pression instable/soupape qui crache ; membrane pouvant être percée (remplacement). `[C]`
- **Sécurité** : eau chaude sous pression ; dépressuriser avant contrôle. `[B]`

## Cadre & suites
- **Normes** : sécurité chauffage central **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Procédure liée** : `cite-procedure` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)

## Relations & tags
- **Tags** : `metier:chauffage famille:fluides sous-famille:reseau intervention:controler intervention:regler equipement:vase-expansion probleme:pression complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
