# Dépannage — ARTIZEN V2

Les symptômes réellement rencontrés sur ce projet, et leur cause racine. La
plupart sont spécifiques à **Windows** (l'environnement de validation) et
invisibles sur macOS/Linux.

## Le conteneur backend redémarre en boucle (`$'\r': command not found`)

**Cause :** `backend/entrypoint.sh` a été réécrit en fins de ligne **CRLF**.
Le défaut de Git for Windows (`core.autocrlf=true`) le fait au checkout si le
`.gitattributes` du dépôt (qui force LF sur `*.sh`) est absent ou ignoré.
Invisible sur macOS/Linux.

**Solution :** ne supprimez pas `.gitattributes`. Re-checkoutez le fichier en
LF :
```bash
git rm --cached backend/entrypoint.sh
git checkout backend/entrypoint.sh   # avec .gitattributes présent → LF
```

## Upload de logo / génération PDF en échec `EACCES` (Docker)

**Cause :** le conteneur tourne en non-root (`artizen`). Un volume
`artizen_storage_data` créé **avant** ce changement (ou un sous-répertoire
créé par un ancien conteneur root) reste détenu par root. `/health` reste
`healthy` (il ne fait qu'un `SELECT 1`), masquant le problème.

**Solution :**
```bash
docker compose run --rm --user root backend chown -R artizen /data/storage
# ou, si les fichiers ne comptent pas :
docker compose down -v
```
Détail : `DOCKER_GUIDE.md`.

## `docker run -v` crée un dossier bizarre sous Git Bash

**Cause :** Git Bash convertit les chemins : `-v vol:/data/storage` devient
`C:/Program Files/Git/data/storage`.

**Solution :** préfixez par `export MSYS_NO_PATHCONV=1`.

## Le backend démarre mais `/health` renvoie `degraded`

**Cause :** la base est injoignable. `GET /health` exécute un vrai `SELECT 1`
et renvoie `{"database":"unavailable"}` (en HTTP 200) si la connexion échoue.

**Solution :** `docker compose ps` (le service `db` doit être `healthy`) ;
vérifiez `POSTGRES_*` dans `.env`. En dev hors Docker, `POSTGRES_HOST` doit
être `localhost` ; dans Docker il est forcé à `db`.

## Le port 5432 est déjà utilisé

**Cause :** un PostgreSQL **local** et celui de **Docker** veulent tous deux
le port 5432.

**Solution :** arrêtez l'un avant de lancer l'autre (`pg_ctl stop`, ou
`docker compose stop db`).

## `pip install` échoue sur `pydantic` (compilation Rust)

**Cause :** vous utilisez **Python 3.14**. `pydantic==2.10.4` n'a pas de wheel
pour 3.14 et sa compilation exigerait Rust.

**Solution :** utilisez **Python 3.13** (l'image et l'environnement de
validation l'imposent).

## `pip install` échoue / avertissements bcrypt

**Cause :** `bcrypt` a été mis à jour. `bcrypt==4.0.1` est **épinglé
volontairement** (incompatibilité avec l'auto-test de passlib 1.7.4).

**Solution :** ne mettez pas à jour `bcrypt` sans lire le commentaire de
`requirements.txt`.

## Le frontend ne joint pas l'API / erreurs CORS

**Cause :** le frontend n'est pas servi sur le port **3000**. `CORS_ORIGINS`
vaut `http://localhost:3000` (depuis `.env`).

**Solution :** `flutter run -d web-server --web-port 3000`, ou modifiez
`CORS_ORIGINS` dans `.env` et redémarrez le backend.

## `flutter analyze` / build échoue après modif d'un modèle

**Cause :** un modèle Freezed a changé sans régénération.

**Solution :**
```bash
cd frontend
dart run build_runner build --delete-conflicting-outputs
```

## Le vrai client Flutter reçoit un 422 là où les tests passent

**Cause connue (piège historique) :** un champ resté requis dans un schéma
Pydantic (ex. `company_id`) alors qu'il devrait être optionnel/ignoré. La
suite de tests peut le manquer si ses fixtures envoient encore le champ.

**Solution :** validez les changements de schéma avec un `curl` réaliste, pas
seulement avec pytest. Voir la note « les tests ne prouvent pas le contrat
HTTP » dans `CLAUDE.md`.

## Le backend devient lent / une requête `register` traîne

**Observé en UAT :** après des heures de conteneur en `--reload`, un worker
peut rester chaud et ralentir le pool de connexions.

**Solution :** `docker compose restart backend` (repart sur un pool propre).
Ce n'est pas un défaut applicatif — la base est saine, aucun verrou.

## Les tests laissent des données entre exécutions

**Cause (assumée) :** les tests backend tournent contre la **vraie** base, sans
base de test dédiée ni rollback par test. Les lignes persistent.

**Solution :** c'est une limite documentée (`KNOWN_LIMITATIONS.md`). Pour un
état propre : `docker compose down -v` puis `up`.
