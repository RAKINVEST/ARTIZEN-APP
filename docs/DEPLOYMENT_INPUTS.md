# ARTIZEN — DEPLOYMENT_INPUTS.md

**Checklist exhaustive des informations externes à renseigner avant le premier déploiement réel (topologie T3).**
Document de collecte : il ne contient **aucune valeur** — il liste ce qu'il faut fournir. Variables ancrées sur `backend/app/core/config.py`, `.env.production.example`, `scalingo.json`, `scripts/`. Aucun code, aucune architecture, aucune modification du Master Execution Plan.

Légende — **Oblig.** : Obligatoire / Optionnelle · **Moment** : tâche du plan · **Resp.** : PO / Infra / Juriste / Code.

---

## 1. Domaine / DNS

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `DOMAINE_RACINE` | Domaine commercial | `artizen.fr` | PO | T01/T23 | Oblig. | Aucune URL publique | Registrar / `whois` |
| `SOUS_DOMAINE_API` | Sous-domaine backend | `api.artizen.fr` | Infra | T23/T33 | Oblig. | API injoignable | `dig api.artizen.fr` |
| `SOUS_DOMAINE_APP` | Sous-domaine frontend | `app.artizen.fr` | Infra | T23/T34 | Oblig. | Front injoignable | `dig app.artizen.fr` |
| `DNS_CNAME_API` | CNAME `api.` → cible Scalingo | (fourni par Scalingo) | Infra | T23 | Oblig. | TLS/routing KO | `dig CNAME` |
| `DNS_CNAME_APP` | CNAME `app.` → cible CDN | (fourni par le CDN) | Infra | T23 | Oblig. | Front KO | `dig CNAME` |

## 2. Scalingo

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `SCALINGO_COMPTE` | Compte créé | — | PO/Infra | T20 | Oblig. | Pas d'hébergement | Login dashboard |
| `SCALINGO_APP` | Nom de l'app | `artizen-api` | Infra | T20 | Oblig. | — | `scalingo apps` |
| `SCALINGO_REGION` | Région (souveraineté FR) | `osc-fr1` | Infra | T20 | Oblig. | Non-conformité UE | Dashboard |
| `PROJECT_DIR` | Sous-dossier build (monorepo) | `backend` | Infra | T30 | Oblig. | Build échoue | Build log |
| `SCALINGO_API_TOKEN` | Token pour CD (facultatif) | — | Infra | — | Opt. | Déploiement manuel | — |
| `WEB_CONCURRENCY` | Nb workers uvicorn | `4` | Infra | T31 | Opt. (défaut 4) | Concurrence réduite | Logs de boot |

## 3. PostgreSQL

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Addon `postgresql` | Base managée | plan `postgresql-starter-512` | Infra | T30 | Oblig. | Pas de base | `scalingo addons` |
| `DATABASE_URL_OVERRIDE` | URL de l'addon | `$SCALINGO_POSTGRESQL_URL` | Infra | T31 | Oblig. | App ne démarre pas | `/api/health` → `database:ok` |

## 4. Redis

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Addon `redis` | Cache/broker managé | `redis-starter-256` | Infra | T30 | Oblig.* | Rate-limit dégradé mémoire | `scalingo addons` |
| `REDIS_URL` | URL de l'addon | `$SCALINGO_REDIS_URL` | Infra | T31 | Oblig.* | idem | `/api/health` → `redis:ok` |

\* Requis dès lors que `RATE_LIMIT_BACKEND=redis` (recommandé prod) ; sinon dégradation gracieuse documentée.

## 5. Stockage S3

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `STORAGE_PROVIDER` | Type de stockage | `s3` | Infra | T31 | Oblig. | Fichiers perdus au redeploy | Boot |
| `STORAGE_S3_ENDPOINT_URL` | Endpoint S3 EU | `https://s3.fr-par.scw.cloud` | Infra | T21/T31 | Oblig. | **Refus de boot** | Boot |
| `STORAGE_S3_REGION` | Région | `fr-par` | Infra | T31 | Oblig. | **Refus de boot** | Boot |
| `STORAGE_S3_BUCKET` | Nom du bucket | `artizen-storage` | Infra | T21/T31 | Oblig. | **Refus de boot** | Upload logo → objet présent |
| `STORAGE_S3_ACCESS_KEY` | Clé d'accès (secret) | — | Infra | T31 | Oblig. | **Refus de boot** | Upload logo |
| `STORAGE_S3_SECRET_KEY` | Clé secrète (secret) | — | Infra | T31 | Oblig. | **Refus de boot** | Upload logo |

