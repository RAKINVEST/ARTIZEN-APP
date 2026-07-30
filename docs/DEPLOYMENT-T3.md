# Déploiement — Topologie T3 (production)

Runbook de mise en production d'ARTIZEN. **Topologie figée (décision d'architecture) :**

```
Frontend Flutter Web (bundle statique)        Backend API FastAPI
   Object Storage + CDN EU          ── HTTPS ──►  Scalingo (osc-fr1, France)
   app.artizen.fr                                 api.artizen.fr
                                                    ├─ PostgreSQL managé (addon)
                                                    ├─ Redis managé (addon)
                                                    ├─ Object Storage S3 (EU) ── logos, PDF, docs
                                                    └─ Brevo (SMTP transactionnel)
   Monitoring externe (UptimeRobot) ── GET /api/health
```

Fondations : gouvernance **« Build Product, Not Infrastructure »** ([DECISIONS.md §9](DECISIONS.md)).
Le frontend ne contient **aucune donnée personnelle** (tout vit dans le Postgres France).
Front et back ne communiquent que par le **contrat API + CORS** — découplage total.

> **Tout le code est prêt.** Ce document ne décrit que des **activations** (comptes, credentials,
> DNS) : aucune ligne de code n'est à écrire pour déployer. Voir le template des variables :
> [.env.production.example](../.env.production.example).

---

## 0. Prérequis (comptes à créer — hors code)

| Ressource | Fournisseur suggéré (EU) | Sert à |
|---|---|---|
| App PaaS | **Scalingo** (osc-fr1) | Backend API + addons managés |
| Object storage S3 | **Scaleway** / OVH (FR) | Logos, PDF, documents |
| SMTP transactionnel | **Brevo** (FR) | E-mails de réinitialisation |
| Nom de domaine + DNS | (au choix) | `api.` et `app.` |
| Supervision | **UptimeRobot** (offre gratuite) | Alerte sur `/api/health` |

---

## 1. Ordre de déploiement

**Le backend d'abord** : le build du frontend a besoin de l'URL API finale.

### Étape 1 — DNS
Réserver le domaine. Prévoir deux sous-domaines : **`api.artizen.fr`** (backend), **`app.artizen.fr`** (frontend).

### Étape 2 — Backend sur Scalingo
```bash
# Création (région France) + addons managés
scalingo create artizen-api --region osc-fr1
scalingo --app artizen-api addons-add postgresql postgresql-starter-512
scalingo --app artizen-api addons-add redis     redis-starter-256

# Monorepo : ne construire que le sous-dossier backend/ (déploiement par Dockerfile)
scalingo --app artizen-api env-set PROJECT_DIR=backend
```
Les migrations Alembic tournent **automatiquement** : `entrypoint.sh` exécute `alembic upgrade head`
avant de lancer uvicorn, et `scalingo.json` déclare le même `postdeploy` en filet de sécurité.
Le serveur se lie à `$PORT` (injecté par la plateforme) — voir le `CMD` du Dockerfile / le `Procfile`.

### Étape 3 — Object storage S3 (EU)
Créer le bucket (région FR) + une paire de clés. **Activer le versioning** du bucket (protection
contre une suppression accidentelle → sert de sauvegarde des fichiers).

### Étape 4 — SMTP (Brevo)
Créer le compte, **vérifier le domaine expéditeur (SPF + DKIM)**, récupérer les identifiants SMTP.

### Étape 5 — Variables backend
Poser toutes les variables (voir [.env.production.example](../.env.production.example)) :
```bash
scalingo --app artizen-api env-set \
  ENVIRONMENT=production \
  SECRET_KEY="$(python -c 'import secrets; print(secrets.token_urlsafe(64))')" \
  DATABASE_URL_OVERRIDE="$SCALINGO_POSTGRESQL_URL" \
  RATE_LIMIT_BACKEND=redis \
  STORAGE_PROVIDER=s3 STORAGE_S3_ENDPOINT_URL=... STORAGE_S3_REGION=fr-par \
  STORAGE_S3_BUCKET=... STORAGE_S3_ACCESS_KEY=... STORAGE_S3_SECRET_KEY=... \
  EMAIL_PROVIDER=smtp SMTP_HOST=smtp-relay.brevo.com SMTP_PORT=587 \
  SMTP_USERNAME=... SMTP_PASSWORD=... EMAIL_FROM=no-reply@artizen.fr \
  SUPPORT_EMAIL=support@artizen.fr \
  CORS_ORIGINS=https://app.artizen.fr APP_BASE_URL=https://app.artizen.fr
```
`REDIS_URL` est fourni par l'addon (`$SCALINGO_REDIS_URL`) — le mapper si nécessaire.
Le backend **refuse de démarrer** si un provider sélectionné est incomplet (garde-fou config).

