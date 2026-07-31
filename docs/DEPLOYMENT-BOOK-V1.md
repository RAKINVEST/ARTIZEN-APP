# ARTIZEN — DEPLOYMENT BOOK FINAL V1

**Manuel opératoire de production.** Conçu pour être exécuté **du début à la fin,
sans improvisation**, par un opérateur qui **ne connaît pas ARTIZEN**. Chaque étape
donne : objectif · durée · commandes exactes · sortie attendue · capture attendue ·
GO/NO GO · erreurs→cause→correction · rollback · preuves à conserver.

> **Règle d'or.** Si le **GO** d'une étape n'est pas atteint, **on ne passe pas à
> la suivante** : appliquer la correction, ou le **rollback** de l'étape, puis
> recommencer. Ne jamais improviser.

## Ce que l'on déploie (contexte minimal)

- **Frontend** : application web **statique** (fichiers) → hébergement objet + CDN Scaleway → `https://app.artizenapp.com`.
- **Backend** : API **FastAPI** (conteneur Docker) → **Scalingo** (région `osc-fr1`, France) → `https://api.artizenapp.com`.
- **Données** : **PostgreSQL** + **Redis** managés (addons Scalingo) · fichiers sur **Scaleway Object Storage** (`fr-par`) · e-mails via **Brevo**.
- Les **migrations** de base tournent **automatiquement** au démarrage du conteneur.

## Prérequis absolus (à vérifier AVANT T+0)

- [ ] Comptes ouverts : **Scalingo**, **Scaleway**, **Brevo** *(Brevo `artizenapp.com` déjà authentifié — T22 ✅)*.
- [ ] Accès **DNS** de `artizenapp.com` (registrar OVH).
- [ ] Outils installés : `scalingo` CLI, `aws` CLI, `git`, `flutter`, `python3`, `curl`, `nslookup`.
- [ ] Dépôt cloné, branche `develop/v3`, arbre propre.
- [ ] Une **boîte e-mail de test réelle** (pour la validation finale).

## Valeurs figées (ne pas réinventer)

| Clé | Valeur |
|---|---|
| Domaine | `artizenapp.com` (backend `api.`, frontend `app.`) |
| Object storage | Scaleway `fr-par` — endpoint `https://s3.fr-par.scw.cloud` |
| SMTP | `smtp-relay.brevo.com:587` · `EMAIL_FROM=no-reply@artizenapp.com` |
| Support | `SUPPORT_EMAIL=support@artizenapp.com` |
| Build front | `API_BASE_URL=https://api.artizenapp.com/api` |

## Chronologie minute par minute (vue d'ensemble)

| T+ | Étape | Durée | Bloquant ? |
|---|---|---|---|
| 00:00 | **É0** — Préparation du poste | 15 min | oui |
| 00:15 | **É1** — Scalingo : app + addons (PG, Redis) | 15 min | oui |
| 00:30 | **É2** — Scaleway : bucket stockage + versioning + clés | 10 min | oui |
| 00:40 | **É3** — Brevo : récupérer la clé SMTP (auth déjà ✅) | 5 min | oui |
| 00:45 | **É4** — Variables d'environnement Scalingo | 15 min | oui |
| 01:00 | **É5** — Déploiement backend (+ migrations auto) | 15 min | oui |
| 01:15 | **É6** — Domaine `api.` + TLS + monitor UptimeRobot | 15 min *(+ propagation DNS, async)* | oui |
| 01:30 | **É7** — Frontend : build + publication + CDN + `app.` | 20 min *(+ propagation CDN)* | oui |
| 01:50 | **É8** — CORS + test de bout en bout réel | 20 min | oui |
| 02:10 | **É9** — Sauvegardes + supervision | 15 min | non (mais condition GO finale) |
| 02:25 | **Validations finales** | 10 min | — |

**Total actif ≈ 2 h 30** (hors attentes de propagation DNS/TLS/CDN, qui sont **asynchrones** et peuvent ajouter des heures — voir É6/É7).

