# Orchestration Engine — Spécification détaillée

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../decision/README.md](../decision/README.md) — **Used By:** implémentation future — **Niveau:** 2 · Architecture · **Couche:** coordination

## Objective
Spécifier l'**Orchestration Engine** : le coordinateur qui transforme une **décision validée** en une
**suite d'actions cohérentes** entre les moteurs métier. **Aucun code.**

## Division des rôles (rappel)
- **Decision Engine** *pense* (propose, explique) — [../decision/](../decision/README.md).
- **Orchestration Engine** *coordonne* (exécute la séquence après validation).
- **Moteurs métier** *exécutent* et **restent propriétaires de leurs données**.
- L'Orchestration Engine **ne remplace aucun moteur** ; il les **coordonne**.

## Conformité — deux réserves explicites (jamais silencieuses)
1. **Moteur nouveau.** Orchestration **n'est pas** dans l'ENGINE_MAP gelé (contrairement à Decision,
   nommé read-side). Cette spécification **ne modifie aucun document figé** ; son **enregistrement
   formel** dans [../ENGINE_MAP.md](../ENGINE_MAP.md) relève d'un **ADR** (à créer, non fait ici).
2. **Aucun modèle persistant créé.** La trace/état d'orchestration réutilise les objets **`Event`/
   `History`** (journal gelé) et l'infrastructure réelle **`app/tasks`** (Redis/arq) ; un magasin de
   saga **dédié persistant** serait **ADR-gated** (signalé, non créé).

## Invariants
- Ne s'exécute qu'**après validation utilisateur** (reçoit une décision validée).
- **Coordonne**, n'**écrit pas** les données d'un autre moteur : chaque moteur exécute **ses** écritures.
- **Aucune destruction** de donnée métier (Loi 5) : les compensations passent par des **opérations
  légitimes** des moteurs propriétaires (transitions d'état), jamais par suppression sauvage.
- Traçable de bout en bout (observabilité), sans secret/PII en log.

## Documents
| Document | Rôle |
|---|---|
| [ORCHESTRATION_ENGINE.md](ORCHESTRATION_ENGINE.md) | responsabilité, frontières |
| [ORCHESTRATION_DOMAIN.md](ORCHESTRATION_DOMAIN.md) | domaine (décision → saga) |
| [ORCHESTRATION_PIPELINE.md](ORCHESTRATION_PIPELINE.md) | pipeline d'exécution |
| [ORCHESTRATION_STATES.md](ORCHESTRATION_STATES.md) | cycle de vie d'une orchestration |
| [ORCHESTRATION_EVENTS.md](ORCHESTRATION_EVENTS.md) | événements |
| [ORCHESTRATION_COMPENSATION.md](ORCHESTRATION_COMPENSATION.md) | compensations (saga) |
| [ORCHESTRATION_RETRY.md](ORCHESTRATION_RETRY.md) | reprises |
| [ORCHESTRATION_INTEGRATIONS.md](ORCHESTRATION_INTEGRATIONS.md) | intégrations inter-moteurs |
| [ORCHESTRATION_APIS.md](ORCHESTRATION_APIS.md) | contrats documentaires |
| [ORCHESTRATION_OBSERVABILITY.md](ORCHESTRATION_OBSERVABILITY.md) | traçabilité |
| [ORCHESTRATION_TEST_STRATEGY.md](ORCHESTRATION_TEST_STRATEGY.md) | stratégie de test |
| [CHANGELOG.md](CHANGELOG.md) | journal |

## Changelog
- 1.0 (2026-08-02) — Spécification initiale.
