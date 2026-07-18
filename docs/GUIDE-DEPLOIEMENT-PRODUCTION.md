# ARTIZEN — Guide de déploiement production V1 (pas à pas)

> **Public** : une personne non experte doit pouvoir suivre chaque étape sans ambiguïté.
> **But** : mettre ARTIZEN en ligne sur un domaine public, en HTTPS, pour lancer la **bêta privée**.
> Version détaillée du [DEPLOIEMENT.md](DEPLOIEMENT.md) (résumé). Ne rien inventer : on déploie l'app
> telle qu'elle est.
>
> **Choix d'architecture (le plus simple)** : **un seul serveur (VPS)** qui héberge tout via Docker,
> avec **Caddy** en façade (HTTPS automatique). Deux sous-domaines :
> - `app.artizen.fr` → le site (landing + application Flutter Web)
> - `api.artizen.fr` → l'API (backend)
>
> Remplacez `artizen.fr` par **votre** domaine partout. Les commandes se tapent dans un terminal SSH
> connecté au serveur, sauf mention « sur votre ordinateur ».

> 🔴 **À LIRE AVANT DE COMMENCER — le seul point qui exige un petit développement** : aujourd'hui, les
> e-mails (dont la **réinitialisation de mot de passe**) ne partent **pas réellement** (seul le mode
> « mock » est câblé : il écrit dans les logs). Pour une bêta avec de vrais artisans, il faut **brancher
> un vrai fournisseur d'e-mails** (voir §7.4). Sans cela, un testeur qui oublie son mot de passe ne
> reçoit rien. Tout le reste ci-dessous fonctionne sans cette étape, mais **ne pas inviter d'artisans
> avant de l'avoir réglée**.

---

## 1. Configuration du domaine

1. Achetez un domaine chez un registrar (**OVH, Gandi, Namecheap, Cloudflare…**), ex. `artizen.fr`
   (~10 €/an).
2. Notez que vous utiliserez **deux sous-domaines** : `app.` et `api.`. Pas besoin de les « créer »
   séparément — ils se déclarent dans le DNS (étape 2).
3. Gardez à portée l'accès à l'**espace DNS** du registrar (souvent « Zone DNS » / « DNS management »).

## 2. Configuration DNS

Objectif : faire pointer vos sous-domaines vers l'**adresse IP** de votre serveur (obtenue à l'étape 3 —
faites l'étape 3 d'abord si vous n'avez pas encore l'IP, puis revenez ici).

Dans la **Zone DNS** du registrar, créez **2 enregistrements de type A** :

| Type | Nom (hôte) | Valeur (cible) | TTL |
|---|---|---|---|
| A | `app` | `VOTRE_IP_SERVEUR` | 3600 |
| A | `api` | `VOTRE_IP_SERVEUR` | 3600 |

*(Optionnel)* un enregistrement `A` pour `@` (le domaine nu) ou un `CNAME` `www` → `app.artizen.fr`.

- La **propagation** DNS prend de quelques minutes à quelques heures.
- Vérifiez depuis votre ordinateur : `nslookup app.artizen.fr` (ou `ping app.artizen.fr`) doit renvoyer
  votre IP.

## 3. Hébergement (le serveur)

1. Louez un **VPS** (Hetzner, Scaleway, OVH, DigitalOcean…). Pour une bêta : **2 vCPU / 4 Go RAM /
   40 Go disque**, **Ubuntu 24.04 LTS**. Coût ~5–8 €/mois. Notez l'**IP publique** (→ étape 2).
2. Connectez-vous en SSH (depuis votre ordinateur) : `ssh root@VOTRE_IP`.
3. **Mettez à jour et sécurisez le serveur** :
   ```bash
   apt update && apt upgrade -y
   # Créer un utilisateur non-root (remplacez "artizen")
   adduser artizen && usermod -aG sudo artizen
   # Pare-feu : n'ouvrir que SSH + HTTP + HTTPS
   ufw allow OpenSSH && ufw allow 80 && ufw allow 443 && ufw --force enable
   ```
4. **Installez Docker** (méthode officielle) :
   ```bash
   curl -fsSL https://get.docker.com | sh
   usermod -aG docker artizen
   ```
   Reconnectez-vous en tant que `artizen` : `ssh artizen@VOTRE_IP`. Vérifiez : `docker --version` et
   `docker compose version`.

## 4. Déploiement du backend

