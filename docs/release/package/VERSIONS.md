# Versions — ARTIZEN V2.0.0-RC1

Relevé au commit tagué `v2.0.0-rc1` (branche `v2`, HEAD `7f68131`).

## Version de la release

| Élément | Valeur | Source |
|---|---|---|
| **Tag Git (autoritatif)** | **`v2.0.0-rc1`** | `git describe --tags` |
| Version backend (métadonnée) | `0.1.0` | `backend/app/core/config.py::VERSION` |
| Version frontend (pubspec) | `1.0.0+1` | `frontend/pubspec.yaml` |
| Version affichée (écran Paramètres) | `1.0.0 (MVP)` | `settings_screen.dart` (codé en dur) |

> ⚠️ **Incohérence connue (mineure, cosmétique).** Le tag `2.0.0-rc1` fait
> foi ; les versions applicatives internes (`0.1.0` backend, `1.0.0`
> frontend) ne sont que des métadonnées d'affichage (Swagger, écran
> Paramètres) sans impact comportemental. À aligner sur `2.0.0` avant la
> publication finale. Voir `docs/KNOWN_LIMITATIONS.md` (#8).

## Composants de la pile

| Composant | Version | Source |
|---|---|---|
| Python | **3.13** (`python:3.13-slim`) | `backend/Dockerfile` |
| PostgreSQL | **16** (`postgres:16-alpine`) | `docker-compose.yml` |
| Dart SDK | **^3.12.2** | `frontend/pubspec.yaml` |
| Docker Compose | v2 | — |

## Migrations

- **6 migrations** Alembic, chaîne linéaire, tête **`6cc7943bff6a`**.
- Voir `docs/MIGRATION_GUIDE.md`.

## Historique des tags

| Tag | Date | Portée |
|---|---|---|
| `v1.0.0-rc1` | 2026-07-17 | Release Candidate V1 (catalogue, clients, devis, copilote IA) |
| `v2.0.0-rc1` | 2026-07-17 | Release Candidate V2 (cycle de vie du devis, PDF, duplication, UI) |
