# CI/CD Policy — Intégration & déploiement continus

> **Version** 1.0 — **Status** Frozen — **Owner** Lead DevOps — **Last Update** 2026-08-02
> **Depends On:** [TEST_STRATEGY.md](TEST_STRATEGY.md) — **Used By:** toute PR/release — **Niveau:** 3 · Implémentation

## Objective
Décrire le pipeline. Ancré sur le réel : `ci.yml` (test) ; déploiement Scalingo (Docker, `PROJECT_DIR=backend`) ; frontend statique Scaleway.

## Pipeline d'intégration (sur push/PR)
1. **Format** (auto) + **Lint / analyse statique** : `ruff`/`mypy`, `flutter analyze`.
2. **Codegen** front : `dart run build_runner build --delete-conflicting-outputs`.
3. **Tests** : backend `pytest` (Postgres+Redis services), frontend `flutter test` + `flutter build web`.
4. Échec bloquant → **pas de merge**. *(CI ne déploie pas — `ci.yml` : « Nothing here deploys ».)*

## Pipeline de livraison
- Backend : `git push scalingo <branche>:master` → build Docker → `alembic upgrade head` (entrypoint + postdeploy).
- Frontend : `scripts/build_frontend.sh` (API bakée) → `scripts/deploy_frontend.sh` (S3 + cache correct).
- Toute variable d'environnement modifiée exige un **redémarrage** (config lue une fois au boot — mémoire d'exploitation).

## Règles
- Aucun artefact non testé n'est livré. Secrets uniquement en variables d'environnement.
- Un changement de schéma HTTP est validé par un `curl` réaliste (les tests ne prouvent pas le contrat).

## Acceptance Criteria
Toute PR passe format+lint+tests+build ; toute release suit le pipeline documenté.

## Related Documents
[RELEASE_PROCESS.md](RELEASE_PROCESS.md) · [MIGRATION_GUIDELINES.md](MIGRATION_GUIDELINES.md)

## Next Reading
[BRANCHING_STRATEGY.md](BRANCHING_STRATEGY.md)

## Changelog
- 1.0 (2026-08-02) — Politique initiale.
