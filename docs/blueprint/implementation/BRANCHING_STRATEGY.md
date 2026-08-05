# Branching Strategy — Stratégie Git

> **Version** 1.0 — **Status** Frozen — **Owner** Lead — **Last Update** 2026-08-02
> **Depends On:** [REVIEW_PROCESS.md](REVIEW_PROCESS.md) — **Used By:** tout contributeur — **Niveau:** 3 · Implémentation

## Objective
Une stratégie Git prévisible.

## Branches
| Branche | Rôle | Règles |
|---|---|---|
| `main` | production certifiée | protégée ; merge via PR + CI verte + revue |
| `develop/*` | intégration (ex. `develop/v3`) | base des features ; CI sur push |
| `feature/<sujet>` | une fonctionnalité | courte ; part de develop |
| `hotfix/<sujet>` | correctif urgent | part de main ; back-merge develop |
| `release/<version>` | stabilisation | corrections seules |

## Conventions
- Nommage : `feature/import-devis-v2`, `hotfix/cors-artizen-web`.
- **Commits** : message clair ; trailer `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>` pour les contributions assistées.
- **Ne jamais** committer/pusher sans demande explicite ; ne jamais travailler directement sur `main`.
- **Fusion** : squash ou merge selon la politique d'équipe ; branche supprimée après merge.
- Ne pas `--force`/skip hooks sans autorisation explicite.

## Forbidden
Commit sur `main` · force-push destructif · branche « fourre-tout ».

## Acceptance Criteria
Toute contribution suit ce modèle ; `main` reste protégée et déployable.

## Related Documents
[CI_CD_POLICY.md](CI_CD_POLICY.md) · [RELEASE_PROCESS.md](RELEASE_PROCESS.md)

## Next Reading
[DOCUMENTATION_RULES.md](DOCUMENTATION_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Stratégie initiale.
