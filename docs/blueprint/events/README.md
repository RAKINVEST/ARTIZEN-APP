# Events

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../engines/](../engines/README.md) — **Used By:** contracts, moteurs read-side — **Niveau:** 2 · Architecture

## Objective
Cataloguer les **Domain Events** : le seul canal cœur → moteurs. Immuables, versionnés (Loi 4 / 17).

## Contains
Un document par événement : nom, émetteur, consommateurs, charge utile, version de schéma, invariants.

## Navigation
**Pourquoi :** découpler le cœur des moteurs (Loi 7 / 16). **Public :** dev. **Avant :** [engines/](../engines/README.md). **Après :** [contracts/](../contracts/README.md). **Dépendants :** tous les moteurs read-side.

## Rules
Aucun événement ne mute un agrégat cœur. Tout événement porte une version de schéma. On apprend uniquement des actions validées (Loi 13).

## Acceptance Criteria
Chaque événement liste émetteur, consommateurs et version ; aucun orphelin.

## Changelog
- 1.0 (2026-08-02) — Section créée (à remplir).