### Étape 6 — Domaine + TLS backend
```bash
scalingo --app artizen-api domains-add api.artizen.fr   # + enregistrement DNS CNAME
```
Scalingo émet et renouvelle le certificat TLS **automatiquement**. **Vérifier que HSTS est actif
au niveau du routeur Scalingo** (l'app ne l'émet pas elle-même). Test : `curl -fsS https://api.artizen.fr/api/health`.

### Étape 7 — Frontend (bundle statique)
```bash
API_BASE_URL=https://api.artizen.fr/api ./scripts/build_frontend.sh
FRONTEND_S3_ENDPOINT=https://s3.fr-par.scw.cloud FRONTEND_S3_BUCKET=artizen-web \
  ./scripts/deploy_frontend.sh
```
Brancher le CDN sur le bucket, puis le domaine **`app.artizen.fr`** + TLS (CDN). L'URL API est
figée dans le bundle au build : un changement de domaine API impose un rebuild.

### Étape 8 — Boucler le CORS
`CORS_ORIGINS` doit valoir exactement `https://app.artizen.fr`. **Tester un login depuis le domaine
réel** (les tests ne prouvent pas le contrat HTTP réel — piège documenté du dépôt).

### Étape 9 — Monitoring
UptimeRobot → `https://api.artizen.fr/api/health` (guette `"status":"ok"`), alerte e-mail.
Sonde locale équivalente : `scripts/healthcheck.sh`.

### Étape 10 — Sauvegardes & restauration
- **Base** : backups automatiques de l'addon PostgreSQL managé (vérifier la rétention). Restauration
  via l'interface/CLI Scalingo.
- **Fichiers** : versioning du bucket S3 (Étape 3).
- **Test de restauration** : à faire **une fois** avant l'ouverture, puis **une fois par trimestre**.
  Sur stack auto-hébergée/compose, `scripts/backup.sh` + `scripts/restore.sh` sont la procédure testée.

---

## Notes d'exploitation

- **Worker asynchrone (arq)** : inutile en V1 (PDF et e-mails synchrones). L'activer seulement quand
  les fonctions V3 arrivent : `scalingo --app artizen-api scale worker:1` (commande `worker` du Procfile).
- **TLS base de données** : `_to_asyncpg_url` retire les paramètres libpq (`sslmode=…`) de l'URL de
  l'addon — asyncpg négocie TLS directement. Si un fournisseur **impose** un TLS forcé qu'asyncpg ne
  prend pas seul, l'ajouter via `connect_args` dans `app/database/session.py` (pas dans l'URL).
- **Rétention RGPD** : `RETENTION_INACTIVE_ACCOUNT_DAYS` reste **non défini** tant que le juriste n'a
  pas fixé la durée (purge = no-op). Activation cron ensuite : `scripts/retention_purge.sh`.
- **`/docs` désactivé en production** (divulgation de schéma) — normal, pas une panne.

---

## Checklist finale avant le premier client

- [ ] `GET /api/health` = `ok` sur `api.artizen.fr` (HTTPS, certificat valide).
- [ ] HSTS actif au routeur Scalingo.
- [ ] Login réel depuis `app.artizen.fr` (CORS OK, JWT OK).
- [ ] Upload d'un logo → présent dans le **bucket S3** (rien sur le disque conteneur).
- [ ] Parcours complet : compte → identité → catalogue → client → devis → **PDF**.
- [ ] E-mail de réinitialisation **réellement reçu** (Brevo, SPF/DKIM verts).
- [ ] Pages légales accessibles **déconnecté** ; `{email}` = `SUPPORT_EMAIL` réel.
- [ ] Suppression de compte (RGPD) vérifiée bout-en-bout.
- [ ] Sonde UptimeRobot verte + alerte testée.
- [ ] **Un** backup PostgreSQL restauré avec succès en test.
- [ ] **Contenu légal validé (juriste)** + `RETENTION_INACTIVE_ACCOUNT_DAYS` posé (ou décidé « non »).
- [ ] `SUPPORT_EMAIL` = adresse réelle relevée.
