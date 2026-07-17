# Guide Docker — ARTIZEN V2

Ce qu'il faut savoir pour exploiter la pile conteneurisée : la composition,
les volumes, la question de la **propriété du volume de stockage** (la seule
subtilité réelle), et les commandes courantes. Tout ce qui suit est ancré
sur `docker-compose.yml`, `backend/Dockerfile` et `backend/entrypoint.sh` du
commit `v2.0.0-rc1`.

## Deux artefacts, deux usages

| Artefact | Rôle | Caractéristique |
|---|---|---|
| `docker-compose.yml` | Pile de **développement** | `--reload`, bind-mount `./backend:/app` |
| `backend/Dockerfile` (image) | Serveur de **production** par défaut | `--workers 4`, sans `--reload`, non-root |

**Ne déployez pas `docker-compose.yml` tel quel en production** : c'est la
pile de dev. L'image, elle, est déjà en configuration production par défaut
(son propre `CMD`). Voir `docs/DEPLOYMENT_GUIDE.md`.

## Services

### `db`

- Image `postgres:16-alpine`, `restart: unless-stopped`.
- Volume `artizen_postgres_data` → `/var/lib/postgresql/data`.
- Port `5432:5432`.
- Healthcheck : `pg_isready -U <user> -d <db>` (interval 5s, 10 essais).

### `backend`

- Build depuis `./backend/Dockerfile`.
- `env_file: .env` + surcharge `POSTGRES_HOST: db` (toujours joindre la base
  par le réseau compose, quel que soit le `POSTGRES_HOST` du `.env` utilisé
  pour du dev hors Docker).
- `depends_on: db (service_healthy)`.
- Port `8000:8000`.
- Volumes : bind-mount `./backend:/app` (dev) + `artizen_storage_data` →
  `/data/storage`.
- Healthcheck : `curl -f http://localhost:8000/health` (interval 10s,
  start_period 15s).

## L'entrypoint et la propriété du volume — à comprendre

Le conteneur **démarre en root**, répare si nécessaire la propriété du
volume de stockage, puis bascule vers l'utilisateur non-root `artizen` via
`setpriv`. C'est **volontaire** : il n'y a **pas** de directive `USER` dans
le Dockerfile.

Pourquoi : Docker ne copie la propriété `artizen` de `/data/storage` sur le
volume `artizen_storage_data` **que** lorsqu'il l'initialise vide. Un volume
créé avant que le conteneur ne passe non-root reste détenu par root, et les
uploads échouent alors en `EACCES` — alors que `/health` (un simple
`SELECT 1`) se déclare `healthy`. Ajouter `USER artizen` au Dockerfile
casserait cette réparation, en silence.

L'entrypoint vérifie **l'arbre entier** `/data/storage` (`find -not -user`),
pas seulement la racine — un correctif V2 : les sous-répertoires créés à la
demande (`logos/`, `templates/`, `document_analysis/`) pouvaient rester
root-owned sur un volume hérité de la V1.

### Réparer un volume préexistant détenu par root

Symptôme : upload de logo / génération PDF échouant en `EACCES`.

```bash
# Option 1 — réparer la propriété (conserve les fichiers)
docker compose run --rm --user root backend chown -R artizen /data/storage

# Option 2 — repartir de zéro (DÉTRUIT les fichiers stockés)
docker compose down -v
```

## Piège Git Bash sur Windows — conversion de chemins

`docker run -v vol:/data/storage` devient
`C:/Program Files/Git/data/storage` sous Git Bash. Préfixez la commande par :

```bash
export MSYS_NO_PATHCONV=1
```

## Commandes courantes

```bash
docker compose up                 # démarrer (logs au premier plan)
docker compose up -d              # démarrer en arrière-plan
docker compose ps                 # état + santé des services
docker compose logs backend       # logs de l'API
docker compose logs -f backend    # logs suivis
docker compose restart backend    # redémarrer l'API (pool de connexions neuf)
docker compose down               # arrêter (conserve les volumes)
docker compose down -v            # arrêter + SUPPRIMER les volumes (reset total)

docker compose exec backend pytest                      # 208 passed
docker compose exec backend alembic upgrade head        # migrations
docker compose exec backend alembic revision --autogenerate -m "msg"
docker compose exec db psql -U artizen -d artizen       # console SQL
```

## Santé et diagnostic

- `GET /health` fait un vrai `SELECT 1` : renvoie `ok`, ou `degraded` si la
  base est injoignable (utile pour un load balancer).
- Le conteneur tourne en uid non-root (`artizen`, uid 1000) — vérifiable :
  `docker compose exec backend id`.

## Sauvegarde des volumes

Deux volumes contiennent tout l'état persistant : `artizen_postgres_data`
(la base) et `artizen_storage_data` (logos, templates, documents uploadés).
Leur sauvegarde/restauration est traitée dans `docs/BACKUP_RESTORE.md`.
