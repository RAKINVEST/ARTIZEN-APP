# Orchestration Retry — Reprises

> **Version** 1.0 — **Status** Validated — **Owner** Orchestration — **Last Update** 2026-08-02
> **Depends On:** [ORCHESTRATION_PIPELINE.md](ORCHESTRATION_PIPELINE.md), [../../implementation/ERROR_HANDLING.md](../../implementation/ERROR_HANDLING.md) — **Used By:** implémentation — **Niveau:** 2 · Architecture

## Objective
Définir la politique de reprise d'une étape en échec.

## Quand relancer / erreurs relançables vs définitives
| Type d'erreur | Exemple | Relançable ? |
|---|---|---|
| **Transitoire** | timeout, indisponibilité temporaire (DB/Redis), verrou | **oui** |
| **Contention** | conflit optimiste temporaire | oui (avec délai) |
| **Validation** (422) | données invalides | **non** (définitive) |
| **Conflit d'état** (409) | transition interdite (ex. devis figé) | **non** (compensation) |
| **Autorisation** (401/403/404 tenant) | droit/tenant | **non** |

## Combien / délais
- **Bornes** : nombre d'essais **limité** (ex. 3) ; au-delà → étape **définitivement** en échec.
- **Backoff exponentiel** avec jitter (éviter l'effet tempête) — s'appuie sur `app/tasks` (arq/Redis).
- Un **budget de temps** global par orchestration ; dépassé → clôture (Échec/Partiellement réussi).

## Règles
- **Idempotence obligatoire** : une étape rejouée ne double jamais son effet (clé d'idempotence).
- Une erreur **définitive** ne se relance pas : elle déclenche la **compensation** ([ORCHESTRATION_COMPENSATION.md](ORCHESTRATION_COMPENSATION.md)).
- Chaque tentative est **tracée** (numéro, délai, cause) — [ORCHESTRATION_OBSERVABILITY.md](ORCHESTRATION_OBSERVABILITY.md).
- Aucun échec **silencieux** : un abandon est journalisé et supervisé.

## Conformité
Retry borné + idempotent ; classification alignée sur les statuts d'erreur du projet (STEP 5/6). ✅

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
