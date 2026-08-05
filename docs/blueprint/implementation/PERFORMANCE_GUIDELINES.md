# Performance Guidelines — Objectifs de performance

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [CODING_STANDARDS.md](CODING_STANDARDS.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Fixer des objectifs raisonnables et des pratiques qui les tiennent.

## Objectifs
| Domaine | Objectif |
|---|---|
| **Temps de réponse** | lecture courante < ~300 ms ; écriture < ~500 ms |
| **Traitement long** | IA/OCR/envoi/indexation → **asynchrone** + notification (jamais bloquant) |
| **Base de données** | requêtes indexées ; pagination bornée (limit ≤ 200) ; éviter le N+1 |
| **Pool DB** | dimensionné vs plafond de l'addon × workers (surveiller la saturation) |
| **Cache** | lectures idempotentes cacheables ; invalidation par événement |
| **Mémoire / CPU** | pas de chargement massif en mémoire ; streaming pour les gros fichiers |
| **Flutter** | pas de rebuild inutile ; état serveur en `AsyncNotifier` ; images `max-width:100%` |
| **PDF** | rendu hors event-loop (thread) |
| **OCR / IA** | asynchrone ; timeout + refus explicite ; jamais de blocage UI |

## Règles
Mesurer avant d'optimiser ; matérialiser les read-models **tard**. Un traitement long ne gèle jamais l'interface.

## Acceptance Criteria
Les objectifs sont respectés ou l'écart est justifié en revue.

## Related Documents
[OBSERVABILITY_GUIDELINES.md](OBSERVABILITY_GUIDELINES.md)

## Next Reading
[ERROR_HANDLING.md](ERROR_HANDLING.md)

## Changelog
- 1.0 (2026-08-02) — Objectifs initiaux.
