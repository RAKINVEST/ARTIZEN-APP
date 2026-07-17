# Versions — ARTIZEN V2.0.0-RC1

Relevé au commit tagué `v2.0.0-rc1` (branche `v2`, HEAD `7f68131`).

## Version de la release

Depuis la **RC2**, toutes les versions applicatives sont **alignées sur
`2.0.0`**.

| Élément | Valeur | Source |
|---|---|---|
| **Tag Git — tip courant** | **`v2.0.0-rc2`** | `git describe --tags` |
| Tag Git — photographie certifiée (gelée) | `v2.0.0-rc1` | `git tag` |
| Version backend | `2.0.0` | `backend/app/core/config.py::VERSION` |
| Version frontend (pubspec) | `2.0.0+1` | `frontend/pubspec.yaml` |
| Version affichée (écran Paramètres) | `2.0.0` | `settings_screen.dart` |

> **Historique.** À la RC1, ces versions divergeaient (`0.1.0` backend,
> `1.0.0` frontend, tag `2.0.0-rc1`) — incohérence **mineure** de métadonnée
> d'affichage (Swagger, écran Paramètres), sans impact comportemental. La
> **RC2** les aligne toutes sur `2.0.0` ; c'est son unique objet, avec les
> mises à jour de documentation associées. La RC1 reste la photographie
> certifiée, figée.

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
| `v2.0.0-rc1` | 2026-07-17 | Release Candidate V2 (cycle de vie du devis, PDF, duplication, UI) — **photographie certifiée, figée** |
| `v2.0.0-rc2` | 2026-07-17 | RC2 minimale : alignement des versions sur `2.0.0` + métadonnées. Aucun changement fonctionnel. |
