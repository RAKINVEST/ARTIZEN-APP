# Project Structure — Structure officielle

> **Version** 1.0 — **Status** Frozen — **Owner** Architecture — **Last Update** 2026-08-02
> **Depends On:** [ARCHITECTURE_RULES.md](ARCHITECTURE_RULES.md) — **Used By:** tout code — **Niveau:** 3 · Implémentation

## Objective
Fixer l'organisation officielle du dépôt (existant). Toute organisation non conforme est refusée.

## Arborescence de référence
```
/
├── backend/
│   ├── app/
│   │   ├── <module>/        # models, schemas, repository, service, deps, router
│   │   ├── core/            # config, exceptions, security, rate_limit, authorization
│   │   ├── ai/  pdf/  database/  auth/  utils/  tasks/
│   │   ├── storage.py  storage_s3.py  redis_client.py  main.py
│   │   └── tests/           # pytest (sans isolation, DB réelle)
│   ├── alembic/  entrypoint.sh  Dockerfile  Procfile  requirements.txt
├── frontend/
│   └── lib/
│       ├── core/            # api (Dio), widgets, navigation, theme, utils
│       ├── features/<domaine>/  # data / domain / presentation
│       └── shared/
│   └── test/                # miroir de lib/
├── scripts/                 # build/deploy/backup/healthcheck (bash)
├── docs/                    # documentation (français) + blueprint/
└── .github/workflows/       # ci.yml
```

## Règles
- **Backend** : un domaine = un module vertical auto-contenu.
- **Flutter** : feature-first ; `core/api` est la seule couche qui connaît Dio.
- **Tests** : `backend/app/tests/` et `frontend/test/` miroir de la source.
- **Config** : `.env` (jamais commité) ; `.env.example` à jour.
- **Assets/Migrations** : `frontend/.../assets`, `backend/alembic/versions`.
- **Documentation** : `docs/` (français) ; le Blueprint est la source d'architecture.

## Forbidden
Fichier métier hors module · logique dans `core/` transverse sans « second consommateur » · Dio hors `core/api`.

## Acceptance Criteria
Toute nouveauté se range dans cette structure ; aucune organisation ad hoc.

## Related Documents
[CODING_STANDARDS.md](CODING_STANDARDS.md) · [../../CLAUDE.md](../../../CLAUDE.md)

## Next Reading
[DEPENDENCY_RULES.md](DEPENDENCY_RULES.md)

## Changelog
- 1.0 (2026-08-02) — Structure initiale (dépôt réel).
