# CHANGELOG — Orchestration Engine

> **Version** 1.0 — **Status** Living — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [README.md](README.md) — **Used By:** gouvernance — **Niveau:** 2 · Architecture

## Objective
Journal des évolutions de la **spécification** de l'Orchestration Engine.

## Historique
### 1.0 — 2026-08-02
- Création de `docs/blueprint/engines/orchestration/` — 13 documents : moteur & frontières, domaine,
  pipeline, états (7 états), événements, compensations (saga), retry, intégrations, contrats
  documentaires, observabilité, stratégie de test.
- **Coordinateur** d'une **décision validée** : décompose, déclenche, attend, gère erreurs/reprises/
  compensations, trace. Chaque moteur **reste propriétaire** de ses écritures. 5 diagrammes Mermaid.

## Réserves de conformité (explicites)
- **Moteur nouveau** : non présent dans l'ENGINE_MAP gelé → son **enregistrement formel** exige un **ADR** (non fait ici ; aucun document figé modifié).
- **Aucun modèle persistant créé** : trace via `Event`/`History` + infra `app/tasks` ; un magasin de saga dédié = **ADR**.
- Lois 1/5/6/7/18 ; ADR-023 ; aucun code.

## Changelog
- 1.0 (2026-08-02) — Entrée initiale.