## 6. SMTP / Brevo

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `EMAIL_PROVIDER` | Fournisseur e-mail | `smtp` | Infra | T31 | Oblig. | E-mails non envoyés | Boot |
| `SMTP_HOST` | Serveur SMTP | `smtp-relay.brevo.com` | Infra | T22/T31 | Oblig. | **Refus de boot** | Reset reçu |
| `SMTP_PORT` | Port | `587` | Infra | T31 | Opt. (défaut 587) | — | — |
| `SMTP_USERNAME` | Login SMTP (secret) | — | Infra | T22 | Oblig. | Auth SMTP KO | Reset reçu |
| `SMTP_PASSWORD` | Clé SMTP (secret) | — | Infra | T22 | Oblig. | Auth SMTP KO | Reset reçu |
| `SMTP_USE_TLS` / `SMTP_USE_SSL` | STARTTLS (587) / SSL (465) | `true` / `false` | Infra | T31 | Opt. (défauts) | Connexion refusée si incohérent | Reset reçu |
| `EMAIL_FROM` | Expéditeur vérifié | `no-reply@artizen.fr` | Infra/PO | T22/T31 | Oblig. | Rejet / spam | Headers e-mail |
| SPF / DKIM | Enregistrements domaine | (fournis par Brevo) | PO/Infra | T22 | Oblig. | E-mails en spam | Reset reçu, en-têtes verts |

## 7. Support

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `SUPPORT_EMAIL` | Adresse de contact réelle | `support@artizen.fr` | PO | T01/T31 | Oblig. | Adresse par défaut affichée | `GET /api/config` |

## 8. Variables JWT

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `SECRET_KEY` | Clé de signature JWT (secret) | `python -c "import secrets;print(secrets.token_urlsafe(64))"` | Infra/PO | T31 | Oblig. | **Refus de boot** (≥32, non-placeholder) | Boot OK |
| `JWT_ALGORITHM` | Algorithme | `HS256` | — | — | Opt. (défaut) | — | — |
| `ACCESS_TOKEN_EXPIRE_MINUTES` | Durée du token | `1440` | Infra | — | Opt. (défaut 24 h) | — | — |

## 9. CORS

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `CORS_ORIGINS` | Origine(s) frontend autorisée(s) | `https://app.artizen.fr` | Infra | T31/T35 | Oblig. | Front ne peut appeler l'API ; `*` **refusé** en prod | Login depuis `app.` |

