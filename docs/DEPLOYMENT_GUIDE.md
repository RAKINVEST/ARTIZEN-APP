# Guide de déploiement — ARTIZEN V2 en production

Ce guide rassemble ce qu'il faut faire **avant** d'exposer Artizen à de vrais
artisans. Il consolide la check-list de `docs/release/04_RELEASE_PACKAGE.md`
et l'actualise pour la V2. Chaque garde applicative citée ici est **vérifiée
par le code** (`backend/app/core/config.py`).

## Principe : l'image est prod, le compose est dev

- `backend/Dockerfile` produit une **image de production par défaut** : son
  `CMD` lance uvicorn avec plusieurs workers, sans `--reload`, en utilisateur
  non-root `artizen`.
- `docker-compose.yml` est la pile de **développement** (`--reload`,
  bind-mount du code). **Ne le déployez pas tel quel.**

Déployez l'**image** (via votre orchestrateur : Compose de prod dédié,
Kubernetes, ECS…), pas le compose de dev.

## Check-list bloquante

Rien de ce qui suit n'est optionnel pour une mise en production.

- [ ] **Générer un vrai `SECRET_KEY`.**
  ```bash
  python -c "import secrets; print(secrets.token_urlsafe(64))"
  ```
  *Le code refuse de démarrer en `ENVIRONMENT=production` si `SECRET_KEY` est
  le placeholder de `.env.example` ou fait moins de 32 caractères* —
  `config.py::_reject_placeholder_secret_in_production`. Un secret public
  laisserait forger un JWT pour n'importe quel artisan de n'importe quelle
  entreprise.

- [ ] **`ENVIRONMENT=production`** et **`DEBUG=false`.**
  *Le code refuse `DEBUG=true` quand `ENVIRONMENT=production`* —
  `config.py::_reject_debug_in_production`. `DEBUG` exposerait les internes
  via les pages d'erreur FastAPI.

- [ ] **Changer `POSTGRES_PASSWORD`** (par défaut `change_me`).

- [ ] **Reverse proxy devant uvicorn**, avec **TLS** et une **limite de corps**.
  uvicorn est aujourd'hui exposé en direct sur `:8000`. Un garde applicatif
  refuse déjà les corps > 20 Mo (`MaxBodySizeMiddleware`, réponse **413**),
  mais il lit `Content-Length` : une requête chunkée passe outre. Le reverse
  proxy ferme ce trou.

- [ ] **`CORS_ORIGINS` sur le vrai domaine du frontend.** La valeur vient de
  `.env` (`config.py`), **pas** de `docker-compose.yml`. Défaut :
  `http://localhost:3000`.

## Fortement recommandé

- [ ] **Stratégie de sauvegarde** des deux volumes (`artizen_postgres_data`,
  `artizen_storage_data`). **Aucune n'existe par défaut.** Procédure et
  commandes testées : `docs/BACKUP_RESTORE.md`.
- [ ] **`ANTHROPIC_API_KEY`** si le copilote doit être réel. Sans elle,
  `MockAIProvider` prend le relais (appariement par mots-clés déterministe,
  pas une vraie IA) — l'app démarre et le copilote répond quand même.
- [ ] **Parcours de fumée** après déploiement : `curl https://.../health` doit
  renvoyer `{"database":"ok"}` ; créer un compte, un devis, générer un PDF.

## Variables d'environnement de production

Référence complète : `.env.example`. Valeurs à durcir en production :

| Variable | Dev | Production |
|---|---|---|
| `ENVIRONMENT` | `development` | **`production`** |
| `DEBUG` | `true` | **`false`** |
| `SECRET_KEY` | placeholder | **secret généré (≥ 32 car.)** |
| `POSTGRES_PASSWORD` | `change_me` | **mot de passe fort** |
| `CORS_ORIGINS` | `http://localhost:3000` | **domaine réel du frontend** |
| `ACCESS_TOKEN_EXPIRE_MINUTES` | `1440` (24 h) | à arbitrer selon votre politique |
| `AUTH_RATE_LIMIT_ENABLED` | `true` | **`true`** (ne désactiver que pour les tests) |
| `ANTHROPIC_API_KEY` | vide (→ mock) | clé réelle si IA voulue |

## Rate limiting — limite connue

`AUTH_RATE_LIMIT_*` protège `POST /auth/login` et `POST /auth/register` (les
deux seules routes sans JWT). **Le compteur vit dans la mémoire de chaque
worker** : avec le `CMD` de production (4 workers), le plafond réel est
≈ 4× la valeur configurée. Il fait aussi confiance à l'IP du socket, donc
inopérant derrière un proxy sans `X-Forwarded-For`. Suffisant pour fermer le
trou béant (énumération illimitée) ; un store partagé (Redis) est la forme
V3. Voir `docs/SECURITY.md`.

## Frontend

`flutter build web --release` produit `frontend/build/web/` (statique). À
servir par le reverse proxy / un CDN. Assurez-vous que l'URL d'API pointée
par le build correspond à votre backend et figure dans `CORS_ORIGINS`.

## Migrations en production

L'entrypoint applique `alembic upgrade head` au démarrage du conteneur.
Avant une montée de version qui embarque une nouvelle migration :
**sauvegardez la base** (`docs/BACKUP_RESTORE.md`), puis lisez
`docs/MIGRATION_GUIDE.md` (la migration V2 `6cc7943bff6a` a un `downgrade`
propre, testé).

## Après mise en production — à surveiller (logs)

- `quote_assistant.catalog_truncated` — une entreprise dépasse 1000 articles
  actifs (le copilote ne voit pas au-delà).
- `branding.previous_logo_delete_failed` — fuite de fichiers.
- `anthropic.request_failed` — indisponibilité du fournisseur IA (503).
- Taux de **429** sur `/auth/*` — pic = attaque ou plafond trop bas.
- Erreurs `EACCES` sur un upload — volume de stockage détenu par root
  (`docs/DOCKER_GUIDE.md`).
