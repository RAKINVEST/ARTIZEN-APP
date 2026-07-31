# ARTIZEN — Runbook d'exécution du premier déploiement (T20 → T35)

Procédure **prête à exécuter** le jour où les 4 comptes sont ouverts (Scalingo,
Scaleway, Brevo, UptimeRobot). Document **d'exploitation** (hors référentiel gelé) :
il **n'ajoute aucun code** et applique la topologie T3 gelée avec les **valeurs
figées** (décisions PO). Cadre de référence : `DEPLOYMENT-T3.md`,
`DEPLOYMENT_INPUTS.md`, `EXPLOITATION-V1.md`, `scripts/`.

> **Objectif :** suivre **uniquement** cette procédure, de haut en bas, sans
> décision à prendre. Toute valeur `<…>` est un secret à coller depuis le compte
> correspondant.

## Prérequis (avant de commencer)

- Comptes ouverts : **Scalingo**, **Scaleway Object Storage**, **Brevo**, **UptimeRobot**.
- Outils : CLI `scalingo`, CLI `aws` (pointant l'endpoint Scaleway), `git`, `flutter`, `python`.
- Accès au **DNS** de `artizenapp.com` (registrar).
- Dépôt à jour (`develop/v3`, arbre propre).
- Valeurs figées : domaine `artizenapp.com` · `SUPPORT_EMAIL=support@artizenapp.com` · paiement **Stripe** (hors déploiement) · stockage **Scaleway fr-par** (`https://s3.fr-par.scw.cloud`).

## Séquence globale

```
T20  Scalingo : app + addons (PostgreSQL, Redis)
T21  Scaleway : bucket stockage + versioning + clés
T22  Brevo    : compte + authentification domaine (SPF/DKIM) + clé SMTP
T24  UptimeRobot : compte (monitor ajouté après T33)
T31  Scalingo : variables d'environnement
T32  Déploiement backend (migrations auto) → /api/health
T33  Domaine api.artizenapp.com + TLS (+ enregistrement DNS = part de T23)
T34  Frontend statique : build + publication + CDN + app.artizenapp.com (+ DNS)
T35  CORS + test de bout en bout depuis le domaine réel
```

---

## T20 — Scalingo : application + addons

**Commandes**
```bash
scalingo login
scalingo create artizen-api --region osc-fr1
# Confirmer les plans disponibles avant d'ajouter :
scalingo addons-plans postgresql
scalingo addons-plans redis
scalingo --app artizen-api addons-add postgresql <plan-postgresql>
scalingo --app artizen-api addons-add redis <plan-redis>
scalingo --app artizen-api env-set PROJECT_DIR=backend
```
**Vérification** : `scalingo --app artizen-api addons` liste `postgresql` et `redis` en statut *running* ; `scalingo --app artizen-api env | grep -E 'SCALINGO_(POSTGRESQL|REDIS)_URL'` renvoie deux URL.
**GO / NO GO** : GO si les 2 addons sont *running* et leurs URL présentes. NO GO sinon.
**Rollback** : `scalingo --app artizen-api addons-remove <id>` ou `scalingo destroy --app artizen-api`.
**Erreurs probables** : quota région → choisir un plan inférieur ; addon en *provisioning* → attendre 1-2 min.
**Sécurité** : région **osc-fr1** (données FR) ; ne jamais exposer les URL d'addon hors des variables Scalingo.
**Captures attendues** : app créée · liste addons *running* · env montrant les 2 URL (URL masquées).

## T21 — Scaleway Object Storage : bucket + versioning + clés

**Commandes** *(aws CLI configuré avec les clés Scaleway ; ou console Scaleway)*
```bash
export AWS_ACCESS_KEY_ID=<clé-scaleway> AWS_SECRET_ACCESS_KEY=<secret-scaleway>
aws s3 mb s3://artizen-storage --endpoint-url https://s3.fr-par.scw.cloud --region fr-par
aws s3api put-bucket-versioning --bucket artizen-storage \
  --versioning-configuration Status=Enabled --endpoint-url https://s3.fr-par.scw.cloud
```
**Vérification** : `aws s3api get-bucket-versioning --bucket artizen-storage --endpoint-url https://s3.fr-par.scw.cloud` → `"Status": "Enabled"`.
**GO / NO GO** : GO si le bucket existe **et** versioning *Enabled*. NO GO sinon.
**Rollback** : `aws s3 rb s3://artizen-storage --force --endpoint-url …` (uniquement si vide et créé par erreur).
**Erreurs probables** : nom de bucket déjà pris → choisir un autre nom (répercuter dans `STORAGE_S3_BUCKET`) ; endpoint erroné → vérifier `s3.fr-par.scw.cloud`.
**Sécurité** : bucket **stockage = privé** (les fichiers sont servis par l'API authentifiée, jamais en public) ; clés dédiées à ce bucket.
**Captures attendues** : bucket créé (région fr-par) · versioning *Enabled* · page des clés API (secret masqué).

## T22 — Brevo : compte + authentification domaine + clé SMTP

**Actions (console Brevo)** : authentifier l'expéditeur `artizenapp.com` → Brevo fournit les enregistrements **SPF** (TXT) et **DKIM** (CNAME/TXT) à ajouter au DNS ; générer une **clé SMTP**.
**DNS à ajouter** (registrar `artizenapp.com`) : les TXT/CNAME SPF+DKIM fournis par Brevo.
**Vérification** : dans Brevo, le domaine passe **« Authentifié / vert »** ; `dig TXT artizenapp.com` montre le SPF.
**GO / NO GO** : GO si domaine authentifié (SPF+DKIM verts) **et** clé SMTP obtenue. NO GO si DKIM non propagé (attendre la propagation).
**Rollback** : sans objet (config externe) ; on peut repasser `EMAIL_PROVIDER=mock` en secours (dégradé).
**Erreurs probables** : DKIM non propagé (jusqu'à 24-48 h) → attendre ; e-mails en spam → vérifier SPF/DKIM avant ouverture.
**Sécurité** : la clé SMTP est un secret (variables Scalingo uniquement) ; `EMAIL_FROM=no-reply@artizenapp.com` doit correspondre au domaine authentifié.
**Captures attendues** : domaine « Authentifié » (SPF+DKIM verts) · page clé SMTP (clé masquée).

## T24 — UptimeRobot : compte

**Action** : créer le compte. **Le monitor** sur `https://api.artizenapp.com/api/health` sera **ajouté après T33** (le domaine doit exister). 
**GO / NO GO** : GO si le compte existe. (Monitor = étape post-T33.)
**Captures attendues** : compte créé.

## T31 — Variables d'environnement Scalingo

D'abord, mapper les URL d'addon (lire puis poser) :
```bash
scalingo --app artizen-api env | grep SCALINGO_POSTGRESQL_URL   # copier la valeur
scalingo --app artizen-api env | grep SCALINGO_REDIS_URL        # copier la valeur
```
Puis poser toutes les variables (secrets = valeurs des comptes T21/T22) :
```bash
scalingo --app artizen-api env-set \
  ENVIRONMENT=production \
  SECRET_KEY="$(python -c 'import secrets;print(secrets.token_urlsafe(64))')" \
  DATABASE_URL_OVERRIDE="<valeur SCALINGO_POSTGRESQL_URL>" \
  REDIS_URL="<valeur SCALINGO_REDIS_URL>" \
  RATE_LIMIT_BACKEND=redis \
  STORAGE_PROVIDER=s3 \
  STORAGE_S3_ENDPOINT_URL=https://s3.fr-par.scw.cloud \
  STORAGE_S3_REGION=fr-par \
  STORAGE_S3_BUCKET=artizen-storage \
  STORAGE_S3_ACCESS_KEY="<clé Scaleway>" \
  STORAGE_S3_SECRET_KEY="<secret Scaleway>" \
  EMAIL_PROVIDER=smtp \
  SMTP_HOST=smtp-relay.brevo.com SMTP_PORT=587 \
  SMTP_USERNAME="<login Brevo>" SMTP_PASSWORD="<clé SMTP Brevo>" \
  EMAIL_FROM=no-reply@artizenapp.com \
  SUPPORT_EMAIL=support@artizenapp.com \
  CORS_ORIGINS=https://app.artizenapp.com \
  APP_BASE_URL=https://app.artizenapp.com
```
*(La durée de rétention `RETENTION_INACTIVE_ACCOUNT_DAYS` reste NON posée — décidée par le juriste après la bêta.)*
**Vérification** : `scalingo --app artizen-api env` liste toutes les variables ci-dessus.
**GO / NO GO** : GO si les 3 blocs (base/redis, S3, SMTP) + `ENVIRONMENT=production` + `SECRET_KEY` (≥32) sont posés. **NO GO** si un provider `s3`/`smtp` est incomplet (le backend refusera de démarrer — garde-fou voulu).
**Rollback** : `scalingo env-unset <VAR>` puis corriger.
**Erreurs probables** : `DATABASE_URL_OVERRIDE` avec `sslmode` → **normalisé automatiquement** (`_to_asyncpg_url`) ; oubli de `ENVIRONMENT=production` → garde-fous muets (à ne jamais oublier).
**Sécurité** : `ENVIRONMENT=production` active les garde-fous (secret fort, pas de DEBUG, CORS `*` interdit, `/docs` off) ; tous les secrets vivent **uniquement** dans Scalingo.
**Captures attendues** : liste des variables (valeurs secrètes masquées).

## T32 — Déploiement du backend

**Commandes**
```bash
git remote add scalingo git@ssh.osc-fr1.scalingo.com:artizen-api.git   # une fois
git push scalingo develop/v3:master
```
Les migrations Alembic s'exécutent **automatiquement** au boot (`entrypoint.sh` → `alembic upgrade head`) ; `scalingo.json` déclare le même `postdeploy` en filet. Le serveur se lie à `$PORT` (Dockerfile).
**Vérification**
```bash
scalingo --app artizen-api logs | grep -E "Running migrations|Starting application"
scalingo --app artizen-api run curl -fsS http://localhost:$PORT/health
```
**GO / NO GO** : GO si le build réussit, les migrations passent, et `/health` renvoie `status:ok` (db+redis `ok`). NO GO sinon.
**Rollback** : `scalingo --app artizen-api rollback` (release précédente) ; si migration en cause : `scalingo run alembic downgrade -1`.
**Erreurs probables** : monorepo mal ciblé → vérifier `PROJECT_DIR=backend` ; DB injoignable → l'entrypoint attend, vérifier l'addon ; TLS base forcé refusé par asyncpg → ajouter `connect_args` (contingence T44, documentée `DEPLOYMENT-T3.md`).
**Sécurité** : conteneur non-root (setpriv) ; `/health` ne fuit rien.
**Captures attendues** : log de build réussi · log migrations + « Starting application » · `/health` = ok.

## T33 — Domaine `api.` + TLS (+ enregistrement DNS)

**Commandes**
```bash
scalingo --app artizen-api domains-add api.artizenapp.com   # renvoie la cible CNAME
```
**DNS** (registrar) : créer `api.artizenapp.com` **CNAME →** la cible fournie par Scalingo.
**Vérification**
```bash
dig CNAME api.artizenapp.com
curl -fsS https://api.artizenapp.com/api/health
curl -sI https://api.artizenapp.com/api/health | grep -i strict-transport-security   # HSTS
```
Puis **ajouter le monitor UptimeRobot** sur `https://api.artizenapp.com/api/health` (reste de T24).
**GO / NO GO** : GO si HTTPS répond `ok`, certificat valide, HSTS présent, sonde verte. NO GO si TLS non provisionné (attendre) ou HSTS absent (activer au routeur).
**Rollback** : `scalingo --app artizen-api domains-remove api.artizenapp.com`.
**Erreurs probables** : propagation DNS lente → attendre ; TLS « en attente » → Scalingo provisionne après résolution du CNAME.
**Sécurité** : **confirmer HSTS** ; l'API n'est jamais servie en clair.
**Captures attendues** : domaine + TLS *actif* dans Scalingo · `/api/health` en HTTPS · en-tête HSTS · monitor UptimeRobot vert.

## T34 — Frontend statique : build + publication + CDN + `app.`

**Commandes**
```bash
API_BASE_URL=https://api.artizenapp.com/api ./scripts/build_frontend.sh
# Bucket web dédié (public) + CDN :
aws s3 mb s3://artizen-web --endpoint-url https://s3.fr-par.scw.cloud --region fr-par
FRONTEND_S3_ENDPOINT=https://s3.fr-par.scw.cloud FRONTEND_S3_BUCKET=artizen-web \
  ./scripts/deploy_frontend.sh
```
Puis (console Scaleway) : activer l'accès **public en lecture** + l'hébergement web du bucket `artizen-web`, y attacher le **CDN/Edge**, et le domaine **`app.artizenapp.com`** (CNAME → cible CDN) + TLS.
**Vérification**
```bash
grep -c "api.artizenapp.com/api" frontend/build/web/main.dart.js   # URL API injectée
curl -fsS https://app.artizenapp.com/ | grep -i "<title"
```
**GO / NO GO** : GO si `app.artizenapp.com` sert le bundle en HTTPS et l'URL API est bien injectée. NO GO sinon.
**Rollback** : re-synchroniser le bundle précédent (rebuild + `deploy_frontend.sh`).
**Erreurs probables** : `index.html` mis en cache → les en-têtes `no-cache` du script l'évitent, sinon purger le CDN ; mauvaise `API_BASE_URL` → rebuild.
**Sécurité** : seul le bucket **web** est public ; le bucket **stockage** (T21) reste privé.
**Captures attendues** : `√ Built build/web` · bucket web + CDN + domaine `app.` TLS · page de login sur `app.artizenapp.com`.

## T35 — CORS + test de bout en bout réel

**Vérification** : `CORS_ORIGINS=https://app.artizenapp.com` est déjà posé (T31). Depuis un navigateur sur **`https://app.artizenapp.com`** : créer un compte, se connecter, téléverser un logo (→ vérifier l'objet dans le bucket **stockage**), créer un devis, générer le **PDF**, demander une réinitialisation (**e-mail réellement reçu**), supprimer le compte.
**GO / NO GO** : **GO déploiement** si tout le parcours passe depuis le domaine réel, sans erreur CORS, e-mail reçu, logo présent dans S3. NO GO sur tout échec.
**Rollback** : ajuster `CORS_ORIGINS` si erreur CORS ; sinon `scalingo rollback`.
**Erreurs probables** : erreur CORS → `CORS_ORIGINS` ≠ origine exacte (schéma+domaine) ; e-mail non reçu → SPF/DKIM ou quota Brevo (voir `EXPLOITATION-V1` G1/G2).
**Sécurité** : login/JWT vérifiés depuis le domaine réel (le contrat HTTP réel n'est prouvé qu'ici).
**Captures attendues** : login OK depuis `app.` · objet logo dans le bucket · PDF généré · e-mail de reset reçu (en-têtes verts).

---

## Points de contrôle sécurité (récapitulatif)

- `ENVIRONMENT=production` posé (garde-fous actifs). · `SECRET_KEY` fort (≥32, généré). · CORS = origine exacte (jamais `*`). · Bucket **stockage privé**, bucket **web public** uniquement. · HSTS confirmé au routeur. · `/docs` désactivé en prod (auto). · SPF/DKIM verts. · Secrets uniquement dans Scalingo. · Conteneur non-root.

## Erreurs probables (récapitulatif)

| Symptôme | Cause | Résolution |
|---|---|---|
| Backend refuse de démarrer | provider `s3`/`smtp` incomplet | compléter les `STORAGE_S3_*` / `SMTP_*` (garde-fou) |
| `/health` `database` KO | `DATABASE_URL_OVERRIDE` absent/mauvais | re-copier `SCALINGO_POSTGRESQL_URL` |
| Connexion base TLS refusée | asyncpg + TLS forcé | `connect_args` (contingence T44) |
| Erreur CORS au login | `CORS_ORIGINS` ≠ origine réelle | poser `https://app.artizenapp.com` |
| E-mail de reset non reçu | SPF/DKIM ou quota Brevo | vérifier l'authentification / le quota |
| Front sert un vieux bundle | cache CDN sur `index.html` | purger le CDN (en-têtes `no-cache` déjà posés) |
| TLS « en attente » | CNAME non résolu | attendre la propagation DNS |

---

*Runbook d'exploitation. Ne modifie ni le code, ni l'architecture, ni le référentiel gelé, ni le Master Execution Plan. La phase de recette n'est PAS préparée ici (à produire après le déploiement).*