1. **Récupérez le code** sur le serveur :
   ```bash
   cd ~ && git clone <URL_DU_DEPOT> artizen && cd artizen
   ```
   *(ou copiez le dossier via `scp`/`rsync` si le dépôt est privé sans accès Git sur le serveur.)*
2. **Créez le fichier de configuration** `.env` (voir §7 pour chaque variable) :
   ```bash
   cp .env.example .env && nano .env   # remplir les valeurs de production
   ```
3. **Créez le fichier `docker-compose.prod.yml`** à la racine (c'est la version *production* : pas de
   `--reload`, base non exposée, Caddy en façade). Collez exactement ceci :
   ```yaml
   services:
     db:
       image: postgres:16-alpine
       restart: unless-stopped
       environment:
         POSTGRES_USER: ${POSTGRES_USER}
         POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
         POSTGRES_DB: ${POSTGRES_DB}
       volumes:
         - artizen_postgres_data:/var/lib/postgresql/data
       healthcheck:
         test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
         interval: 5s
         timeout: 5s
         retries: 10
       # PAS de "ports:" -> la base n'est JAMAIS exposée sur Internet.

     redis:
       image: redis:7-alpine
       restart: unless-stopped
       healthcheck:
         test: ["CMD", "redis-cli", "ping"]
         interval: 5s
         timeout: 3s
         retries: 10

     backend:
       build: { context: ./backend, dockerfile: Dockerfile }
       restart: unless-stopped
       # PAS de "command:" -> on utilise le CMD de production de l'image
       # (plusieurs workers, sans --reload). PAS de bind-mount du code.
       env_file: [.env]
       environment:
         POSTGRES_HOST: db
         REDIS_URL: redis://redis:6379/0
       depends_on:
         db: { condition: service_healthy }
         redis: { condition: service_healthy }
       volumes:
         - artizen_storage_data:/data/storage   # logos / signatures persistés
       expose: ["8000"]                          # visible seulement par Caddy

     worker:
       build: { context: ./backend, dockerfile: Dockerfile }
       restart: unless-stopped
       command: ["arq", "app.tasks.worker.WorkerSettings"]
       env_file: [.env]
       environment:
         POSTGRES_HOST: db
         REDIS_URL: redis://redis:6379/0
       depends_on:
         db: { condition: service_healthy }
         redis: { condition: service_healthy }
       volumes:
         - artizen_storage_data:/data/storage

     caddy:
       image: caddy:2-alpine
       restart: unless-stopped
       ports: ["80:80", "443:443"]
       volumes:
         - ./Caddyfile:/etc/caddy/Caddyfile
         - ./artizen-web:/srv/artizen-web
         - caddy_data:/data
         - caddy_config:/config
       depends_on: [backend]

   volumes:
     artizen_postgres_data:
     artizen_storage_data:
     caddy_data:
     caddy_config:
   ```
4. **Créez le `Caddyfile`** (le reverse-proxy HTTPS, voir §8) à la racine.
5. **Construisez et démarrez** (le frontend web sera ajouté en §5) :
   ```bash
   docker compose -f docker-compose.prod.yml build
   docker compose -f docker-compose.prod.yml up -d db redis backend worker
   docker compose -f docker-compose.prod.yml ps      # tout doit être "healthy"
   ```
   Les **migrations Alembic s'appliquent automatiquement** au démarrage du backend.
6. **Vérifiez l'API** (de l'intérieur, avant HTTPS) :
   ```bash
   docker compose -f docker-compose.prod.yml exec backend curl -fsS http://localhost:8000/health
   # -> {"status":"ok","database":"ok","redis":"ok",...}
   ```

## 5. Déploiement du Flutter Web

Le web se **construit sur votre ordinateur** (qui a Flutter), puis on **envoie le résultat** sur le
serveur. (Installer Flutter sur le serveur est inutile et lourd.)

1. **Sur votre ordinateur**, dans le dépôt :
   ```bash
   cd frontend
   flutter build web --release --dart-define=API_BASE_URL=https://api.artizen.fr/api
   ```
   ⚠️ Le `--dart-define` est **obligatoire** : sans lui l'app pointe sur `localhost` et sera **morte**
   pour les artisans. Le résultat est dans `frontend/build/web/`.
2. **Envoyez** ce dossier vers le serveur, dans `~/artizen/artizen-web` (le dossier servi par Caddy) :
   ```bash
   rsync -avz --delete frontend/build/web/ artizen@VOTRE_IP:~/artizen/artizen-web/
   ```