---

## É0 — Préparation du poste (15 min)

**Objectif** : se connecter aux outils, se placer dans le dépôt.
**Commandes**
```bash
scalingo login
git clone <URL_DEPOT> artizen && cd artizen && git checkout develop/v3
git status   # doit être propre
```
**Sortie attendue** : `scalingo login` → « Login successful » ; `git status` → « nothing to commit, working tree clean ».
**Capture attendue** : terminal login OK.
**GO / NO GO** : GO si login OK + arbre propre. NO GO sinon.
**Erreurs** : CLI absent → installer `scalingo`/`aws` ; mauvaise branche → `git checkout develop/v3`.
**Rollback** : —. **Preuves** : capture terminal.

## É1 — Scalingo : application + addons (15 min) *(T20/T30)*

**Objectif** : créer l'app + PostgreSQL + Redis managés.
**Commandes**
```bash
scalingo create artizen-api --region osc-fr1
scalingo --app artizen-api addons-plans postgresql     # noter un plan
scalingo --app artizen-api addons-plans redis          # noter un plan
scalingo --app artizen-api addons-add postgresql <plan>
scalingo --app artizen-api addons-add redis <plan>
scalingo --app artizen-api env-set PROJECT_DIR=backend
```
**Sortie / vérification**
```bash
scalingo --app artizen-api addons          # 2 addons "running"
scalingo --app artizen-api env | grep -E 'SCALINGO_(POSTGRESQL|REDIS)_URL'   # 2 URL
```
**Capture attendue** : app créée · liste addons *running* · env montrant les 2 URL (masquées).
**GO / NO GO** : GO si 2 addons *running* + 2 URL présentes. NO GO sinon.
**Erreurs → cause → correction** : addon en *provisioning* → attendre 1-2 min ; plan indisponible → choisir un plan listé ; quota → plan inférieur.
**Rollback** : `scalingo --app artizen-api addons-remove <id>` / `scalingo destroy --app artizen-api`.
**Preuves** : capture addons *running* + env (URL masquées).

## É2 — Scaleway : bucket stockage + versioning + clés (10 min) *(T21)*

**Objectif** : bucket privé pour logos/PDF/documents, avec versioning (protection).
**Commandes**
```bash
export AWS_ACCESS_KEY_ID=<clé-scaleway> AWS_SECRET_ACCESS_KEY=<secret-scaleway>
aws s3 mb s3://artizen-storage --endpoint-url https://s3.fr-par.scw.cloud --region fr-par
aws s3api put-bucket-versioning --bucket artizen-storage \
  --versioning-configuration Status=Enabled --endpoint-url https://s3.fr-par.scw.cloud
aws s3api get-bucket-versioning --bucket artizen-storage --endpoint-url https://s3.fr-par.scw.cloud
```
**Sortie attendue** : la dernière commande renvoie `{"Status": "Enabled"}`.
**Capture attendue** : bucket créé (région fr-par) · versioning *Enabled* · page des clés API (secret masqué).
**GO / NO GO** : GO si bucket existe **et** versioning *Enabled*. NO GO sinon.
**Erreurs → cause → correction** : nom pris → autre nom (répercuter dans `STORAGE_S3_BUCKET`) ; 403 → clés/endpoint erronés.
**Rollback** : `aws s3 rb s3://artizen-storage --force --endpoint-url …` (si créé par erreur).
**Sécurité** : bucket **stockage = privé** (jamais public). **Preuves** : capture bucket + versioning + clés (masquées).

## É3 — Brevo : récupérer la clé SMTP (5 min) *(T22 — auth déjà ✅)*

