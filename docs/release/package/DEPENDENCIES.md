# Dépendances — ARTIZEN V2.0.0-RC1

Inventaire exact des dépendances au commit tagué. Toutes les versions backend
sont **épinglées** (`==`) ; les versions Flutter suivent la convention `^`
(compatibilité sémantique) avec un `pubspec.lock` versionné.

## Backend (`backend/requirements.txt`)

### Runtime

| Paquet | Version | Rôle |
|---|---|---|
| fastapi | 0.115.6 | Framework API |
| uvicorn[standard] | 0.34.0 | Serveur ASGI |
| python-multipart | 0.0.20 | Uploads `multipart/form-data` |
| sqlalchemy | 2.0.36 | ORM async |
| greenlet | 3.1.1 | Support async SQLAlchemy |
| asyncpg | 0.30.0 | Driver PostgreSQL async |
| alembic | 1.14.0 | Migrations |
| pypdf | 5.1.0 | Lecture PDF (analyse de documents) |
| Pillow | 11.0.0 | Images (détection, dépendance reportlab) |
| **reportlab** | **4.2.5** | **Génération PDF (V2)** — pur Python, aucune lib système |
| pydantic | 2.10.4 | Validation / schémas |
| pydantic-settings | 2.7.0 | Configuration |
| python-jose[cryptography] | 3.3.0 | JWT (⚠️ non maintenu — migration PyJWT prévue V3) |
| passlib[bcrypt] | 1.7.4 | Hachage de mots de passe |
| **bcrypt** | **4.0.1 (épinglé)** | Hachage — épinglé pour compatibilité passlib 1.7.4 |
| email-validator | 2.2.0 | Validation d'emails |
| httpx | 0.28.1 | Client HTTP (providers, tests) |
| anthropic | 0.40.0 | SDK IA (optionnel — mock si pas de clé) |

### Développement / tests

| Paquet | Version | Rôle |
|---|---|---|
| pytest | 8.3.4 | Tests |
| pytest-asyncio | 0.25.0 | Tests async |

> **Notes d'épinglage** (commentées dans `requirements.txt`) :
> `reportlab` choisi contre WeasyPrint (pas de cairo/pango dans
> `python:3.13-slim`) ; `bcrypt==4.0.1` figé car passlib 1.7.4 casse avec
> `bcrypt ≥ 4.1`.

## Frontend (`frontend/pubspec.yaml`)

### Runtime

| Paquet | Contrainte | Rôle |
|---|---|---|
| flutter (SDK) | — | Framework |
| cupertino_icons | ^1.0.8 | Icônes |
| flutter_riverpod | ^2.6.1 | Gestion d'état |
| go_router | ^14.6.2 | Navigation |
| dio | ^5.7.0 | Client HTTP (isolé dans `core/api/`) |
| pretty_dio_logger | ^1.4.0 | Logs HTTP |
| freezed_annotation | ^2.4.4 | Modèles immuables |
| json_annotation | ^4.9.0 | (Dé)sérialisation JSON |
| flutter_secure_storage | ^9.2.2 | Stockage du JWT (localStorage sur web) |
| intl | ^0.19.0 | Formatage HT/TVA/TTC |
| file_picker | ^8.1.6 | Choix de fichier (import de modèle) |
| http_parser | ^4.1.2 | `MediaType` pour l'upload multipart |
| **printing** | **^5.15.0** | **Aperçu / impression / partage PDF (V2)** |

### Développement / tests

| Paquet | Contrainte | Rôle |
|---|---|---|
| flutter_test (SDK) | — | Tests unitaires/widget |
| flutter_lints | ^6.0.0 | Analyse statique |
| build_runner | ^2.4.13 | Génération de code |
| freezed | ^2.5.7 | Génération de modèles |
| json_serializable | ^6.9.0 | Génération JSON |
| mocktail | ^1.0.4 | Mocks de test |
| **integration_test (SDK)** | — | **Harnais UAT (V2)** — pilotage navigateur réel |

## Images conteneur

| Image | Version |
|---|---|
| `python` | `3.13-slim` |
| `postgres` | `16-alpine` |

## Nouveautés de dépendances en V2

- Backend : **reportlab** (génération PDF).
- Frontend : **printing** (aperçu/partage PDF) + **integration_test** (UAT,
  dev).