3. **Démarrez Caddy** (sur le serveur) :
   ```bash
   docker compose -f docker-compose.prod.yml up -d caddy
   ```
4. Ouvrez `https://app.artizen.fr` dans un navigateur → la **landing ARTIZEN** doit s'afficher, et
   `https://app.artizen.fr/login` doit fonctionner.

## 6. Configuration de la base de données

- La base **PostgreSQL** tourne dans le conteneur `db`, ses données sont dans le volume
  `artizen_postgres_data` (persistant).
- **Rien à installer** : le schéma est créé par les **migrations Alembic** au premier démarrage.
- **Mot de passe** : défini par `POSTGRES_PASSWORD` dans `.env` — mettez un mot de passe **long et
  aléatoire**.
- La base **n'est pas exposée** sur Internet (aucun `ports:` sur `db`) — c'est voulu et sûr.
- **Purge des données de test** (important) : la suite de tests a pu créer des doublons (« Chauffe-eau
  Atlantic »…). Sur une **base neuve** créée par ce déploiement, il n'y en a pas. Si vous réutilisez une
  base de dev, repartez d'une base vierge : `docker compose -f docker-compose.prod.yml down -v` **ré-
  initialise** la base (⚠️ efface tout) — à ne faire **qu'avant** d'avoir de vraies données.
- Vérifier la connexion : `docker compose -f docker-compose.prod.yml exec db psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\dt"`.

## 7. Variables d'environnement (`.env`)

Remplissez `~/artizen/.env` ainsi (les valeurs entre `<…>` sont à personnaliser) :

```bash
# --- Application ---
ENVIRONMENT=production          # active les garde-fous de prod
DEBUG=false                     # OBLIGATOIRE en prod (le démarrage échoue si true)
API_PREFIX=/api
CORS_ORIGINS=https://app.artizen.fr    # l'URL EXACTE du site (pas de localhost, pas de "*")

# --- Base de données ---
POSTGRES_HOST=db
POSTGRES_PORT=5432
POSTGRES_USER=artizen
POSTGRES_PASSWORD=<mot_de_passe_long_et_aleatoire>
POSTGRES_DB=artizen

# --- Sécurité / JWT ---
SECRET_KEY=<64+ caracteres aleatoires>   # voir §7.1
ACCESS_TOKEN_EXPIRE_MINUTES=1440

# --- Rate limiting ---
AUTH_RATE_LIMIT_ENABLED=true
RATE_LIMIT_BACKEND=redis        # compteur partagé entre workers (sinon plafond ~x4)

# --- Redis ---
REDIS_URL=redis://redis:6379/0

# --- E-mail (voir §7.4) ---
EMAIL_PROVIDER=mock             # -> à remplacer par un vrai fournisseur avant la bêta
EMAIL_FROM=no-reply@artizen.fr
APP_BASE_URL=https://app.artizen.fr    # base des liens dans les e-mails (reset)

# --- Stockage ---
STORAGE_PROVIDER=local
STORAGE_LOCAL_ROOT=/data/storage

# (Clés IA facultatives : laissez vides, le mode démo hors-ligne s'active seul.)
```

**7.1 Générer `SECRET_KEY`** (sur votre ordinateur) :
`python -c "import secrets; print(secrets.token_urlsafe(64))"` → collez le résultat.
> Le backend **refuse de démarrer** en production si `SECRET_KEY` est celui de l'exemple ou fait moins
> de 32 caractères, et si `DEBUG=true`. C'est une protection, pas un bug.