**Objectif** : l'authentification du domaine est **déjà verte** (Code Brevo + DKIM×2 + DMARC). Il reste à **récupérer les identifiants SMTP**.
**Action (console Brevo)** : SMTP & API → **clé SMTP** ; noter `SMTP_USERNAME` (login) + `SMTP_PASSWORD` (clé).
**Vérification** : le domaine `artizenapp.com` est **Authentifié** (tous verts).
**GO / NO GO** : GO si clé SMTP obtenue + domaine authentifié. NO GO sinon.
**Erreurs** : domaine repassé « non authentifié » → un enregistrement DNS a été modifié → le restaurer.
**Preuves** : capture domaine authentifié + page clé (masquée).

## É4 — Variables d'environnement Scalingo (15 min) *(T31)*

**Objectif** : configurer l'app (garde-fous, base, S3, SMTP, CORS).
**Commandes** — d'abord lire les URL d'addon (à recopier) :
```bash
scalingo --app artizen-api env | grep SCALINGO_POSTGRESQL_URL
scalingo --app artizen-api env | grep SCALINGO_REDIS_URL
```
Puis poser toutes les variables :
```bash
scalingo --app artizen-api env-set \
  ENVIRONMENT=production \
  SECRET_KEY="$(python3 -c 'import secrets;print(secrets.token_urlsafe(64))')" \
  DATABASE_URL_OVERRIDE="<valeur SCALINGO_POSTGRESQL_URL>" \
  REDIS_URL="<valeur SCALINGO_REDIS_URL>" \
  RATE_LIMIT_BACKEND=redis \
  STORAGE_PROVIDER=s3 \
  STORAGE_S3_ENDPOINT_URL=https://s3.fr-par.scw.cloud STORAGE_S3_REGION=fr-par \
  STORAGE_S3_BUCKET=artizen-storage \
  STORAGE_S3_ACCESS_KEY="<clé Scaleway>" STORAGE_S3_SECRET_KEY="<secret Scaleway>" \
  EMAIL_PROVIDER=smtp SMTP_HOST=smtp-relay.brevo.com SMTP_PORT=587 \
  SMTP_USERNAME="<login Brevo>" SMTP_PASSWORD="<clé SMTP>" \
  EMAIL_FROM=no-reply@artizenapp.com \
  SUPPORT_EMAIL=support@artizenapp.com \
  CORS_ORIGINS=https://app.artizenapp.com APP_BASE_URL=https://app.artizenapp.com
```
**Vérification** : `scalingo --app artizen-api env` liste toutes ces variables.
**GO / NO GO** : GO si les 3 blocs (base/redis, S3, SMTP) + `ENVIRONMENT=production` + `SECRET_KEY` (≥32) sont posés. **NO GO** si un provider `s3`/`smtp` est incomplet (le backend refusera de démarrer — garde-fou voulu).
**Erreurs → cause → correction** : `ENVIRONMENT` oublié → garde-fous muets → **le poser** ; `DATABASE_URL_OVERRIDE` avec `sslmode` → normalisé automatiquement (rien à faire).
**Rollback** : `scalingo env-unset <VAR>`. **Preuves** : capture `env` (secrets masqués).

## É5 — Déploiement backend (15 min) *(T32)*

**Objectif** : mettre l'API en ligne ; les migrations tournent au boot.
**Commandes**
```bash
git remote add scalingo git@ssh.osc-fr1.scalingo.com:artizen-api.git   # une fois
git push scalingo develop/v3:master
```
**Sortie attendue** (logs) : lignes contenant
```
Waiting for database at …
Database is available. Running migrations...
Starting application...
```
**Vérification**
```bash
scalingo --app artizen-api run curl -fsS "http://localhost:$PORT/health"
```
→ attendu : `{"status":"ok","version":"2.0.0","environment":"production","database":"ok","redis":"ok","queue_depth":0}`
**Capture attendue** : log de build réussi + migrations + « Starting application » + `/health` = ok.
**GO / NO GO** : GO si build OK, migrations passées, `/health` = `ok` (db+redis `ok`). NO GO sinon.
**Erreurs → cause → correction** : monorepo mal ciblé → vérifier `PROJECT_DIR=backend` ; DB injoignable → addon *running* ? ; TLS base forcé refusé → ajouter `connect_args` (contingence documentée `DEPLOYMENT-T3.md`).
**Rollback** : `scalingo --app artizen-api rollback` ; migration en cause → `scalingo run alembic downgrade -1`.
**Preuves** : logs déploiement + `/health`.

