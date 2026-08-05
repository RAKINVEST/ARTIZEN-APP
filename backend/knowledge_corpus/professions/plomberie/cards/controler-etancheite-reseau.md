# Contrôler l'étanchéité d'un réseau après intervention

> **Brouillon (v0) — proposé par IA, en attente de validation métier** (Loi 7/18). Modèle : [../../../cards/CARD_TEMPLATE.md](../../../cards/CARD_TEMPLATE.md).
> Confiance : A normes/fabricant · B technique · C terrain · D hypothèse.

## Métadonnées
| Champ | Valeur |
|---|---|
| Identifiant | `controler-etancheite-reseau` |
| Titre | Contrôler l'étanchéité d'un réseau après intervention |
| Profession | `metier:plomberie` |
| Famille | `famille:fluides` |
| Sous-famille | `sous-famille:alimentation` |
| Version | v0.1 |
| Auteur | IA (proposition) |
| Validateur | ⟦à valider métier⟧ |
| Statut | Brouillon |
| Indice de confiance | **C** (protocole d'essai précis à confirmer) |

## Cadrage
- **Objectif** : Vérifier l'absence de fuite après une intervention avant remise en service définitive. `[C]`
- **Résumé** : Remettre en eau progressivement, contrôler visuellement chaque raccord, laisser en pression et recontrôler après un temps d'observation. `[C]`
- **Difficulté** : `simple` `[C]`
- **Temps moyen** : ~10–20 min (+ temps d'observation) `[C]`

## Réalisation
- **Étapes** :
  1. Rouvrir l'eau **progressivement** ; purger l'air. `[B]`
  2. Contrôler **chaque raccord** (visuel + toucher au sec). `[C]`
  3. Maintenir en **pression de service** ; observer une durée définie. `[C]` ⟦durée/pression d'essai à préciser selon réseau⟧
  4. Recontrôler ; sécher et re-vérifier les points sensibles. `[C]`
  5. Consigner le résultat (OK / reprise). `[C]`
- **Contrôles** : `a-checklist` → [controle-etancheite](../../../checklists/plomberie/controle-etancheite.md)
- **Points critiques** : montée en pression **progressive** ; distinguer humidité résiduelle et fuite ; temps d'observation suffisant. `[C]`
- **Sécurité** : coups de bélier à la remise en eau ; eau chaude sur ECS. `[B]`

## Cadre & suites
- **Normes** : essais d'étanchéité des réseaux d'eau — **DTU 60.1** `[B]` ⟦protocole/valeurs exacts à confirmer par le validateur⟧.
- **Procédure liée** : [purge-reseau](../../../procedures/plomberie/purge-reseau.md)

## Relations & tags
- **Relations** : `a-checklist`, `respecte-norme`.
- **Tags** : `metier:plomberie famille:fluides sous-famille:alimentation intervention:controler intervention:verifier probleme:fuite complexite:simple type:controle`

## Historique
| Version | Date | Auteur | Validateur | Motif |
|---|---|---|---|---|
| v0.1 | 2026-08-02 | IA | ⟦—⟧ | proposition initiale (Brouillon) |
