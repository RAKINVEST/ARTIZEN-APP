# Architecture

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [../constitution/](../constitution/README.md) — **Used By:** domain, engines, contracts, ADR — **Niveau:** 2 · Architecture

## Objective
Décrire la structure macro : **Bounded Contexts**, carte de contexte, **règles de dépendances**. Le plan du système.

## Contains
Carte des contextes (Cœur / Moteurs / Partage), sens de dépendance autorisé, décision cadre : monolithe modulaire + bus d'événements interne.

## Navigation
**Pourquoi :** empêcher les couplages qui imposeraient une réécriture (Loi 17). **Public :** architectes, dev. **Avant :** [constitution/](../constitution/README.md). **Après :** [domain/](../domain/README.md). **Dépendants :** engines, contracts, events.

## Rules
Le cœur ne dépend jamais d'un moteur. Les moteurs lisent des événements, jamais des internes. Aucun cycle.

## Acceptance Criteria
Chaque contexte a un propriétaire, un rôle unique, ses dépendances listées.

## Changelog
- 1.0 (2026-08-02) — Section créée (à remplir).