## É6 — Domaine `api.` + TLS + monitor (15 min + propagation) *(T33/T24)*

**Objectif** : exposer l'API en HTTPS sur `api.artizenapp.com`.
**Commandes**
```bash
scalingo --app artizen-api domains-add api.artizenapp.com   # renvoie la CIBLE CNAME
```
**DNS (OVH)** : créer `api.artizenapp.com` **CNAME →** la cible fournie par Scalingo.
**Vérification**
```bash
nslookup -type=CNAME api.artizenapp.com 8.8.8.8
curl -fsS https://api.artizenapp.com/api/health
curl -sI https://api.artizenapp.com/api/health | grep -i strict-transport-security
```
→ attendu : le CNAME résout ; `/api/health` = `ok` ; en-tête `strict-transport-security` présent.
Puis **ajouter le monitor UptimeRobot** sur `https://api.artizenapp.com/api/health` (T24).
**Capture attendue** : domaine + TLS *actif* (Scalingo) · `/api/health` HTTPS · en-tête HSTS · monitor UptimeRobot vert.
**GO / NO GO** : GO si HTTPS `ok` + certificat valide + HSTS + sonde verte. NO GO sinon.
**Erreurs → cause → correction** : `NXDOMAIN`/pas de résolution → propagation DNS (attendre, re-`nslookup`) ; TLS « en attente » → Scalingo provisionne **après** résolution du CNAME ; HSTS absent → l'activer au routeur Scalingo.
**Rollback** : `scalingo --app artizen-api domains-remove api.artizenapp.com`.
**Preuves** : sorties `nslookup`/`curl -I` + capture TLS.

## É7 — Frontend : build + publication + CDN + `app.` (20 min + propagation) *(T34)*

**Objectif** : publier l'app statique et l'exposer sur `app.artizenapp.com`.
**Commandes**
```bash
API_BASE_URL=https://api.artizenapp.com/api ./scripts/build_frontend.sh
grep -c "api.artizenapp.com/api" frontend/build/web/main.dart.js   # attendu : >= 1
aws s3 mb s3://artizen-web --endpoint-url https://s3.fr-par.scw.cloud --region fr-par
FRONTEND_S3_ENDPOINT=https://s3.fr-par.scw.cloud FRONTEND_S3_BUCKET=artizen-web \
  ./scripts/deploy_frontend.sh
```
Puis (console Scaleway) : activer **accès public en lecture** + hébergement web du bucket `artizen-web`, y attacher le **CDN/Edge**, et le domaine **`app.artizenapp.com`** (CNAME → cible CDN) + TLS.
**Sortie attendue** : `√ Built build/web` ; `grep -c` ≥ 1.
**Vérification** : `curl -fsS https://app.artizenapp.com/ | grep -i "<title"` → page servie en HTTPS.
**Capture attendue** : build OK · bucket web + CDN + domaine `app.` TLS · page de login sur `app.artizenapp.com`.
**GO / NO GO** : GO si `app.` sert le bundle en HTTPS et l'URL API est injectée. NO GO sinon.
**Erreurs → cause → correction** : `index.html` en cache → en-têtes `no-cache` déjà posés par le script, sinon purger le CDN ; mauvaise `API_BASE_URL` → rebuild.
**Rollback** : re-synchroniser le bundle précédent (rebuild + `deploy_frontend.sh`).
**Sécurité** : seul le bucket **web** est public ; le bucket **stockage** reste privé.
**Preuves** : `√ Built` + `grep -c` + capture page login.

## É8 — CORS + test de bout en bout réel (20 min) *(T35)*

