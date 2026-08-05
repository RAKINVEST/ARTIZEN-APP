# Test Strategy — Stratégie de tests

> **Version** 1.0 — **Status** Frozen — **Owner** Lead QA — **Last Update** 2026-08-02
> **Depends On:** [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) — **Used By:** tout développement — **Niveau:** 3 · Implémentation

## Objective
Tout développement est testé aux bons niveaux. Ancrée sur l'outillage réel (pytest, flutter test, ci.yml).

## Niveaux
| Niveau | Backend | Frontend |
|---|---|---|
| **Unitaire** | logique pure (calculateur, mapping, guards) — sans DB | modèles, notifiers, utils |
| **Intégration** | endpoints + DB/Redis réels (ci.yml) | repositories avec fakes |
| **Fonctionnel** | parcours métier (Business Flows) | widgets/écrans |
| **Non-régression** | tout bug corrigé ajoute un test qui le reproduit | idem |

## Règles & limites connues (à ne pas ignorer)
- **Tests backend sans isolation** : DB PostgreSQL réelle, pas de rollback par test — les données persistent. `asyncio_default_fixture_loop_scope=function` ; fixture `_dispose_engine_after_test`.
- **Les tests ne prouvent pas le contrat HTTP réel** : valider un changement de schéma par un `curl` réaliste, pas seulement la suite.
- **Aucun test Flutter n'appelle le vrai backend** (fakes/mocks) : la validation bout-en-bout est manuelle/recette.
- Un test unitaire pur tourne **sans conftest** (`pytest --noconftest`) quand il n'a pas besoin de la DB.

## Couverture & nomenclature
- Couverture minimale exigée sur la **logique métier** (calcul, invariants, guards, mapping) : élevée ; UI/infra : raisonnable.
- Fichiers `test_<sujet>.py` / `<sujet>_test.dart`, miroir de la source ; noms de test descriptifs (comportement).
- **Aucune donnée client réelle** en test ; données déterministes.

## Acceptance Criteria
Chaque feature a ses tests aux niveaux pertinents ; la suite passe avant merge.

## Related Documents
[QUALITY_STANDARD.md](QUALITY_STANDARD.md) · [CI_CD_POLICY.md](CI_CD_POLICY.md) · [../../CLAUDE.md](../../../CLAUDE.md)

## Next Reading
[QUALITY_STANDARD.md](QUALITY_STANDARD.md)

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
