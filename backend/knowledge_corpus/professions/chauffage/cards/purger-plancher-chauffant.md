# Purger un plancher chauffant à eau

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Niveaux de confiance : A normes/fabricant · B technique · C terrain validé · D hypothèse. Rien n'est publié comme certitude.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `purger-plancher-chauffant` |
| Titre | Purger un plancher chauffant à eau |
| Profession | `metier:chauffage` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:emetteurs` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** |

## Cadrage
- **Objectif** : évacuer l'air des boucles d'un plancher chauffant à eau pour rétablir une chauffe homogène. `[C]`
- **Résumé** : au collecteur, purger boucle par boucle (isoler les autres), rétablir la pression, puis contrôler l'homogénéité et l'équilibrage. `[C]` ⟦protocole selon collecteur à valider⟧

## Réalisation
- **Étapes** :
  1. Repérer départ/retour et les boucles au **collecteur**. `[C]`
  2. Isoler toutes les boucles sauf une ; purger cette boucle à débit franc. `[C]`
  3. Répéter **boucle par boucle**. `[C]`
  4. Rétablir la **pression** du circuit. `[B]`
  5. Contrôler l'homogénéité ; équilibrer si nécessaire. `[C]` → [equilibrer-circuit-chauffage](equilibrer-circuit-chauffage.md)
- **Points critiques** : ne pas dépasser la **température max** d'un plancher chauffant ; purge boucle par boucle. `[B]`
- **Sécurité** : eau chaude ; température de surface limitée (réglementaire). `[B]`

## Cadre & suites
- **Normes** : planchers chauffants à eau chaude **DTU 65.14** ; sécurité **DTU 65.11** `[B]` ⟦références/versions exactes à confirmer par le validateur⟧. `respecte-norme`
- **Procédure liée** : `cite-procedure` → [mise-en-service-chauffage](../../../procedures/chauffage/mise-en-service-chauffage.md)

## Relations & tags
- **Tags** : `metier:chauffage famille:fluides sous-famille:emetteurs intervention:purger intervention:entretenir equipement:plancher-chauffant probleme:air complexite:moyenne type:entretien`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-04 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