**7.4 E-mail réel (avant d'inviter des testeurs)** : `EMAIL_PROVIDER=mock` n'envoie rien (il logue).
Pour de vrais e-mails, il faut **ajouter un fournisseur SMTP** derrière l'abstraction `app/email/`
(petit développement, ~0,5 j) et un compte transactionnel (Brevo/Postmark/Mailjet/SES — palier gratuit).
Une fois fait : `EMAIL_PROVIDER=smtp` + identifiants SMTP. *(Cette brique n'existe pas encore ; à
planifier avec l'équipe technique.)*

## 8. HTTPS (Caddy — certificat automatique)

Créez `~/artizen/Caddyfile` :
```
api.artizen.fr {
    reverse_proxy backend:8000
}

app.artizen.fr {
    root * /srv/artizen-web
    encode gzip
    try_files {path} /index.html
    file_server
}
```
- Caddy obtient **automatiquement** un certificat TLS (Let's Encrypt) et **renouvelle** tout seul.
- Le **http → https** est redirigé automatiquement.
- Prérequis : les DNS (étape 2) doivent déjà pointer sur le serveur, et les ports 80/443 ouverts (§3).
- Recharger après modification : `docker compose -f docker-compose.prod.yml restart caddy`.

## 9. Sauvegardes (obligatoire — les devis sont des documents légaux)

1. **Script** `~/artizen/backup.sh` :
   ```bash
   #!/usr/bin/env bash
   set -euo pipefail
   cd ~/artizen
   TS=$(date +%F_%H%M)
   mkdir -p ~/backups
   # Base de données
   docker compose -f docker-compose.prod.yml exec -T db \
     pg_dump -U artizen artizen | gzip > ~/backups/db_$TS.sql.gz
   # Fichiers (logos, signatures)
   docker run --rm -v artizen_artizen_storage_data:/data -v ~/backups:/backup alpine \
     tar czf /backup/storage_$TS.tgz -C /data .
   # Ne garder que 14 jours
   find ~/backups -type f -mtime +14 -delete
   ```
   `chmod +x ~/artizen/backup.sh`
2. **Planifier** (tous les jours à 3 h) : `crontab -e` puis ajoutez
   `0 3 * * * /home/artizen/artizen/backup.sh >> /home/artizen/backups/backup.log 2>&1`.
3. **Copie hors-serveur** : envoyez `~/backups` vers un stockage externe (S3, autre serveur…) — une
   sauvegarde sur le même serveur ne protège pas d'une perte du serveur.
4. **Testez une restauration AVANT la bêta** (voir §13, procédure de restauration).

## 10. Monitoring

- **Disponibilité** : créez un moniteur gratuit (**UptimeRobot** ou **BetterStack**) qui appelle
  `https://api.artizen.fr/health` toutes les 5 min et vous **alerte par e-mail/SMS** si ≠ 200 ou si le
  corps ne contient pas `"status":"ok"`.
- **Redémarrage auto** : déjà en place (`restart: unless-stopped`) — un conteneur qui plante repart seul.
- **Espace disque** : `df -h` régulièrement ; alerte si > 80 %. Les logs et sauvegardes remplissent le
  disque avec le temps.
- **Logs** : `docker compose -f docker-compose.prod.yml logs -f backend` pour observer en direct ;
  surveiller les lignes `WARNING`/`ERROR`.

## 11. Vérifications de sécurité

Avant d'ouvrir, vérifiez **chaque** point :
- [ ] `SECRET_KEY` = valeur aléatoire de 64+ caractères (**pas** celle de l'exemple).
- [ ] `DEBUG=false` et `ENVIRONMENT=production`.
- [ ] `CORS_ORIGINS` = l'URL exacte du site (jamais `*`).
- [ ] `RATE_LIMIT_BACKEND=redis` (limiteur anti-brute-force efficace).
- [ ] Base de données **non exposée** (aucun `ports:` sur `db`) — confirmez : `docker compose -f docker-compose.prod.yml port db 5432` ne doit **rien** renvoyer.
- [ ] **HTTPS forcé** : `curl -I http://api.artizen.fr/health` renvoie une **redirection 3xx vers https**.
- [ ] **En-têtes de sécurité** présents : `curl -sI https://api.artizen.fr/health | grep -i -E "x-content-type-options|x-frame-options|referrer-policy"` (doit lister nosniff / DENY / …).
- [ ] Pare-feu actif : `ufw status` (seuls 22/80/443 ouverts).
- [ ] Connecté en **utilisateur non-root** ; SSH par clé de préférence.
- [ ] `.env` **jamais** commité dans Git (il contient des secrets) ; il reste sur le serveur.
- [ ] Sauvegardes actives **et testées** (§9/§13).
- [ ] **E-mail réel branché** (§7.4) — sinon le reset de mot de passe ne fonctionne pas pour de vrais
  testeurs.
- [ ] CGU / Politique de confidentialité publiées (voir `docs/legal/`).

## 12. Check-list de mise en production (récapitulatif technique)

- [ ] DNS `app.` et `api.` pointent sur l'IP (propagé).
- [ ] Serveur à jour, pare-feu, Docker installé, utilisateur non-root.
- [ ] `.env` de production complété (§7) ; `SECRET_KEY` fort ; `DEBUG=false`.
- [ ] `docker-compose.prod.yml` + `Caddyfile` en place.
- [ ] `docker compose -f docker-compose.prod.yml up -d` : db/redis/backend/worker **healthy**.
- [ ] `/health` = ok en HTTPS ; certificat valide (cadenas).
- [ ] Frontend web buildé avec `API_BASE_URL` et déployé ; landing + login OK.
- [ ] Parcours complet **testé sur un vrai téléphone**.
- [ ] Sécurité (§11) : tous les points cochés.
- [ ] Sauvegardes planifiées + **restauration testée**.
- [ ] Monitoring branché et alertes reçues (test).
- [ ] E-mail réel opérationnel (reset testé de bout en bout).

## 13. Procédure de rollback (retour arrière)

**Principe** : toujours pouvoir revenir à la version précédente **et** aux données précédentes.

**Avant chaque déploiement** :
```bash
# 1) Sauvegarde immédiate
~/artizen/backup.sh
# 2) Noter la version en cours
git -C ~/artizen rev-parse --short HEAD    # ex: 1d430cb  (à conserver)
```

**Déployer une nouvelle version** :
```bash
cd ~/artizen && git pull
docker compose -f docker-compose.prod.yml build backend worker
docker compose -f docker-compose.prod.yml up -d          # migrations appliquées au démarrage
```

**En cas de problème après déploiement** — revenir au code précédent :
```bash
docker compose -f docker-compose.prod.yml down
git checkout <ANCIEN_COMMIT>            # celui noté avant le déploiement
docker compose -f docker-compose.prod.yml build backend worker
docker compose -f docker-compose.prod.yml up -d
```

**Si une migration a corrompu / cassé les données** — restaurer la base depuis la sauvegarde :
```bash
docker compose -f docker-compose.prod.yml stop backend worker
# Recréer une base vierge puis réinjecter le dernier dump
docker compose -f docker-compose.prod.yml exec -T db psql -U artizen -c "DROP DATABASE artizen;"
docker compose -f docker-compose.prod.yml exec -T db psql -U artizen -c "CREATE DATABASE artizen;"
gunzip -c ~/backups/db_<HORODATAGE>.sql.gz | docker compose -f docker-compose.prod.yml exec -T db psql -U artizen -d artizen
docker compose -f docker-compose.prod.yml up -d backend worker
```

**Frontend** : conservez le build précédent (`mv artizen-web artizen-web-KO && mv artizen-web-prev artizen-web`)
avant de remplacer, pour revenir en une commande. Caddy sert immédiatement l'ancien.

> **Règle d'or** : ne jamais déployer sans **sauvegarde fraîche** + **version précédente notée**. Le
> rollback doit être répété **une fois à blanc** avant la bêta pour être sûr qu'il fonctionne.

---

## ✅ Check-list « GO LIVE » (avant d'inviter les premiers bêta-testeurs)

**Accessibilité publique**
- [ ] `https://app.artizen.fr` affiche la landing (cadenas HTTPS vert).
- [ ] `https://app.artizen.fr/login` et `/register` fonctionnent.
- [ ] `https://api.artizen.fr/health` renvoie `status: ok`.
- [ ] `http://…` redirige bien vers `https://…`.

**Parcours artisan de bout en bout (sur un vrai téléphone)**
- [ ] Inscription → onboarding guidé visible.
- [ ] « Mon entreprise » : enregistrement OK, PDF conforme.
- [ ] Catalogue + client + **devis** créés ; **PDF téléchargé** et correct.
- [ ] **Mot de passe oublié → e-mail réellement reçu → réinitialisation OK** *(bloquant : nécessite §7.4)*.

**Exploitation**
- [ ] Sauvegarde du jour présente ; **restauration testée**.
- [ ] Monitoring actif ; une alerte de test a bien été reçue.
- [ ] Sécurité (§11) : 100 % coché.

**Business / légal**
- [ ] CGU + Politique de confidentialité en ligne (acceptation à l'inscription).
- [ ] Canal de **support** ouvert et surveillé.
- [ ] **Kit bêta** prêt à envoyer (invitation, guide, questionnaires — `docs/beta/`).

**Décision GO / NO-GO**
- ✅ **GO** : toutes les cases ci-dessus cochées, e-mail réel fonctionnel, rollback testé.
- 🛑 **NO-GO** : au moins une case « bloquante » non cochée (HTTPS, parcours devis, **e-mail de reset**,
  sauvegarde/restauration). Régler avant d'inviter le moindre artisan.

> Une fois GO : invitez **5 à 10 artisans** (kit bêta), et pilotez avec `docs/beta/PILOTAGE_BETA.md`.
