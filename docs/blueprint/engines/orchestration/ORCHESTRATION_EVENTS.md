# Orchestration Events — Événements

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../ENGINE_EVENTS.md](../ENGINE_EVENTS.md), [../decision/DECISION_EVENTS.md](../decision/DECISION_EVENTS.md) — **Used By:** Performance, observabilité — **Niveau:** 2 · Architecture

## Objective
Décrire les événements d'orchestration. L'orchestrateur **émet des faits de coordination** ; il
**n'écrit pas** les données des moteurs (ce sont eux qui publient leurs propres événements métier).

## Événement consommé (déclencheur)
| Événement (source) | Réaction |
|---|---|
| `DecisionValidated` (Decision) | démarre une orchestration (décomposition en étapes) |

## Événements publiés (coordination / read-model)
| Événement | Sens |
|---|---|
| `OrchestrationStarted` | une orchestration démarre (id, décision) |
| `StepStarted` | une étape est déclenchée vers un moteur |
| `StepSucceeded` | un moteur a exécuté son étape |
| `StepFailed` | échec d'étape (relançable/définitif) |
| `StepCompensated` | une étape a été compensée |
| `OrchestrationCompleted` | terminée (Réussi / Partiellement réussi / Échec / Annulé) |

> Les **effets métier** (`QuoteCreated`, `MissionCreated`…) sont publiés par les **moteurs
> propriétaires**, pas par Orchestration. Tout nouvel événement de cycle = **ADR**.

## Séquence
```mermaid
sequenceDiagram
  participant De as Decision
  participant Or as Orchestration
  participant Q as Quote (propriétaire)
  participant N as Notification (propriétaire)
  De-->>Or: DecisionValidated
  Or-->>Or: OrchestrationStarted
  Or-->>Q: StepStarted (créer devis)
  Q->>Q: crée le Quote (geste propriétaire) ; publie QuoteCreated
  Q-->>Or: résultat
  Or-->>Or: StepSucceeded
  Or-->>N: StepStarted (informer client)
  N-->>Or: résultat
  Or-->>Or: OrchestrationCompleted (Réussi)
```

## Conformité
Événements de coordination uniquement ; les effets métier restent aux propriétaires. ✅

## Changelog
- 1.0 (2026-08-02) — Événements initiaux.
