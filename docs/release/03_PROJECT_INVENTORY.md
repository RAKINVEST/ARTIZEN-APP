# 03 — Inventaire du projet

> ⚠️ **Artefact de certification V1**, figé à la date du tag `v1.0.0-rc1` (2026-07-17).
> Ce document décrit la **V1**, pas l'état courant de la branche `v2`. Pour la V2, voir
> `CHANGELOG.md`, `docs/ROADMAP.md` et `docs/release/07_V2_CERTIFICATION.md`.


**Relevé le 2026-07-17.** Tous les chiffres sont **mesurés** par commande,
jamais estimés. La commande qui produit chacun est donnée pour qu'il soit
recomptable.

## Décompte des fichiers

| Catégorie | Nombre | Commande |
|---|---:|---|
| Python backend (hors tests) | **132** | `find backend/app -name '*.py' -not -path '*/tests/*' \| grep -v __pycache__ \| wc -l` |
| Python de test | **14** | `find backend/app/tests -name '*.py' \| grep -v __pycache__ \| wc -l` |
| Migrations Alembic | **5** | `find backend/alembic/versions -name '*.py' \| wc -l` |
| Dart écrit à la main | **65** | `find frontend/lib -name '*.dart' -not -name '*.g.dart' -not -name '*.freezed.dart' \| wc -l` |
| Dart généré (Freezed/json) | **13** | `find frontend/lib \( -name '*.g.dart' -o -name '*.freezed.dart' \) \| wc -l` |
| Dart de test | **20** | `find frontend/test -name '*.dart' \| wc -l` |

Contrôle croisé du premier chiffre : `git ls-files` donne **128** fichiers
Python suivis hors tests, plus **4** nouveaux non suivis = 132. Cohérent.

## Modules backend

**Modules métier verticaux (9)** — chacun auto-contenu (`models.py`,
`schemas.py`, `repository.py`, `service.py`, `deps.py`, `router.py`) :

`users` · `branding` · `document_analysis` · `document_detection` ·
`catalog` · `clients` · `quotes` · `quote_assistant` · `template_import`

**Infrastructure transverse (11)** :

`ai` · `api` · `auth` · `core` · `database` · `models` · `pdf` (vide) ·
`repositories` · `schemas` · `services` (vide) · `utils`

`quote_assistant` n'a ni modèle, ni table, ni migration — il ne persiste
rien, par contrat.

## Features Flutter (9)

`auth` · `branding` · `catalog` · `clients` · `dashboard` ·
`quote_assistant` · `quotes` · `settings` · `template_import`

Miroir des modules backend, à l'exception de `dashboard` (agrégation
client) et `settings` (écran local).

## Routes API — **42 au total**, extraites de l'application en fonctionnement

Obtenues en introspectant `app.routes` sur l'app réellement montée, pas en
lisant les décorateurs.

**36 routes métier** (`/api`) + **6 routes d'infrastructure**
(`/`, `/health`, `/docs`, `/docs/oauth2-redirect`, `/redoc`, `/openapi.json`).

**Seules 2 routes métier sont accessibles sans JWT** — c'est le contrat :
`POST /api/auth/register` et `POST /api/auth/login`. Ce sont exactement les
deux que le rate limiter protège.

| Module | Routes |
|---|---|
| auth | `POST /api/auth/register` · `POST /api/auth/login` · `GET /api/auth/me` |
| branding | `GET /api/branding/profile` · `PUT /api/branding/company` · `PUT /api/branding/brand` · `POST /api/branding/logo` · `POST /api/branding/template/quote` · `POST /api/branding/template/invoice` |
| catalog | `GET`/`POST /api/catalog/categories` · `GET`/`PUT`/`DELETE /api/catalog/categories/{id}` · `GET`/`POST /api/catalog/items` · `GET`/`PUT`/`DELETE /api/catalog/items/{id}` |
| clients | `GET`/`POST /api/clients` · `GET`/`PUT`/`DELETE /api/clients/{id}` |
| quotes | `GET`/`POST /api/quotes` · `GET`/`DELETE /api/quotes/{id}` |
| quote_assistant | `POST /api/quote-assistant/suggest` |
| document_analysis | `GET /api/document-analysis` · `POST /api/document-analysis/upload` · `GET /api/document-analysis/{id}` · `POST /api/document-analysis/{id}/process` |
| document_detection | `GET /api/document-analysis/{id}/detection` |
| template_import | `GET /api/template-import/{id}/preview` · `POST /api/template-import/{id}/validate` |

Note : `quotes` n'expose **ni `PUT` ni `PATCH`**. C'est délibéré et
documenté — l'absence de chemin d'écriture est aujourd'hui ce qui garantit
que les totaux persistés restent cohérents avec les lignes (voir
`docs/AUDIT-V1.md`). `DELETE` couvre la correction d'une erreur par
suppression-recréation.

## Tests — **219 vérifications automatisées**

| Suite | Nombre | Preuve |
|---|---:|---|
| `pytest` | **142** | `evidence/pytest.txt` |
| `flutter test` | **53** | `evidence/flutter_test.txt` |
| Tests de casse volontaire | **24** | `evidence/break_attempt.txt` |
| QA fonctionnelle HTTP (Docker) | 32 | `evidence/docker_qa.py` — non rejoué aujourd'hui |

## Migrations (5, chaîne linéaire à une seule tête)

```
bd7d5c7f9cc8  add branding tables            (base)
c68fbf271bcb  add document_analyses table
65a012f34084  add document_detection_results table
6521371f0e54  add catalog, clients and quotes tables
75aa1c39d0bf  add users table                (head)
```

**11 tables** + `alembic_version` = 12 relations dans `public`.

## Scripts et points d'entrée

| Fichier | Rôle |
|---|---|
| `backend/entrypoint.sh` | Attend la DB, applique les migrations, bascule en non-root via `setpriv`, lance uvicorn |
| `docker-compose.yml` | Pile de **développement** (`--reload`, bind mount) |
| `backend/Dockerfile` | Image de **production** par défaut (`--workers 4`, sans `--reload`) |
| `.gitattributes` | Force LF sur `*.sh` — sans lui, le conteneur ne démarre pas sur Windows |
| `docs/release/evidence/break_it.py` | 24 tentatives de casse, rejouable |
| `docs/release/evidence/docker_qa.py` | 32 vérifications HTTP contre Docker, rejouable |

## Ce que l'inventaire ne couvre pas

- `frontend/build/` — produit par `flutter build web`, ignoré par git.
- `backend/.env` — artefact local de validation, ignoré par git et par
  `.dockerignore`. **Non versionné, et il ne doit pas l'être.**
