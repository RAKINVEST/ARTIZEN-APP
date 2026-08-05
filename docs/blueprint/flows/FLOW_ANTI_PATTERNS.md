# Flow Anti-Patterns — Erreurs de flux interdites

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [FLOW_PATTERNS.md](FLOW_PATTERNS.md) — **Used By:** revue de tout flux — **Niveau:** 2 · Architecture

## Objective
Interdire les structures de flux qui cassent la traçabilité, la cohérence ou le contrôle de l'artisan.

## Anti-patterns interdits
| Anti-pattern | Pourquoi | À faire |
|---|---|---|
| **Saut d'étape** | état incohérent | respecter la machine à états |
| **Validation implicite** | l'artisan n'a pas décidé (Loi 7) | confirmation explicite |
| **Action irréversible sans confirmation** | perte non voulue | étape de confirmation obligatoire |
| **Double création** | doublon (Loi 1) | idempotence / vérification d'existence |
| **Événement silencieux** | non traçable | toute transition publie |
| **État impossible** | corruption | transitions déclarées uniquement |
| **Transition cachée** | comportement non documenté | toute transition figure dans FLOW_STATES |
| **Destruction d'une donnée métier** | viole Loi 5 | archiver / compenser |
| **Blocage synchrone d'un traitement long** | gèle l'UI | asynchrone + notification |

## Règle
Un flux qui présente un de ces anti-patterns est refusé en revue. Toute exception exige un **ADR**.

## Acceptance Criteria
Les anti-patterns majeurs sont listés avec leur correction.

## Related Documents
[FLOW_PATTERNS.md](FLOW_PATTERNS.md) · [FLOW_PRINCIPLES.md](FLOW_PRINCIPLES.md)

## Next Reading
[flows/](flows/)

## Changelog
- 1.0 (2026-08-02) — Anti-patterns initiaux.
