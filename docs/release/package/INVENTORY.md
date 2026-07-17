# Inventaire — ARTIZEN V2.0.0-RC1

Chiffres **mesurés** par commande au commit tagué `v2.0.0-rc1` (HEAD
`7f68131`). Actualise `docs/release/03_PROJECT_INVENTORY.md` (qui était figé
sur la V1) pour l'état V2.

## Décompte des fichiers

| Catégorie | V1 | **V2** | Commande |
|---|---:|---:|---|
| Python backend (hors tests) | 132 | **135** | `find backend/app -name '*.py' -not -path '*/tests/*' \| grep -v __pycache__ \| wc -l` |
| Python de test | 14 | **17** | `find backend/app/tests -name '*.py' \| grep -v __pycache__ \| wc -l` |
| Migrations Alembic | 5 | **6** | `find backend/alembic/versions -name '*.py' \| wc -l` |
| Dart écrit à la main | 65 | **66** | `find frontend/lib -name '*.dart' -not -name '*.g.dart' -not -name '*.freezed.dart' \| wc -l` |
| Dart généré | 13 | **13** | `find frontend/lib \( -name '*.g.dart' -o -name '*.freezed.dart' \) \| wc -l` |
| Dart de test (unit/widget) | 20 | **21** | `find frontend/test -name '*.dart' \| wc -l` |
| Dart integration_test (UAT) | — | **2** | `find frontend/integration_test frontend/test_driver -name '*.dart' \| wc -l` |

## Modules backend (9 métier)

`users` · `branding` · `document_analysis` · `document_detection` ·
`catalog` · `clients` · `quotes` · `quote_assistant` · `template_import`

Infrastructure transverse : `ai` · `api` · `auth` · `core` · `database` ·
`models` · **`pdf` (peuplé en V2)** · `repositories` · `schemas` · `utils`.

## Features Flutter (9)

`auth` · `branding` · `catalog` · `clients` · `dashboard` ·
`quote_assistant` · `quotes` · `settings` · `template_import`

Navigation : 5 onglets (`StatefulShellRoute`) — Tableau de bord, Clients,
Catalogue, Devis, Paramètres — + routes racines poussées.

## Routes API — **44 endpoints**

- **39 routes métier** (`/api`) : auth 3 · branding 6 · catalog 10 ·
  clients 5 · **quotes 7** · quote_assistant 1 · document_analysis 4 ·
  document_detection 1 · template_import 2.
- **2 routes d'infrastructure codées** : `GET /`, `GET /health`.
- **3 auto-générées** : `/docs`, `/redoc`, `/openapi.json`.

Nouveautés V2 sur `quotes` (V1 en avait 4, V2 en a 7) :
`POST /{id}/duplicate`, `GET /{id}/pdf`, `PUT /{id}/status`. Toujours **ni
`PUT` ni `PATCH`** sur le contenu d'un devis. Détail : `docs/API_REFERENCE.md`.

## Base de données — **13 relations**

12 tables métier + `alembic_version` (mesuré depuis un `pg_dump` réel) :

`brand_profiles` · `catalog_categories` · `catalog_items` · `clients` ·
`companies` · `document_analyses` · `document_detection_results` ·
`document_templates` · **`quote_counters` (V2)** · `quote_lines` · `quotes` ·
`users` · `alembic_version`.

Nouveauté V2 : `quote_counters` (numérotation verrouillée) + colonnes
`quote_number` / `status` sur `quotes`.

## Tests — vue d'ensemble

| Suite | V1 | **V2** |
|---|---:|---:|
| `pytest` | 142 | **208** |
| `flutter test` | 53 | **63** |
| Tests de casse (cycle de vie + PDF) | — | **32** (18 + 14) |
| UAT (parcours navigateur, 17 étapes) | — | **1 scénario** + 13/13 vérifs backend |

## État Git

- Branche : `v2` · HEAD : `7f68131` · Tag : `v2.0.0-rc1`.
- V1 figée sur `main` (`v1.0.0-rc1`) — aucun commit V2 ne l'a touchée.
- **Rien n'est poussé sur `origin`** (décision de non-publication).