**Objectif** : prouver le parcours réel depuis le domaine.
**Vérification** : `CORS_ORIGINS=https://app.artizenapp.com` déjà posé (É4). Depuis un navigateur sur **`https://app.artizenapp.com`** : créer un compte → se connecter → téléverser un logo (**vérifier l'objet dans le bucket stockage**) → créer un devis → **générer le PDF** → demander une réinitialisation (**e-mail reçu**) → **supprimer le compte**.
**Capture attendue** : login OK depuis `app.` · objet logo dans le bucket · PDF généré · e-mail de reset reçu (en-têtes verts).
**GO / NO GO** : **GO déploiement** si tout le parcours passe depuis le domaine réel, sans erreur CORS, e-mail reçu, logo dans S3. NO GO sur tout échec.
**Erreurs → cause → correction** : erreur CORS → `CORS_ORIGINS` ≠ origine exacte → corriger + redeploy ; e-mail non reçu → SPF/DKIM ou quota Brevo.
**Rollback** : `scalingo rollback` si régression backend.
**Preuves** : captures parcours + objet S3 + e-mail reçu.

## É9 — Sauvegardes + supervision (15 min)

**Objectif** : garantir reprise + visibilité avant d'ouvrir.
**Actions** : vérifier les **backups managés** du PostgreSQL (rétention) ; **1 test de restauration** ; confirmer le versioning du bucket ; armer les **alertes** (sonde `/api/health`, `email.smtp_send_failed`, 5xx, quota Brevo).
**GO / NO GO** : GO si backup présent + **1 restauration testée** + supervision armée. NO GO sinon.
**Preuves** : capture backups + preuve de restauration + capture alertes.

---

## Validations finales (le déploiement est « fait » si TOUT est coché)

- [ ] `curl https://api.artizenapp.com/api/health` = `ok` (HTTPS, HSTS, db+redis ok).
- [ ] `https://app.artizenapp.com` sert l'app en HTTPS ; login réel OK (pas d'erreur CORS).
- [ ] Logo téléversé **présent dans le bucket stockage** (privé, versioning ON).
- [ ] E-mail de réinitialisation **réellement reçu** (SPF/DKIM verts).
- [ ] Parcours complet compte → identité → devis → **PDF** → suppression RGPD : OK.
- [ ] `/docs` **désactivé** en prod ; `ENVIRONMENT=production`.
- [ ] Sonde UptimeRobot verte + alertes armées.
- [ ] **1 restauration** testée avec succès.

→ **Si tout est GO : le déploiement V1 est terminé ; passer au dossier de recette (`RECETTE-V1.md`).**

## Tableau des preuves à conserver

| Étape | Preuve |
|---|---|
| É1 | addons *running* + env URL (masquées) |
| É2 | bucket + versioning *Enabled* + clés (masquées) |
| É3 | domaine Brevo authentifié + clé SMTP (masquée) |
| É4 | `env` complet (secrets masqués) |
| É5 | logs migrations + `/health` |
| É6 | `nslookup`/`curl -I` (HSTS) + TLS actif + monitor |
| É7 | `√ Built` + `grep -c` + page login |
| É8 | parcours (captures) + objet S3 + e-mail reçu |
| É9 | backups + restauration + alertes |

## Rollback global

- Régression backend → `scalingo --app artizen-api rollback` (release précédente).
- Migration fautive → `scalingo run alembic downgrade -1` puis rollback.
- Frontend cassé → re-sync du bundle précédent.
- Domaine/TLS KO → `domains-remove` puis reprendre É6.
- **Aucune donnée n'est jamais perdue** : base sauvegardée, fichiers versionnés.

---

*Manuel opératoire. Ne modifie ni le code, ni l'architecture, ni le référentiel gelé, ni le Master Execution Plan. Complète (sans le remplacer) `DEPLOY-EXECUTION-T20-T35.md` en y ajoutant chronologie, sorties attendues, temps et preuves pour un opérateur externe.*
