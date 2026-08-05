# ARTIZEN — Audit Release Candidate (RC-1)

> Artefact d'industrialisation. Photographie de la qualité du dépôt au moment de
> la préparation RC-1. Aucune nouvelle fonctionnalité métier n'a été ajoutée dans
> cette phase : uniquement robustesse, observabilité, packaging et déploiement.

## 1. Synthèse

| Axe | État |
|---|---|
| Tests backend | ✅ verts (suite complète sous Docker/PostgreSQL) |
| Tests Flutter | ✅ verts (analyze + test + build web) |
| Lint (ruff `F,I`) | ✅ « All checks passed » sur tout `app/` |
| Typage (mypy, modules durcis) | ✅ 0 erreur (`--follow-imports=silent`) |
| Migrations Alembic | ✅ tête **unique** `f2a3b4c5d6e7`, chaîne linéaire |
| TODO / FIXME / HACK / XXX (code) | ✅ **0** |
| Imports inutiles / noms indéfinis | ✅ **0** (ruff `F`) |
| Secrets en dur | ✅ aucun (heuristique) |
| Corpus Knowledge | ✅ **embarqué dans l'image** (`backend/knowledge_corpus/`) |
| Observabilité | ✅ correlation_id + temps de réponse + access log + `/health` |
| CI/CD | ✅ lint · pytest · Flutter · **docker build + assertion corpus** — tous bloquants |

## 2. Architecture

- **Monolithe modulaire à modules verticaux** (`models/schemas/repository/service/deps/router`),
  inchangé. 38 packages sous `app/`.
- Moteurs livrés et validés runtime : Knowledge, Decision, Workflow, Mission, Planning,
  Notification, Orchestration, Quote, **AI Companion** (couche conversationnelle, read-side).
- Dépendances inter-moteurs **à sens unique et justifiées** (cf. CLAUDE.md). Seule entorse
  connue et **documentée** : cycle `users ↔ branding` (aucun cycle à l'import — l'app démarre,
  toute la suite le prouve) — à traiter en V2, non bloquant.
- Le Companion n'accède qu'aux **services publics** des moteurs, jamais à un repository/DB.

## 3. Dépendances

- Toutes épinglées (`fastapi==0.115.6`, `sqlalchemy==2.0.36`, `pydantic==2.10.4`, …).
- `bcrypt==4.0.1` épinglé **volontairement** (incompatibilité auto-test passlib 1.7.4 — commenté
  dans `requirements.txt`). Ne pas relever sans lire le commentaire.
- Outillage dev/CI (`ruff`, `mypy`) isolé dans `requirements-dev.txt` — **hors image de prod**.

## 4. Migrations

- Tête unique `f2a3b4c5d6e7` ; `alembic branches` vide (aucun point de branche).
- `postdeploy` Scalingo = `alembic upgrade head` ; l'entrypoint Docker migre avant de servir.

## 5. Sécurité

- `company_id` toujours issu du JWT ; mismatch de tenant → 404 (jamais 403).
- Rate limiting `/auth/*` actif par défaut (`AUTH_RATE_LIMIT_ENABLED=True`).
- En-têtes de sécurité sur chaque réponse (`SecurityHeadersMiddleware`).
- `SECRET_KEY` refusé au boot si placeholder en production.
- Redis/S3/SMTP : abstractions à fallback, jamais d'échec au démarrage sans configuration.
- Corpus d'en-tête `X-Request-ID` **borné et assaini** (jamais cru verbatim).

## 6. Performances

- Un seul point de calcul monétaire (`quotes/calculator.py`, `Decimal`, ADR-023).
- Corpus Knowledge chargé **une fois** et mis en cache (`lru_cache`).
- Temps de réponse mesuré et exposé (`X-Response-Time-ms`) + access log par requête.

## 7. Duplication / dead code

- Aucun import inutile ni nom indéfini (ruff `F` vert).
- Aucune duplication de logique de calcul (invariant ADR-023 respecté).
- Règle « deuxième consommateur = signal d'infrastructure » respectée.

## 8. Dette technique restante (non bloquante)

1. **Lint élargi** : le ruleset RC est `F,I`. Le ruleset par défaut de ruff 0.16.1 remonte ~153
   findings de style **pré-existants** (tri d'imports déjà couvert, `# noqa` orphelins, suggestions
   FURB) sur des fichiers hors sprint — à trier en lot dédié V1.1 (aucun impact runtime).
2. **Typage complet** : mypy est un gate **sur les modules durcis** ; quelques modules legacy
   (`quotes/service.py` — shadowing `list`, sans effet runtime) restent à typer. Objectif V1.1.
3. **Cycle `users ↔ branding`** : refactor V2 (déplacer `Company`).
4. **Phrasing LLM du Companion** : composition déterministe en V1 ; provider câblé pour bascule LLM.

## 9. Risques restants

| Risque | Gravité | Mitigation |
|---|---|---|
| Corpus non commité (`backend/knowledge_corpus` était non suivi par git) | Moyen | **Le commiter** — sinon absent des clones/déploiements. Action PO. |
| mypy partiel | Faible | Gate sur modules critiques ; élargissement V1.1 planifié. |
| Observabilité sans backend de métriques (Prometheus) | Faible | Logs structurés + `/health` suffisent en V1 ; métriques agrégées = V1.1. |

## 10. Verdict RC-1

**Aucun bug bloquant. Tous les tests verts. Build reproductible et corpus embarqué.**
Sous réserve du **commit du corpus** (action PO), la fondation RC-1 est prête pour une validation
par de vrais artisans. Guides opératoires : [INSTALL.md](INSTALL.md), [DOCKER_GUIDE.md](DOCKER_GUIDE.md),
[DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md), [ADMIN_GUIDE.md](ADMIN_GUIDE.md), [USER_GUIDE.md](USER_GUIDE.md),
dossier [release/RC1_DOSSIER.md](release/RC1_DOSSIER.md).
