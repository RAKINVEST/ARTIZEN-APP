# Installation — ARTIZEN V2

Deux voies : **Docker** (recommandée, la seule réellement supportée par
`docker compose up`) et **locale sans Docker** (utile pour déboguer le
backend ou lancer pytest hors conteneur). Les deux sont documentées ici avec
les versions exactes utilisées pour valider la V2.

## Versions de référence (commit `v2.0.0-rc1`)

| Composant | Version | Source |
|---|---|---|
| Python | **3.13** (`python:3.13-slim`) | `backend/Dockerfile` |
| PostgreSQL | **16** (`postgres:16-alpine`) | `docker-compose.yml` |
| FastAPI | 0.115.6 | `backend/requirements.txt` |
| SQLAlchemy | 2.0.36 | idem |
| Alembic | 1.14.0 | idem |
| Pydantic | 2.10.4 | idem |
| asyncpg | 0.30.0 | idem |
| reportlab | 4.2.5 | idem |
| python-jose[cryptography] | 3.3.0 | idem |
| passlib[bcrypt] | 1.7.4 | idem |
| bcrypt | **4.0.1 (épinglé)** | idem — voir note ci-dessous |
| Flutter / Dart | Dart **3.12.2** | `frontend/pubspec.yaml` (contrainte SDK) |

> **`bcrypt==4.0.1` est épinglé volontairement** : incompatibilité connue
> avec l'auto-test de passlib 1.7.4. Ne pas mettre à jour sans lire le
> commentaire de `requirements.txt`.

## Voie A — Docker (recommandée)

### 1. Prérequis

- Docker Desktop (Windows/macOS) ou Docker Engine + Compose v2 (Linux).
- Sur **Windows** : WSL 2. Docker Desktop l'exige ; l'installation du noyau
  WSL 2 peut réclamer un redémarrage de Windows.

### 2. Configuration

```bash
cp .env.example .env
```

Éditez `.env` si besoin. Les valeurs par défaut conviennent pour un
développement local. **Pour la production, voir `docs/DEPLOYMENT_GUIDE.md`**
(SECRET_KEY, mot de passe PostgreSQL, `ENVIRONMENT=production`, TLS…).

### 3. Démarrage

```bash
docker compose up
```

- `db` : PostgreSQL 16, volume `artizen_postgres_data`, healthcheck
  `pg_isready`.
- `backend` : build de l'image, attente de la DB, migrations Alembic, puis
  uvicorn sur `:8000`. Healthcheck sur `/health`.

### 4. Vérification

```bash
docker compose ps                     # les deux services "healthy"
docker compose exec backend pytest    # 208 passed
```

### Piège Windows — CRLF et `.gitattributes`

`backend/entrypoint.sh` **doit** rester en fins de ligne **LF**. Sans le
`.gitattributes` du dépôt (qui force LF sur `*.sh`), le défaut de Git for
Windows (`core.autocrlf=true`) le réécrit en CRLF au checkout et le conteneur
redémarre en boucle avec `$'\r': command not found`. **Invisible sur
macOS/Linux.** Ne supprimez pas `.gitattributes`.

## Voie B — Locale sans Docker

Utile pour lancer le backend ou pytest directement. Documentée dans
`docs/release/05_HANDOFF.md`, résumé ici.

### Python (backend)

```bash
# Python 3.13 requis — PAS 3.14 : pydantic==2.10.4 n'a pas de wheel pour
# 3.14 et sa compilation exigerait Rust.
python3.13 -m venv .venv
.venv/bin/pip install -r backend/requirements.txt   # Windows: .venv\Scripts\pip
```

### PostgreSQL local

Nécessite un PostgreSQL 16 écoutant sur `:5432`, et un `backend/.env` avec :

- `POSTGRES_HOST=localhost`
- `STORAGE_LOCAL_ROOT` en **chemin de l'OS hôte** (le `/data/storage` par
  défaut n'existe que dans le conteneur).

> ⚠️ Le port **5432 est partagé** entre un PostgreSQL local et celui de
> Docker. Arrêtez l'un avant de lancer l'autre.

### Lancer

```bash
cd backend
alembic upgrade head
uvicorn app.main:app --reload
```

## Frontend (Flutter)

```bash
cd frontend
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # modèles Freezed
flutter analyze        # No issues found!
flutter test           # 63 passed
flutter run -d web-server --web-port 3000
```

## Après installation

- Guide de déploiement production : `docs/DEPLOYMENT_GUIDE.md`
- Guide Docker (volumes, propriété, réparation) : `docs/DOCKER_GUIDE.md`
- Sauvegarde / restauration : `docs/BACKUP_RESTORE.md`
- Dépannage : `docs/TROUBLESHOOTING.md`
