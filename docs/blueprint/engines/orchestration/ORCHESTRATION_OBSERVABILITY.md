# Orchestration Observability — Traçabilité

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [../../implementation/OBSERVABILITY_GUIDELINES.md](../../implementation/OBSERVABILITY_GUIDELINES.md) — **Used By:** exploitation, Performance — **Niveau:** 2 · Architecture

## Objective
Rendre **chaque orchestration entièrement traçable**, sans exposer de donnée sensible.

## Ce qui est tracé (par orchestration)
| Élément | Détail |
|---|---|
| **Identifiant** | id de corrélation unique (relie toutes les étapes) |
| **Chronologie** | horodatage de chaque transition (début/fin) |
| **Étapes** | moteur cible, entrée logique, résultat (succès/échec/compensée) |
| **Durées** | par étape et totale (goulots) |
| **Erreurs** | type, tentative n°, cause (relançable/définitive) |
| **Événements** | `OrchestrationStarted`/`Step*`/`OrchestrationCompleted` |

## Supports (réutilisation de l'existant — aucun modèle dédié)
- **Journal métier** : `History` (append-only). **Événements** : `Event`. (objets gelés)
- **Logs** : `logging` centralisé, niveaux justes, **jamais de secret/PII** (OBSERVABILITY_GUIDELINES).
- **Métriques** : durées/échecs remontés à **Performance** par événements.
- **Corrélation** : l'id d'orchestration propagé à chaque étape/tâche (`app/tasks`).

## Règles d'or
- **Aucun échec silencieux** : tout abandon/compensation est journalisé et **supervisé**.
- **Explicable** : depuis l'id, on reconstitue le déroulé complet (Loi 6).
- **Sans PII/secret** en trace ; conformité tenant.

## Conformité
S'appuie sur OBSERVABILITY_GUIDELINES (STEP 6) et le journal gelé ; aucun modèle dédié. ✅

## Changelog
- 1.0 (2026-08-02) — Observabilité initiale.
