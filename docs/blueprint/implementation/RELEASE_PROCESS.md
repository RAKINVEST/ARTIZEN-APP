# Release Process — Processus de livraison

> **Version** 1.0 — **Status** Frozen — **Owner** Lead — **Last Update** 2026-08-02
> **Depends On:** [CI_CD_POLICY.md](CI_CD_POLICY.md) — **Used By:** toute mise en production — **Niveau:** 3 · Implémentation

## Objective
Rendre chaque mise en production reproductible et sûre.

## Étapes
1. **Gel de périmètre** : la version est figée (scope triage) ; plus de nouvelle feature.
2. **Stabilisation** sur `release/<version>` : corrections seules.
3. **Vérifications** : CI verte, DoD cochée, migrations relues, CHANGELOG à jour, versionnage sémantique.
4. **Tag** : `vX.Y.Z` (ex. `v1.0.0-rc1`).
5. **Livraison backend** : push Scalingo → build Docker → `alembic upgrade head`.
6. **Livraison frontend** : build (API bakée) → déploiement S3 + invalidation cache.
7. **Post-déploiement** : `/health` OK, redémarrage si variable d'env modifiée, contrôle fumée (création de compte, login, parcours devis).
8. **Journal** : release notée (CHANGELOG + dossier de release).

## Règles
- Rien n'est livré sans passer la CI ni la DoD. Rollback documenté et possible.
- Versionnage sémantique ; rupture de contrat = version majeure + ADR.

## Acceptance Criteria
Chaque release est taguée, testée, tracée, avec un chemin de rollback.

## Related Documents
[DONE_DEFINITION.md](DONE_DEFINITION.md) · [../quality/VERSIONING.md](../quality/VERSIONING.md)

## Next Reading
[DONE_DEFINITION.md](DONE_DEFINITION.md)

## Changelog
- 1.0 (2026-08-02) — Processus initial.