## 10. HTTPS

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| TLS `api.` | Certificat auto Scalingo | (auto Let's Encrypt) | Infra | T33 | Oblig. | Trafic en clair | `curl https://api.…/api/health` |
| TLS `app.` | Certificat CDN | (auto) | Infra | T34 | Oblig. | Trafic en clair | `curl https://app.…` |
| HSTS | En-tête au routeur Scalingo | activé | Infra | T33 | Recommandé | Downgrade HTTPS possible | `curl -I` → `Strict-Transport-Security` |

## 11. Sauvegardes

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Backups Postgres managés | Rétention à confirmer | quotidien | Infra | T43 | Oblig. | Pas de reprise base | Dashboard addon |
| Versioning bucket S3 | Protection fichiers | activé | Infra | T21 | Oblig. | Suppression fichier irréversible | Console S3 |
| Test de restauration | 1 restauration prouvée | — | Infra | T43 | Oblig. | Reprise non prouvée | `restore.sh` / restore addon → `/health` ok |

## 12. Monitoring

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Compte UptimeRobot | Supervision externe | offre gratuite | Infra | T24 | Oblig. (cond. GO) | Incident invisible | Sonde verte |
| Sonde `/api/health` | Cible de la sonde | `https://api.…/api/health` | Infra | T42 | Oblig. | idem | Alerte testée |
| Alerte livraison e-mail | Sur log `email.smtp_send_failed` | — | Infra | T42 | Recommandé (G1) | E-mail silencieux non vu | Test |
| Surveillance quota Brevo | Suivi 300/j (gratuit) | — | Infra | T42 | Recommandé (G2) | Resets perdus en silence | Dashboard Brevo |

## 13. Paiement *(hors logiciel — ARTIZEN ne collecte pas d'argent)*

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Prestataire de paiement | Encaissement externe | Stripe / facture | PO | T01/T50/T60 | Oblig. | Aucun encaissement possible | Transaction test |
| Process de remboursement | Procédure externe | — | PO | T50 | Oblig. | Pas de remboursement | — |

## 14. Juridique

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| Contenu Mentions/CGU/Confidentialité | Textes validés (remplacent le DRAFT) | — | Juriste | T11 | Oblig. | Ouverture commerciale interdite | Pages sans bandeau « provisoire » |
| Champs éditeur (`{…}`) | Raison sociale, SIREN, capital, hébergeur, DPO… | — | PO/Juriste | T11 | Oblig. | Mentions incomplètes | Relecture |
| `RETENTION_INACTIVE_ACCOUNT_DAYS` | Durée de rétention RGPD | `365` | Juriste | T12/T31 | Opt. (no-op si absente) | Purge désactivée | `python -m app.retention` |

## 15. Secrets *(récapitulatif — à ne jamais committer, poser en variables Scalingo)*

| Secret | Catégorie | Resp. | Oblig. |
|---|---|---|---|
| `SECRET_KEY` | JWT | Infra/PO | Oblig. |
| `STORAGE_S3_ACCESS_KEY` / `STORAGE_S3_SECRET_KEY` | S3 | Infra | Oblig. |
| `SMTP_USERNAME` / `SMTP_PASSWORD` | Brevo | Infra | Oblig. |
| Credentials Postgres / Redis | via addons (`$SCALINGO_*_URL`) | Infra | Oblig. (auto) |
| `SCALINGO_API_TOKEN` | CD | Infra | Opt. |
| `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` | Déploiement front (CLI S3) | Infra | Oblig. (déploiement front) |

## 16. Comptes externes *(récapitulatif)*

| Compte | Fournisseur suggéré (EU) | Resp. | Oblig. |
|---|---|---|---|
| Hébergement | Scalingo | PO/Infra | Oblig. |
| Object storage | Scaleway / OVH | Infra | Oblig. |
| E-mail transactionnel | Brevo | PO/Infra | Oblig. |
| Domaine | Registrar au choix | PO | Oblig. |
| Supervision | UptimeRobot | Infra | Oblig. |
| Paiement | Stripe / autre | PO | Oblig. |

## 17. Certificats

| Élément | Description | Resp. | Oblig. | Note |
|---|---|---|---|---|
| TLS `api.` | Let's Encrypt auto Scalingo | Infra | Oblig. | **Aucun certificat manuel à fournir** — renouvellement automatique |
| TLS `app.` | Certificat CDN | Infra | Oblig. | idem |

## 18. Variables Flutter *(build-time)*

| Variable | Description | Exemple | Resp. | Moment | Oblig. | Impact si absente | Vérification |
|---|---|---|---|---|---|---|---|
| `API_BASE_URL` | URL API figée au build (`--dart-define`) | `https://api.artizen.fr/api` | Infra/Code | T34 | Oblig. | Front pointe ailleurs | `grep` dans `build/web/main.dart.js` |
| `FRONTEND_S3_ENDPOINT` | Endpoint objet pour publier le bundle | `https://s3.fr-par.scw.cloud` | Infra | T34 | Oblig. | Publication impossible | Script de deploy |
| `FRONTEND_S3_BUCKET` | Bucket web | `artizen-web` | Infra | T34 | Oblig. | idem | Script |
| `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` / `AWS_REGION` | Credentials CLI pour le sync | — | Infra | T34 | Oblig. | Sync refusé | Script |

## 19. Variables Backend *(récapitulatif ENV Scalingo — voir `.env.production.example`)*

| Variable | Exemple | Resp. | Oblig. | Impact si absente |
|---|---|---|---|---|
| `ENVIRONMENT` | `production` | Infra | Oblig. | **Garde-fous désactivés** (secret, DEBUG, CORS `*`, `/docs`) |
| `DEBUG` | `false` | Infra | Opt. (défaut) | Fuite d'internes si `true` en prod (refusé) |
| `APP_BASE_URL` | `https://app.artizen.fr` | Infra | Oblig. | Liens de reset pointent sur localhost |
| `RATE_LIMIT_BACKEND` | `redis` | Infra | Recommandé | Plafond ~4× par worker |
| `LOG_LEVEL` | `INFO` | Infra | Opt. (défaut) | — |
| *(+ toutes les variables des sections 3-9 ci-dessus)* | — | Infra | — | — |

## 20. Vérifications post-déploiement *(preuves à cocher)*

| Vérification | Commande / geste | Attendu | Moment |
|---|---|---|---|
| Santé | `curl https://api.…/api/health` | `status:ok`, `database:ok`, `redis:ok` | T33 |
| TLS/HSTS | `curl -I https://api.…` | 200 + `Strict-Transport-Security` | T33 |
| Login réel | depuis `https://app.…` | 200 + token | T35 |
| S3 réel | upload d'un logo | objet présent dans le bucket | T40 |
| SMTP réel | demander un reset | e-mail reçu, SPF/DKIM verts | T41 |
| Config publique | `curl https://api.…/api/config` | `SUPPORT_EMAIL` réel | T35 |
| Pages légales | accès déconnecté | contenu validé, `{email}` substitué, sans bandeau | T61 |
| RGPD | supprimer un compte de test | 204 + données effacées | T45 |
| Supervision | couper/rétablir | alerte reçue | T42 |
| Restauration | restaurer un backup | `/health` ok après restore | T43 |

---

## Checklist « Jour J » (ordre exact des opérations)

1. **Décisions PO figées** (§1, §13, §7) : domaine, prestataire paiement, object-storage EU, `SUPPORT_EMAIL`.
2. **DNS** (§1) : créer le domaine, préparer `api.` et `app.`.
3. **Comptes ouverts** (§16) : Scalingo (osc-fr1), bucket S3 EU + clés + **versioning**, Brevo + **SPF/DKIM**, UptimeRobot.
4. **App Scalingo + addons** (§2, §3, §4) : `create` + `postgresql` + `redis`, `PROJECT_DIR=backend`.
5. **Variables & secrets** (§5-§9, §14, §19) : poser toutes les ENV, dont `ENVIRONMENT=production`, `SECRET_KEY`, `DATABASE_URL_OVERRIDE`, `STORAGE_S3_*`, `SMTP_*`, `CORS_ORIGINS`, `APP_BASE_URL`, `SUPPORT_EMAIL`, `RATE_LIMIT_BACKEND=redis`, `RETENTION_INACTIVE_ACCOUNT_DAYS` (si fournie).
6. **Déployer le backend** : migrations automatiques au boot. → `curl /api/health`.
7. **Domaine `api.` + TLS** (§10) : `domains-add` + CNAME + confirmer HSTS.
8. **Build + déployer le frontend** (§18) : `API_BASE_URL=https://api.…/api`, publier sur S3+CDN, domaine `app.` + TLS.
9. **Boucler le CORS** (§9) : `CORS_ORIGINS=https://app.…` + test login réel.
10. **Vérifications production** (§20) : S3, SMTP, config, RGPD, pages légales.
11. **Supervision** (§12) : sonde UptimeRobot + alertes e-mail/5xx + quota Brevo.
12. **Sauvegardes** (§11) : confirmer backups managés + **1 test de restauration**.
13. **Contenu légal** (§14) : déployer les textes validés → retrait du bandeau « provisoire ».
14. **Paiement** (§13) : activer le process d'encaissement.
15. **GO** : ouvrir au premier client.

---

*Ce document est un formulaire de collecte. Le remplir ne modifie ni le code, ni l'architecture, ni le Master Execution Plan.*
